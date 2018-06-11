Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 11 Jun 2018 10:20:53 -0700
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Dmitry Vyukov <dvyukov@google.com>, Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bdi: Fix another oops in wb_workfn()
Message-ID: <20180611172053.GR1351649@devbig577.frc2.facebook.com>
References: <201806080231.w582VIRn021009@www262.sakura.ne.jp>
 <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
 <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
 <CACT4Y+Z4i=bD49cb4pJ5zOMxVu675NT8wCNk+c2n2XJVOXG2bg@mail.gmail.com>
 <2b437c6f-3e10-3d83-bdf3-82075d3eaa1a@i-love.sakura.ne.jp>
 <3cf4b0e3-31b6-8cdc-7c1e-15ba575a7879@i-love.sakura.ne.jp>
 <20180611091248.2i6nt27h5mxrodm2@quack2.suse.cz>
 <20180611160131.GQ1351649@devbig577.frc2.facebook.com>
 <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180611162920.mwapvuqotvhkntt3@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Jun 11, 2018 at 06:29:20PM +0200, Jan Kara wrote:
> > Would something like the following work or am I missing the point
> > entirely?
> 
> I was pondering the same solution for a while but I think it won't work.
> The problem is that e.g. wb_memcg_offline() could have already removed
> wb from the radix tree but it is still pending in bdi->wb_list
> (wb_shutdown() has not run yet) and so we'd drop reference we didn't get.

Yeah, right, so the root cause is that we're walking the wb_list while
holding lock and expecting the object to stay there even after lock is
released.  Hmm... we can use a mutex to synchronize the two
destruction paths.  It's not like they're hot paths anyway.

Thanks.

-- 
tejun
