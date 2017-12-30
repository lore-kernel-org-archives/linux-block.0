Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:56894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdL3GQh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Dec 2017 01:16:37 -0500
Date: Fri, 29 Dec 2017 22:16:24 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Byungchul Park <byungchul.park@lge.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <20171230061624.GA27959@bombadil.infradead.org>
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <20171229014736.GA10341@X58A-UD3R>
 <20171229035146.GA11757@thunk.org>
 <20171229072851.GA12235@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171229072851.GA12235@X58A-UD3R>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Dec 29, 2017 at 04:28:51PM +0900, Byungchul Park wrote:
> On Thu, Dec 28, 2017 at 10:51:46PM -0500, Theodore Ts'o wrote:
> > On Fri, Dec 29, 2017 at 10:47:36AM +0900, Byungchul Park wrote:
> > > 
> > >    (1) The best way: To classify all waiters correctly.
> > 
> > It's really not all waiters, but all *locks*, no?
> 
> Thanks for your opinion. I will add my opinion on you.
> 
> I meant *waiters*. Locks are only a sub set of potential waiters, which
> actually cause deadlocks. Cross-release was designed to consider the
> super set including all general waiters such as typical locks,
> wait_for_completion(), and lock_page() and so on..

I think this is a terminology problem.  To me (and, I suspect Ted), a
waiter is a subject of a verb while a lock is an object.  So Ted is asking
whether we have to classify the users, while I think you're saying we
have extra objects to classify.

I'd be comfortable continuing to refer to completions as locks.  We could
try to come up with a new object name like waitpoints though?

> > In addition, the lock classification system is not documented at all,
> > so now you also need someone who understands the lockdep code.  And
> > since some of these classifications involve transient objects, and
> > lockdep doesn't have a way of dealing with transient locks, and has a
> > hard compile time limit of the number of locks that it supports, to
> > expect a subsystem maintainer to figure out all of the interactions,
> > plus figure out lockdep, and work around lockdep's limitations
> > seems.... not realistic.
> 
> I have to think it more to find out how to solve it simply enough to be
> acceptable. The only solution I come up with for now is too complex.

I want to amplify Ted's point here.  How to use the existing lockdep
functionality is undocumented.  And that's not your fault.  We have
Documentation/locking/lockdep-design.txt which I'm sure is great for
someone who's willing to invest a week understanding it, but we need a
"here's how to use it" guide.

> > Given that once Lockdep reports a locking violation, it doesn't report
> > any more lockdep violations, if there are a large number of false
> > positives, people will not want to turn on cross-release, since it
> > will report the false positive and then turn itself off, so it won't
> > report anything useful.  So if no one turns it on because of the false
> > positives, how does the bitrot problem get resolved?
> 
> The problems come from wrong classification. Waiters either classfied
> well or invalidated properly won't bitrot.

I disagree here.  As Ted says, it's the interactions between the
subsystems that leads to problems.  Everything's goig to work great
until somebody does something in a way that's never been tried before.
