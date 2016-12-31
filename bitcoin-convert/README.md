=== Plugin Name ===
Contributors: modernwebservices
Donate link: https://modernwebservices.com.au/donate
Tags: bitcoin
Requires at least: 4.6
Tested up to: 4.7
Stable tag: trunk
License: GPLv2 or later
License URI: https://www.gnu.org/licenses/gpl-2.0.html

Display Fiat currency values in Bitcoin or visa-versa using real-time exchange rates. Requires PHP 7.0+.

== Description ==

Provides ability for content author to insert a shortcode specifying an amount in either Bitcoin or a Fiat currency.

The plugin then converts this value in to the corresponding value using real-time exchange rates.

For example, I use this on my business site to display my hourly rates in my local currency, as well as in Bitcoin.

Includes a Tiny MCE plugin to assist content author in generating the shortcode.

Requires PHP 7.0+ due to scalar argument declarations.

== Installation ==

1. Upload the plugin files to the `/wp-content/plugins/bitcoin-convert` directory, or install the plugin through the WordPress plugins screen directly.
1. Activate the plugin through the 'Plugins' screen in WordPress
1. Use the Settings->Plugin Name screen to configure the plugin
1. (Make your instructions match the desired user flow for activating and installing your plugin. Include any steps that might be needed for explanatory purposes)


== Frequently Asked Questions ==

= Are values updated client-side? =

At the moment no. All currency conversion is performed server-side. I'll probably add a jQuery plugin and optional data attributes in a later 
version to enable that functionality.


== Screenshots ==

1. Tiny MCE short-code generator plugin
2. Example public page showing real-time fiat to bitcoin conversion
