import ast.*;
import org.antlr.v4.runtime.tree.TerminalNode;

import java.util.ArrayList;
import java.util.List;


public class ASTBuilder extends CoolParserBaseVisitor<Tree> {

    @Override
    public Tree visitProgram(CoolParser.ProgramContext ctx) {

        ProgramNode p = new ProgramNode(ctx.getStart().getLine());
        for (CoolParser.CoolClassContext c : ctx.coolClass()) {
            p.add((ClassNode) visitCoolClass(c));
        }
        return p;
    }

    @Override
    public ClassNode visitCoolClass(CoolParser.CoolClassContext ctx) {
        int ln = ctx.getStart().getLine();


        TerminalNode nameNode = ctx.TYPE_ID().get(0);

        Symbol name = StringTable.idtable.addString(nameNode.getSymbol().getText());
        Symbol filename = StringTable.stringtable.addString(ctx.start.getTokenSource().getSourceName());

        Symbol parent;
        if (ctx.TYPE_ID().size() > 1) {
            TerminalNode parentNode;
            parentNode = ctx.TYPE_ID().get(1);
            parent = StringTable.idtable.addString(parentNode.getSymbol().getText());
        } else {
            parent = TreeConstants.Object_;
        }
        ClassNode c = new ClassNode(ln, name, parent, filename);
        if (ctx.feature() != null)
            for (CoolParser.FeatureContext f : ctx.feature())
                c.add((FeatureNode) visit(f));

        return c;
    }

    @Override
    public Tree visitFeature(CoolParser.FeatureContext ctx) {
        if (ctx.PARENT_OPEN() == null) { // isAttribute
            return visitAttributeNode(ctx);
        }
        return visitMethodNode(ctx); // isMethod
    }

    public Tree visitMethodNode(CoolParser.FeatureContext ctx) {

        List<FormalNode> formalNodes = new ArrayList<>();
        Symbol name = StringTable.idtable.addString(ctx.OBJECT_ID().getSymbol().getText());
        Symbol returnType = StringTable.idtable.addString(ctx.TYPE_ID().getSymbol().getText());

        for (CoolParser.FormalContext c : ctx.formal()) {
            formalNodes.add((FormalNode) visit(c));
        }

        MethodNode m = new MethodNode(ctx.OBJECT_ID().getSymbol().getLine(), name, formalNodes, returnType,
                (ExpressionNode) visit(ctx.expression()));

        return m;
    }

    public Tree visitAttributeNode(CoolParser.FeatureContext ctx) {
        Symbol name = StringTable.idtable.addString(ctx.OBJECT_ID().getSymbol().getText());
        Symbol type = StringTable.idtable.addString(ctx.TYPE_ID().getSymbol().getText());

        ExpressionNode expr = (ctx.ASSIGN_OPERATOR() == null) ? new NoExpressionNode(0)
                : (ExpressionNode) visit(ctx.expression());

        return new AttributeNode(ctx.OBJECT_ID().getSymbol().getLine(), name, type, expr);
    }

    @Override
    public Tree visitFormal(CoolParser.FormalContext ctx) {
        Symbol name = StringTable.idtable.addString(ctx.OBJECT_ID().getSymbol().getText());
        Symbol type = StringTable.idtable.addString(ctx.TYPE_ID().getSymbol().getText());

        return new FormalNode(ctx.OBJECT_ID().getSymbol().getLine(), name, type);
    }

    public Tree visitBranchMode(CoolParser.BranchContext ctx) {
        int lineNumber = ctx.OBJECT_ID().getSymbol().getLine();
        Symbol name = StringTable.idtable.addString(ctx.OBJECT_ID().getSymbol().getText());
        Symbol type = StringTable.idtable.addString(ctx.TYPE_ID().getSymbol().getText());

        ExpressionNode expr = (ExpressionNode) visit(ctx.expression());

        return new BranchNode(lineNumber, name, type, expr);
    }

    public Tree visitAssignNode(CoolParser.AssignContext ctx) {
        int lineNumber = ctx.OBJECT_ID().getSymbol().getLine();
       Symbol name = StringTable.idtable.addString(ctx.OBJECT_ID().getSymbol().getText());

        ExpressionNode exprNode = (ExpressionNode) visit(ctx.expression());

     return new AssignNode(lineNumber, name, exprNode);
    }

    



}