Return-Path: <nix.or.die@gmail.com>
MIME-Version: 1.0
From: Gabriel C <nix.or.die@gmail.com>
Date: Mon, 10 Jul 2017 17:03:05 +0200
Message-ID: <CAEJqkgjSVapRO7aTXJ3uTSOEC8UdfLp7+SNeef=888GY6Wye1Q@mail.gmail.com>
Subject: elevator= seems to be confused with MQ and !MQ scheduler
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hello,

We are allowed to build all scheduler as modules or build-in setting
defaults with
CONFIG_SCSI_MQ_DEFAULT=y/n / CONFIG_DM_MQ_DEFAULT=y/n.


Following setup:

All scheduler set to Y ( build-in )
CONFIG_DEFAULT_CFQ=y
CONFIG_SCSI_MQ_DEFAULT and CONFIG_DM_MQ_DEFAULT set to N

Boot now with elevator=some_mq_schedule

While it should not even try to use any MQ it will try to set values
from elevator and hang.

Now boot with scsi_mod.use_blk_mq=y dm_mod.use_blk_mq=y
elevator=!some_mq_schedule , hangs too.

This looks better but still some output in  dmesg is wrong:

Build scheduler M ( I have cfq mq-deadline Y to have some defaults)
CONFIG_DEFAULT_CFQ=y
CONFIG_SCSI_MQ_DEFAULT and CONFIG_DM_MQ_DEFAULT set to N

Boot with elevator=some_mq_schedule_is_module
Will give an error since it can't find the module and continue with
default cfq which is fine.
Once box is up modprobe the modules you used in elevator= and whatch
your dmesg..

So how is that meant to work now ? use elevator= only you know what
your kernel config looks like ( which probably lots users have no clue
about ) ?

Best Regards,

Gabriel C
