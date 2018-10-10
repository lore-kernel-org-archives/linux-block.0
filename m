Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/15 v2] loop: Fix oops and possible deadlocks
Date: Wed, 10 Oct 2018 12:04:00 +0200
Message-Id: <20181010100415.26525-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hi,

this patch series fixes oops and possible deadlocks as reported by syzbot [1]
[2]. The second patch in the series (from Tetsuo) fixes the oops, the remaining
patches are cleaning up the locking in the loop driver so that we can in the
end reasonably easily switch to rereading partitions without holding mutex
protecting the loop device.

I have lightly tested the patches by creating, deleting, and modifying loop
devices but if there's some more comprehensive loopback device testsuite, I
can try running it. Review is welcome!

Changes since v1:
* Added patch moving fput() calls in loop_change_fd() from under loop_ctl_mutex
* Fixed bug in loop_control_ioctl() where it failed to return error properly

								Honza

[1] https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
[2] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
