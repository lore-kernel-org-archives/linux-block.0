Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blkcg: not hold blkcg lock when deactivating policy.
To: jiang.biao2@zte.com.cn, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, tj@kernel.org,
 zhong.weidong@zte.com.cn, wen.yang99@zte.com.cn, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org
References: <201804181718167747438@zte.com.cn>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3a699198-edf4-7337-f5e7-faaa6b058713@kernel.dk>
Date: Wed, 18 Apr 2018 08:40:20 -0600
MIME-Version: 1.0
In-Reply-To: <201804181718167747438@zte.com.cn>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/18/18 3:18 AM, jiang.biao2@zte.com.cn wrote:
> Hi,
>>> Il giorno 17 apr 2018, alle ore 09:10, Jiang Biao <jiang.biao2@zte.com.cn> ha scritto:
>>>
>>> As described in the comment of blkcg_activate_policy(),
>>> *Update of each blkg is protected by both queue and blkcg locks so
>>> that holding either lock and testing blkcg_policy_enabled() is
>>> always enough for dereferencing policy data.*
>>> with queue lock held, there is no need to hold blkcg lock in
>>> blkcg_deactivate_policy(). Similar case is in
>>> blkcg_activate_policy(), which has removed holding of blkcg lock in
>>> commit 4c55f4f9ad3001ac1fefdd8d8ca7641d18558e23.
>>>
>>
>> Hi,
>> by chance, did you check whether this may cause problems with bfq,
>> being the latter not protected by the queue lock as cfq?
> Checked the bfq code, bfq seems never used blkcg lock derectly, and 
> update of blkg in the common code is protected by both queue and 
> blkcg locks, so IMHO this patch would not introduce any new problem
> with bfq, even though bfq is not protected by queue lock.
> On the other hand, the locks (queue lock/blkcg lock) used to protected
> the update of blkg seems a bit too heavyweight, especially the queue lock 
> which is used too widely may cause races with other contexts. I wonder
> if there is any way to ease the case? e.g. add a new lock for blkg's own.:) 

It might make sense to lock it separately, but I would not worry
about it unless it shows up as hot in your testing.

I've applied your patch, thanks.

-- 
Jens Axboe
