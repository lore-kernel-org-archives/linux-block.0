Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F72C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 01:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJUBN7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJUBN6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 21:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28D822D59C
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 18:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666314837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x0x7La/KJwWUwTRhdc113nlLBaY7LHMOa3RNzKxynnI=;
        b=dAKw4c+nh3AVPVPIm8hiheZTS6nN8tPH8PWs6mETKRgnqdkOYazUhN1OplLKXZmaCdB7AB
        Eo2a0iOxgEEtaw3ggaSn4y0dD32Lh+UTomwbOx7wfASUK5H+GZIhIaiZWrA0RvtjQMI5I/
        C0AiQalxmTtTNKERye4wg/C3xqv2uzY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-eDA5xFHcP06FD__MNwUdQg-1; Thu, 20 Oct 2022 21:13:54 -0400
X-MC-Unique: eDA5xFHcP06FD__MNwUdQg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69E14800186;
        Fri, 21 Oct 2022 01:13:48 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7486426205;
        Fri, 21 Oct 2022 01:13:36 +0000 (UTC)
Date:   Fri, 21 Oct 2022 09:13:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Message-ID: <Y1HyOS9A72GZIQWT@T590>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-3-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 20, 2022 at 12:56:02PM +0200, Christoph Hellwig wrote:
> For submit_bio based queues there is no (S)RCU critical section during
> I/O submission and thus nothing to wait for in blk_mq_wait_quiesce_done,
> so skip doing any synchronization.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 33292c01875d5..df967c8af9fee 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -280,7 +280,9 @@ EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
>  void blk_mq_quiesce_queue(struct request_queue *q)
>  {
>  	blk_mq_quiesce_queue_nowait(q);
> -	blk_mq_wait_quiesce_done(q);
> +	/* nothing to wait for non-mq queues */
> +	if (queue_is_mq(q))
> +		blk_mq_wait_quiesce_done(q);

This interface can't work as expected for bio drivers, the only user
should be del_gendisk(), but anyway the patch is fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming

