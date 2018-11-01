Return-Path: <hare@suse.de>
Subject: Re: [PATCH 09/16] blk-mq: cache request hardware queue mapping
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-10-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <222351ec-bf5b-526c-33dd-bd2e8ba051fa@suse.de>
Date: Thu, 1 Nov 2018 10:27:16 +0100
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-10-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/30/18 7:32 PM, Jens Axboe wrote:
> We call blk_mq_map_queue() a lot, at least two times for each
> request per IO, sometimes more. Since we now have an indirect
> call as well in that function. cache the mapping so we don't
> have to re-call blk_mq_map_queue() for the same request
> multiple times.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-flush.c      | 12 ++++--------
>   block/blk-mq-debugfs.c |  4 +---
>   block/blk-mq-sched.c   |  6 ++----
>   block/blk-mq-tag.c     |  9 +--------
>   block/blk-mq.c         | 22 +++++++++-------------
>   block/blk-mq.h         |  5 +----
>   include/linux/blkdev.h |  1 +
>   7 files changed, 19 insertions(+), 40 deletions(-)
> 
Hehe.
I had been wondering about this since the original mq implementation, 
but was told not to worry :-)

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
