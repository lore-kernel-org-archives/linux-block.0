Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1545EC433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 01:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJUBrG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 21:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJUBrF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 21:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B6922E8C0
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 18:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666316821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rubxu5P5m0yu63YebC/bkr+rMDHRCz0exG7/VTY1p5I=;
        b=c1UqjQ4I51zOfFDvgHKF8zlWe28luZe8SOoq94+qJti/cqC8aV0uVlcN7UevODHJa4kYpS
        G0aiMiYLQgJHPJWap0GYymlAbMfZzAHIqNm+wzWvVMz1febgbC70pYivDfsvuK8IgWtTvW
        R7HvURTdOff8hQS70lIEFseUSqc61Eg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-WYpq7VaSOFCIvvnJf5CBIA-1; Thu, 20 Oct 2022 21:46:58 -0400
X-MC-Unique: WYpq7VaSOFCIvvnJf5CBIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C65593810D51;
        Fri, 21 Oct 2022 01:46:56 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E989D40E8B14;
        Fri, 21 Oct 2022 01:46:42 +0000 (UTC)
Date:   Fri, 21 Oct 2022 09:46:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/8] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Message-ID: <Y1H5+Z5HotPo7yWV@T590>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-5-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 20, 2022 at 12:56:04PM +0200, Christoph Hellwig wrote:
> Noting in blk_mq_wait_quiesce_done needs the request_queue now, so just
> pass the tagset, and move the non-mq check into the only caller that
> needs it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c           | 10 +++++-----
>  drivers/nvme/host/core.c |  4 ++--
>  drivers/scsi/scsi_lib.c  |  2 +-
>  include/linux/blk-mq.h   |  2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4a81a2da43328..cf8f9f9a96c35 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -254,15 +254,15 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>  
>  /**
>   * blk_mq_wait_quiesce_done() - wait until in-progress quiesce is done
> - * @q: request queue.
> + * @set: tag_set to wait on
>   *
>   * Note: it is driver's responsibility for making sure that quiesce has
>   * been started.
>   */
> -void blk_mq_wait_quiesce_done(struct request_queue *q)
> +void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set)

The change is fine, but the interface could confuse people, it
looks like it is waiting for whole tagset quiesced, but it needs
to mark all request queues as quiesced first, otherwise it is just
wait for one specific queue's quiesce.

So suggest to document such thing.


Thanks,
Ming

