Return-Path: <jack@suse.cz>
Date: Mon, 18 Jun 2018 14:27:29 +0200
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Dmitry Vyukov <dvyukov@google.com>, Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180618122729.f5gh7nuaibuvf3e7@quack2.suse.cz>
References: <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
 <20180611172053.GR1351649@devbig577.frc2.facebook.com>
 <20180612155754.x5k2yndh5t6wlmpy@quack2.suse.cz>
 <20180613143315.GS1351649@devbig577.frc2.facebook.com>
 <20180615120620.uyc7h6sudbpsecnm@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180615120620.uyc7h6sudbpsecnm@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Fri 15-06-18 14:06:20, Jan Kara wrote:
> On Wed 13-06-18 07:33:15, Tejun Heo wrote:
> > Hello, Jan.
> > 
> > On Tue, Jun 12, 2018 at 05:57:54PM +0200, Jan Kara wrote:
> > > > Yeah, right, so the root cause is that we're walking the wb_list while
> > > > holding lock and expecting the object to stay there even after lock is
> > > > released.  Hmm... we can use a mutex to synchronize the two
> > > > destruction paths.  It's not like they're hot paths anyway.
> > > 
> > > Hmm, do you mean like having a per-bdi or even a global mutex that would
> > > protect whole wb_shutdown()? Yes, that should work and we could get rid of
> > > WB_shutting_down bit as well with that. Just it seems a bit strange to
> > 
> > Yeap.
> > 
> > > introduce a mutex only to synchronize these two shutdown paths - usually
> > > locks protect data structures and in this case we have cgwb_lock for
> > > that so it looks like a duplication from a first look.
> > 
> > Yeah, I feel a bit reluctant too but I think that's the right thing to
> > do here.  This is an inherently weird case where there are two ways
> > that an object can go away with the immediate drain requirement from
> > one side.  It's not a hot path and the dumber the synchronization the
> > better, right?
> 
> Yeah, fair enough. Something like attached patch? It is indeed considerably
> simpler than fixing synchronization using WB_shutting_down. This one even
> got some testing using scsi_debug, I want to do more testing next week with
> more cgroup writeback included.

OK, the test has passed some beating with cgroup writeback running. I'll do
official posting shortly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
