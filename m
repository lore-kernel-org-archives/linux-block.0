Return-Path: <hare@suse.de>
Subject: Re: [PATCH 09/12] virtio_blk: Use blk_rq_is_scsi()
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-10-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c1ca05a5-f7fb-fd9a-e682-a4dbbc214fd7@suse.de>
Date: Fri, 18 Aug 2017 09:39:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170817232311.25948-10-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 01:23 AM, Bart Van Assche wrote:
> This patch does not change any functionality.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 1498b899a593..0ba1eb911a42 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -265,7 +265,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	}
>  
>  	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> -	if (req_op(req) == REQ_OP_SCSI_IN || req_op(req) == REQ_OP_SCSI_OUT)
> +	if (blk_rq_is_scsi(req))
>  		err = virtblk_add_req_scsi(vblk->vqs[qid].vq, vbr, vbr->sg, num);
>  	else
>  		err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
