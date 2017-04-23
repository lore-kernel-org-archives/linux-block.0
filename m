Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33486 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162141AbdDWR7m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Apr 2017 13:59:42 -0400
Received: by mail-lf0-f50.google.com with SMTP id 88so63934637lfr.0
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2017 10:59:42 -0700 (PDT)
Subject: Re: [PATCH 5/5] lightnvm: pblk: fix erase counters on error fail
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
 <1492817569-13532-6-git-send-email-javier@cnexlabs.com>
 <9d864388-00e8-d5e4-eef7-2f5d4d8f738d@lightnvm.io>
 <ACB77414-F14D-4FBE-90D2-555E95B127C3@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9a4a3f1d-1919-b2e6-31e9-48f5ad823638@lightnvm.io>
Date: Sun, 23 Apr 2017 19:59:37 +0200
MIME-Version: 1.0
In-Reply-To: <ACB77414-F14D-4FBE-90D2-555E95B127C3@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/22/2017 11:31 AM, Javier González wrote:
>
>> On 22 Apr 2017, at 11.22, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 04/22/2017 01:32 AM, Javier González wrote:
>>> When block erases fail, these blocks are marked bad. The number of valid
>>> blocks in the line was not updated, which could cause an infinite loop
>>> on the erase path.
>>>
>>> Fix this atomic counter and, in order to avoid taking an irq lock on the
>>> interrupt context, make the erase counters atomic too.
>>
>> I can't find out where the counters are used in irq context? Can you
>> point me in the right direction? I'll prefer for these counters to go
>> in under the existing line_lock.
>>
>
> This counter is line->blk_in_line, which is used on pblk_mark_bb. This
> is triggered on the erase completion path. Note that we do not want to
> wait until the recovery kicks in on the workqueue since the line might
> start getting recycled straight away if we are close to reaching
> capacity. This is indeed the scenario that triggers the race condition.
>
> Making all erase counters atomic allows us to avoid taking the
> line_lock. Note that the counters do not depend on each other.
>
>>> Also, in the case that a significant number of blocks become bad in a
>>> line, the result is the double shared metadata buffer (emeta) to stop
>>> the pipeline until all metadata is flushed to the media. Increase the
>>> number of metadata lines from 2 to 4 to avoid this case.
>>
>> How does moving to 4 lines solve this case? The way I read it is that
>> it only postpones when this occurs?
>>
>
> The chances of having more than 2 lines falling out of blocks after
> pre-condition are slim. Adding two more lines should be enough.
>
>>>
>>> [...]
>>>
>>> -#define PBLK_DATA_LINES 2
>>> +#define PBLK_DATA_LINES 4
>>
>> Why this change? I like to keep new features for 4.13. Only bugfixes for 4.12.
>
> This is the 4 lines referred above. I see it as a bug fix since we risk
> stalling the pipeline if a line goes above a certain number of bad
> blocks on initialization, but we can leave it out and fix this when we
> add in-line metadata on the write thread for 4.12
>
> Thanks,
> Javier
>

Okay. It tickles me a bit. However, to make it pretty, some refactoring 
is needed, which we won't push for this release.

Reviewed-by: Matias Bjørling <matias@cnexlabs.com>
