Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8867FC433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 14:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351066AbiCXOeG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 10:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351075AbiCXOd6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 10:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FC78AD131
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648132330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=inPw/ywO3r7g5Acohc7OmszZqzvn1xPk23Mbpa9WRq4=;
        b=hLEiPIBIGbHzdmCKYzt6ma5slXgV1fS8ziXiN0rTTmkvn4CZUdyowu2E8knxIh7MALOHu6
        6Pxer/d6HKatHZr8DdqT2bKrZuLTEvAsljCmK+Eje4LZU+GIZEA3Ahy9wS3Bg1E7lwcb3z
        vLaehsKn/g3LtLDtwboi3FubzT8UyhY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-9QWcdTi5Ml6NqlSeH_0SDQ-1; Thu, 24 Mar 2022 10:32:08 -0400
X-MC-Unique: 9QWcdTi5Ml6NqlSeH_0SDQ-1
Received: by mail-wm1-f72.google.com with SMTP id n186-20020a1ca4c3000000b0038cdec2d700so120126wme.5
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 07:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=inPw/ywO3r7g5Acohc7OmszZqzvn1xPk23Mbpa9WRq4=;
        b=0+RZ+4KPfGbhtg9JfrA4eqCpUio2qJebktq9SVmebVqWj/L99Di2/+10sVtZhvc2pT
         qCgH8TJXOIpDPjvsgot4FE//jdqoJ6WmmxI5Rcxyts1/Jw38r/P1cSqQZw8BwdJLuYHk
         WETgmdBqg63TAWsUc33aUE7YowgpYszJDOO/o6/+aHFsXVB4oGmVRkOXYw56zCBOv1My
         G74KiQfwO8cQ/nYQlmu1MuwIHOrX73ZQKutnorVlGbO1QjuzDIzbGG7O3D+SGkcewrhM
         ujvXi/NPTVDOkws24ADJM+JTIWuKG/H73yp1u0ulTK+Rx+PIJwH6FkYZ05qQe3L0dvRt
         kAmA==
X-Gm-Message-State: AOAM531L58n5DAjQOPjTm2fw1VrftFSwOKWws2grD9tjdnrNs5ACToB+
        keEY0S8OBPy4n8dt68PC+yQodw4zxWPmofOoYqiTI7cJCaZRr4F9KbGxZTtH3iZ8bxteWltWoU+
        /bX7ypvLyC/MJqmpF04ElUos=
X-Received: by 2002:a05:600c:2045:b0:38c:98be:9bd8 with SMTP id p5-20020a05600c204500b0038c98be9bd8mr14105271wmg.76.1648132327306;
        Thu, 24 Mar 2022 07:32:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4wGtHxH6De4HVnsqhpQLTCoo9q3VJCxEnDip3XbrLIZmiUE+vlY85HgatPXyU9HxwVswiPw==
X-Received: by 2002:a05:600c:2045:b0:38c:98be:9bd8 with SMTP id p5-20020a05600c204500b0038c98be9bd8mr14105249wmg.76.1648132326951;
        Thu, 24 Mar 2022 07:32:06 -0700 (PDT)
Received: from redhat.com ([2.55.151.118])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038c6d836935sm6299185wms.16.2022.03.24.07.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:32:06 -0700 (PDT)
Date:   Thu, 24 Mar 2022 10:32:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] virtio-blk: support polling I/O
Message-ID: <20220324103056-mutt-send-email-mst@kernel.org>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324140450.33148-2-suwan.kim027@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 24, 2022 at 11:04:49PM +0900, Suwan Kim wrote:
> This patch supports polling I/O via virtio-blk driver. Polling
> feature is enabled by module parameter "num_poll_queues" and it
> sets dedicated polling queues for virtio-blk. This patch improves
> the polling I/O throughput and latency.
> 
> The virtio-blk driver doesn't not have a poll function and a poll
> queue and it has been operating in interrupt driven method even if
> the polling function is called in the upper layer.
> 
> virtio-blk polling is implemented upon 'batched completion' of block
> layer. virtblk_poll() queues completed request to io_comp_batch->req_list
> and later, virtblk_complete_batch() calls unmap function and ends
> the requests in batch.
> 
> virtio-blk reads the number of poll queues from module parameter
> "num_poll_queues". If VM sets queue parameter as below,
> ("num-queues=N" [QEMU property], "num_poll_queues=M" [module parameter])
> It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
> as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
> queues, the poll queues have no callback function.
> 
> Regarding HW-SW queue mapping, the default queue mapping uses the
> existing method that condsiders MSI irq vector. But the poll queue
> doesn't have an irq, so it uses the regular blk-mq cpu mapping.
> 
> For verifying the improvement, I did Fio polling I/O performance test
> with io_uring engine with the options below.
> (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
> I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
> queues for VM.
> 
> As a result, IOPS and average latency improved about 10%.
> 
> Test result:
> 
> - Fio io_uring poll without virtio-blk poll support
> 	-- numjobs=1 : IOPS = 339K, avg latency = 188.33us
> 	-- numjobs=2 : IOPS = 367K, avg latency = 347.33us
> 	-- numjobs=4 : IOPS = 383K, avg latency = 682.06us
> 
> - Fio io_uring poll with virtio-blk poll support
> 	-- numjobs=1 : IOPS = 380K, avg latency = 167.87us
> 	-- numjobs=2 : IOPS = 409K, avg latency = 312.6us
> 	-- numjobs=4 : IOPS = 413K, avg latency = 619.72us
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 101 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 97 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 8c415be86732..3d16f8b753e7 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -37,6 +37,10 @@ MODULE_PARM_DESC(num_request_queues,
>  		 "0 for no limit. "
>  		 "Values > nr_cpu_ids truncated to nr_cpu_ids.");
>  
> +static unsigned int num_poll_queues;
> +module_param(num_poll_queues, uint, 0644);
> +MODULE_PARM_DESC(num_poll_queues, "The number of dedicated virtqueues for polling I/O");
> +
>  static int major;
>  static DEFINE_IDA(vd_index_ida);
>

Is there some way to make it work reasonably without need to set
module parameters? I don't see any other devices with a num_poll_queues
parameter - how do they handle this?
  
> @@ -81,6 +85,7 @@ struct virtio_blk {
>  
>  	/* num of vqs */
>  	int num_vqs;
> +	int io_queues[HCTX_MAX_TYPES];
>  	struct virtio_blk_vq *vqs;
>  };
>  
> @@ -548,6 +553,7 @@ static int init_vq(struct virtio_blk *vblk)
>  	const char **names;
>  	struct virtqueue **vqs;
>  	unsigned short num_vqs;
> +	unsigned int num_poll_vqs;
>  	struct virtio_device *vdev = vblk->vdev;
>  	struct irq_affinity desc = { 0, };
>  
> @@ -556,6 +562,7 @@ static int init_vq(struct virtio_blk *vblk)
>  				   &num_vqs);
>  	if (err)
>  		num_vqs = 1;
> +
>  	if (!err && !num_vqs) {
>  		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
>  		return -EINVAL;
> @@ -565,6 +572,13 @@ static int init_vq(struct virtio_blk *vblk)
>  			min_not_zero(num_request_queues, nr_cpu_ids),
>  			num_vqs);
>  
> +	num_poll_vqs = min_t(unsigned int, num_poll_queues, num_vqs - 1);
> +
> +	memset(vblk->io_queues, 0, sizeof(int) * HCTX_MAX_TYPES);
> +	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
> +	vblk->io_queues[HCTX_TYPE_READ] = 0;
> +	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
> +
>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>  	if (!vblk->vqs)
>  		return -ENOMEM;
> @@ -578,8 +592,13 @@ static int init_vq(struct virtio_blk *vblk)
>  	}
>  
>  	for (i = 0; i < num_vqs; i++) {
> -		callbacks[i] = virtblk_done;
> -		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> +		if (i < num_vqs - num_poll_vqs) {
> +			callbacks[i] = virtblk_done;
> +			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> +		} else {
> +			callbacks[i] = NULL;
> +			snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
> +		}
>  		names[i] = vblk->vqs[i].name;
>  	}
>  
> @@ -728,16 +747,87 @@ static const struct attribute_group *virtblk_attr_groups[] = {
>  static int virtblk_map_queues(struct blk_mq_tag_set *set)
>  {
>  	struct virtio_blk *vblk = set->driver_data;
> +	int i, qoff;
> +
> +	for (i = 0, qoff = 0; i < set->nr_maps; i++) {
> +		struct blk_mq_queue_map *map = &set->map[i];
> +
> +		map->nr_queues = vblk->io_queues[i];
> +		map->queue_offset = qoff;
> +		qoff += map->nr_queues;
> +
> +		if (map->nr_queues == 0)
> +			continue;
> +
> +		/*
> +		 * Regular queues have interrupts and hence CPU affinity is
> +		 * defined by the core virtio code, but polling queues have
> +		 * no interrupts so we let the block layer assign CPU affinity.
> +		 */
> +		if (i == HCTX_TYPE_DEFAULT)
> +			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
> +		else
> +			blk_mq_map_queues(&set->map[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static void virtblk_complete_batch(struct io_comp_batch *iob)
> +{
> +	struct request *req;
> +	struct virtblk_req *vbr;
>  
> -	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
> -					vblk->vdev, 0);
> +	rq_list_for_each(&iob->req_list, req) {
> +		vbr = blk_mq_rq_to_pdu(req);
> +		virtblk_unmap_data(req, vbr);
> +		virtblk_cleanup_cmd(req);
> +	}
> +	blk_mq_end_request_batch(iob);
> +}
> +
> +static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> +{
> +	struct virtio_blk_vq *vq = hctx->driver_data;
> +	struct virtblk_req *vbr;
> +	unsigned long flags;
> +	unsigned int len;
> +	int found = 0;
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +
> +	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
> +		struct request *req = blk_mq_rq_from_pdu(vbr);
> +
> +		found++;
> +		if (!blk_mq_add_to_batch(req, iob, vbr->status,
> +						virtblk_complete_batch))
> +			blk_mq_complete_request(req);
> +	}
> +
> +	spin_unlock_irqrestore(&vq->lock, flags);
> +
> +	return found;
> +}
> +
> +static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> +			  unsigned int hctx_idx)
> +{
> +	struct virtio_blk *vblk = data;
> +	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
> +
> +	WARN_ON(vblk->tag_set.tags[hctx_idx] != hctx->tags);
> +	hctx->driver_data = vq;
> +	return 0;
>  }
>  
>  static const struct blk_mq_ops virtio_mq_ops = {
>  	.queue_rq	= virtio_queue_rq,
>  	.commit_rqs	= virtio_commit_rqs,
> +	.init_hctx	= virtblk_init_hctx,
>  	.complete	= virtblk_request_done,
>  	.map_queues	= virtblk_map_queues,
> +	.poll		= virtblk_poll,
>  };
>  
>  static unsigned int virtblk_queue_depth;
> @@ -816,6 +906,9 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
>  	vblk->tag_set.driver_data = vblk;
>  	vblk->tag_set.nr_hw_queues = vblk->num_vqs;
> +	vblk->tag_set.nr_maps = 1;
> +	if (vblk->io_queues[HCTX_TYPE_POLL])
> +		vblk->tag_set.nr_maps = 3;
>  
>  	err = blk_mq_alloc_tag_set(&vblk->tag_set);
>  	if (err)
> -- 
> 2.26.3

