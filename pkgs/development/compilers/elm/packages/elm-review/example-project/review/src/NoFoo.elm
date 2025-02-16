module NoFoo exposing (rule)

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Review.Rule as Rule exposing (Error, Rule)

-- Create a new rule
rule : Rule
rule =
    -- Define the rule with the same name as the module it is defined in
    Rule.newModuleRuleSchema "NoFoo" ()
        -- Make it look at expressions
        |> Rule.withSimpleExpressionVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema

-- This function will visit all the expressions (like `1`, `"string"`, `foo bar`, `a + b`, ...)
-- and report problems that it finds
expressionVisitor : Node Expression -> List (Error {})
expressionVisitor node =
    case Node.value node of
        -- It will look at string literals (like "a", """a""")
        Expression.Literal str ->
            if String.contains "foo" str then
                -- Return a single error, describing the problem
                [ Rule.error
                    { message = "Replace `foo` by `bar`"
                    , details = [ "" ]
                    }
                    -- This is the location of the problem in the source code
                    (Node.range node)
                ]

            else
                []

        _ ->
            []
