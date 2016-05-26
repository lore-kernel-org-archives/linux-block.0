Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: clear q->mq_ops if init fail
To: Ming Lin <mlin@kernel.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <1464243807-27526-1-git-send-email-mlin@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57470DCC.1060400@kernel.dk>
Date: Thu, 26 May 2016 08:53:00 -0600
MIME-Version: 1.0
In-Reply-To: <1464243807-27526-1-git-send-email-mlin@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/26/2016 12:23 AM, Ming Lin wrote:
> From: Ming Lin <ming.l@samsung.com>
>
> blk_mq_init_queue() calls blk_mq_init_allocated_queue(), but q->mq_ops
> was not cleared when blk_mq_init_allocated_queue() fails.
> Then blk_cleanup_queue() calls blk_mq_free_queue() which will crash because:
> - q->all_q_node is not added to all_q_list yet
> - q->tag_set is NULL
> - hctx was not setup yet or already freed
>
> Fixed it by clearing q->mq_ops on error path.

Thanks Ming, applied for this series.

-- 
Jens Axboe
