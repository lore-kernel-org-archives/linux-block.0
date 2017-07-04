Return-Path: <mst@redhat.com>
Date: Wed, 5 Jul 2017 00:39:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 7/8] virtio_blk: quiesce/unquiesce live IO when entering
 PM states
Message-ID: <20170705003734-mutt-send-email-mst@kernel.org>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-8-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499154912-10420-8-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 04, 2017 at 10:55:11AM +0300, Sagi Grimberg wrote:
> We must make sure that no requests are being queued before we iterate
> delete vqs. quiesce/unquiesce the request queue istead of start/stop
> hw queues.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

But please remember to Cc virtio mailing list on virtio patches.


> ---
>  drivers/block/virtio_blk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 0297ad7c1452..4e02aa5fdac0 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -840,7 +840,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
>  
> -	blk_mq_stop_hw_queues(vblk->disk->queue);
> +	blk_mq_quiesce_queue(vblk->disk->queue);
>  
>  	vdev->config->del_vqs(vdev);
>  	return 0;
> @@ -857,7 +857,7 @@ static int virtblk_restore(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> -	blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> +	blk_mq_unquiesce_queue(vblk->disk->queue);
>  	return 0;
>  }
>  #endif
> -- 
> 2.7.4
