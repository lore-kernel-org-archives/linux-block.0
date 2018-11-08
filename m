Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/16 v3] loop: Fix oops and possible deadlocks
Date: Thu,  8 Nov 2018 14:01:00 +0100
Message-Id: <20181108130116.12140-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hi,

this patch series fixes oops and possible deadlocks as reported by syzbot [1]
[2]. The second patch in the series (from Tetsuo) fixes the oops, the remaining
patches are cleaning up the locking in the loop driver so that we can in the
end reasonably easily switch to rereading partitions without holding mutex
protecting the loop device.

I have tested the patches by creating, deleting, modifying loop devices, and by
running loop blktests (as well as creating new ones with the load syzkaller has
used to detect the problem). Review is welcome but I think the patches are fine
to go as far as I'm concerned! Jens, can you please pick them up?

Changes since v1:
* Added patch moving fput() calls in loop_change_fd() from under loop_ctl_mutex
* Fixed bug in loop_control_ioctl() where it failed to return error properly

Changes since v2:
* Rebase on top of 4.20-rc1
* Add patch to stop fooling lockdep about loop_ctl_mutex

								Honza

[1] https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
[2] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
