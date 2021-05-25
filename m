Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F439C2B9F7
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 03:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D256117A
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 03:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhEYDXX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 23:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229575AbhEYDXW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 23:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621912913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hN/qmFSWE4X1/1WyvflertyODujEppC5hAfuD6ka3nI=;
        b=ed8W5poqBJoXUeo4AFCqvRWNXI0zEUFSwbvumx+9GNklEkEXA3TmGqQbEfJNPbhmn2CaQI
        WzG1EtmhvlaHRMXGSJugmei33K0l6jECZao+zf/m2yIZs5G0r/6O7K1SpMEoVpggq8i13O
        y1gP2OlTyfhBG4/0MR2U1X8/vQAVcyM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-3AZnjRV5N66ECl3m5wGy0w-1; Mon, 24 May 2021 23:21:51 -0400
X-MC-Unique: 3AZnjRV5N66ECl3m5wGy0w-1
Received: by mail-pf1-f197.google.com with SMTP id a141-20020a621a930000b02902de0bf944f8so15137124pfa.10
        for <linux-block@vger.kernel.org>; Mon, 24 May 2021 20:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hN/qmFSWE4X1/1WyvflertyODujEppC5hAfuD6ka3nI=;
        b=iqObrVgEnM/0hu2s6eayHG2x++8lXw8ypCDQDeUvmaIwhAGZDw3VR/DQgAmGH2TiAu
         cIKRuykEJyQdbqEvPTlvpPsSn6n1ZxS+O3cZEn7AT+ihYq+lNj3k+LIrZ4JWyz/rajhS
         ONXjCbwsC3cXW1WGUxRCsaUu8QIkXGot9GW8x44USLumaB9/FgQHKoo1bK74qxHUmCGz
         dZpcGPwDf7r3BJWpUI5VvEv3pGLA9Tc0P5s2YmTXEQaXPZ15gjd1VfdqWsoAn+KPdkEg
         J1durE2kiIdNFLHxKd8/soNrzbDXcp4f9/OdHOZ0zf9xiFAwlHlsMrhQFM8FOEkxW/OG
         E9yQ==
X-Gm-Message-State: AOAM5334rO7tiB7t1ia847c4l+Hg2hIG9yJIPLUhWuhCeNdUz9+ZvU15
        U5n/HRcNpSFqazvtW7mFKnpwIb0/36A1q3thOEmfkmIAiOWhVkncjT8hfjz2cyTrcXDgIJev9R1
        dKakoduipePmx7Xoyp1Wv9CU=
X-Received: by 2002:a17:902:f784:b029:ef:8e2f:430e with SMTP id q4-20020a170902f784b02900ef8e2f430emr28826879pln.28.1621912910735;
        Mon, 24 May 2021 20:21:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDUbseCl+SvcFZTnoFf+aRPtbg6SWGAQweGkBDt3D+VDTBF5zU1ukESHVEzVi0j0Heq4PiHA==
X-Received: by 2002:a17:902:f784:b029:ef:8e2f:430e with SMTP id q4-20020a170902f784b02900ef8e2f430emr28826854pln.28.1621912910345;
        Mon, 24 May 2021 20:21:50 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jz7sm666619pjb.32.2021.05.24.20.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 20:21:49 -0700 (PDT)
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <eefac014-0361-b554-ffdc-2ce920810fa5@redhat.com>
Date:   Tue, 25 May 2021 11:21:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520141305.355961-4-stefanha@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


ÔÚ 2021/5/20 ÏÂÎç10:13, Stefan Hajnoczi Ð´µÀ:
> Request completion latency can be reduced by using polling instead of
> irqs. Even Posted Interrupts or similar hardware support doesn't beat
> polling. The reason is that disabling virtqueue notifications saves
> critical-path CPU cycles on the host by skipping irq injection and in
> the guest by skipping the irq handler. So let's add blk_mq_ops->poll()
> support to virtio_blk.
>
> The approach taken by this patch differs from the NVMe driver's
> approach. NVMe dedicates hardware queues to polling and submits
> REQ_HIPRI requests only on those queues. This patch does not require
> exclusive polling queues for virtio_blk. Instead, it switches between
> irqs and polling when one or more REQ_HIPRI requests are in flight on a
> virtqueue.
>
> This is possible because toggling virtqueue notifications is cheap even
> while the virtqueue is running. NVMe cqs can't do this because irqs are
> only enabled/disabled at queue creation time.
>
> This toggling approach requires no configuration. There is no need to
> dedicate queues ahead of time or to teach users and orchestration tools
> how to set up polling queues.
>
> Possible drawbacks of this approach:
>
> - Hardware virtio_blk implementations may find virtqueue_disable_cb()
>    expensive since it requires DMA.


Note that it's probably not related to the behavior of the driver but 
the design of the event suppression mechanism.

Device can choose to ignore the suppression flag and keep sending 
interrupts.


>   If such devices become popular then
>    the virtio_blk driver could use a similar approach to NVMe when
>    VIRTIO_F_ACCESS_PLATFORM is detected in the future.
>
> - If a blk_poll() thread is descheduled it not only hurts polling
>    performance but also delays completion of non-REQ_HIPRI requests on
>    that virtqueue since vq notifications are disabled.


Can we poll only when only high pri requests are pending?

If the backend is a remote one, I think the polling may cause more cpu 
cycles.


>
> Performance:
>
> - Benchmark: fio ioengine=pvsync2 numjobs=4 direct=1
> - Guest: 4 vCPUs with one virtio-blk device (4 virtqueues)
> - Disk: Intel Corporation NVMe Datacenter SSD [Optane] [8086:2701]
> - CPU: Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz
>
> rw          bs hipri=0 hipri=1
> ------------------------------
> randread    4k 149,426 170,763 +14%
> randread   16k 118,939 134,269 +12%
> randread   64k  34,886  34,906   0%
> randread  128k  17,655  17,667   0%
> randwrite   4k 138,578 163,600 +18%
> randwrite  16k 102,089 120,950 +18%
> randwrite  64k  32,364  32,561   0%
> randwrite 128k  16,154  16,237   0%
> read        4k 146,032 170,620 +16%
> read       16k 117,097 130,437 +11%
> read       64k  34,834  35,037   0%
> read      128k  17,680  17,658   0%
> write       4k 134,562 151,422 +12%
> write      16k 101,796 107,606  +5%
> write      64k  32,364  32,594   0%
> write     128k  16,259  16,265   0%
>
> Larger block sizes do not benefit from polling as much but the
> improvement is worthwhile for smaller block sizes.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   drivers/block/virtio_blk.c | 92 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 87 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index fc0fb1dcd399..f0243dcd745a 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -29,6 +29,16 @@ static struct workqueue_struct *virtblk_wq;
>   struct virtio_blk_vq {
>   	struct virtqueue *vq;
>   	spinlock_t lock;
> +
> +	/* Number of non-REQ_HIPRI requests in flight. Protected by lock. */
> +	unsigned int num_lopri;
> +
> +	/* Number of REQ_HIPRI requests in flight. Protected by lock. */
> +	unsigned int num_hipri;
> +
> +	/* Are vq notifications enabled? Protected by lock. */
> +	bool cb_enabled;


We had event_flag_shadow, is it sufficient to introduce a new helper 
virtqueue_cb_is_enabled()?


> +
>   	char name[VQ_NAME_LEN];
>   } ____cacheline_aligned_in_smp;
>   
> @@ -171,33 +181,67 @@ static inline void virtblk_request_done(struct request *req)
>   	blk_mq_end_request(req, virtblk_result(vbr));
>   }
>   
> -static void virtblk_done(struct virtqueue *vq)
> +/* Returns true if one or more requests completed */
> +static bool virtblk_complete_requests(struct virtqueue *vq)
>   {
>   	struct virtio_blk *vblk = vq->vdev->priv;
>   	struct virtio_blk_vq *vbq = &vblk->vqs[vq->index];
>   	bool req_done = false;
> +	bool last_hipri_done = false;
>   	struct virtblk_req *vbr;
>   	unsigned long flags;
>   	unsigned int len;
>   
>   	spin_lock_irqsave(&vbq->lock, flags);
> +
>   	do {
> -		virtqueue_disable_cb(vq);
> +		if (vbq->cb_enabled)
> +			virtqueue_disable_cb(vq);
>   		while ((vbr = virtqueue_get_buf(vq, &len)) != NULL) {
>   			struct request *req = blk_mq_rq_from_pdu(vbr);
>   
> +			if (req->cmd_flags & REQ_HIPRI) {
> +				if (--vbq->num_hipri == 0)
> +					last_hipri_done = true;
> +			} else
> +				vbq->num_lopri--;
> +
>   			if (likely(!blk_should_fake_timeout(req->q)))
>   				blk_mq_complete_request(req);
>   			req_done = true;
>   		}
>   		if (unlikely(virtqueue_is_broken(vq)))
>   			break;
> -	} while (!virtqueue_enable_cb(vq));
> +
> +		/* Enable vq notifications if non-polled requests remain */
> +		if (last_hipri_done && vbq->num_lopri > 0) {
> +			last_hipri_done = false;
> +			vbq->cb_enabled = true;
> +		}
> +	} while (vbq->cb_enabled && !virtqueue_enable_cb(vq));
>   
>   	/* In case queue is stopped waiting for more buffers. */
>   	if (req_done)
>   		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
>   	spin_unlock_irqrestore(&vbq->lock, flags);
> +
> +	return req_done;
> +}
> +
> +static int virtblk_poll(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct virtio_blk *vblk = hctx->queue->queuedata;
> +	struct virtqueue *vq = vblk->vqs[hctx->queue_num].vq;
> +
> +	if (!virtqueue_more_used(vq))


I'm not familiar with block polling but what happens if a buffer is made 
available after virtqueue_more_used() returns false here?

Thanks


> +		return 0;
> +
> +	return virtblk_complete_requests(vq);
> +}
> +
> +static void virtblk_done(struct virtqueue *vq)
> +{
> +	virtblk_complete_requests(vq);
>   }
>   
>   static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> @@ -275,6 +319,16 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	}
>   
>   	spin_lock_irqsave(&vbq->lock, flags);
> +
> +	/* Re-enable vq notifications if first req is non-polling */
> +	if (!(req->cmd_flags & REQ_HIPRI) &&
> +	    vbq->num_lopri == 0 && vbq->num_hipri == 0 &&
> +	    !vbq->cb_enabled) {
> +		/* Can't return false since there are no in-flight reqs */
> +		virtqueue_enable_cb(vbq->vq);
> +		vbq->cb_enabled = true;
> +	}
> +
>   	err = virtblk_add_req(vbq->vq, vbr, vbr->sg, num);
>   	if (err) {
>   		virtqueue_kick(vbq->vq);
> @@ -294,6 +348,21 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>   		}
>   	}
>   
> +	/*
> +	 * Disable vq notifications when polled reqs are submitted.
> +	 *
> +	 * The virtqueue lock is held so req is still valid here even if the
> +	 * device polls the virtqueue and completes the request before we call
> +	 * virtqueue_notify().
> +	 */
> +	if (req->cmd_flags & REQ_HIPRI) {
> +		if (vbq->num_hipri++ == 0 && vbq->cb_enabled) {
> +			virtqueue_disable_cb(vbq->vq);
> +			vbq->cb_enabled = false;
> +		}
> +	} else
> +		vbq->num_lopri++;
> +
>   	if (bd->last && virtqueue_kick_prepare(vbq->vq))
>   		notify = true;
>   	spin_unlock_irqrestore(&vbq->lock, flags);
> @@ -533,6 +602,9 @@ static int init_vq(struct virtio_blk *vblk)
>   	for (i = 0; i < num_vqs; i++) {
>   		spin_lock_init(&vblk->vqs[i].lock);
>   		vblk->vqs[i].vq = vqs[i];
> +		vblk->vqs[i].num_lopri = 0;
> +		vblk->vqs[i].num_hipri = 0;
> +		vblk->vqs[i].cb_enabled = true;
>   	}
>   	vblk->num_vqs = num_vqs;
>   
> @@ -681,8 +753,16 @@ static int virtblk_map_queues(struct blk_mq_tag_set *set)
>   {
>   	struct virtio_blk *vblk = set->driver_data;
>   
> -	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
> -					vblk->vdev, 0);
> +	set->map[HCTX_TYPE_DEFAULT].nr_queues = vblk->num_vqs;
> +	blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT], vblk->vdev, 0);
> +
> +	set->map[HCTX_TYPE_READ].nr_queues = 0;
> +
> +	/* HCTX_TYPE_DEFAULT queues are shared with HCTX_TYPE_POLL */
> +	set->map[HCTX_TYPE_POLL].nr_queues = vblk->num_vqs;
> +	blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_POLL], vblk->vdev, 0);
> +
> +	return 0;
>   }
>   
>   static const struct blk_mq_ops virtio_mq_ops = {
> @@ -691,6 +771,7 @@ static const struct blk_mq_ops virtio_mq_ops = {
>   	.complete	= virtblk_request_done,
>   	.init_request	= virtblk_init_request,
>   	.map_queues	= virtblk_map_queues,
> +	.poll		= virtblk_poll,
>   };
>   
>   static unsigned int virtblk_queue_depth;
> @@ -768,6 +849,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>   
>   	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
>   	vblk->tag_set.ops = &virtio_mq_ops;
> +	vblk->tag_set.nr_maps = 3; /* default, read, and poll */
>   	vblk->tag_set.queue_depth = queue_depth;
>   	vblk->tag_set.numa_node = NUMA_NO_NODE;
>   	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;

