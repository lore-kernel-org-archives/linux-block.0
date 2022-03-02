Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6A3C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 02:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiCBCHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 21:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiCBCHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 21:07:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B93F9A419F
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 18:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646186790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JiTNz3c25LAxZH982KhGDW834vFU9x7i9V6d+h6Hjes=;
        b=MBPPMPnfw7ORNt/leFMfy2+G14pi1H9tWN+KqffKtaF6CZKBbcsSLPeJQZagPMIvqLnOQD
        6EWYWb04XWp/xlcnJpHQeWMLpXZEaADg8cHP/4wQkxWHx5PaWoxUdqHrKzcRKCpkk+zIjt
        quGdFajzuV2yHsS3OR+jqrQiblJrkTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-7s2u0rzzMRmFKdKO0wwxRg-1; Tue, 01 Mar 2022 21:06:25 -0500
X-MC-Unique: 7s2u0rzzMRmFKdKO0wwxRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BED72F35;
        Wed,  2 Mar 2022 02:06:24 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 732D960BD8;
        Wed,  2 Mar 2022 02:06:08 +0000 (UTC)
Date:   Wed, 2 Mar 2022 10:06:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 6/6] blk-mq: manage hctx map via xarray
Message-ID: <Yh7RDCaqiqMmKj1s@T590>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-7-ming.lei@redhat.com>
 <Yh4hjS0S3vXfLWlH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh4hjS0S3vXfLWlH@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 01, 2022 at 05:37:17AM -0800, Christoph Hellwig wrote:
> > -			hctxs[i] = blk_mq_alloc_and_init_hctx(set, q, i,
> > -					old_node);
> > -			WARN_ON_ONCE(!hctxs[i]);
> > +			WARN_ON_ONCE(!blk_mq_alloc_and_init_hctx(set, q, i,
> > +						old_node));
> 
> 
> Please avoid doing the actual work inside a WARN_ON statement.

OK.

> 
> >  
> >  	for (; j < end; j++) {
> > -		struct blk_mq_hw_ctx *hctx = hctxs[j];
> > +		struct blk_mq_hw_ctx *hctx = blk_mq_get_hctx(q, j);
> >  
> > -		if (hctx) {
> > +		if (hctx)
> >  			blk_mq_exit_hctx(q, set, hctx, j);
> > -			hctxs[j] = NULL;
> > -		}
> >  	}
> 
> Instead of a for loop that does xa_loads repeatedly this can just
> use xa_for_each_range.  Same for a bunch of other loops like that,
> e.g. in blk_mq_unregister_dev or the __blk_mq_register_dev failure
> path.
> 
> > @@ -919,12 +919,12 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
> >  static inline struct blk_mq_hw_ctx *blk_mq_get_hctx(struct request_queue *q,
> >  		unsigned int hctx_idx)
> >  {
> > -	return q->queue_hw_ctx[hctx_idx];
> > +	return xa_load(&q->hctx_table, hctx_idx);
> >  }
> >  
> >  #define queue_for_each_hw_ctx(q, hctx, i)				\
> >  	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
> > -	     ({ hctx = blk_mq_get_hctx((q), (i)); 1; }); (i)++)
> > +	     (hctx = blk_mq_get_hctx((q), (i))); (i)++)
> 
> This should be using a xa_for_each loop.

I did considered xa_for_each(), but it requires rcu read lock.

Also queue_for_each_hw_ctx() is supposed to not run in fast path,
meantime xa_load() is lightweight enough too, so repeated xa_load()
is fine here.


Thanks,
Ming

