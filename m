Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC102C04A6A
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 19:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjHJTYt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 15:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbjHJTYs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 15:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34588272C
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691695435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eNpUhxfG0oagA+OSHR3CBYIVBwq8hSKrFiUJQDT85NI=;
        b=a5C3fAnJillqqDzf9asR/dEcy1BHnCTsbNR3l8JqIohN80KAuZbOM08fcl5sKOfJ6nwQ+B
        cGEqAUNmS42uRAdgcu2BCwJxJKPSh8W87nqlMm329I2Cucs6qZyouwspilCaED6edzzuDU
        vxqesVNudAiZBnogVVknCvWG9s67y90=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-PMjH__-IP6qTzF6xHAJQPg-1; Thu, 10 Aug 2023 15:23:54 -0400
X-MC-Unique: PMjH__-IP6qTzF6xHAJQPg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-317dff409dfso537634f8f.1
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 12:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695433; x=1692300233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNpUhxfG0oagA+OSHR3CBYIVBwq8hSKrFiUJQDT85NI=;
        b=VbxZy1TP4CxYSLNHePKCt9UAybKa/zI0Qa6kdKbE2eR5iJ7p3hX7o0he943sDdp6jx
         qXZEU1sEUMRUtxUxUkFDl52bwBsNm4lwJL4JW1W4PBVGez6XD8tbxZCCYQ+fHRbamTpG
         XxBSzHUB1Y9kXyiR6HTlOsyOfRjB4gvmj+A3tSdr3gEqz3VNexvQ5BuOV+fTVMYH5O0J
         0t+V8zeydW73mZHEpky8nYPS84QDmJI2n/adQmE7N7cNdYsPmRLXBHMRh1OaXO2NDgbo
         eHw7e75OEBUAuiqKS5k8PXORbZKS0mc8wJG338Kw1uuk+U8wnoTepaOfiLtbnxAmH38J
         Fm1g==
X-Gm-Message-State: AOJu0Yy7bA4qSWWNYEbVjc/4voTI8/vZacEeYu+/8Wzd1vG5ndbqAPq+
        7drYi09AFAQTSn5T0iIEURmkUYAS+eyCKWGEJr0MqD1AEEwwMUQ2pl2o66lWmHA11F+rTFVmMBj
        Qhiqn9QaGS0zlqP5btSVrc4g=
X-Received: by 2002:a5d:444d:0:b0:317:ce01:fe99 with SMTP id x13-20020a5d444d000000b00317ce01fe99mr2842382wrr.9.1691695433189;
        Thu, 10 Aug 2023 12:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR0CV1UmR4DNEMAn9v2ToSkc3HIbFYdNRmAuQjKcn2GH2b+kNRcs5y/tG7/rWE1x5qPYNz9w==
X-Received: by 2002:a5d:444d:0:b0:317:ce01:fe99 with SMTP id x13-20020a5d444d000000b00317ce01fe99mr2842373wrr.9.1691695432826;
        Thu, 10 Aug 2023 12:23:52 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d6886000000b00317f01fa3c4sm3018221wru.112.2023.08.10.12.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:23:52 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:23:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V3 04/14] virtio-blk: limit max allowed submit queues
Message-ID: <20230810152310-mutt-send-email-mst@kernel.org>
References: <20230808104239.146085-1-ming.lei@redhat.com>
 <20230808104239.146085-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808104239.146085-5-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 08, 2023 at 06:42:29PM +0800, Ming Lei wrote:
> Take blk-mq's knowledge into account for calculating io queues.
> 
> Fix wrong queue mapping in case of kdump kernel.
> 
> On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> still returns all CPUs because 'maxcpus=1' just bring up one single
> cpu core during booting.
> 
> blk-mq sees single queue in kdump kernel, and in driver's viewpoint
> there are still multiple queues, this inconsistency causes driver to apply
> wrong queue mapping for handling IO, and IO timeout is triggered.
> 
> Meantime, single queue makes much less resource utilization, and reduce
> risk of kernel failure.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

superficially:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but this patch only makes sense if the rest of patchset is merged.
feel free to merge directly.

> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 1fe011676d07..4ba79fe2a1b4 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1047,7 +1047,8 @@ static int init_vq(struct virtio_blk *vblk)
>  
>  	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
>  
> -	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
> +	vblk->io_queues[HCTX_TYPE_DEFAULT] = min_t(unsigned,
> +			num_vqs - num_poll_vqs, blk_mq_max_nr_hw_queues());
>  	vblk->io_queues[HCTX_TYPE_READ] = 0;
>  	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
>  
> -- 
> 2.40.1

