<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'root' );

/** MySQL database password */
define( 'DB_PASSWORD', 'root' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql:3306' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );


/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '/Q@#pswk]Q9~$L,jg$/+g?y!+3>6h$|Qh_Q>JQFDJk#L}7<8+a2+c}OmF) b_I|#');
define('SECURE_AUTH_KEY',  ')PPD((n-~b$XG;sMeY_4[J%@s?S#MvveD!2orNKB=P_@!aM:j$i+iBRQC2{D2A| ');
define('LOGGED_IN_KEY',    'f8gzjB]GO:z(h%Xh7]4?b>3U3nA[vxV^?VWl+G|`qIBIIy!{#G&)DJ4d`=k!p1|4');
define('NONCE_KEY',        'Y#:Ds eq 0$5b+D(;KVI4vr5J$]-}%;#KH2?%+f3H?&#Pw+q{K1u4T>jk~FKCHRP');
define('AUTH_SALT',        'nR2JZ/jAzy|3<[`jh]:,C)D&cd~e+UN~^jsiSQ}i]O2TD+[%;p3PstX3Qm~q|+LC');
define('SECURE_AUTH_SALT', 'RJAf%4@L;RHYM9^Yx?P8XHVHOS(,e]+)}Upwy=Sxj,?@aZ;9y:i|? l,AG.VM0U-');
define('LOGGED_IN_SALT',   '{8` V=c#4E1],ROBD8FgRv1K<n5,p[!r|x>C.%BG3r8$0l6!$wgLDJr)|f*92YlK');
define('NONCE_SALT',       '4s?-}G{c;wEefQO_+8`9Yoh;t YNge+U45`9fNZq]!-?8ZWBU|rA/~GuIHj{W/|;');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */

define('WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
