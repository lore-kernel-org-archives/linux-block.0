Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD51BC4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 12:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E76613AD
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 12:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbhHWMvH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237070AbhHWMvG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 08:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629723024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OFTm09P5LyoQVIUNtr43h/G3XCJIvH4h4XxosBFOzR4=;
        b=fbkLREV+o1GQ+LHyOKxAGPU60dHcXt8h/R07WQYSQkm9oVM6JaPKUO8SspyyGS3wyIDvXQ
        TD8/OqxVCRILjkgmko/LPvkuQLm5YXwPcee1Ym2bYkP0N5lojRdqk2VfvuptHK6E1MqGM9
        njJU0/jyBLh9HJMZaNU3DEIabD5S0/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-cDuADdTmNbyFHI7jTK7Hjg-1; Mon, 23 Aug 2021 08:50:23 -0400
X-MC-Unique: cDuADdTmNbyFHI7jTK7Hjg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C3101B18BC0;
        Mon, 23 Aug 2021 12:50:21 +0000 (UTC)
Received: from T590 (ovpn-8-41.pek2.redhat.com [10.72.8.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B28AA60861;
        Mon, 23 Aug 2021 12:50:13 +0000 (UTC)
Date:   Mon, 23 Aug 2021 20:50:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Joseph Qi <jiangqi903@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>,
        Yufen Yu <yuyufen@huawei.com>
Subject: Re: [PATCH] blk-mq: fix is_flush_rq
Message-ID: <YSOZgPtd4xkeAzeI@T590>
References: <20210818010925.607383-1-ming.lei@redhat.com>
 <ae6c32cc-0bd1-601a-559e-8d6e2578f0ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6c32cc-0bd1-601a-559e-8d6e2578f0ec@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 23, 2021 at 08:42:45PM +0800, Joseph Qi wrote:
> Hi Ming,
> 
> On 8/18/21 9:09 AM, Ming Lei wrote:
> > is_flush_rq() is called from bt_iter()/bt_tags_iter(), and runs the
> > following check:
> > 
> > 	hctx->fq->flush_rq == req
> > 
> > but the passed hctx from bt_iter()/bt_tags_iter() may be NULL because:
> > 
> > 1) memory re-order in blk_mq_rq_ctx_init():
> > 
> > 	rq->mq_hctx = data->hctx;
> > 	...
> > 	refcount_set(&rq->ref, 1);
> > 
> > OR
> > 
> > 2) tag re-use and ->rqs[] isn't updated with new request.
> > 
> > Fix the issue by re-writing is_flush_rq() as:
> > 
> > 	return rq->end_io == flush_end_io;
> > 
> > which turns out simpler to follow and immune to data race since we have
> > ordered WRITE rq->end_io and refcount_set(&rq->ref, 1).
> > 
> Recently we've run into a similar crash due to NULL rq->mq_hctx in
> blk_mq_put_rq_ref() on ARM, and it is a normal write request.
> Since memory reorder truly exists, we may also risk other uninitialized
> member accessing after this commit, at least we have to be more careful
> in busy_iter_fn...
> So here you don't use memory barrier before refcount_set() is for
> performance consideration?

Yes, also it is much simpler to check ->end_io in concept.


Thanks,
Ming

