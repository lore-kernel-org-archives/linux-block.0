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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0EAC2B9F7
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F64613EC
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhEYC04 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 22:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230026AbhEYC0y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 22:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621909525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1qoKlOsGh04ss63Lt/Lntwf9cwsxjTtguPKVdlfA3Ng=;
        b=XT44TIXkrAAPWSDGaqDvDWkenuKetRqNR9d7/SheXZe4VAeCG+njkih9Rg7YtW82ffBPUQ
        My4sDe915n761znsrPLb9ua5c73ikeyeglkp2XX4r2QqJ9NEG0LON5LU3Xg/rHns29ZFQy
        tm3tam4bu+iwF+zBllmwt0Uus7in3w0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-4VFaPRDUM6ah1aXpMwHw1A-1; Mon, 24 May 2021 22:25:23 -0400
X-MC-Unique: 4VFaPRDUM6ah1aXpMwHw1A-1
Received: by mail-pf1-f200.google.com with SMTP id v22-20020aa785160000b02902ddbe7f56bdso15550599pfn.12
        for <linux-block@vger.kernel.org>; Mon, 24 May 2021 19:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1qoKlOsGh04ss63Lt/Lntwf9cwsxjTtguPKVdlfA3Ng=;
        b=LTCkZbKtIougQ3fqcO2wktrZIMfdPBgneCbc1d4QIAUxhAFPmIapdl4jMMJuFCDP4l
         mCqEKio+M4aAINiUdocLz4AcfamMpl3DijzwM04z1llcQEHhvBkOc49SH9oRSnS57Dga
         +iorQxvU3mV8itzIDQFPo0U7sIKtrPbeaupfmtTJj1ByCTexeCBJ6gzRS7Ou6cBGpEKo
         +1ls6M3mcLiPVICv5wcldakI8y2I+S0UpXfZwwRS686C3azdj2M9KoIzKy5iLLEAJQlP
         aCk32sV9nbsjNYzkYBKdf/8Cfo2aug2dT88cwn4/XMNBrapD5O7gHaAyn21lZl4gupQT
         DSWA==
X-Gm-Message-State: AOAM5311xkRpImtm1RcRvLinyur8IFgzhS3qK4d+VvyCvx0Pl7ZkyYNV
        iTZji5naEk0yo0iiTubBncOkJWcHp0TODnfwLAVb7kT8yKk1TSddz0g4tT0k4ihXiPUGaHyAjXA
        QekfGCWjeG78uXZcLHMtQjzc=
X-Received: by 2002:a17:90b:4a12:: with SMTP id kk18mr28055333pjb.99.1621909522561;
        Mon, 24 May 2021 19:25:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRV+qJUokH6c8EHK6OUiQ6oCyA7PhcBNQL+CnWJHhK5yhITE+2ZcU/lrqFBmiLVDRSYo1z9w==
X-Received: by 2002:a17:90b:4a12:: with SMTP id kk18mr28055310pjb.99.1621909522344;
        Mon, 24 May 2021 19:25:22 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d15sm3912029pfd.35.2021.05.24.19.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 19:25:21 -0700 (PDT)
Subject: Re: [PATCH 2/3] virtio_blk: avoid repeating vblk->vqs[qid]
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-3-stefanha@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <caf006e5-760f-23c9-64a6-35cd6e1f33f4@redhat.com>
Date:   Tue, 25 May 2021 10:25:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520141305.355961-3-stefanha@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


ÔÚ 2021/5/20 ÏÂÎç10:13, Stefan Hajnoczi Ð´µÀ:
> struct virtio_blk_vq is accessed in many places. Introduce "vbq" local
> variables to avoid repeating vblk->vqs[qid] throughout the code. The
> patches that follow will add more accesses, making the payoff even
> greater.
>
> virtio_commit_rqs() calls the local variable "vq", which is easily
> confused with struct virtqueue. Rename to "vbq" for clarity.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/block/virtio_blk.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b9fa3ef5b57c..fc0fb1dcd399 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -174,16 +174,16 @@ static inline void virtblk_request_done(struct request *req)
>   static void virtblk_done(struct virtqueue *vq)
>   {
>   	struct virtio_blk *vblk = vq->vdev->priv;
> +	struct virtio_blk_vq *vbq = &vblk->vqs[vq->index];
>   	bool req_done = false;
> -	int qid = vq->index;
>   	struct virtblk_req *vbr;
>   	unsigned long flags;
>   	unsigned int len;
>   
> -	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> +	spin_lock_irqsave(&vbq->lock, flags);
>   	do {
>   		virtqueue_disable_cb(vq);
> -		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
> +		while ((vbr = virtqueue_get_buf(vq, &len)) != NULL) {
>   			struct request *req = blk_mq_rq_from_pdu(vbr);
>   
>   			if (likely(!blk_should_fake_timeout(req->q)))
> @@ -197,32 +197,32 @@ static void virtblk_done(struct virtqueue *vq)
>   	/* In case queue is stopped waiting for more buffers. */
>   	if (req_done)
>   		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> -	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> +	spin_unlock_irqrestore(&vbq->lock, flags);
>   }
>   
>   static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>   {
>   	struct virtio_blk *vblk = hctx->queue->queuedata;
> -	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> +	struct virtio_blk_vq *vbq = &vblk->vqs[hctx->queue_num];
>   	bool kick;
>   
> -	spin_lock_irq(&vq->lock);
> -	kick = virtqueue_kick_prepare(vq->vq);
> -	spin_unlock_irq(&vq->lock);
> +	spin_lock_irq(&vbq->lock);
> +	kick = virtqueue_kick_prepare(vbq->vq);
> +	spin_unlock_irq(&vbq->lock);
>   
>   	if (kick)
> -		virtqueue_notify(vq->vq);
> +		virtqueue_notify(vbq->vq);
>   }
>   
>   static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>   			   const struct blk_mq_queue_data *bd)
>   {
>   	struct virtio_blk *vblk = hctx->queue->queuedata;
> +	struct virtio_blk_vq *vbq = &vblk->vqs[hctx->queue_num];
>   	struct request *req = bd->rq;
>   	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
>   	unsigned long flags;
>   	unsigned int num;
> -	int qid = hctx->queue_num;
>   	int err;
>   	bool notify = false;
>   	bool unmap = false;
> @@ -274,16 +274,16 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>   			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_IN);
>   	}
>   
> -	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> -	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
> +	spin_lock_irqsave(&vbq->lock, flags);
> +	err = virtblk_add_req(vbq->vq, vbr, vbr->sg, num);
>   	if (err) {
> -		virtqueue_kick(vblk->vqs[qid].vq);
> +		virtqueue_kick(vbq->vq);
>   		/* Don't stop the queue if -ENOMEM: we may have failed to
>   		 * bounce the buffer due to global resource outage.
>   		 */
>   		if (err == -ENOSPC)
>   			blk_mq_stop_hw_queue(hctx);
> -		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> +		spin_unlock_irqrestore(&vbq->lock, flags);
>   		switch (err) {
>   		case -ENOSPC:
>   			return BLK_STS_DEV_RESOURCE;
> @@ -294,12 +294,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>   		}
>   	}
>   
> -	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
> +	if (bd->last && virtqueue_kick_prepare(vbq->vq))
>   		notify = true;
> -	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> +	spin_unlock_irqrestore(&vbq->lock, flags);
>   
>   	if (notify)
> -		virtqueue_notify(vblk->vqs[qid].vq);
> +		virtqueue_notify(vbq->vq);
>   	return BLK_STS_OK;
>   }
>   

