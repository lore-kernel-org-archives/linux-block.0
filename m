Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:53921 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeACB5P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jan 2018 20:57:15 -0500
Subject: Re: About the try to remove cross-release feature entirely by Ingo
To: Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, david@fromorbit.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com, kernel-team@lge.com, daniel@ffwll.ch
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <20171229014736.GA10341@X58A-UD3R> <20171229035146.GA11757@thunk.org>
 <20171229072851.GA12235@X58A-UD3R>
 <20171230061624.GA27959@bombadil.infradead.org>
 <20171230154041.GB3366@thunk.org>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <c32eb67d-8dc1-2e0a-e359-6f9fb3353906@lge.com>
Date: Wed, 3 Jan 2018 10:57:11 +0900
MIME-Version: 1.0
In-Reply-To: <20171230154041.GB3366@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/31/2017 12:40 AM, Theodore Ts'o wrote:
> On Fri, Dec 29, 2017 at 10:16:24PM -0800, Matthew Wilcox wrote:
>>
>> I disagree here.  As Ted says, it's the interactions between the
>> subsystems that leads to problems.  Everything's goig to work great
>> until somebody does something in a way that's never been tried before.
> 
> The question what is classified *well* mean?  At the extreme, we could
> put the locks for every single TCP connection into their own lockdep
> class.  But that would blow the limits in terms of the number of locks
> out of the water super-quickly --- and it would destroy the ability
> for lockdep to learn what the proper locking order should be.  Yet
> given Lockdep's current implementation, the only way to guarantee that
> there won't be any interactions between subsystems that cause false
> positives would be to categorizes locks for each TCP connection into
> their own class.
> 
> So this is why I get a little annoyed when you say, "it's just a
> matter of classification".  NO IT IS NOT.  We can not possibly
> classify things "correctly" to completely limit false positives
> without completely destroying lockdep's scalability as it is currently

You seem to admit that it can be solved by proper classification but
say that it's *not realistic* because of the limitation of lockdep.

Right?

I've agreed with you for that point. I also think it's very hard to
do it because of the lockdep design and the only way might be to fix
lockdep fundamentally, that may be the one we should do ultimately.

Is it the best decision to keep it removed until lockdep get fixed
fundamentally? If I believe it were, I would have kept quiet. But, I
don't think so. Almost other users had already gotten benifit from
it except the special case.

And it would be appriciated if you remind that I suggested 3 methods
+ 1 (by Amir) before for that reason.

I don't want to force it forward but just want the facts to be shared.
I felt like I failed it because of the lack of explanation.

> As far as the "just invalidate the waiter", the problem is that it
> requires source level changes to invalidate the waiter, and for

Or, no change is needed if we adopt the (4)th option (by Amir), in
which we keep waiters invalidated by default and validate waiters
explicitly only when it needs.

> different use cases, we will need to validate different waiters.  For
> example, in the example I gave, we would have to invalidate *all* TCP
> waiters/locks in order to prevent false positives.  But that makes the

No. Only invalidating waiters is enough. For now, the waiter in
submit_bio_wait() is the only one to invalidate.

> lockdep useless for all TCP locks.  What's the solution?  I claim that

Even if we invalidate waiters, TCP locks can still work with lockdep.
Invalidating waiters *never* affect lockdep checking for typical locks
at all.

> The only way it can work is to either dump it on the reposibility of
> the people debugging lockdep reports to make source level changes to
> other subsystems which they aren't the maintainers of to suppress
> false positives that arise due to how the subsystems are being used
> together in their particular configuration ---- or you can try to

You seem to misunderstand it a lot.. The only thing we have to is to
use init_completion_nomap() instead of init_completion() for the
problematic completion object. So far, the completion in
submit_bio_wait() has been the only one.

If you belive that we have a lot of problematic completions(waiters)
so that we cannot handle it, the (4) by Amir can be an option.

Just to be sure, there were several false positives by cross-release.
Something was due to confliction between manual acquire()s added
before and automatic cross-release, both of which are for detecting
deadlocks by a specific completion(waiter). Or, something was solved
by classifying locks properly simply. And this case of
submit_bio_wait() is the first case that we cannot classify locks
simply and need to consider other options.

-- 
Thanks,
Byungchul
