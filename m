Return-Path: <mst@redhat.com>
Date: Tue, 10 Jan 2017 06:10:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] virtio_blk: fix panic in initialization error path
Message-ID: <20170110060937-mutt-send-email-mst@kernel.org>
References: <4bc0f759ce198dc36e9b678a3c8f69bfef5cb728.1483990999.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4bc0f759ce198dc36e9b678a3c8f69bfef5cb728.1483990999.git.osandov@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 09, 2017 at 11:44:12AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> If blk_mq_init_queue() returns an error, it gets assigned to
> vblk->disk->queue. Then, when we call put_disk(), we end up calling
> blk_put_queue() with the ERR_PTR, causing a bad dereference. Fix it by
> only assigning to vblk->disk->queue on success.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Jens, do you mind picking this one up as well, since
you have one virtio-blk patch already?


> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 5545a679abd8..8587361e5356 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -628,11 +628,12 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	if (err)
>  		goto out_put_disk;
>  
> -	q = vblk->disk->queue = blk_mq_init_queue(&vblk->tag_set);
> +	q = blk_mq_init_queue(&vblk->tag_set);
>  	if (IS_ERR(q)) {
>  		err = -ENOMEM;
>  		goto out_free_tags;
>  	}
> +	vblk->disk->queue = q;
>  
>  	q->queuedata = vblk;
>  
> -- 
> 2.11.0
