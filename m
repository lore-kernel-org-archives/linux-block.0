Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22E5C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FC320737
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzAFkrOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgGBEhH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:37:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22350 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726047AbgGBEhG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 00:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593664625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ihaaUAj1dv1X8e2gPNhrZht2SMG64bRXTo9mlrkcfac=;
        b=gzAFkrOUJyn+Inrrd3RUUTd2Qmmj5HgGqRwVsi0WqILHmoRAgx8PgckUixb1bDnyiXxCkk
        eYtwofYhPFz/vqmJEmOzv+vHmyIRNH2+Y7LK2JI0bXyTVOjHhM0uZKCKQzjDtN2gKYQYN0
        4ZTmCww3dJ8Dw6GVSLqaecOLAVIlBSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435--JHYcDUGNP62_xbncg1M4Q-1; Thu, 02 Jul 2020 00:37:03 -0400
X-MC-Unique: -JHYcDUGNP62_xbncg1M4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C90D18A0761;
        Thu,  2 Jul 2020 04:37:02 +0000 (UTC)
Received: from T590 (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1A577922F;
        Thu,  2 Jul 2020 04:36:56 +0000 (UTC)
Date:   Thu, 2 Jul 2020 12:36:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hulk Robot <hulkci@huawei.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH -next] block: remove unused but set variable 'hctx'
Message-ID: <20200702043651.GB2452799@T590>
References: <20200702035445.22780-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702035445.22780-1-weiyongjun1@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 02, 2020 at 11:54:45AM +0800, Wei Yongjun wrote:
> From: Hulk Robot <hulkci@huawei.com>
> 
> After commit 37f4a24c2469 ("blk-mq: centralise related handling
> into blk_mq_get_driver_tag"), 'hctx' is never be used. Gcc report
> build warning:
> 
> block/blk-flush.c:222:24: warning:
>  variable hctx set but not used [-Wunused-but-set-variable]
>   222 |  struct blk_mq_hw_ctx *hctx;
>       |                        ^~~~
> 
> Just removing it to avoid build warning.
> 
> Signed-off-by: Hulk Robot <hulkci@huawei.com>
> ---
>  block/blk-flush.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index e756db088d84..a20fe125e9fa 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -219,7 +219,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>  	struct request *rq, *n;
>  	unsigned long flags = 0;
>  	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
> -	struct blk_mq_hw_ctx *hctx;
>  
>  	blk_account_io_flush(flush_rq);
>  
> @@ -235,7 +234,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
>  	if (fq->rq_status != BLK_STS_OK)
>  		error = fq->rq_status;
>  
> -	hctx = flush_rq->mq_hctx;
>  	if (!q->elevator)
>  		flush_rq->tag = BLK_MQ_NO_TAG;
>  	else
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

