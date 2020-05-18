defmodule TndWeb.Router do
  use TndWeb, :router

  import TndWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TndWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TndWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TndWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TndWeb.Telemetry
    end
  end

  ## Authentication routes

  scope "/", TndWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/login", UserSessionController, :new
    post "/users/login", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", TndWeb do
    pipe_through [:browser, :require_authenticated_user]

    # live /characters/, CharactersLive.Index
    # live /characters/new, CharactersLive.New
    # live /characters/:character_id, CharactersLive.Show
    # live /characters/:character_id/edit, CharactersLive.Edit

    # live /games/, GamesLive.Index
    # live /games/new, GamesLive.New
    # live /games/:game_id, GamesLive.Show
    # live /games/:game_id/settings, GamesLive.Settings

    # live /compendium/, CompendiumLive.Index
    # live /compendium/new, CompendiumLive.New
    # live /compendium/:compendium_id, CompendiumLive.Show
    # live /compendium/:compendium_id/archetypes/, CompendiumArchetypes.Index
    # live /compendium/:compendium_id/archetypes/new, CompendiumArchetypes.New
    # live /compendium/:compendium_id/archetypes/:archetype_id, CompendiumArchetypes.Show
    # live /compendium/:compendium_id/archetypes/:archetype_id/edit, CompendiumArchetypes.Edit
    # live /compendium/:compendium_id/careers/, CompendiumCareers.Index
    # live /compendium/:compendium_id/careers/new, CompendiumCareers.New
    # live /compendium/:compendium_id/careers/:career_id, CompendiumCareers.Show
    # live /compendium/:compendium_id/careers/:career_id/edit, CompendiumCareers.Edit
    # live /compendium/:compendium_id/talents/, CompendiumTalents.Index
    # live /compendium/:compendium_id/talents/new, CompendiumTalents.New
    # live /compendium/:compendium_id/talents/:talent_id, CompendiumTalents.Show
    # live /compendium/:compendium_id/talents/:talent_id/edit, CompendiumTalents.Edit
    # live /compendium/:compendium_id/skills/, CompendiumSkills.Index
    # live /compendium/:compendium_id/skills/new, CompendiumSkills.New
    # live /compendium/:compendium_id/skills/:skill_id, CompendiumSkills.Show
    # live /compendium/:compendium_id/skills/:skill_id/edit, CompendiumSkills.Edit
    # live /compendium/:compendium_id/weapons/, CompendiumWeapons.Index
    # live /compendium/:compendium_id/weapons/new, CompendiumWeapons.New
    # live /compendium/:compendium_id/weapons/:weapon_id, CompendiumWeapons.Show
    # live /compendium/:compendium_id/weapons/:weapon_id/edit, CompendiumWeapons.Edit
    # live /compendium/:compendium_id/armor/, CompendiumArmor.Index
    # live /compendium/:compendium_id/armor/new, CompendiumArmor.New
    # live /compendium/:compendium_id/armor/:armor_id, CompendiumArmor.Show
    # live /compendium/:compendium_id/armor/:armor_id/edit, CompendiumArmor.Edit
    # live /compendium/:compendium_id/gear/, CompendiumGear.Index
    # live /compendium/:compendium_id/gear/new, CompendiumGear.New
    # live /compendium/:compendium_id/gear/:gear_id, CompendiumGear.Show
    # live /compendium/:compendium_id/gear/:gear_id/edit, CompendiumGear.Edit
    # live /compendium/:compendium_id/adversaries/, CompendiumAdversaries.Index
    # live /compendium/:compendium_id/adversaries/new, CompendiumAdversaries.New
    # live /compendium/:compendium_id/adversaries/:adversary_id, CompendiumAdversaries.Show
    # live /compendium/:compendium_id/adversaries/:adversary_id/edit, CompendiumAdversaries.Edit

    delete "/me/logout", UserSessionController, :delete
    get "/me/settings", UserSettingsController, :edit
    put "/me/settings/update_password", UserSettingsController, :update_password
    put "/me/settings/update_email", UserSettingsController, :update_email
    get "/me/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", TndWeb do
    pipe_through [:browser]

    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end
end
