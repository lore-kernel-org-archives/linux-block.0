Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72C8C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7FA208E4
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="iteTtL7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7FA208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeK1KpN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:45:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34496 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeK1KpN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:45:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so16408982plo.1
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 15:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bky8JVJJx8ApO3OG/34yswhEZrzIQfeMMlKBkuDdP3Q=;
        b=iteTtL7XXMFxcxd1gbibGOz5LlmK+1yBENnSZh8/25xN9Ipx9KC77dLcKJUnQIicd2
         OV4wIJz+ykPIFHl2KMMzO1kuUX6AogZHMmqkUTKvVyYWnOMCJRO/kSay/tQVpa1xlcrm
         ZYqPbh9Mqev/ddvfdWBTPN98GIuR0/lZQjBFsQFIGNFN5OZtXtGoPiFHl4wiq+v7V2z2
         hKMTs91eILQ1u+DICVLvbmRyS9/uvIGx//BAH7Fyv9jptvU+Dmyz42UTOMvoj953NRbN
         W1da2AzdnfOaK2KiV+j3714/NAoFm4Nrx9y0Lycq8KsEE9m0pfy1xBeHenUqsqtKbFTt
         cytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bky8JVJJx8ApO3OG/34yswhEZrzIQfeMMlKBkuDdP3Q=;
        b=tFdSqBp+1V/WJZHRENm7DsWEowKYg8Jsj+M+VLP6xOOAiK1tZHEzYeXjCZLAVyP1KC
         kAegOhiuHFw3/wS/ay3sZwPqV9BRutkcZeR6cCXQI/pHijASFnvAjPgV+M3aWdM9kFdG
         lFyz3axY5ko8Aapv3Tk8HaXppcPDL5+LIFir8TI+I0TGp9jUfevI67M/Y1X4ynrOnNdD
         C5Yrg6P36KvAFobfF2duYpynPxon37uLMMY/nbCla7ix0/MqP7tS3ewqE+tzut3cXuYQ
         ZKkpnsesHQJd71Y5out1GMJcXDxk2LbiQMz+QROik3g3XyMH3BYHOtiHalqZaIeZlHZb
         F9Xw==
X-Gm-Message-State: AA+aEWZmdKxW/OREHqQos+jJWwneI051x1g+3YWEqB3xum5CrQN7kV64
        AG4NfR9KW0E6ltrp8uBsYU620g==
X-Google-Smtp-Source: AFSGD/XXQ1myClH4+UT34zJ6c6s4HR6EnIuIYMYgsWXgRBasVukiN2ZVC9Ib8vlC+1oAtrrfvR0KtQ==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr11628417plt.98.1543362339885;
        Tue, 27 Nov 2018 15:45:39 -0800 (PST)
Received: from vader ([2620:10d:c090:200::5:71bd])
        by smtp.gmail.com with ESMTPSA id v14sm6051725pgf.3.2018.11.27.15.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 15:45:39 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:45:38 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/8] virtio_blk: implement mq_ops->commit_rqs() hook
Message-ID: <20181127234538.GD846@vader>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126163556.5181-6-axboe@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:35:53AM -0700, Jens Axboe wrote:
> We need this for blk-mq to kick things into gear, if we told it that
> we had more IO coming, but then failed to deliver on that promise.

Reviewed-by: Omar Sandoval <osandov@fb.com>

But also cc'd the virtio-blk maintainers.

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/block/virtio_blk.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6e869d05f91e..b49c57e77780 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -214,6 +214,20 @@ static void virtblk_done(struct virtqueue *vq)
>  	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>  }
>  
> +static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct virtio_blk *vblk = hctx->queue->queuedata;
> +	int qid = hctx->queue_num;
> +	bool kick;
> +
> +	spin_lock_irq(&vblk->vqs[qid].lock);
> +	kick = virtqueue_kick_prepare(vblk->vqs[qid].vq);
> +	spin_unlock_irq(&vblk->vqs[qid].lock);
> +
> +	if (kick)
> +		virtqueue_notify(vblk->vqs[qid].vq);
> +}
> +
>  static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  			   const struct blk_mq_queue_data *bd)
>  {
> @@ -638,6 +652,7 @@ static void virtblk_initialize_rq(struct request *req)
>  
>  static const struct blk_mq_ops virtio_mq_ops = {
>  	.queue_rq	= virtio_queue_rq,
> +	.commit_rqs	= virtio_commit_rqs,
>  	.complete	= virtblk_request_done,
>  	.init_request	= virtblk_init_request,
>  #ifdef CONFIG_VIRTIO_BLK_SCSI
> -- 
> 2.17.1
> 
