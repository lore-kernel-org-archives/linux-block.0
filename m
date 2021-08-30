Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0BCC432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 21:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA8060E90
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 21:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbhH3Vtd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237167AbhH3Vtd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 17:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630360118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AmK5AK//VpDNOflKYrie75fU9H15kJEGNG5tiW/9pzA=;
        b=RVODUNDAVOSbrtZemWwsw+8SdJ1FaYLDkXY/+aINyP3f3oeXYTMcphyz5D0JSRwuEn4GCb
        5R3HUrNhSVZgzMUT2sr9FWUc0BnJ6OI4WphZXhu/aToc4NXyY0A3eGcodLOhc6jTqiPM3Q
        dL7Rro/flEF+xsW21kE9oLunBERa3RQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-TqQuL7QdNpGLm8eZaywa0w-1; Mon, 30 Aug 2021 17:48:37 -0400
X-MC-Unique: TqQuL7QdNpGLm8eZaywa0w-1
Received: by mail-wr1-f70.google.com with SMTP id z15-20020adff74f000000b001577d70c98dso3559087wrp.12
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 14:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AmK5AK//VpDNOflKYrie75fU9H15kJEGNG5tiW/9pzA=;
        b=QAMKv9LHU4pTLl7nXAvq+aRASIgmg36Y2K4IrAp3pjarZyM0C8T5E3VXvRjhNTqlmK
         NNbyHUflt9Tp31ChKiwpQ94A7pzat2OWbo4YIzx/Ko9s6tabg60RyVxQTfDhzETXo/i3
         62tmFbJ+vDeP//VO3iZoixcC5ajolkUGWy8clKGIm9ODXYXl0xUyQsdz7LWTL+HEEkF8
         X0blZhqUyA7brwRplCfZXxQOgQd/uc6NmRiEpW6+BgF5GKOqv/417z5ooBs+IX//bBPr
         xVCKrhqewGbbrzuJzxmlGRZIyzUlI9VmnmGvOhs/1d1/x4TX1UUIh5jVa/B0ldI9kSjH
         ADlQ==
X-Gm-Message-State: AOAM533gut5TQ6EJKZBlCC/eFWYpKTL0E0iYT1Kp0+35VvrGmWjygD2p
        5rX9WP1584d9Z8y91fvPuFOrC46YxH6ptukKkTIl/tmVoBAS8CxR/SjFk/cB85cGZl1zQeEjmH+
        uBBAQ2trB41aMJZ9+4WnbCc0=
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr967735wma.121.1630360115920;
        Mon, 30 Aug 2021 14:48:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5fhrlu0kEOzo1cvWkb9o9z8Fn1FmpxfqvNOtZoj6358rRlPDpe9fYiRVrse76ReP25wmvgw==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr967723wma.121.1630360115695;
        Mon, 30 Aug 2021 14:48:35 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
        by smtp.gmail.com with ESMTPSA id v62sm68440wme.21.2021.08.30.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:48:35 -0700 (PDT)
Date:   Mon, 30 Aug 2021 17:48:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        stefanha@redhat.com, oren@nvidia.com, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <20210830174345-mutt-send-email-mst@kernel.org>
References: <20210830120023.22202-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830120023.22202-1-mgurtovoy@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 30, 2021 at 03:00:23PM +0300, Max Gurtovoy wrote:
> Sometimes a user would like to control the amount of IO queues to be
> created for a block device. For example, for limiting the memory
> footprint of virtio-blk devices.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>


Hmm. It's already limited by # of CPUs... Why not just limit
from the hypervisor side? What's the actual use-case here?

> ---
>  drivers/block/virtio_blk.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index e574fbf5e6df..77e8468e8593 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -24,6 +24,28 @@
>  /* The maximum number of sg elements that fit into a virtqueue */
>  #define VIRTIO_BLK_MAX_SG_ELEMS 32768
>  
> +static int virtblk_queue_count_set(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	unsigned int n;
> +	int ret;
> +
> +	ret = kstrtouint(val, 10, &n);
> +	if (ret != 0 || n > nr_cpu_ids)
> +		return -EINVAL;
> +	return param_set_uint(val, kp);
> +}
> +
> +static const struct kernel_param_ops queue_count_ops = {
> +	.set = virtblk_queue_count_set,
> +	.get = param_get_uint,
> +};
> +
> +static unsigned int num_io_queues;
> +module_param_cb(num_io_queues, &queue_count_ops, &num_io_queues, 0644);
> +MODULE_PARM_DESC(num_io_queues,
> +		 "Number of IO virt queues to use for blk device.");
> +
>  static int major;
>  static DEFINE_IDA(vd_index_ida);
>  
> @@ -501,7 +523,9 @@ static int init_vq(struct virtio_blk *vblk)
>  	if (err)
>  		num_vqs = 1;
>  
> -	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> +	num_vqs = min_t(unsigned int,
> +			min_not_zero(num_io_queues, nr_cpu_ids),
> +			num_vqs);
>  
>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>  	if (!vblk->vqs)
> -- 
> 2.18.1

