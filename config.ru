require './config/environment'



use Rack::MethodOverride
use UsersController
use WorkoutsController
run ApplicationController
