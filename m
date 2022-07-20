Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFB0C43334
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 23:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiGTXzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 19:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiGTXzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 19:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 645AE19C12
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 16:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658361320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZiIki+EFwqboammilHL/MQyZf3Y1IPP63ig+d68u8Y=;
        b=NVRhnQlfSCzxLmrKQZe3VeEC6jI7b9IcstipfObxVq3oKSHpmcs770/DN6nOqhjnXNlmgG
        ieVSYtHk9e1btgKm18NA3y5s1nc4ucwRMWZXoxR0tQmTDHRU8H/Yxn0lDDvxztr+v8OetB
        Ce0fNootsAswUE+G8ys1rPfhnLxvjVA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-XnM5QZW_OUa7m5LyQLuT8w-1; Wed, 20 Jul 2022 19:55:13 -0400
X-MC-Unique: XnM5QZW_OUa7m5LyQLuT8w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B771B8001EA;
        Wed, 20 Jul 2022 23:55:12 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89C47492C3B;
        Wed, 20 Jul 2022 23:55:08 +0000 (UTC)
Date:   Thu, 21 Jul 2022 07:55:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] blk-mq: fix error handling in __blk_mq_alloc_disk
Message-ID: <YtiV148hTcpsjTZ+@T590>
References: <20220720130541.1323531-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720130541.1323531-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 03:05:40PM +0200, Christoph Hellwig wrote:
> To fully clean up the queue if the disk allocation fails we need to
> call blk_mq_destroy_queue and not just blk_put_queue.
> 
> Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d716b7f3763f3..70177ee74295b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3960,7 +3960,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
>  
>  	disk = __alloc_disk_node(q, set->numa_node, lkclass);
>  	if (!disk) {
> -		blk_put_queue(q);
> +		blk_mq_destroy_queue(q);
>  		return ERR_PTR(-ENOMEM);
 
The same change is needed in case of blk_mq_init_allocated_queue() failure too.

Thanks,
Ming

