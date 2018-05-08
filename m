Return-Path: <tytso@thunk.org>
Date: Tue, 8 May 2018 08:37:30 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Jan Kara <jack@suse.cz>, Milan Broz <gmazyland@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: general protection fault in lo_ioctl (2)
Message-ID: <20180508123730.GH999@thunk.org>
References: <000000000000cbaaf6056b341859@google.com>
 <CACT4Y+bTo34q4=7X8zGL_XVOGoYd7fqhfAbCAWUxsr-N96Kyxw@mail.gmail.com>
 <2030b2cf-29f9-7bfd-8266-b39abc19bdfe@I-love.SAKURA.ne.jp>
 <4d91224a-ecba-3696-1116-3da2e48ec4d3@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d91224a-ecba-3696-1116-3da2e48ec4d3@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 08, 2018 at 08:05:12PM +0900, Tetsuo Handa wrote:
> 
> So, it is time to think how to solve this race condition, as well as how to solve
> lockdep's deadlock warning (and I guess that syzbot is actually hitting deadlocks).
> An approach which serializes loop operations using global lock was proposed at
> https://groups.google.com/d/msg/syzkaller-bugs/2Rw8-OM6IbM/PzdobV8kAgAJ .
> Please respond...

I'm looking at your patch which you proposed on this, and the locking
architecture still looks way too complex.  Things like
loop_mutex_owner, and all of the infrastructure around
lo->ioctl_in_progress should be removed, if at all possible.

I believe it should be possible to do things with a single global
mutex, some code refactoring, and some unlocked versions of some of
the functions.

Again, this requires root, and it requires someone deliberately trying
to induce a race.  So "it's time" is not necessarily the priority I
would set for this item.  But if we are going to fix it, let's fix it
right, and not make the code more complex and less maintainable, all
in the name of trying to make a rare, not-likely-to-happen-in-real-life
syzbot reported problem to go away.

Cheers,

							- Ted
