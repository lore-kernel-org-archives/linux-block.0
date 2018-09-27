Return-Path: <jack@suse.cz>
Date: Thu, 27 Sep 2018 13:42:47 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
Subject: Re: [PATCH 4/4] block/loop: Fix circular locking dependency at
 blkdev_reread_part().
Message-ID: <20180927114247.GC16469@quack2.suse.cz>
References: <1537889209-7208-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1537889209-7208-4-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180927112744.GB16469@quack2.suse.cz>
 <6571703a-ecd7-5c0e-0e2a-61f791dea075@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6571703a-ecd7-5c0e-0e2a-61f791dea075@i-love.sakura.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Thu 27-09-18 20:35:27, Tetsuo Handa wrote:
> On 2018/09/27 20:27, Jan Kara wrote:
> > Hi,
> > 
> > On Wed 26-09-18 00:26:49, Tetsuo Handa wrote:
> >> syzbot is reporting circular locking dependency between bdev->bd_mutex
> >> and lo->lo_ctl_mutex [1] which is caused by calling blkdev_reread_part()
> >> with lock held. We need to drop lo->lo_ctl_mutex in order to fix it.
> >>
> >> This patch fixes it by combining loop_index_mutex and loop_ctl_mutex into
> >> loop_mutex, and releasing loop_mutex before calling blkdev_reread_part()
> >> or fput() or path_put() or leaving ioctl().
> >>
> >> The rule is that current thread calls lock_loop() before accessing
> >> "struct loop_device", and current thread no longer accesses "struct
> >> loop_device" after unlock_loop() is called.
> >>
> >> Since syzbot is reporting various bugs [2] where a race in the loop module
> >> is suspected, let's check whether this patch affects these bugs too.
> >>
> >> [1] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889
> >> [2] https://syzkaller.appspot.com/bug?id=b3c7e1440aa8ece16bf557dbac427fdff1dad9d6
> >>
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >> Reported-by: syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
> >> ---
> >>  drivers/block/loop.c | 187 ++++++++++++++++++++++++++++-----------------------
> >>  1 file changed, 101 insertions(+), 86 deletions(-)
> > 
> > I still don't like this patch. I'll post a patch series showing what I have
> > in mind. Admittedly, it's a bit tedious but the locking is much saner
> > afterwards...
> 
> Please be sure to Cc: me. I'm not subscribed to linux-block ML.

Yes, I've CCed you.

> But if we have to release lo_ctl_mutex before calling blkdev_reread_part(),
> what is nice with re-acquiring lo_ctl_mutex after blkdev_reread_part() ?

We don't reacquire the mutex after blkdev_reread_part(). Just the code
needed to be cleaned up so that loop_reread_part() does not need
lo_ctl_mutex for anything.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
