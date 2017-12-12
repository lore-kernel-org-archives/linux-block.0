Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:60950 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbdLLCGQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Dec 2017 21:06:16 -0500
Date: Mon, 11 Dec 2017 20:56:45 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Byungchul Park <byungchul.park@lge.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@lge.com,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] locking/lockdep: Add CONFIG_LOCKDEP_AGGRESSIVE
Message-ID: <20171212015645.wfkfin5mkgcvdfw2@thunk.org>
References: <20171211035017.32678-1-tytso@mit.edu>
 <CA+55aFxU6A5doeHh6QagAPpTKvdHzUimAcq+gnnrva=TUtLzhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFxU6A5doeHh6QagAPpTKvdHzUimAcq+gnnrva=TUtLzhg@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Dec 11, 2017 at 01:06:55PM -0800, Linus Torvalds wrote:
> On Sun, Dec 10, 2017 at 7:50 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> > CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS can result
> > in a large number of false positives because lockdep doesn't
> > understand how to deal with multiple stacked loop or MD devices.
> 
> Guys, can we just remove this nasty crud already?
> 
> It's not working. Give it up. It was complex, it was buggy, it was slow.
> 
> Now it's causing people to disable lockdep entirely, or play these
> kinds of games in unrelated trees.
> 
> It's time to give up on bad debugging, and definitely _not_ enable it
> by default for PROVE_LOCKING.

To be fair to Byungchul, I think it *can* be valid for finding some
classes of bugs.  It's just a disaster for anything to do with storage.

I crafted this patch as something something which I thought *could* be
a path forward; it disables it by default, and gives a warning about
how it could cause a lot of pain for storage developers, but if other
kernel devs want to use it to potentially find problem in their
networking or wifi drivers --- sure, why not?  Just make it be
something *optional*.

If people really want to make this work for storage, what I think we
would need is variants of spin_lock_init(), mutex_init(), etc., which
take a struct super or a struct block device, with proper
documentation so that people don't have to struggle with undocumented
C preprocessor macros where every single time I need to mess with
lockdep annotations, I have to try figure out exactly what is a class
and subclass.

So in fact, what I was really hoping for was that some variant of this
patch would end up in the sched tree, and get pushed to you v4.15-rcX
patch as a regression fix, and I'd drop it from the ext4 tree.

	      	   	      	       	   - Ted
