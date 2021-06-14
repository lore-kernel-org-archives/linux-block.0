Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76EFC2B9F4
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 22:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16B461185
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 22:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhFNWJX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 18:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229836AbhFNWJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 18:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623708438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0fcsgEfARtJMbU3di1nGFAh34iIfXYKSNJJyS9SqZTw=;
        b=Ti6MWap0LR9tdCfbWgjuZjwZbShG0m7fpbKXGVWEA2shdud7fmb2YipEYxujQsTDGS+G8I
        yN6S/WkAtzXU9Tos4s43/uLmb48IG1RGS1XbGKMjq/0Q2qzbSacQa/UurxfahOjQtSI2ys
        I/eusIw05MhNpjY1QsuiO3rXRoaCfYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-bO2fwlbTOmC8_JCsPKBRCw-1; Mon, 14 Jun 2021 18:07:14 -0400
X-MC-Unique: bO2fwlbTOmC8_JCsPKBRCw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93FDA8015A4;
        Mon, 14 Jun 2021 22:07:13 +0000 (UTC)
Received: from T590 (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C6435C1A3;
        Mon, 14 Jun 2021 22:07:06 +0000 (UTC)
Date:   Tue, 15 Jun 2021 06:07:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] blk-mq: fix use-after-free in blk_mq_exit_sched
Message-ID: <YMfTBagmPCHGkhYa@T590>
References: <20210609063046.122843-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609063046.122843-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 09, 2021 at 02:30:46PM +0800, Ming Lei wrote:
> tagset can't be used after blk_cleanup_queue() is returned because
> freeing tagset usually follows blk_clenup_queue(). Commit d97e594c5166
> ("blk-mq: Use request queue-wide tags for tagset-wide sbitmap") adds
> check on q->tag_set->flags in blk_mq_exit_sched(), and causes
> use-after-free.
> 
> Fixes it by using hctx->flags.
> 
> Reported-by: syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com
> Fixes: d97e594c5166 ("blk-mq: Use request queue-wide tags for tagset-wide sbitmap")
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-sched.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index a9182d2f8ad3..80273245d11a 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -680,6 +680,7 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>  {
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned int i;
> +	unsigned int flags = 0;
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		blk_mq_debugfs_unregister_sched_hctx(hctx);
> @@ -687,12 +688,13 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>  			e->type->ops.exit_hctx(hctx, i);
>  			hctx->sched_data = NULL;
>  		}
> +		flags = hctx->flags;
>  	}
>  	blk_mq_debugfs_unregister_sched(q);
>  	if (e->type->ops.exit_sched)
>  		e->type->ops.exit_sched(e);
>  	blk_mq_sched_tags_teardown(q);
> -	if (blk_mq_is_sbitmap_shared(q->tag_set->flags))
> +	if (blk_mq_is_sbitmap_shared(flags))
>  		blk_mq_exit_sched_shared_sbitmap(q);
>  	q->elevator = NULL;
>  }

Hello Jens,

Any chance to merge this fix?


Thanks,
Ming

