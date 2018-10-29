Return-Path: <hare@suse.de>
Subject: Re: [PATCH 07/14] blk-mq: support multiple hctx maps
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-8-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <90a7b15b-4770-079f-7a98-7a21b812a8a9@suse.de>
Date: Mon, 29 Oct 2018 08:39:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211626.12692-8-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> Add support for the tag set carrying multiple queue maps, and
> for the driver to inform blk-mq how many it wishes to support
> through setting set->nr_maps.
> 
> This adds an mq_ops helper for drivers that support more than 1
> map, mq_ops->flags_to_type(). The function takes request/bio flags
> and CPU, and returns a queue map index for that. We then use the
> type information in blk_mq_map_queue() to index the map set.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq.c         | 85 ++++++++++++++++++++++++++++--------------
>   block/blk-mq.h         | 19 ++++++----
>   include/linux/blk-mq.h |  7 ++++
>   3 files changed, 76 insertions(+), 35 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
