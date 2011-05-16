module Mensario
  # Allowed timezones
  TIMEZONES = ['Europe/Berlin',        'Europe/Andorra',      'Europe/Vienna',        'Europe/Brussels', 
               'Europe/Sarajevo',      'Europe/Sofia',        'Asia/Nicosia',         'Europe/Nicosia',       'Europe/Zagreb', 
               'Europe/Copenhagen',    'Atlantic/Faroe',      'Europe/Bratislava',    'Europe/Ljubljana', 
               'Europe/Madrid',        'Atlantic/Canary',     'Africa/Ceuta',         'Europe/Tallinn',       'Europe/Helsinki', 
               'Europe/Mariehamm',     'Europe/Paris',        'Europe/Athens',        'Europe/Budapest',      'Europe/Dublin', 
               'Atlantic/Reykjavik',   'Europe/Rome',         'Europe/Riga',          'Europe/Vilnius',       'Europe/Luxembourg', 
               'Europe/Malta',         'Europe/Podgorica',    'Europe/Oslo',          'Atlantic/Jan_Mayen',   'Artic/Longyearbyen', 
               'Europe/Amsterdam',     'Europe/Warsaw',       'Europe/Lisbon',        'Atlantic/Azores',      'Atlantic/Madeira', 
               'Europe/London',        'Europe/Belfast',      'Europe/Guersey',       'Europe/Jersey',        'Europe/Isle_of_Man', 
               'Europe/Prague',        'Europe/Bucharest',    'Europe/Kaliningrad',   'Europe/Moscow',        'Europe/Volgograd', 
               'Europe/Samara',        'Antarctica/Vostok',   'Asia/Sakhalin',        'Asia/Vladivostok',     'Europe/Belgrade', 
               'Europe/Stockholm',     'Europe/Zurich',       'Asia/Istanbul',        'Europe/Istanbul',      'Europe/Kiev', 
               'Europe/Simferopol',    'Europe/Uzhgorod',     'Europe/Zaporozhye']

  module Status
    OK = 'OK'
    KO_DIS_SERV = 'KO-DIS-SERV'
    KO_INT_ERR = 'KO-INT-ERR'
    KO_INV_TASK = 'KO-INV-TASK'
    KO_INV_XML = 'KO-INV-XML'
    KO_INV_AUTH = 'KO-INV-AUTH'
    KO_BLK_LIC = 'KO-BLK-LIC'
    KO_EXP_LIC = 'KO-EXP-LIC'
    KO_INV_TZ = 'KO-INV-TZ'
    KO_INV_SINT = 'KO-INV-SINT'
    KO_INV_PHON = 'KO-INV-PHON'
    KO_INV_CODE = 'KO-INV-CODE'
    KO_EXC_AMNT = 'KO-EXC-AMNT'
    KO_INV_TIME = 'KO-INV-TIME'
    KO_UNK_REQU = 'KO-UNK-REQU'
    KO_UNK_MSGS = 'KO-UNK-MSGS'
  end

  class Mensario
    attr_accessor :license
    attr_accessor :username
    attr_accessor :password

    # Timezone for use in API
    attr_accessor :timezone
 
 
    def initialize
      yield self
    end

    def synchronize
    end
  end
end
