Return-Path: <jack@suse.cz>
Date: Tue, 11 Apr 2017 11:38:27 +0200
From: Jan Kara <jack@suse.cz>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: WBT for SQ devices interface
Message-ID: <20170411093827.GC2471@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi,

when testing my fix for 0-day reports with writeback throttling I came
across somewhat unexpected behavior with user interface of writeback
throttling. So currently if CFQ is used as an IO scheduler, we disable
writeback throttling because they don't go well together. However when user
has CONFIG_BLK_WBT_SQ=y and switches IO scheduler to NOOP or DEADLINE
writeback throttling still stays disabled. This is somewhat unexpected
especially because the switching of IO scheduler from CFQ to something else
can have happened behind user's back by some udev rule or so. So basically
CONFIG_DEFAULT_CFQ=y and CONFIG_BLK_WBT_SQ=y don't make sense together.

So do people thing we should enable WBT if CONFIG_BLK_WBT_SQ=y and IO
scheduler is switched from CFQ to something else?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
