Return-Path: <jack@suse.cz>
Date: Wed, 17 Oct 2018 11:47:45 +0200
From: Jan Kara <jack@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jan Kara <jack@suse.cz>, Johannes Thumshirn <jthumshirn@suse.de>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/15 v2] loop: Fix oops and possible deadlocks
Message-ID: <20181017094745.GA23493@quack2.suse.cz>
References: <20181010100415.26525-1-jack@suse.cz>
 <a40fcf62-85a4-a6be-0803-d99dedf8cc61@i-love.sakura.ne.jp>
 <20181010114227.GA12977@linux-x5ow.site>
 <20181010122809.GE11507@quack2.suse.cz>
 <20181016113654.GG18918@quack2.suse.cz>
 <20181016181622.GF23044@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181016181622.GF23044@vader>
List-ID: <linux-block@vger.kernel.org>

On Tue 16-10-18 11:16:22, Omar Sandoval wrote:
> On Tue, Oct 16, 2018 at 01:36:54PM +0200, Jan Kara wrote:
> > On Wed 10-10-18 14:28:09, Jan Kara wrote:
> > > On Wed 10-10-18 13:42:27, Johannes Thumshirn wrote:
> > > > On Wed, Oct 10, 2018 at 07:19:00PM +0900, Tetsuo Handa wrote:
> > > > > On 2018/10/10 19:04, Jan Kara wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > this patch series fixes oops and possible deadlocks as reported by syzbot [1]
> > > > > > [2]. The second patch in the series (from Tetsuo) fixes the oops, the remaining
> > > > > > patches are cleaning up the locking in the loop driver so that we can in the
> > > > > > end reasonably easily switch to rereading partitions without holding mutex
> > > > > > protecting the loop device.
> > > > > > 
> > > > > > I have lightly tested the patches by creating, deleting, and modifying loop
> > > > > > devices but if there's some more comprehensive loopback device testsuite, I
> > > > > > can try running it. Review is welcome!
> > > > > 
> > > > > Testing on linux-next by syzbot will be the most comprehensive. ;-)
> > > > 
> > > > Apart from that blktests has a loop category and I think it could also be
> > > > worthwhile to add the C reproducer from syzkaller to blktests.
> > > 
> > > Yeah, I did run loop tests now and they ran fine. I can try converting the
> > > syzbot reproducers into something legible but it will take a while.
> > 
> > So I took a stab at this. But I hit two issues:
> > 
> > 1) For the reproducer triggering the lockdep warning, you need a 32-bit
> > binary (so that it uses compat_ioctl). I don't think we want to introduce
> > 32-bit devel environment dependency to blktests. With 64-bits, the problem
> > is also there but someone noticed and silenced lockdep (with a reason that
> > I consider is incorrect)... I think the test is still worth it though as
> > I'll remove the lockdep-fooling code in my patches and thus new breakage
> > will be noticed.
> 
> Agreed, even if it doesn't trigger lockdep now, it's a good regression
> test.
> 
> > 2) For the oops (use-after-free) issue I was not able to reproduce that in
> > my test KVM in couple hours. The race window is rather narrow and syzbot
> > with KASAN and everything hit it only 11 times. So I'm not sure how useful
> > that test is. Any opinions?
> 
> I'd say we should add it anyways. If anything, it's a smoke test for
> changing fds on a loop device. You could add a note that the race it's
> testing for is very narrow.

OK, I'll post the patches later today.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
