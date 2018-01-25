Return-Path: <baijiaju1990@gmail.com>
Return-Path: <baijiaju1990@gmail.com>
Subject: Re: [PATCH] block: blk-mq-sched: Replace GFP_ATOMIC with GFP_KERNEL
 in blk_mq_sched_assign_ioc
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1516848386-5720-1-git-send-email-baijiaju1990@gmail.com>
 <20180125025811.GT13338@ZenIV.linux.org.uk>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <70efc238-9517-7cfa-03ce-ba9c3ba0ebd4@gmail.com>
Date: Thu, 25 Jan 2018 11:13:56 +0800
MIME-Version: 1.0
In-Reply-To: <20180125025811.GT13338@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 2018/1/25 10:58, Al Viro wrote:
> On Thu, Jan 25, 2018 at 10:46:26AM +0800, Jia-Ju Bai wrote:
>> The function ioc_create_icq here is not called in atomic context.
>> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
>>
>> This is found by a static analysis tool named DCNS written by myself.
> Umm...  Some human-readable analysis would be welcome.  FWIW, I've tried to
> put a proof together, but...
> 	struct blk_mq_ops->timeout = nvme_timeout
> 	nvme_timeout()
> 		nvme_alloc_request()
> 			blk_mq_alloc_request_hctx()
> 				blk_mq_get_request()
> 					blk_mq_sched_assign_ioc()
> ... and while I have not traced the call chain further, the look of that
> function (nvme_timeout()) strongly suggests that it *is* meant to be
> called from bloody atomic context.
>
> "My tool has found that place/put together a proof" is nice, but it
> doesn't replace the proof itself...

Thanks for reply :)

I have checked the given call chain, and find that nvme_dev_disable in 
nvme_timeout calls mutex_lock that can sleep.
Thus, I suppose this call chain is not in atomic context.

Besides, how do you find that "function (nvme_timeout()) strongly 
suggests that it *is* meant to be called from bloody atomic context"?
I check the comments in nvme_timeout, and do not find related description...

By the way, do you mean that I should add "My tool has proved that this 
function is never called in atomic context" in the description?


Thanks,
Jia-Ju Bai
