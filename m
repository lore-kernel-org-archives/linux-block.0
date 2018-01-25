Return-Path: <baijiaju1990@gmail.com>
Return-Path: <baijiaju1990@gmail.com>
Subject: Re: [PATCH 1/2] block: blk-tag: Replace GFP_ATOMIC with GFP_KERNEL in
 __blk_queue_init_tags
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1516851525-6828-1-git-send-email-baijiaju1990@gmail.com>
 <7b20dc97-9240-726a-5664-c40c9421ef61@kernel.dk>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <bfb2759d-0f35-7baf-8637-054a669f01b6@gmail.com>
Date: Thu, 25 Jan 2018 16:03:36 +0800
MIME-Version: 1.0
In-Reply-To: <7b20dc97-9240-726a-5664-c40c9421ef61@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 2018/1/25 11:44, Jens Axboe wrote:
> On 1/24/18 8:38 PM, Jia-Ju Bai wrote:
>> After checking all possible call chains to kmalloc here,
>> my tool finds that kmalloc is never called in atomic context.
>> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
>>
>> This is found by a static analysis tool named DCNS written by myself.
> These two look OK to me, mostly.

It sounds good :)

> One issue is that blk_queue_init_tags()
> can be used to resize tags, in which case it's called with the
> queue lock held. Nobody is using it like that anymore, though. So I'd
> prefer if you did a v2 of this patch, and include a correction to that
> comment.
>

I am not sure what you mean...

Do you mean that the code in blk_queue_init_tags:
     else if (q->queue_tags) {
         ...
     }
can be deleted?

Or just delete the comment before blk_queue_init_tags?
  * Queue lock must be held here if the function is called to resize an
  * existing map.
  **/

Or add the description "The case that queue lock held is never used" in 
my patches?


Thanks,
Jia-Ju Bai
