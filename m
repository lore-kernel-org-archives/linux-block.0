Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A2EFA373F
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 21:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiJXVDb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiJXVDN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 17:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BDE1217C1
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666638481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Co+mZwrA6BtWICFuluqHpcYHUEFY3CVy1+yDBlYoNG0=;
        b=Z+jfX3JC1sQFvoHX2QUCFNe+Vd2HSJFCo4izWoWzLqjXUvZPlv0zw0lPAjTH19k33tvE9N
        uRmu8VFJ7HAlDjNsKmAzZErm6vme26UKafJVrvsdRiecqK6Vit5jTC6g7vQUi5/aXekB6x
        L7cwmQStDSB7Z8u5Ecx+5GFNIWgfMyc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-549-Dz7eVoSTN5O59DnC8WJBBw-1; Mon, 24 Oct 2022 09:33:53 -0400
X-MC-Unique: Dz7eVoSTN5O59DnC8WJBBw-1
Received: by mail-qk1-f200.google.com with SMTP id f12-20020a05620a408c00b006ced53b80e5so8992133qko.17
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 06:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co+mZwrA6BtWICFuluqHpcYHUEFY3CVy1+yDBlYoNG0=;
        b=HetacyjTvk9FdbtDXYtNF0RC0i5QhiF9BahBTrOpHuxqCLxMQmCiF74PaoKTKNDD5s
         2TgkYuy+LFbSH0gqA0RY7evG73pcMQ6B0rSiEGFbOzk6ylelh5HSqaGNaaqPSSReXfRj
         DHoofNdnb2tN7cwXzOKlQDUaublGKa4wnJQwdMJgCAdZSs+txA265tV48QnEhDIWBSry
         oFm/8MR385v69QucsVv4mb0VO8jhUnmjYvb8fvMY7vpjnIqsBdVYXvY4oxIdh3mBt7d7
         sqzW2iOjwAS8TrN68p19rLE+7r8yYrAjypduR/+wbGdnys9+vntUTW6xirxAcucAkyDC
         K4Pg==
X-Gm-Message-State: ACrzQf13r6BlnS88Q2hSzOW29kAZqoQ02q9wmvJT0yflmUzlnWiySwM1
        w+DHeYbzuejHvSbA8SEfys5FHWnNhTETKZEXHsYAf5KQYzvyoXj7eb28Dp3yfMfGH7xZXL43MsI
        jtCuVgA4zD0Jv0HYO3SB5Wh0=
X-Received: by 2002:a05:620a:2991:b0:6ee:92ee:5165 with SMTP id r17-20020a05620a299100b006ee92ee5165mr23277318qkp.177.1666618432977;
        Mon, 24 Oct 2022 06:33:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Yg9OJr5t+PzjIlFe7DyeWZYWlKJigBrJ2zA777WAfcBRrHdX5Mzg+wwVEGTHNrqihr8BU8g==
X-Received: by 2002:a05:620a:2991:b0:6ee:92ee:5165 with SMTP id r17-20020a05620a299100b006ee92ee5165mr23277283qkp.177.1666618432728;
        Mon, 24 Oct 2022 06:33:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-34.retail.telecomitalia.it. [87.11.6.34])
        by smtp.gmail.com with ESMTPSA id ay11-20020a05620a178b00b006ee96d82188sm13005230qkb.1.2022.10.24.06.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:33:52 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:33:46 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_blk: Fix signedness bug in virtblk_prep_rq()
Message-ID: <20221024133346.whuejusy333o3vqd@sgarzare-redhat>
References: <20221021204126.927603-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221021204126.927603-1-rafaelmendsr@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 21, 2022 at 05:41:26PM -0300, Rafael Mendonca wrote:
>The virtblk_map_data() function returns negative error codes, however, the
>'nents' field of vbr->sg_table is an unsigned int, which causes the error
>handling not to work correctly.
>
>Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
>Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
>---
> drivers/block/virtio_blk.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Good catch!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>index 19da5defd734..291f705e61a8 100644
>--- a/drivers/block/virtio_blk.c
>+++ b/drivers/block/virtio_blk.c
>@@ -321,16 +321,18 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
> 					struct virtblk_req *vbr)
> {
> 	blk_status_t status;
>+	int num;
>
> 	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> 	if (unlikely(status))
> 		return status;
>
>-	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
>-	if (unlikely(vbr->sg_table.nents < 0)) {
>+	num = virtblk_map_data(hctx, req, vbr);
>+	if (unlikely(num < 0)) {
> 		virtblk_cleanup_cmd(req);
> 		return BLK_STS_RESOURCE;
> 	}
>+	vbr->sg_table.nents = num;
>
> 	blk_mq_start_request(req);
>
>-- 
>2.34.1
>

