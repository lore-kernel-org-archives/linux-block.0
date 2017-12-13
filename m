Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:38106 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdLMFdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Dec 2017 00:33:16 -0500
Subject: Re: [PATCH] locking/lockdep: Add CONFIG_LOCKDEP_AGGRESSIVE
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@lge.com,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
References: <20171211035017.32678-1-tytso@mit.edu>
 <CA+55aFxU6A5doeHh6QagAPpTKvdHzUimAcq+gnnrva=TUtLzhg@mail.gmail.com>
 <c4a4b7be-b3c4-ed56-21a5-d3396b8a4e25@lge.com>
 <20171212130343.6nwxip3i4ua24dwr@thunk.org>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <350e2541-640c-a8a0-c9f9-60ba6dc0491d@lge.com>
Date: Wed, 13 Dec 2017 14:33:12 +0900
MIME-Version: 1.0
In-Reply-To: <20171212130343.6nwxip3i4ua24dwr@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/12/2017 10:03 PM, Theodore Ts'o wrote:
> On Tue, Dec 12, 2017 at 02:20:32PM +0900, Byungchul Park wrote:
>>
>> The *problem* is false positives, since locks and waiters in
>> kernel are not classified properly, at the moment, which is just
>> a fact that is not related to cross-release stuff at all. IOW,
>> that would be useful once all locks and waiters are classified
>> correctly. It might take time but the classifying is a must-do
>> we have to keep doing.
> 
> This is the wrong attitude.  The reason why LOCKDEP was so powerful

I understand you why you told me like this, but you seem to
mis-understand me. It's not a matter of attitudes. I also
think any tools should not bother others as far as possible.

> was because it automatically classified locks, instead of requiring

Right. Original lockdep tries to classify locks automatically,
but it can never achieve it with the current way. Conceptually,
there are still many places where locks are not classified
properly yet, but enough for lockdep to work for now.

> developers to document the locking hierarchy.  Requiring developers to
> have to document and classified locks --- especially when the d*mned

I also think requesting it to others instead of solving it
internally is bad. Please don't mis-understand me. I just
wanted to say that experts of specific domains can do it best.

I know you and fs folks have worked on it as enough as original
lockdep works, even though many other locks are still left
classified unproperly.

> mechanisms for doign so are so primitive and not even documented ---
> is a complete non-strarter.
> 
> So, ***NO***, WE do not have to do anything.  We can just disable

Right. I also think the best way is to classify locks more
perfectly and automatically w/o bothering others - but we cannot
achieve it in current way - relying on caller sites.

> Lockdep instead.  You can not and must not transfer responsibility for
> documenting locks to the subsystem maintainers, as if it is some sort

I said it can be done by each sub-system expert best, but it's not
about responsibility. I also think we should not transfer
respensibility to them. Sorry for confusing you.

> of bug that the locks are not "classified correctly".  The fact that

However, "locks are not classified correctly, yet" is a fact. Of
course, it has been just annotated as enough as lockdep works for
now. But many things are still left.

> your new technique requires clasification is a BUG, and goes against

Sorry to say it, but I don't think so, it's not a bug. To classify
locks more precisely just becomes required. For *example*,

    Lockdep automatically classifies locks 30%.
    Manually we have classified locks 20% more precisely until now.
    Cross-release requires to classify locks 20% more precisely.
    However, we still have 30% locks classified unproperly,
    but it's enough to work and those don't affect lockdep's work.

> the original design principle of LOCKDEP in the first place.

It's never against the original principle but following exactly
same as original principle.

>> I admit to make it optional for now, but I don't see why you
>> want to remove it entierly.
> 
> So are you willing to take my patch?  Or give me permission to keep in
> the ext4 tree?

I agree with your patch. Or I want another to be taken which makes
cross-release optional. Whatever.

Thank you for your opinion.

> 
> 						- Ted
> 

-- 
Thanks,
Byungchul
