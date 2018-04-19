Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blkcg: not hold blkcg lock when deactivating policy.
To: jiang.biao2@zte.com.cn
Cc: paolo.valente@linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, tj@kernel.org, zhong.weidong@zte.com.cn,
 wen.yang99@zte.com.cn, ulf.hansson@linaro.org, linus.walleij@linaro.org,
 broonie@kernel.org
References: <201804190854343346115@zte.com.cn>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bb119bf0-b7f2-cb25-8de4-6016a3dd7a9e@kernel.dk>
Date: Wed, 18 Apr 2018 20:09:26 -0600
MIME-Version: 1.0
In-Reply-To: <201804190854343346115@zte.com.cn>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/18/18 6:54 PM, jiang.biao2@zte.com.cn wrote:
>>>> by chance, did you check whether this may cause problems with bfq,
>>>> being the latter not protected by the queue lock as cfq?
>>> Checked the bfq code, bfq seems never used blkcg lock derectly, and
>>> update of blkg in the common code is protected by both queue and
>>> blkcg locks, so IMHO this patch would not introduce any new problem
>>> with bfq, even though bfq is not protected by queue lock.
>>> On the other hand, the locks (queue lock/blkcg lock) used to protected
>>> the update of blkg seems a bit too heavyweight, especially the queue lock
>>> which is used too widely may cause races with other contexts. I wonder
>>> if there is any way to ease the case? e.g. add a new lock for blkg's own.:)
>>
>> It might make sense to lock it separately, but I would not worry
>> about it unless it shows up as hot in your testing.
> Actually, we've met a triggering of nmi_watchdog, blocked at the queue lock
> in blkcg_print_blkgs(), caused by the slow serial console and too many printks.
> Related discussion is here,
> https://bugzilla.kernel.org/show_bug.cgi?id=199003
> Even though it's not caused by the queue lock directly, it would not happen
> without using queue lock. The queue lock is big and used too widely, using it
> would intensify the race, so we're trying to understand the locks using in blkg,
> and maybe could improve the situation.

The queue lock is only used widely on non blk-mq, where it is the only
lock really. Doing serial IO under a spinlock is always going to suck,
regardless of how contended it is.

-- 
Jens Axboe
