Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/14] loop: Fix oops and possible deadlocks
Date: Thu, 27 Sep 2018 13:36:38 +0200
Message-Id: <20180927113652.5422-1-jack@suse.cz>
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

								Honza

[1] https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
[2] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
