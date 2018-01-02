Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:49672 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeABH53 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jan 2018 02:57:29 -0500
Subject: Re: About the try to remove cross-release feature entirely by Ingo
To: Matthew Wilcox <willy@infradead.org>
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
References: <CANrsvRPQcWz-p_3TYfNf+Waek3bcNNPniXhFzyyS=7qbCqzGyg@mail.gmail.com>
 <20171229014736.GA10341@X58A-UD3R> <20171229035146.GA11757@thunk.org>
 <20171229072851.GA12235@X58A-UD3R>
 <20171230061624.GA27959@bombadil.infradead.org>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <5256580e-27d3-8c16-5ba6-45f5a06e857a@lge.com>
Date: Tue, 2 Jan 2018 16:57:23 +0900
MIME-Version: 1.0
In-Reply-To: <20171230061624.GA27959@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/30/2017 3:16 PM, Matthew Wilcox wrote:
> On Fri, Dec 29, 2017 at 04:28:51PM +0900, Byungchul Park wrote:
>> On Thu, Dec 28, 2017 at 10:51:46PM -0500, Theodore Ts'o wrote:
>>> On Fri, Dec 29, 2017 at 10:47:36AM +0900, Byungchul Park wrote:
>>>>
>>>>     (1) The best way: To classify all waiters correctly.
>>>
>>> It's really not all waiters, but all *locks*, no?
>>
>> Thanks for your opinion. I will add my opinion on you.
>>
>> I meant *waiters*. Locks are only a sub set of potential waiters, which
>> actually cause deadlocks. Cross-release was designed to consider the
>> super set including all general waiters such as typical locks,
>> wait_for_completion(), and lock_page() and so on..
> 
> I think this is a terminology problem.  To me (and, I suspect Ted), a
> waiter is a subject of a verb while a lock is an object.  So Ted is asking
> whether we have to classify the users, while I think you're saying we
> have extra objects to classify.
> 
> I'd be comfortable continuing to refer to completions as locks.  We could
> try to come up with a new object name like waitpoints though?

Right. Then "event" should be used as an object name than "waiter".

>> The problems come from wrong classification. Waiters either classfied
>> well or invalidated properly won't bitrot.
> 
> I disagree here.  As Ted says, it's the interactions between the

As you know, the classification is something already considering
the interactions between the subsystems and classified. But, yes.
That is just what we have to do untimately but not what we can do
right away. That's why I suggested all 3 ways + 1 way (by Amir).

> subsystems that leads to problems.  Everything's goig to work great
> until somebody does something in a way that's never been tried before.

Yes. Everything has worked great so far, since the classification
by now is done well enough at least to avoid such problems, not
perfect though. IMO, the classification does not have to be perfect
but needs to be good enough to work.

--
Thanks,
Byungchul
