Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:49481 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdLLFUf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 00:20:35 -0500
Subject: Re: [PATCH] locking/lockdep: Add CONFIG_LOCKDEP_AGGRESSIVE
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@lge.com,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
References: <20171211035017.32678-1-tytso@mit.edu>
 <CA+55aFxU6A5doeHh6QagAPpTKvdHzUimAcq+gnnrva=TUtLzhg@mail.gmail.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <c4a4b7be-b3c4-ed56-21a5-d3396b8a4e25@lge.com>
Date: Tue, 12 Dec 2017 14:20:32 +0900
MIME-Version: 1.0
In-Reply-To: <CA+55aFxU6A5doeHh6QagAPpTKvdHzUimAcq+gnnrva=TUtLzhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/12/2017 6:06 AM, Linus Torvalds wrote:
> On Sun, Dec 10, 2017 at 7:50 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>> CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS can result
>> in a large number of false positives because lockdep doesn't
>> understand how to deal with multiple stacked loop or MD devices.
> 
> Guys, can we just remove this nasty crud already?
> 
> It's not working. Give it up. It was complex, it was buggy, it was slow.

Sorry to hear that, but it works well and fortunately it has not
been buggy until now, of course, it has been wrongly accused
twice though. Furthormore, it's not slow now since it was fixed.
You seem to say that w/o foundation but emotionally.

The *problem* is false positives, since locks and waiters in
kernel are not classified properly, at the moment, which is just
a fact that is not related to cross-release stuff at all. IOW,
that would be useful once all locks and waiters are classified
correctly. It might take time but the classifying is a must-do
we have to keep doing.

I admit to make it optional for now, but I don't see why you
want to remove it entierly.
> Now it's causing people to disable lockdep entirely, or play these
> kinds of games in unrelated trees.
> 
> It's time to give up on bad debugging, and definitely _not_ enable it
> by default for PROVE_LOCKING.
> 
> Ted: in the meantime, don't use PROVE_LOCKING. Just use
> DEBUG_LOCK_ALLOC instead. Please drop this patch from your tree.
> 
>                        Linus
> 

-- 
Thanks,
Byungchul
