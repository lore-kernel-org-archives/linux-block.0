Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:45893 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeACIK4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jan 2018 03:10:56 -0500
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
 <20171230204417.GF27959@bombadil.infradead.org>
 <20171230224028.GC3366@thunk.org>
 <f2bc220a-a363-122a-dbf9-e5416c550899@lge.com>
 <20180103070556.GA22583@thunk.org>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <66296fcb-8df0-9697-2825-efa37c234ad9@lge.com>
Date: Wed, 3 Jan 2018 17:10:52 +0900
MIME-Version: 1.0
In-Reply-To: <20180103070556.GA22583@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 1/3/2018 4:05 PM, Theodore Ts'o wrote:
> On Wed, Jan 03, 2018 at 11:10:37AM +0900, Byungchul Park wrote:
>>> The point I was trying to drive home is that "all we have to do is
>>> just classify everything well or just invalidate the right lock
>>
>> Just to be sure, we don't have to invalidate lock objects at all but
>> a problematic waiter only.
> 
> So essentially you are proposing that we have to play "whack-a-mole"
> as we find false positives, and where we may have to put in ad-hoc
> plumbing to only invalidate "a problematic waiter" when it's
> problematic --- or to entirely suppress the problematic waiter

If we have too many problematic completions(waiters) to handle it,
then I agree with you. But so far, only one exits and it seems able
to be handled even in the future on my own.

Or if you believe that we have a lot of those kind of completions
making trouble so we cannot handle it, the (4) by Amir would work,
no? I'm asking because I'm really curious about your opinion..

> altogether.  And in that case, a file system developer might be forced
> to invalidate a lock/"waiter"/"completion" in another subsystem.

As I said, with regard to the invalidation, we don't have to
consider locks at all. It's enough to invalidate the waiter only.

> I will also remind you that doing this will trigger a checkpatch.pl
> *error*:

This is what we decided. And I think the decision is reasonable for
original lockdep. But I wonder if we should apply the same decision
on waiters. I don't insist but just wonder.

> ERROR("LOCKDEP", "lockdep_no_validate class is reserved for device->mutex.\n" . $herecurr);
> 
> 	 		      	       		- Ted
> 

-- 
Thanks,
Byungchul
