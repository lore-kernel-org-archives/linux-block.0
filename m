Subject: Re: __blk_mq_tag_busy() weirdness
To: Hannes Reinecke <hare@suse.de>
References: <6e2db454-b2f7-16a1-acc6-999ee09fdf10@suse.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <e60d5aef-ad4c-687e-1e46-1262a7a80991@fb.com>
Date: Mon, 23 Jan 2017 08:12:37 -0700
MIME-Version: 1.0
In-Reply-To: <6e2db454-b2f7-16a1-acc6-999ee09fdf10@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/23/2017 07:07 AM, Hannes Reinecke wrote:
> Hi Jens,
> 
> while hunting yet another queue stall I've been looking at
> __blk_mq_tag_busy():
> 
> bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
> {
> 	if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) &&
> 	    !test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> 		atomic_inc(&hctx->tags->active_queues);
> 
> 	return true;
> }
> 
> Is this some subtle usage of bitops (and I just didn't grasp it) or is
> the first test_bit() pointless?

Is it subtle? I've used that in a few places in blk-mq, and in mm/filemap.c
as well:

commit 7fcbbaf18392f0b17c95e2f033c8ccf87eecde1d
Author: Jens Axboe <axboe@fb.com>
Date:   Thu May 22 11:54:16 2014 -0700

    mm/filemap.c: avoid always dirtying mapping->flags on O_DIRECT

the test_and_* functions always need to be locked, and there's no point
in doing that if we only rarely need to change the value.

> If the former I _really_ would like to have some comments on why this is
> required.

Sure, but I really didn't think it was black magic.

-- 
Jens Axboe
