Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6191C433DF
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 12:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E5720756
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 12:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8WY5jQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgHKMa7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:30:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31068 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728556AbgHKMay (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 08:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597149052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=10MTXNup6VoSKx7DEPPubWhjC5uO2qbyQnR6Wsit9SQ=;
        b=V8WY5jQmzJy2mE+S8frGh8XQXghqRGjqainKhiyYsv0SYhj3afsIqUWsZmeHKidEexyp1V
        ij/AheSNdGMchZ5THHTR8iEoDDc1RFmkpEd8sLyqMh26KxBy2gs3B5koa9lcMDGnapR01l
        J6EojYgPRd383/10Cc796YzP2NQSHwQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-Y2haxx6nM7ScIoWZ9UYRxQ-1; Tue, 11 Aug 2020 08:30:50 -0400
X-MC-Unique: Y2haxx6nM7ScIoWZ9UYRxQ-1
Received: by mail-wm1-f72.google.com with SMTP id z1so759138wmf.9
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 05:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=10MTXNup6VoSKx7DEPPubWhjC5uO2qbyQnR6Wsit9SQ=;
        b=lMHajtL/pvYllAhwO2bJE9CgaPJ2cbafHz+iMUeWH3xeSuu4EebWS5/FLre5CsIoNU
         9B218g/Sp8zdQdYryWKTdjExE4vk3M+ghGlJ1AgriStRzF5de1i6TtR/SnR0Xnsj6KaS
         ZMrrqL9E8K6lcYJ9/Kk3N0UGHhf1qRuQwJTKb3U0GVpjBoU56OezHR3Kl+MGTogZu+gi
         b9lilmSupWSJL5sVMB+2KvJTTHWVFzYklhGye2PE8F8pjqoP5J3nciFGbvI+I4MXy1Rn
         7dI6J3XIKyy0/8pvfNeHN1El1D3ZU2KnQltALdlx2i1UsPhajqCVILhVvRzKYsT8Ruos
         bhBw==
X-Gm-Message-State: AOAM531pYPGJlQQ4xSKY5SoX1qll3XmqmEo2WImyqxZ6wYe35CbabWE6
        GF75lWuqdCwdbspN25czammzPJsy+L7Fha6zwrrPqaV4MMq8XE69CTo2slqSOQNUE20vviiRNzV
        wz/rNCELvUQvMraLKw5T4jIA=
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr6010062wrq.106.1597149049786;
        Tue, 11 Aug 2020 05:30:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpkPXnaYNAbEIHfRyL8D+9eNZ1HA5BQbOZTK6mTep8R6aFkMAC08hRahZX1x9Db5IUwRYMMg==
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr6010035wrq.106.1597149049369;
        Tue, 11 Aug 2020 05:30:49 -0700 (PDT)
Received: from steredhat ([5.171.229.91])
        by smtp.gmail.com with ESMTPSA id k204sm5657686wma.21.2020.08.11.05.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 05:30:48 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:30:44 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/2] block: virtio_blk: fix handling single range discard
 request
Message-ID: <20200811123044.mzsc2clpf6nxf6f6@steredhat>
References: <20200811092134.2256095-1-ming.lei@redhat.com>
 <20200811092134.2256095-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811092134.2256095-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On Tue, Aug 11, 2020 at 05:21:34PM +0800, Ming Lei wrote:
> 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
> to support multi-range discard for virtio-blk. However, the virtio-blk
> disk may report max discard segment as 1, at least that is exactly what
> qemu is doing.
> 
> So far, block layer switches to normal request merge if max discard segment
> limit is 1, and multiple bios can be merged to single segment. This way may
> cause memory corruption in virtblk_setup_discard_write_zeroes().
> 
> Fix the issue by handling single max discard segment in straightforward
> way.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Changpeng Liu <changpeng.liu@intel.com>
> Cc: Daniel Verkamp <dverkamp@chromium.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 63b213e00b37..05b01903122b 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c'
> @@ -126,14 +126,21 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
>  	if (!range)
>  		return -ENOMEM;

We are allocating the 'range' array to contain 'segments' elements.
When queue_max_discard_segments() returns 1, should we limit 'segments'
to 1?

>  
> -	__rq_for_each_bio(bio, req) {
> -		u64 sector = bio->bi_iter.bi_sector;
> -		u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> -
> -		range[n].flags = cpu_to_le32(flags);
> -		range[n].num_sectors = cpu_to_le32(num_sectors);
> -		range[n].sector = cpu_to_le64(sector);
> -		n++;
> +	if (queue_max_discard_segments(req->q) == 1) {
> +		range[0].flags = cpu_to_le32(flags);
> +		range[0].num_sectors = cpu_to_le32(blk_rq_sectors(req));
> +		range[0].sector = cpu_to_le64(blk_rq_pos(req));
> +		n = 1;
                ^
                this doesn't seem necessary since we don't use 'n' afterwards.

Thanks,
Stefano

> +	} else {
> +		__rq_for_each_bio(bio, req) {
> +			u64 sector = bio->bi_iter.bi_sector;
> +			u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +
> +			range[n].flags = cpu_to_le32(flags);
> +			range[n].num_sectors = cpu_to_le32(num_sectors);
> +			range[n].sector = cpu_to_le64(sector);
> +			n++;
> +		}
>  	}
>  
>  	req->special_vec.bv_page = virt_to_page(range);
> -- 
> 2.25.2
> 

