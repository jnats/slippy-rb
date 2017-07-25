::RBNACL_LIBSODIUM_GEM_LIB_PATH = "E:/libsodium.dll"

require 'discordrb'
require 'configatron'
require 'opus-ruby'
require_relative 'config.rb'
bot = Discordrb::Commands::CommandBot.new token: configatron.token, client_id: configatron.client_id, prefix: configatron.prefix

#bot management Commands

##set game
bot.command(:game, help_available: false) do |event, args|
  break unless event.user.id == configatron.owner_id
  game = event.message.content.gsub(".game ", "")
  bot.game = game
  event.respond "Succesfully changed game to **#{game}**"
end

#set status
bot.command(:status, help_available: false) do |event, args|
  break unless event.user.id == configatron.owner_id
    if args=="dnd"
      bot.dnd
      event.respond "Bot set to **Do Not Disturb**"
    else
      if args=="idle"
        bot.idle
        event.respond "Bot set to **Idle**"
    else
      if args=="online"
        bot.online
        event.respond "Bot set to **Online**"
    else
      if args=="invisible"
        bot.invisible
        event.respond "Bot set to **Invisible**"
        end
      end
    end
  end
end

#moderation commands

##kick
bot.command(:kick, description: "Kicks the mentioned User") do |event, args|
  member = event.bot.parse_mention(args)
  if event.author.permission?(:kick_members)==true
    begin
    event.server.kick(member)
  rescue Discordrb::Errors::NoPermission
    event.respond "❌ I do not have the correct permissions to kick #{args}!"
  else
    event.respond "👞 Mentioned User Kicked."
  if event.author.permission?(:kick_members)==false
    event.respond "❌ You do not have the correct permissions to kick this user."
      end
    end
  end
end

##ban
bot.command(:ban, description: "Bans the mentioned User") do |event, args|
  member = event.bot.parse_mention(args)
  if event.author.permission?(:ban_members)==true
    begin
    event.server.ban(member)
  rescue Discordrb::Errors::NoPermission
    event.respond "❌ I do not have the correct permissions to ban #{args}!"
  else
    event.respond "🔨 Mentioned User Banned."
  if event.author.permission?(:kick_members)==false
    event.respond "❌ You do not have the correct permissions to ban this user."
      end
    end
  end
end

##prune
bot.command(:prune, description: "Clears from 2 up to 100 messages in a text channel") do |event, args|
  i = args.to_i
  if i>100
    event.respond "❌ Please input a number below **100.**"
  else
  if event.author.permission?(:manage_messages)==true
    begin
    event.channel.prune(i)
  rescue Discordrb::Errors::NoPermission
    event.respond "❌ I do not have the permissions to prune this channel."
  else
    event.respond "✔️ Channel succesfully pruned. **#{args}** messages deleted."
      end
    end
  end
end


#fun commands

##d6
bot.command(:d6, description: "Rolls a six-sided die.") do |event|
  die = rand(1 .. 6)
  event.respond "[🎲]The die reads **#{die}**."
end

##coinflip
bot.command(:coinflip, description: "Flips a coin") do |event|
  coin = rand(1 .. 2)
  if coin==1
    event.respond "[🙂]The coin landed on **heads**!"
  else
  if coin==2
    event.respond "[🐈] The coin landed on **tails**!"
    end
  end
end

bot.run
