Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A32C433E1
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 10:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C388B20732
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 10:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bF9jfaZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgHUKQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727791AbgHUKQh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 06:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598004996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKzoyZbMVaVF+UK4C75BNUUVXmG7cGcHLaVyeGXNfqo=;
        b=bF9jfaZoLNiuW9My5jzYJX3x+PSDKpbhESK/u5CCf7Ql3VkONhR/rTy22NGgteiHsN+40O
        YocvRikMGSbd8OOTlnnCyE5b1PMN+ooXnD1KABEds/bcOwdXOJOEy0EQr5twy5UfvdVa6K
        Kkg9NBhluHUoMcMzD8CkEFSPg5JvKsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-_HQcu0nkOy2kTTo1ebvgew-1; Fri, 21 Aug 2020 06:16:32 -0400
X-MC-Unique: _HQcu0nkOy2kTTo1ebvgew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F31F1074649;
        Fri, 21 Aug 2020 10:16:30 +0000 (UTC)
Received: from T590 (ovpn-13-95.pek2.redhat.com [10.72.13.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDFD07AEC5;
        Fri, 21 Aug 2020 10:16:21 +0000 (UTC)
Date:   Fri, 21 Aug 2020 18:16:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Message-ID: <20200821101617.GA3125762@T590>
References: <20200820030248.2809559-1-ming.lei@redhat.com>
 <20200821063448.GF28559@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821063448.GF28559@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 21, 2020 at 08:34:48AM +0200, Christoph Hellwig wrote:
> > -static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
> > -	__releases(hctx->srcu)
> > +static void hctx_unlock(struct blk_mq_hw_ctx *hctx)
> >  {
> >  	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
> >  		rcu_read_unlock();
> >  	else
> > -		srcu_read_unlock(hctx->srcu, srcu_idx);
> > +		percpu_ref_put(&hctx->queue->dispatch_counter);
> 
> While you're at it:  can we avoid the pointless inversion in the if
> statement and just do:
> 
>  	if (hctx->flags & BLK_MQ_F_BLOCKING)
> 		percpu_ref_put(&hctx->queue->dispatch_counter);
> 	else
> 		rcu_read_unlock();

OK, will do that, but strictly speaking they don't belong to this patch.

> 
> > +static inline bool hctx_lock(struct blk_mq_hw_ctx *hctx)
> >  {
> >  	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> > -		/* shut up gcc false positive */
> > -		*srcu_idx = 0;
> >  		rcu_read_lock();
> > +		return true;
> >  	} else
> > -		*srcu_idx = srcu_read_lock(hctx->srcu);
> > +		return percpu_ref_tryget_live(&hctx->queue->dispatch_counter);
> >  }
> 
> Same here.
> 
> Otherwise this looks good to me, but did you do a deep audit that all
> the new hctx_lock() failure cases don't cause problems?

This patch just treats hctx_lock() failure as queue quiesce since
queue quiesce is the only reason of the failure:

1) called for run hw queue:

- __blk_mq_run_hw_queue()
- blk_mq_run_hw_queue()

In both two functions, blk_queue_quiesced() follows hctx_lock(), and
we return immediately if queue is quiesced. hctx_lock() failure
is thought as queue being quiesced, so the handling is correct.

2) called in direct issue path:
- blk_mq_try_issue_directly()
- blk_mq_request_issue_directly()

The current handling is to add request to scheduler queue if queue
is quiesced, so this patch adds the request to scheduler queue in case
of hctx_lock() failure.


Thanks,
Ming

