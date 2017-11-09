Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:51731 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754505AbdKIMpk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Nov 2017 07:45:40 -0500
Received: by mail-it0-f54.google.com with SMTP id o135so10595111itb.0
        for <linux-block@vger.kernel.org>; Thu, 09 Nov 2017 04:45:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3608285c-614a-36cc-5f7b-5fb5708c1a84@intel.com>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-11-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZNcd7Nu2dAajqBcn44c05jY76BUNOM5vBPzfhVub_HhQ@mail.gmail.com> <3608285c-614a-36cc-5f7b-5fb5708c1a84@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Nov 2017 13:45:39 +0100
Message-ID: <CACRpkdbDWmOTOP1JmriFkpH_rEYJQv17_OhBvNbHY-4Y6m61qA@mail.gmail.com>
Subject: Re: [PATCH V13 10/10] mmc: block: blk-mq: Stop using legacy recovery
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 9, 2017 at 8:43 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 08/11/17 11:38, Linus Walleij wrote:
>> On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>>> There are only a few things the recovery needs to do. Primarily, it just
>>> needs to:
>>>         Determine the number of bytes transferred
>>>         Get the card back to transfer state
>>>         Determine whether to retry
>>>
>>> There are also a couple of additional features:
>>>         Reset the card before the last retry
>>>         Read one sector at a time
>>>
>>> The legacy code spent much effort analyzing command errors, but commands
>>> fail fast, so it is simpler just to give all command errors the same number
>>> of retries.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> I have nothing against the patch as such. In fact something
>> like this makes a lot of sense (to me).
>>
>> But this just makes mmc_blk_rw_recovery() look really nice.
>>
>> And leaves a very ugly mmc_blk_issue_rw_rq() with the legacy
>> error handling in-tree.
>>
>> The former function isn't even named with some *mq* infix
>> making it clear that the new recovery path only happens
>> in the MQ case.
>>
>> If newcomers read this code in the MMC stack they will
>> just tear their hair, scream and run away. Even faster than
>> before.
>>
>> How are they supposed to know which functions are used on
>> which path? Run ftrace?
>
> You're kidding me right?  You don't know how to find where a function used?

What I mean is that there are now several functions in the same
file doing similar things, and it is pretty hard for a newcomer
already (IMO) to understand how the MMC/SD stack works.

This phenomenon of code complexity is not just making me
frustrated but also you, because you get annoyed that people
like me don't "just get it".

>> This illustrates firmly why we need to refactor and/or kill off
>> the old block layer interface *first* then add MQ on top.
>
> No it doesn't!  You are playing games!

You need to stop your snarky and undfriendly attitude.

Look Adrian: you have one (1) person reviewing your patches.
That is me.

I think need to quote Documentation/process/6.Followthrough.rst
in verbatim (it's an awesome piece of text!)

----8<--------8<-------8<------

Working with reviewers
----------------------

A patch of any significance will result in a number of comments from other
developers as they review the code.  Working with reviewers can be, for
many developers, the most intimidating part of the kernel development
process.  Life can be made much easier, though, if you keep a few things in
mind:

 - If you have explained your patch well, reviewers will understand its
   value and why you went to the trouble of writing it.  But that value
   will not keep them from asking a fundamental question: what will it be
   like to maintain a kernel with this code in it five or ten years later?
   Many of the changes you may be asked to make - from coding style tweaks
   to substantial rewrites - come from the understanding that Linux will
   still be around and under development a decade from now.

 - Code review is hard work, and it is a relatively thankless occupation;
   people remember who wrote kernel code, but there is little lasting fame
   for those who reviewed it.  So reviewers can get grumpy, especially when
   they see the same mistakes being made over and over again.  If you get a
   review which seems angry, insulting, or outright offensive, resist the
   impulse to respond in kind.  Code review is about the code, not about
   the people, and code reviewers are not attacking you personally.

 - Similarly, code reviewers are not trying to promote their employers'
   agendas at the expense of your own.  Kernel developers often expect to
   be working on the kernel years from now, but they understand that their
   employer could change.  They truly are, almost without exception,
   working toward the creation of the best kernel they can; they are not
   trying to create discomfort for their employers' competitors.

What all of this comes down to is that, when reviewers send you comments,
you need to pay attention to the technical observations that they are
making.  Do not let their form of expression or your own pride keep that
from happening.  When you get review comments on a patch, take the time to
understand what the reviewer is trying to say.  If possible, fix the things
that the reviewer is asking you to fix.  And respond back to the reviewer:
thank them, and describe how you will answer their questions.

----8<--------8<-------8<------

> One function could be named
> differently, so that is evidence the whole patch set should be ignored.

No I was not pointing to that at all.

> The old code is rubbish.  There is nothing worth keeping.  Churning it
> around is a waste of everybody's time.  Review and test the new code.
> Delete the old code.  Much much simpler!

Yeah, but you do not delete the old code in your patch
set so why are you are saying this?

The essence of my response to patch 3 was exactly that if
you have this "my way or the highway" (i.e. delete all the old
code paths) attitude to the code (which I kind of understand)
Then go all in and actually delete it.

As it is, here, at the end of the patch set, the old legacy block
path and combersome error handling still exists.

Yours,
Linus Walleij
