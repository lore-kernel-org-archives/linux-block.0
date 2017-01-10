Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967497AbdAJCrO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Jan 2017 21:47:14 -0500
Subject: Re: [PATCH] virtio_blk: fix panic in initialization error path
To: Omar Sandoval <osandov@osandov.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <4bc0f759ce198dc36e9b678a3c8f69bfef5cb728.1483990999.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Jason Wang <jasowang@redhat.com>
Message-ID: <82025cef-6b5d-f640-dce0-82b52881753b@redhat.com>
Date: Tue, 10 Jan 2017 10:47:06 +0800
MIME-Version: 1.0
In-Reply-To: <4bc0f759ce198dc36e9b678a3c8f69bfef5cb728.1483990999.git.osandov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 2017年01月10日 03:44, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>
> If blk_mq_init_queue() returns an error, it gets assigned to
> vblk->disk->queue. Then, when we call put_disk(), we end up calling
> blk_put_queue() with the ERR_PTR, causing a bad dereference. Fix it by
> only assigning to vblk->disk->queue on success.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>   drivers/block/virtio_blk.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 5545a679abd8..8587361e5356 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -628,11 +628,12 @@ static int virtblk_probe(struct virtio_device *vdev)
>   	if (err)
>   		goto out_put_disk;
>   
> -	q = vblk->disk->queue = blk_mq_init_queue(&vblk->tag_set);
> +	q = blk_mq_init_queue(&vblk->tag_set);
>   	if (IS_ERR(q)) {
>   		err = -ENOMEM;
>   		goto out_free_tags;
>   	}
> +	vblk->disk->queue = q;
>   
>   	q->queuedata = vblk;
>   

Acked-by: Jason Wang <jasowang@redhat.com>
