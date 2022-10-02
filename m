Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524F1C433FE
	for <linux-block@archiver.kernel.org>; Sun,  2 Oct 2022 15:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJBPvE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Oct 2022 11:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJBPvE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Oct 2022 11:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CE21CFFF
        for <linux-block@vger.kernel.org>; Sun,  2 Oct 2022 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664725861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xc5wXjX6YMHDc48LC9ROPqe1Trpb5RnwdSq8IG2ryzA=;
        b=i9jHqvapLNdX5wqwDtmgMMlU0p2AvIFHTlta8E+PcM7Zg8gwA3RqzcC68OWU0N9IhpR3kY
        SpKkJLSFTKdISYUYP6cmGDJFQ6CqBtFwODvQ6fyebA3Vc7Sv2c4dUANcMGqPymok5mRvsV
        VJzrDoM2kOS5I1VXzY9g8gXCYhzP2EA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-TIQKteWvNgylcrHls2joIw-1; Sun, 02 Oct 2022 11:51:00 -0400
X-MC-Unique: TIQKteWvNgylcrHls2joIw-1
Received: by mail-wm1-f71.google.com with SMTP id i132-20020a1c3b8a000000b003b339a8556eso5070025wma.4
        for <linux-block@vger.kernel.org>; Sun, 02 Oct 2022 08:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Xc5wXjX6YMHDc48LC9ROPqe1Trpb5RnwdSq8IG2ryzA=;
        b=QAAH7+peo6qjplXM59D8hv7QHQizA9Diw+ajXN+NYDZ2MpNH+0n3Xto2WiNUq4746B
         FADPtdF1OyVVIvjKk52CZurytICZf07ARFpfzF1X79uI1VB88Ko1yDynI6l7amWQPNEz
         aH5+ByY5LZG6AEb31aJ8hRb32A5a2MHs/GqGVJZM/+zImE7fhVwuUyvR3Y/epOx9HjQ/
         hwHFge5k+TUvOOhVcqg34qvZbYw3xApb/yJ3XNCGA+0C6gzGXRB/NBSOms9DBbmm+rQg
         STvTNV2NHzXNDaqX139zjUf5xa3wI2OOTI5LUaKCoysYVudFVwT+OGpxbuKqlnt3WXAw
         09fA==
X-Gm-Message-State: ACrzQf246n9J36iZaPmMX9lN6lre3hyjwdPynLeK31k+RXJCWMxAUaQp
        fWMBqN+MCWhWckWR+yrHFB0srhs5JQKN3uT+xab8MeTx7udFt4wMHxc13qD9X/7s5ZK4Wvwox5L
        tKDr5XP98dbhRVUPsr7BtGY0=
X-Received: by 2002:a05:600c:687:b0:3b4:7280:9b7 with SMTP id a7-20020a05600c068700b003b4728009b7mr4564506wmn.189.1664725859397;
        Sun, 02 Oct 2022 08:50:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5owdchnkA0uNmm8BwwM3bwcyoaJD5N/yRbSjAp9gh2lCqpGxctsSJvp4lYlpUzkCGRGJ7ebA==
X-Received: by 2002:a05:600c:687:b0:3b4:7280:9b7 with SMTP id a7-20020a05600c068700b003b4728009b7mr4564494wmn.189.1664725859172;
        Sun, 02 Oct 2022 08:50:59 -0700 (PDT)
Received: from redhat.com ([2.55.17.78])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d530d000000b0022aeba020casm7588579wrv.83.2022.10.02.08.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 08:50:58 -0700 (PDT)
Date:   Sun, 2 Oct 2022 11:50:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com
Subject: Re: [PATCH 1/1] virtio-blk: simplify probe function
Message-ID: <20221002115024-mutt-send-email-mst@kernel.org>
References: <20221002154417.34583-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002154417.34583-1-mgurtovoy@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 02, 2022 at 06:44:17PM +0300, Max Gurtovoy wrote:
> Divide the extremely long probe function to small meaningful functions.
> This makes the code more readably and easy to maintain.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

This is subjective ... pls CC some reviewers. If Stefan or Paolo
ack this I will merge.

> ---
>  drivers/block/virtio_blk.c | 227 +++++++++++++++++++++----------------
>  1 file changed, 131 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 30255fcaf181..bdd44069bf6f 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -882,28 +882,13 @@ static const struct blk_mq_ops virtio_mq_ops = {
>  static unsigned int virtblk_queue_depth;
>  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>  
> -static int virtblk_probe(struct virtio_device *vdev)
> +static int virtblk_q_limits_set(struct virtio_device *vdev,
> +		struct request_queue *q)
>  {
> -	struct virtio_blk *vblk;
> -	struct request_queue *q;
> -	int err, index;
> -
> -	u32 v, blk_size, max_size, sg_elems, opt_io_size;
> -	u16 min_io_size;
>  	u8 physical_block_exp, alignment_offset;
> -	unsigned int queue_depth;
> -
> -	if (!vdev->config->get) {
> -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> -			__func__);
> -		return -EINVAL;
> -	}
> -
> -	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
> -			     GFP_KERNEL);
> -	if (err < 0)
> -		goto out;
> -	index = err;
> +	u16 min_io_size;
> +	u32 v, blk_size, max_size, sg_elems, opt_io_size;
> +	int err;
>  
>  	/* We need to know how many segments before we allocate. */
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
> @@ -917,73 +902,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	/* Prevent integer overflows and honor max vq size */
>  	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>  
> -	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
> -	if (!vblk) {
> -		err = -ENOMEM;
> -		goto out_free_index;
> -	}
> -
> -	mutex_init(&vblk->vdev_mutex);
> -
> -	vblk->vdev = vdev;
> -
> -	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
> -
> -	err = init_vq(vblk);
> -	if (err)
> -		goto out_free_vblk;
> -
> -	/* Default queue sizing is to fill the ring. */
> -	if (!virtblk_queue_depth) {
> -		queue_depth = vblk->vqs[0].vq->num_free;
> -		/* ... but without indirect descs, we use 2 descs per req */
> -		if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
> -			queue_depth /= 2;
> -	} else {
> -		queue_depth = virtblk_queue_depth;
> -	}
> -
> -	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
> -	vblk->tag_set.ops = &virtio_mq_ops;
> -	vblk->tag_set.queue_depth = queue_depth;
> -	vblk->tag_set.numa_node = NUMA_NO_NODE;
> -	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> -	vblk->tag_set.cmd_size =
> -		sizeof(struct virtblk_req) +
> -		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
> -	vblk->tag_set.driver_data = vblk;
> -	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
> -	vblk->tag_set.nr_maps = 1;
> -	if (vblk->io_queues[HCTX_TYPE_POLL])
> -		vblk->tag_set.nr_maps = 3;
> -
> -	err = blk_mq_alloc_tag_set(&vblk->tag_set);
> -	if (err)
> -		goto out_free_vq;
> -
> -	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, vblk);
> -	if (IS_ERR(vblk->disk)) {
> -		err = PTR_ERR(vblk->disk);
> -		goto out_free_tags;
> -	}
> -	q = vblk->disk->queue;
> -
> -	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
> -
> -	vblk->disk->major = major;
> -	vblk->disk->first_minor = index_to_minor(index);
> -	vblk->disk->minors = 1 << PART_BITS;
> -	vblk->disk->private_data = vblk;
> -	vblk->disk->fops = &virtblk_fops;
> -	vblk->index = index;
> -
> -	/* configure queue flush support */
> -	virtblk_update_cache_mode(vdev);
> -
> -	/* If disk is read-only in the host, the guest should obey */
> -	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
> -		set_disk_ro(vblk->disk, 1);
> -
>  	/* We can handle whatever the host told us to handle. */
>  	blk_queue_max_segments(q, sg_elems);
>  
> @@ -1011,12 +929,13 @@ static int virtblk_probe(struct virtio_device *vdev)
>  			dev_err(&vdev->dev,
>  				"virtio_blk: invalid block size: 0x%x\n",
>  				blk_size);
> -			goto out_cleanup_disk;
> +			return err;
>  		}
>  
>  		blk_queue_logical_block_size(q, blk_size);
> -	} else
> +	} else {
>  		blk_size = queue_logical_block_size(q);
> +	}
>  
>  	/* Use topology information if available */
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
> @@ -1075,19 +994,136 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
>  	}
>  
> +	return 0;
> +}
> +
> +static void virtblk_tagset_put(struct virtio_blk *vblk)
> +{
> +	put_disk(vblk->disk);
> +	blk_mq_free_tag_set(&vblk->tag_set);
> +}
> +
> +static void virtblk_tagset_free(struct virtio_blk *vblk)
> +{
> +	del_gendisk(vblk->disk);
> +	blk_mq_free_tag_set(&vblk->tag_set);
> +}
> +
> +static int virtblk_tagset_alloc(struct virtio_blk *vblk,
> +		unsigned int queue_depth)
> +{
> +	int err;
> +
> +	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
> +	vblk->tag_set.ops = &virtio_mq_ops;
> +	vblk->tag_set.queue_depth = queue_depth;
> +	vblk->tag_set.numa_node = NUMA_NO_NODE;
> +	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> +	vblk->tag_set.cmd_size =
> +		sizeof(struct virtblk_req) +
> +		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
> +	vblk->tag_set.driver_data = vblk;
> +	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
> +	vblk->tag_set.nr_maps = 1;
> +	if (vblk->io_queues[HCTX_TYPE_POLL])
> +		vblk->tag_set.nr_maps = 3;
> +
> +	err = blk_mq_alloc_tag_set(&vblk->tag_set);
> +	if (err)
> +		return err;
> +
> +	vblk->disk = blk_mq_alloc_disk(&vblk->tag_set, vblk);
> +	if (IS_ERR(vblk->disk)) {
> +		err = PTR_ERR(vblk->disk);
> +		goto out_free_tags;
> +	}
> +
> +	return 0;
> +
> +out_free_tags:
> +	blk_mq_free_tag_set(&vblk->tag_set);
> +	return err;
> +}
> +
> +static int virtblk_probe(struct virtio_device *vdev)
> +{
> +	struct virtio_blk *vblk;
> +	int err, index;
> +	unsigned int queue_depth;
> +
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
> +			     GFP_KERNEL);
> +	if (err < 0)
> +		goto out;
> +	index = err;
> +
> +	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
> +	if (!vblk) {
> +		err = -ENOMEM;
> +		goto out_free_index;
> +	}
> +
> +	mutex_init(&vblk->vdev_mutex);
> +
> +	vblk->vdev = vdev;
> +
> +	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
> +
> +	err = init_vq(vblk);
> +	if (err)
> +		goto out_free_vblk;
> +
> +	/* Default queue sizing is to fill the ring. */
> +	if (!virtblk_queue_depth) {
> +		queue_depth = vblk->vqs[0].vq->num_free;
> +		/* ... but without indirect descs, we use 2 descs per req */
> +		if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
> +			queue_depth /= 2;
> +	} else {
> +		queue_depth = virtblk_queue_depth;
> +	}
> +
> +	err = virtblk_tagset_alloc(vblk, queue_depth);
> +	if (err)
> +		goto out_free_vq;
> +
> +	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
> +
> +	vblk->disk->major = major;
> +	vblk->disk->first_minor = index_to_minor(index);
> +	vblk->disk->minors = 1 << PART_BITS;
> +	vblk->disk->private_data = vblk;
> +	vblk->disk->fops = &virtblk_fops;
> +	vblk->index = index;
> +
> +	/* configure queue flush support */
> +	virtblk_update_cache_mode(vdev);
> +
> +	/* If disk is read-only in the host, the guest should obey */
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_RO))
> +		set_disk_ro(vblk->disk, 1);
> +
> +	err = virtblk_q_limits_set(vdev, vblk->disk->queue);
> +	if (err)
> +		goto out_tagset_put;
> +
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
>  	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>  	if (err)
> -		goto out_cleanup_disk;
> +		goto out_tagset_put;
>  
>  	return 0;
>  
> -out_cleanup_disk:
> -	put_disk(vblk->disk);
> -out_free_tags:
> -	blk_mq_free_tag_set(&vblk->tag_set);
> +out_tagset_put:
> +	virtblk_tagset_put(vblk);
>  out_free_vq:
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);
> @@ -1106,8 +1142,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
>  
> -	del_gendisk(vblk->disk);
> -	blk_mq_free_tag_set(&vblk->tag_set);
> +	virtblk_tagset_free(vblk);
>  
>  	mutex_lock(&vblk->vdev_mutex);
>  
> -- 
> 2.18.1

