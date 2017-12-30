Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:37434 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdL3PpW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Dec 2017 10:45:22 -0500
Date: Sat, 30 Dec 2017 10:40:41 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: Byungchul Park <byungchul.park@lge.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, david@fromorbit.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com, kernel-team@lge.com, daniel@ffwll.ch
Subject: Re: About the try to remove cross-release feature entirely by Ingo
Message-ID: <20171230154041.GB3366@thunk.org>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <20171229014736.GA10341@X58A-UD3R>
 <20171229035146.GA11757@thunk.org>
 <20171229072851.GA12235@X58A-UD3R>
 <20171230061624.GA27959@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171230061624.GA27959@bombadil.infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 29, 2017 at 10:16:24PM -0800, Matthew Wilcox wrote:
> 
> I think this is a terminology problem.  To me (and, I suspect Ted), a
> waiter is a subject of a verb while a lock is an object.  So Ted is asking
> whether we have to classify the users, while I think you're saying we
> have extra objects to classify.

Exactly, the classification is applied when the {lock, mutex,
completion} object is initialized.  Not currently at the individual
call points to mutex_lock(), wait_for_completion(), down_write(), etc.


> > The problems come from wrong classification. Waiters either classfied
> > well or invalidated properly won't bitrot.
> 
> I disagree here.  As Ted says, it's the interactions between the
> subsystems that leads to problems.  Everything's goig to work great
> until somebody does something in a way that's never been tried before.

The question what is classified *well* mean?  At the extreme, we could
put the locks for every single TCP connection into their own lockdep
class.  But that would blow the limits in terms of the number of locks
out of the water super-quickly --- and it would destroy the ability
for lockdep to learn what the proper locking order should be.  Yet
given Lockdep's current implementation, the only way to guarantee that
there won't be any interactions between subsystems that cause false
positives would be to categorizes locks for each TCP connection into
their own class.

So this is why I get a little annoyed when you say, "it's just a
matter of classification".  NO IT IS NOT.  We can not possibly
classify things "correctly" to completely limit false positives
without completely destroying lockdep's scalability as it is currently
designed.  Byungchul, you don't acknowledge this, and it makes the
"just classify everything" argument completely suspect as a result.

As far as the "just invalidate the waiter", the problem is that it
requires source level changes to invalidate the waiter, and for
different use cases, we will need to validate different waiters.  For
example, in the example I gave, we would have to invalidate *all* TCP
waiters/locks in order to prevent false positives.  But that makes the
lockdep useless for all TCP locks.  What's the solution?  I claim that
until lockdep is fundamentally fixed, there is no way to eliminate
*all* false positives without invalidating *all*
cross-release/cross-locks --- in which case you might as well leave
the cross-release patches as an out of tree patch.

So to claim that we can somehow fix the problem by making source-level
changes outside of lockdep, by "properly classifying" or "properly
invalidating" all locks, just doesn't make sense. 

The only way it can work is to either dump it on the reposibility of
the people debugging lockdep reports to make source level changes to
other subsystems which they aren't the maintainers of to suppress
false positives that arise due to how the subsystems are being used
together in their particular configuration ---- or you can try to
claim that there is an "acceptable level" of false positives with
which we can live with forever, and which can not be fixed by "proper
classifying" the locks.

Or you can try to make lockdep scalable enough that if we could put
every single lock for every single object into its own lock class
(e.g., each lock for every single TCP connection gets its own lock
class) which is after all the only way we can "properly classify
everything") and still let lockdep be useful.

If you think that is doable, why don't you work on that, and once that
is done, maybe cross-locks lockdep will be considered more acceptable
for mainstream?

					- Ted
