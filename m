Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93946C7EE23
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 01:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjEVBYo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 May 2023 21:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjEVBYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2023 21:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A98DDB
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 18:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684718642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJumi8n/WQJPSueROKAa9XL2xxes9sqnYn4QAnZbcgY=;
        b=L/VwYasPuGT6xxOXM9IaKXWQ3LHPuEw27RZduJ8wbk//F4KnODHUSYFUJh3gLRz+d0T8rP
        ek/1WweAmZq6Yf/7FwwV+CZXp+obmu93hfjBetjkmZd9F4zWvI1KelvNuwQdir/In356y+
        FyuR+smBsr7aDtzeiy81Op7/YUv9Ls4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-i981L9DGPJuubz231dHERQ-1; Sun, 21 May 2023 21:23:58 -0400
X-MC-Unique: i981L9DGPJuubz231dHERQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0ED9D101A531;
        Mon, 22 May 2023 01:23:58 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DC69C57961;
        Mon, 22 May 2023 01:23:54 +0000 (UTC)
Date:   Mon, 22 May 2023 09:23:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Tian Lan <tilan7663@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Tian Lan <tian.lan@twosigma.com>
Subject: Re: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
Message-ID: <ZGrEJRrZcjYtlMpV@ovpn-8-16.pek2.redhat.com>
References: <20230522004328.760024-1-tilan7663@gmail.com>
 <694813ca-690d-4852-0066-cee6833ad8c4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <694813ca-690d-4852-0066-cee6833ad8c4@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 10:15:22AM +0900, Damien Le Moal wrote:
> On 5/22/23 09:43, Tian Lan wrote:
> > From: Tian Lan <tian.lan@twosigma.com>
> > 
> > If multiple CPUs are sharing the same hardware queue, it can
> > cause leak in the active queue counter tracking when __blk_mq_tag_busy()
> > is executed simultaneously.
> > 
> > Fixes: ee78ec1077d3 ("blk-mq: blk_mq_tag_busy is no need to return a value")
> > Signed-off-by: Tian Lan <tian.lan@twosigma.com>
> > ---
> >  block/blk-mq-tag.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index d6af9d431dc6..07372032238a 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -42,13 +42,15 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
> >  	if (blk_mq_is_shared_tags(hctx->flags)) {
> >  		struct request_queue *q = hctx->queue;
> >  
> > -		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> > +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
> > +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
> 
> This is weird. test_and_set_bit() returns the bit old value, so shouldn't this be:
> 
> 		if (test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> 			return;
> 
> ?

It is one micro optimization since test_and_set_bit is much heavier than
test_bit, so test_and_set_bit() is just needed in the 1st time.

Thanks,
Ming

