
# # Create Load Balancer Listener
# resource "aws_lb_listener" "prodxcloud-LB-Listener" {
#   load_balancer_arn = aws_lb.PRODXCLOUD-Load-Balancer.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.PRODXCLOUD-TG.arn
#   }
# }
