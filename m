Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Tue, 12 Dec 2017 08:03:43 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Byungchul Park <byungchul.park@lge.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@lge.com,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] locking/lockdep: Add CONFIG_LOCKDEP_AGGRESSIVE
Message-ID: <20171212130343.6nwxip3i4ua24dwr@thunk.org>
References: <20171211035017.32678-1-tytso@mit.edu>
 <CA+55aFxU6A5doeHh6QagAPpTKvdHzUimAcq+gnnrva=TUtLzhg@mail.gmail.com>
 <c4a4b7be-b3c4-ed56-21a5-d3396b8a4e25@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c4a4b7be-b3c4-ed56-21a5-d3396b8a4e25@lge.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Dec 12, 2017 at 02:20:32PM +0900, Byungchul Park wrote:
> 
> The *problem* is false positives, since locks and waiters in
> kernel are not classified properly, at the moment, which is just
> a fact that is not related to cross-release stuff at all. IOW,
> that would be useful once all locks and waiters are classified
> correctly. It might take time but the classifying is a must-do
> we have to keep doing.

This is the wrong attitude.  The reason why LOCKDEP was so powerful
was because it automatically classified locks, instead of requiring
developers to document the locking hierarchy.  Requiring developers to
have to document and classified locks --- especially when the d*mned
mechanisms for doign so are so primitive and not even documented ---
is a complete non-strarter.

So, ***NO***, WE do not have to do anything.  We can just disable
Lockdep instead.  You can not and must not transfer responsibility for
documenting locks to the subsystem maintainers, as if it is some sort
of bug that the locks are not "classified correctly".  The fact that
your new technique requires clasification is a BUG, and goes against
the original design principle of LOCKDEP in the first place.

> I admit to make it optional for now, but I don't see why you
> want to remove it entierly.

So are you willing to take my patch?  Or give me permission to keep in
the ext4 tree?

						- Ted
