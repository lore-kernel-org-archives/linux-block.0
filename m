Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6EFC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 15:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244558AbiCKPjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiCKPjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 10:39:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CD131C1EE2
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 07:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647013094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YD3FbTWDdRUPir8Zt2BKp98U4skV0lPtRrNJbm4dnUw=;
        b=SIxQcHXmongWEjR0ZZpuLdhJFvHMM/gtz1Am44Jh8M9/TK3JuewObXU3UAhOy4Xi/cqhJQ
        U0AFXlOYOdOaLCGFNYTQ+QctS4ls2hihvCWQmuNmCkpFs8NbVROSMSRShLBtkJEw90wLkM
        cY2anTpE83lPHEfYJXxrYhR+XF3A6lY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-S5fItiWhO1qO6Ee_YZhMtA-1; Fri, 11 Mar 2022 10:38:13 -0500
X-MC-Unique: S5fItiWhO1qO6Ee_YZhMtA-1
Received: by mail-wr1-f72.google.com with SMTP id q14-20020adfea0e000000b002036c16c6daso2936729wrm.8
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 07:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YD3FbTWDdRUPir8Zt2BKp98U4skV0lPtRrNJbm4dnUw=;
        b=7oYX9KuHxF7jiXRcyP8brCf59HHYiUY8mGSaHXwfyt0hCBN6tCu1Jqpir/id/YD2KW
         SsTnwQJpdJxNWva+0tD9+cYqXkBnFhdR1Z1pxbHbmzpda1DGrOzQwBaukUEcMyTzI3Tl
         FTbcA38uFo0J4W7riRomR4yUMKF3nE0BjBQSTICuVBKUzOA0KOj9HelZjIzNhyZZsBeh
         yweOS0F4ETfeuZLOgvSYn0urD135EdNID2UgB25M2g91vRORk9mUlURa16/Tw3e2KcV5
         cGqZu9CYMQk21FnMIe4MxHxOoKbuF3fbxlR+F2pYQnZfIu8GyfsR/tkTXyYLSN39fJjR
         6ceQ==
X-Gm-Message-State: AOAM532C2p2VNPHuqwzxu5teao09rs4IHSP1s1hk0Nz6Pk08SmrvBo0d
        SPar9QyttEU9uV98HXM4yVHKLGuefzQiDPp7V+7+Nrp6Oc6v95joYNFAd59D11WjMPLzSyLYxuv
        A3ipBQbdnYwLhpcjLBqwc4bg=
X-Received: by 2002:a05:6000:1568:b0:203:72c4:bee with SMTP id 8-20020a056000156800b0020372c40beemr7710547wrz.193.1647013091796;
        Fri, 11 Mar 2022 07:38:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynfVlQBSjbAKsq3G5l6Xx8jziz3/IiquJn6qXnkJBSURmwWs8ZfZVn999GsTUAb4z5l9DKvg==
X-Received: by 2002:a05:6000:1568:b0:203:72c4:bee with SMTP id 8-20020a056000156800b0020372c40beemr7710533wrz.193.1647013091544;
        Fri, 11 Mar 2022 07:38:11 -0800 (PST)
Received: from redhat.com ([2.53.27.107])
        by smtp.gmail.com with ESMTPSA id n9-20020a1c7209000000b00389a616615csm11858696wmc.2.2022.03.11.07.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:38:10 -0800 (PST)
Date:   Fri, 11 Mar 2022 10:38:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <20220311103549-mutt-send-email-mst@kernel.org>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311152832.17703-1-suwan.kim027@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 12, 2022 at 12:28:32AM +0900, Suwan Kim wrote:
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index d888f013d9ff..3fcaf937afe1 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -119,8 +119,9 @@ struct virtio_blk_config {
>  	 * deallocation of one or more of the sectors.
>  	 */
>  	__u8 write_zeroes_may_unmap;
> +	__u8 unused1;
>  
> -	__u8 unused1[3];
> +	__virtio16 num_poll_queues;
>  } __attribute__((packed));

Same as any virtio UAPI change, this has to go through the virtio TC.
In particular I don't think gating a new config field on
an existing feature flag is a good idea.

>  /*
> -- 
> 2.26.3

