require './config/environment'



use Rack::MethodOverride
use UserController
use WorkoutsController
run ApplicationController