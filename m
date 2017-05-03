Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
CC: "hch@infradead.org" <hch@infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
Date: Wed, 3 May 2017 17:35:21 +0000
Message-ID: <1493832921.3901.22.camel@sandisk.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
	 <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
	 <20170503040303.GA20187@ming.t460p>
	 <f52b4478-0d18-a248-3fbf-721216a79f92@fb.com>
	 <370fbeb6-d832-968a-2759-47f16b866551@kernel.dk>
	 <20170503150351.GA7927@ming.t460p>
	 <31bb973e-d9cf-9454-58fd-4893701088c5@kernel.dk>
	 <20170503153808.GB7927@ming.t460p> <20170503165201.GB9706@ming.t460p>
	 <20170503170315.GD9706@ming.t460p>
	 <24ff7ca6-73d6-f8a5-b7d9-e92d0bfdb4b0@kernel.dk>
	 <1493831722.3901.19.camel@sandisk.com>
	 <d537355e-3581-fc86-62ce-0757a84d9c1a@kernel.dk>
In-Reply-To: <d537355e-3581-fc86-62ce-0757a84d9c1a@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-05-03 at 11:24 -0600, Jens Axboe wrote:
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/m=
tip32xx.c
> index 3a779a4f5653..33b5d1382c45 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> [ ... ]
> @@ -4009,7 +4009,7 @@ static int mtip_block_remove(struct driver_data *dd=
)
>  						dd->disk->disk_name);
> =20
>  	blk_freeze_queue_start(dd->queue);
> -	blk_mq_stop_hw_queues(dd->queue);
> +	blk_mq_stop_hw_queues(dd->queue, true);
>  	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
> =20
>  	/*

Hello Jens,

How about replacing the blk_freeze_queue_start() and blk_mq_stop_hw_queues(=
)
calls by a single call to blk_set_queue_dying()? I think that would be more
appropriate in the context of mtip_block_remove().

> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 6b98ec2a3824..ce5490938232 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -656,7 +656,7 @@ static void nbd_clear_req(struct request *req, void *=
data, bool reserved)
> =20
>  static void nbd_clear_que(struct nbd_device *nbd)
>  {
> -	blk_mq_stop_hw_queues(nbd->disk->queue);
> +	blk_mq_stop_hw_queues(nbd->disk->queue, true);
>  	blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
>  	blk_mq_start_hw_queues(nbd->disk->queue);
>  	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");

A similar comment here: since nbd_clear_que() is called just before shuttin=
g
down the block layer queue in the NBD driver, how about replacing the
blk_mq_stop_hw_queues() / blk_mq_start_hw_queues() pair by a single=20
blk_set_queue_dying() call?

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 94173de1efaa..a73d2823cdb2 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -844,7 +844,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
> =20
> -	blk_mq_stop_hw_queues(vblk->disk->queue);
> +	blk_mq_stop_hw_queues(vblk->disk->queue, true);
> =20
>  	vdev->config->del_vqs(vdev);
>  	return 0;

Since the above blk_mq_stop_hw_queues() call is followed by a .del_vqs() ca=
ll,
shouldn't the blk_mq_stop_hw_queues() / blk_mq_start_hw_queues() pair in th=
e
virtio_blk driver be changed into a blk_mq_freeze_queue() / blk_mq_unfreeze=
_queue()
pair?

Thanks,

Bart.=
