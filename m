Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
To: tytso@mit.edu
Cc: syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com, axboe@kernel.dk,
        syzkaller-bugs@googlegroups.com, jack@suse.cz, gmazyland@gmail.com,
        dvyukov@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: general protection fault in lo_ioctl (2)
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <000000000000cbaaf6056b341859@google.com>
	<CACT4Y+bTo34q4=7X8zGL_XVOGoYd7fqhfAbCAWUxsr-N96Kyxw@mail.gmail.com>
	<2030b2cf-29f9-7bfd-8266-b39abc19bdfe@I-love.SAKURA.ne.jp>
	<4d91224a-ecba-3696-1116-3da2e48ec4d3@I-love.SAKURA.ne.jp>
	<20180508123730.GH999@thunk.org>
In-Reply-To: <20180508123730.GH999@thunk.org>
Message-Id: <201805090606.IBH69745.SOQVMFOOFHtFJL@I-love.SAKURA.ne.jp>
Date: Wed, 9 May 2018 06:06:50 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Theodore Y. Ts'o wrote:
> On Tue, May 08, 2018 at 08:05:12PM +0900, Tetsuo Handa wrote:
> > 
> > So, it is time to think how to solve this race condition, as well as how to solve
> > lockdep's deadlock warning (and I guess that syzbot is actually hitting deadlocks).
> > An approach which serializes loop operations using global lock was proposed at
> > https://groups.google.com/d/msg/syzkaller-bugs/2Rw8-OM6IbM/PzdobV8kAgAJ .
> > Please respond...
> 
> I'm looking at your patch which you proposed on this, and the locking
> architecture still looks way too complex.  Things like
> loop_mutex_owner, and all of the infrastructure around
> lo->ioctl_in_progress should be removed, if at all possible.

The patch in the above link no longer uses "lo->ioctl_in_progress".
You looked at previous version rather than current version.

> 
> I believe it should be possible to do things with a single global
> mutex, some code refactoring, and some unlocked versions of some of
> the functions.

The patch in the above link uses single global mutex "loop_mutex".

> 
> Again, this requires root, and it requires someone deliberately trying
> to induce a race.  So "it's time" is not necessarily the priority I
> would set for this item.  But if we are going to fix it, let's fix it
> right, and not make the code more complex and less maintainable, all
> in the name of trying to make a rare, not-likely-to-happen-in-real-life
> syzbot reported problem to go away.

While NULL pointer dereference would be rare, deadlocks might not be rare
enough to postpone the patch. Deadlocks can cause pile of false-positive
hung task reports and can prevent syzbot from finding other bugs. That's
why I say "it is time to think".
