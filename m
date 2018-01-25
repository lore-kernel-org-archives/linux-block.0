Return-Path: <baijiaju1990@163.com>
Subject: Re: [PATCH] block: blk-mq-sched: Replace GFP_ATOMIC with GFP_KERNEL
 in blk_mq_sched_assign_ioc
To: Jens Axboe <axboe@kernel.dk>, Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1516848386-5720-1-git-send-email-baijiaju1990@gmail.com>
 <7a1809ce-c456-0d53-4d3b-2368fb19bfd8@kernel.dk>
From: Jia-Ju Bai <baijiaju1990@163.com>
Message-ID: <00ecf255-c5cf-1e32-d754-96f70460a734@163.com>
Date: Thu, 25 Jan 2018 11:40:38 +0800
MIME-Version: 1.0
In-Reply-To: <7a1809ce-c456-0d53-4d3b-2368fb19bfd8@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 2018/1/25 11:34, Jens Axboe wrote:
> On 1/24/18 7:46 PM, Jia-Ju Bai wrote:
>> The function ioc_create_icq here is not called in atomic context.
>> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
>>
>> This is found by a static analysis tool named DCNS written by myself.
> But it's running off the IO submission path, so by definition the GFP
> mask cannot include anything that will do IO. GFP_KERNEL will make
> it deadlock prone.
>
> It could be GFP_NOIO, but that's also overlooking the fact that we can
> have preemption disabled here.
>
> On top of all that, we want something quick here, and it's OK that
> it fails. That's preferable to blocking. So we want an atomic alloc,
> even if we could tolerate a blocking one.
>
> So I think you need to fix your static analysis tool, it's missing
> a few key things.
>

Okay, thanks for your advice.


Thanks,
Jia-Ju Bai
