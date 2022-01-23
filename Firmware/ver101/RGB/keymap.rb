# Initialize a Keyboard
kbd = Keyboard.new

# Initialize GPIO assign
kbd.init_pins(
  [ 9, 10, 11  ],            # row0, row1,... respectively
  [ 1, 2, 3, 4, 5, 6, 14, 15, 26, 27, 12, 13 ]    # col0, col1,... respectively
)
#keyboard.row_pins = (board.GP9, board.GP10, board.GP11)
#keyboard.col_pins = (board.GP1, board.GP2, board.GP3, board.GP4, board.GP5, board.GP6, board.GP14, board.GP15, board.GP26, board.GP27, board.GP12, board.GP13)
#cool836rp PCB ver.1.01

# default layer should be added at first
kbd.add_layer :default, %i[
  KC_ESCAPE ALT_Q   KC_W    KC_E        KC_R      KC_T     KC_Y     KC_U     KC_I      KC_O     KC_P      KC_BSPACE
  KC_LCTL   KC_A    KC_S    KC_D        KC_F      KC_G     KC_H     KC_J     KC_K      KC_L     KC_MINUS  KC_ENTER
  KC_LSFT   KC_Z    GUI_X   KC_C        KC_V      KC_B     LOWER_SPC RAISE_N     KC_M      KC_COMMA  KC_DOT   KC_SPACE
]
kbd.add_layer :raise, %i[
  KC_TAB    KC_1    KC_2    KC_3        KC_4      KC_5     KC_6      KC_7      KC_8      KC_9     KC_0     KC_BSPACE
  KC_LCTL   KC_EXLM KC_AT   KC_HASH     KC_DLR    KC_PERC  KC_CIRC   KC_AMPR   KC_ASTER  KC_LPRN  KC_RPRN  KC_ENTER 
  KC_LSFT   KC_PLUS KC_MINUS KC_ASTER     KC_SLASH  KC_EQUAL KC_SPACE  RAISE_N    KC_INSERT      KC_LBRC  KC_RBRC  KC_SPACE 
]
kbd.add_layer :lower, %i[
    KC_TAB   KC_F1   KC_F2   KC_F3       KC_F4     KC_F5    KC_F6     KC_F7     KC_F8     KC_F9     KC_F10   KC_BSPACE
    KC_LCTRL KC_AT   KC_BSLASH KC_SCOLON KC_SCOLON KC_QUOTE  KC_LEFT   KC_DOWN   KC_UP     KC_RIGHT KC_PIPE KC_ENTER
    KC_LSFT  RGB_TOG    RGB_MOD RGB_HUI RGB_HUD      KC_B     LOWER_SPC  KC_N      KC_M      KC_LBRC  KC_RBRC  KC_SPACE 
]
#
#                   Your custom     Keycode or             Keycode (only modifiers)      Release time      Re-push time
#                   key name        Array of Keycode       or Layer Symbol to be held    threshold(ms)     threshold(ms)
#                                   or Proc                or Proc which will run        to consider as    to consider as
#                                   when you click         while you keep press          `click the key`   `hold the key`
kbd.define_mode_key :ALT_Q,       [ :KC_Q,                 :KC_LALT,                     150,              150]
kbd.define_mode_key :GUI_X,       [ :KC_X,                 :KC_LGUI,                     150,              150 ]
kbd.define_mode_key :RAISE_N,     [ :KC_N,                 :raise,                       150,              250 ]
kbd.define_mode_key :LOWER_SPC,   [ :KC_SPACE,             :lower,                       150,              250 ]

# `before_report` will work just right before reporting what keys are pushed to USB host.
# You can use it to hack data by adding an instance method to Keyboard class by yourself.
# ex) Use Keyboard#before_report filter if you want to input `":" w/o shift` and `";" w/ shift`
#kbd.before_report do
#  kbd.invert_sft if kbd.keys_include?(:KC_SCOLON)
#  # You'll be also able to write `invert_ctl`, `invert_alt` and `invert_gui`
#end

rgb = RGB.new(
  0,    # pin number
  36,    # size of underglow pixel
  0,   # size of backlight pixel
  true # 32bit data will be sent to a pixel if true while 24bit if false
)
rgb.effect     = :breath
rgb.speed      = 31  # 1-31  / default: 22
rgb.hue        = 10  # 0-100 / default: 0
rgb.saturation = 100 # 0-100 / default: 100
rgb.max_value  = 10  # 1-31  / default: 13

kbd.append rgb # `kbd` is an instance of Keyboard class that should be newed in advance

kbd.start!
