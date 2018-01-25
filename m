Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] block: blk-tag: Replace GFP_ATOMIC with GFP_KERNEL in
 __blk_queue_init_tags
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1516851525-6828-1-git-send-email-baijiaju1990@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7b20dc97-9240-726a-5664-c40c9421ef61@kernel.dk>
Date: Wed, 24 Jan 2018 20:44:26 -0700
MIME-Version: 1.0
In-Reply-To: <1516851525-6828-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/24/18 8:38 PM, Jia-Ju Bai wrote:
> After checking all possible call chains to kmalloc here,
> my tool finds that kmalloc is never called in atomic context.
> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.

These two look OK to me, mostly. One issue is that blk_queue_init_tags()
can be used to resize tags, in which case it's called with the
queue lock held. Nobody is using it like that anymore, though. So I'd
prefer if you did a v2 of this patch, and include a correction to that
comment.

-- 
Jens Axboe
