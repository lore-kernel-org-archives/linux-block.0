Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E5DC04FF3
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 20:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380DE6140F
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 20:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhEXUtP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 16:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233557AbhEXUtP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 16:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621889266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9wE24F6jeVv0CWPxGEyqhTAfrT3uRpeYbPC2WgzwDxI=;
        b=BMRtkeo3upn3Oj/Ygwlpp+CZ11EPfQzb75//95OcImiGeMPhGc9CJqy5Tbqar3ukhftObq
        +Nh4Jt5596Deeby9f8+lYStR018zgZCPOHOEm/U2GdP88VL0vxfJrIODJDiOcVdrgNAWi+
        Wiy2AhASfHKHG5I3GkO8HijfXbCflYs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-v0jjDxuYNcewZDZqiBT9og-1; Mon, 24 May 2021 16:47:43 -0400
X-MC-Unique: v0jjDxuYNcewZDZqiBT9og-1
Received: by mail-wr1-f69.google.com with SMTP id t5-20020adfb7c50000b029010dd0bb24cfso13580442wre.2
        for <linux-block@vger.kernel.org>; Mon, 24 May 2021 13:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9wE24F6jeVv0CWPxGEyqhTAfrT3uRpeYbPC2WgzwDxI=;
        b=EdIkY1KjWxadXs22MK5nFgEFbxEC5gjrEhGsq3bG/Du7tLlThUZWO7hXsQ21vTC635
         +PMAG8gRmgfV9sICpAf9TX/+7FQOBAsRBphNFA4Ks3LvWUJ9jyGfOXeHkgzGGcipfj3k
         PkQxmHV59EUIg7d4L5oT/GQ/ux1wI7Z5PqVb5MizKvYLW29sOmog07gL0IX0nGWYIK8a
         JvT4uF+sDKRL6OhPCc63flBKAUXL/lvTSa0H1BlIi2KkznPIBr2Vl1HMxMu7yQxhkAH/
         076FcZ1G1Gx+7iKCr+MGhbf53D8s6KqJIWCzSvgLuJb2tGvRGXu71k6OBCVZmWglfNtj
         W75A==
X-Gm-Message-State: AOAM531E66H+1HrcXRNfsxwKz3mgYK5LGyfr1bg7sYNrug7tw2Ryn5zd
        NdRPuLDxECoDmj24nDIw7SSdHx2TbjcDuY5QIE707Lgh/QsiXtmUnNak/jkdobPgUEKStVsZW75
        j/Pms3oyS4WcHR3k8p4ZI9R4=
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr20645475wme.112.1621889262690;
        Mon, 24 May 2021 13:47:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4y0ixYEj3qFXDzaHoaf15oPnQFx3vI9s/uYI6cgYBO1tcM6YLEAAGHvOKrpR63lp1dfe8Dg==
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr20645470wme.112.1621889262506;
        Mon, 24 May 2021 13:47:42 -0700 (PDT)
Received: from redhat.com ([2a10:8006:fcda:0:90d:c7e7:9e26:b297])
        by smtp.gmail.com with ESMTPSA id c15sm14024623wrd.49.2021.05.24.13.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 13:47:40 -0700 (PDT)
Date:   Mon, 24 May 2021 16:47:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
        Christoph Hellwig <hch@lst.de>, jasowang@redhat.com
Subject: Re: [PATCH v2] virtio-blk: limit seg_max to a safe value
Message-ID: <20210524164202-mutt-send-email-mst@kernel.org>
References: <20210524154020.98195-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524154020.98195-1-stefanha@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 24, 2021 at 04:40:20PM +0100, Stefan Hajnoczi wrote:
> The struct virtio_blk_config seg_max value is read from the device and
> incremented by 2 to account for the request header and status byte
> descriptors added by the driver.
> 
> In preparation for supporting untrusted virtio-blk devices, protect
> against integer overflow and limit the value to a safe maximum.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Limit to a virtio-specific value instead of using SG_MAX_SEGMENTS
>    [Christoph]
> ---
>  drivers/block/virtio_blk.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b9fa3ef5b57c..1635d4289202 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -21,6 +21,9 @@
>  #define VQ_NAME_LEN 16
>  #define MAX_DISCARD_SEGMENTS 256u
>  
> +/* The maximum number of sg elements that fit into a virtqueue */
> +#define VIRTIO_BLK_MAX_SG_ELEMS 32768

32768 is what it says for split queues but for packed queues
it says 2^15.

So 0x8000 then?

> +
>  static int major;
>  static DEFINE_IDA(vd_index_ida);
>  
> @@ -728,7 +731,10 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	if (err || !sg_elems)
>  		sg_elems = 1;
>  
> -	/* We need an extra sg elements at head and tail. */

s/an extra/extra/

> +	/* Prevent integer overflows and honor max vq size */
> +	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
> +
> +	/* We need extra sg elements at head and tail. */
>  	sg_elems += 2;
>  	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
>  	if (!vblk) {
> -- 
> 2.31.1
> 

