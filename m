Return-Path: <hare@suse.de>
Subject: Re: [PATCH 09/28] dm: remove legacy IO path
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-10-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <414bd2c8-6ee1-e63a-cadd-4ec37e3224f5@suse.de>
Date: Mon, 29 Oct 2018 07:53:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-10-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> dm supports both, and since we're killing off the legacy path
> in general, get rid of it in dm as well.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/md/Kconfig    |  11 --
>   drivers/md/dm-core.h  |  10 --
>   drivers/md/dm-mpath.c |  14 +-
>   drivers/md/dm-rq.c    | 293 ++++--------------------------------------
>   drivers/md/dm-rq.h    |   4 -
>   drivers/md/dm-sysfs.c |   3 +-
>   drivers/md/dm-table.c |  36 +-----
>   drivers/md/dm.c       |  21 +--
>   drivers/md/dm.h       |   1 -
>   9 files changed, 35 insertions(+), 358 deletions(-)
> 
[ .. ]

> @@ -790,11 +550,6 @@ int dm_mq_init_request_queue(struct mapped_device *md, struct dm_table *t)
>   	struct dm_target *immutable_tgt;
>   	int err;
>   
> -	if (!dm_table_all_blk_mq_devices(t)) {
> -		DMERR("request-based dm-mq may only be stacked on blk-mq device(s)");
> -		return -EINVAL;
> -	}
> -
>   	md->tag_set = kzalloc_node(sizeof(struct blk_mq_tag_set), GFP_KERNEL, md->numa_node_id);
>   	if (!md->tag_set)
>   		return -ENOMEM;
That warnint is still valid, no?

[ .. ]
> @@ -2217,13 +2211,6 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
>   
>   	switch (type) {
>   	case DM_TYPE_REQUEST_BASED:
> -		dm_init_normal_md_queue(md);
> -		r = dm_old_init_request_queue(md, t);
> -		if (r) {
> -			DMERR("Cannot initialize queue for request-based mapped device");
> -			return r;
> -		}
> -		break;
>   	case DM_TYPE_MQ_REQUEST_BASED:
>   		r = dm_mq_init_request_queue(md, t);
>   		if (r) {
I'd love to kill DM_TYPE_REQUEST_BASED completely, seeing that it's 
referring to the now-defunct legacy I/O path.
Mike?

Cheers,

Hannes
