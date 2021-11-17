Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759B7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 09:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A62161BD3
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 09:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhKQJXU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:23:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235056AbhKQJXS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 04:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637140820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=77rEDu/reg/YJ6amwbhAgjZqXAbfYRFP4sr85cH8gm4=;
        b=ag+dyQo2AvlxAw6gQe94MJ2D+ZgiT5Ref0HtOjcHpzUQsrwCrMmwRYz/Dg6u6doh/Qfk/c
        MaKGUCCShVkoXB6a4C6Ir5ZIzIMXaVCk1s4w+NyIMpa/+j11yA3xPAMz4Ffe7miWnq1gUP
        JYbJQGYtE5h+wztniBqz6QcxnClp2fs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-5sjyeyKpOzajjyBXehv2eA-1; Wed, 17 Nov 2021 04:20:18 -0500
X-MC-Unique: 5sjyeyKpOzajjyBXehv2eA-1
Received: by mail-ed1-f70.google.com with SMTP id r16-20020a056402019000b003e6cbb77ed2so1570491edv.10
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 01:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=77rEDu/reg/YJ6amwbhAgjZqXAbfYRFP4sr85cH8gm4=;
        b=ZHstyE489Uay1AzWD9EOGadabPqZfU96WCXezVsxyy/edv4YG8P1s84SdAuvbO3ctM
         J8xZaAg4LXWLgK4q9QzDFKmTT04AZ6x5HLAJb45sEFT2r2QSPAGcCDj7jTUUymyz0I0g
         ZzVUjTTBqDbqakHuO2TO0/IOFxubXapPmdrI/73Mw+nGESoRO/XEFimnXQywbm6udAoG
         UYtv0wPd/FKAYyukI+uukeVKQN4BMqEjGEmbBdazGbzb+FfwWcDoNhfV77SIwW1sQBU0
         fVX75Tz4weC7qz/lwtkBB5MFhrnD/j6QFUMBV7T4szZKwC5MkiuTMcNTy3e4k4YRn7x9
         XLkQ==
X-Gm-Message-State: AOAM5335CNt7QE6+rqxxpXt9acg7k2n4Uulk6x5IpqTZWUIzr4k24Ukt
        w0LglgvwKQZpwZccHX7ZLiIDAh1Pewgu3qRsXVeTJ725LqFVfhHCCHmejV9dFT4U/MTyjT2cAHP
        6K2TXFox8i/Uc4qywknaTPXw=
X-Received: by 2002:aa7:c714:: with SMTP id i20mr19958655edq.180.1637140817840;
        Wed, 17 Nov 2021 01:20:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYtu97PwkW2A1yYGpWopI7K1d4sbVlbcdvIekk7lLEy/KSy29AQt851GD79KmBNlKEUMRrUw==
X-Received: by 2002:aa7:c714:: with SMTP id i20mr19958629edq.180.1637140817719;
        Wed, 17 Nov 2021 01:20:17 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id hw8sm9777163ejc.58.2021.11.17.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 01:20:17 -0800 (PST)
Date:   Wed, 17 Nov 2021 10:20:14 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     cgel.zte@gmail.com
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] virtio-blk: modify the value type of num in
 virtio_queue_rq()
Message-ID: <20211117092014.qyqhtg2y5etoxrqe@steredhat>
References: <20211117063955.160777-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211117063955.160777-1-ye.guojin@zte.com.cn>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 17, 2021 at 06:39:55AM +0000, cgel.zte@gmail.com wrote:
>From: Ye Guojin <ye.guojin@zte.com.cn>
>
>This was found by coccicheck:
>./drivers/block/virtio_blk.c, 334, 14-17, WARNING Unsigned expression
>compared with zero  num < 0
>

We should add the Fixes tag:

Fixes: 02746e26c39e ("virtio-blk: avoid preallocating big SGL for data")

>Reported-by: Zeal Robot <zealci@zte.com.cn>
>Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
>---
> drivers/block/virtio_blk.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>index 97bf051a50ce..eed1666eff31 100644
>--- a/drivers/block/virtio_blk.c
>+++ b/drivers/block/virtio_blk.c
>@@ -316,7 +316,7 @@ static blk_status_t virtio_queue_rq(struct 
>blk_mq_hw_ctx *hctx,
> 	struct request *req = bd->rq;
> 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> 	unsigned long flags;
>-	unsigned int num;
>+	int num;
> 	int qid = hctx->queue_num;
> 	bool notify = false;
> 	blk_status_t status;
>-- 
>2.25.1
>

The patch LGTM.

With the Fixes tag added:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

