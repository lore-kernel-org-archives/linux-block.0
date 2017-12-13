Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:48202 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdLMFi0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Dec 2017 00:38:26 -0500
Subject: Re: [PATCH] locking/lockdep: Add CONFIG_LOCKDEP_AGGRESSIVE
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@lge.com,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
References: <20171211035017.32678-1-tytso@mit.edu>
 <CA+55aFxU6A5doeHh6QagAPpTKvdHzUimAcq+gnnrva=TUtLzhg@mail.gmail.com>
 <c4a4b7be-b3c4-ed56-21a5-d3396b8a4e25@lge.com>
 <CA+55aFw3kiLObrtMTTiJBJW44gWV=cc=-rZs46XyuLjaTvxcHg@mail.gmail.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <ccb7fefe-29a7-2868-424b-bf4f9135d8bb@lge.com>
Date: Wed, 13 Dec 2017 14:38:24 +0900
MIME-Version: 1.0
In-Reply-To: <CA+55aFw3kiLObrtMTTiJBJW44gWV=cc=-rZs46XyuLjaTvxcHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/13/2017 2:00 AM, Linus Torvalds wrote:
> On Mon, Dec 11, 2017 at 9:20 PM, Byungchul Park <byungchul.park@lge.com> wrote:
>>
>> The *problem* is false positives, since locks and waiters in
>> kernel are not classified properly
> 
> So the problem is that those false positives apparently end up being a
> big deal for the filesystem people.
> 
> I personally don't think the code itself has to be removed, but I do
> think that it should never have been added on as part of the generic
> lock proving, and should always have been a separate config option.

I admit it.

> I also feel that you dismiss "false positives" much too easily. A

I don't dismiss the ones easily...

Anyway, I mostly agree with your whole opinion.

Thanks for replying.

> false positive is a big problem - because it makes people ignore the
> real cases (or just disable the functionality entirely).
> 
> It's why I am very quick to disable compiler warnings that have false
> positives, for example. Just a couple of "harmless" false positive
> warnings will poison the real warnings for people because they'll get
> used to seeing warnings while building, and no longer actually look at
> them.
> 
>                   Linus
> 

-- 
Thanks,
Byungchul
