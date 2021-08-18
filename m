Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB199C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 03:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC70F6101A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 03:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhHRDci (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Aug 2021 23:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236111AbhHRDch (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 23:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629257523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCAXF2FMGjV3iL9yjzNwxD1Hc358X4e4S/k1dyzylgo=;
        b=Nwbr3kbW4G+U7kJsDQvQxHKBfnA4BLnaDgFaJnTxihoVt4TpKag6cfufbXTf0r+pW4fO7r
        OCF5CMXXAqzMXusymaQDwoDrTctT7TkzQZ5Hfj+pSQ2gfyjBpXFa+Fc0f/zFKXkbQ6SCl2
        LjiD4QJ34d8ShwBIUEcATWY5n/VL3OE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-J-YGiMNiPKOI_M0MEhoNPg-1; Tue, 17 Aug 2021 23:31:59 -0400
X-MC-Unique: J-YGiMNiPKOI_M0MEhoNPg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 322EB802922;
        Wed, 18 Aug 2021 03:31:58 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 953AC5DA2D;
        Wed, 18 Aug 2021 03:31:51 +0000 (UTC)
Date:   Wed, 18 Aug 2021 11:31:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>,
        Yufen Yu <yuyufen@huawei.com>
Subject: Re: [PATCH] blk-mq: fix is_flush_rq
Message-ID: <YRx/IWsvzq0rVd1H@T590>
References: <20210818010925.607383-1-ming.lei@redhat.com>
 <ef0681f8-5862-e340-b9e6-ebce5cfa3c2c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef0681f8-5862-e340-b9e6-ebce5cfa3c2c@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 17, 2021 at 08:02:58PM -0700, Bart Van Assche wrote:
> On 8/17/21 6:09 PM, Ming Lei wrote:
> > +bool is_flush_rq(struct request *rq)
> > +{
> > +	return rq->end_io == flush_end_io;
> > +}
> 
> My understanding is that calling is_flush_rq() is only safe if the
> caller guarantees that the request refcount >= 1. How about adding a
> comment that explains this?

Yeah, we can add the following words, but it isn't something urgent
since is_flush_rq() is one block layer internal helper.

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 4201728bf3a5..babf6262120e 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -262,6 +262,11 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 }
 
+/*
+ * Caller has to grab refcount of this request, otherwise the flush request
+ * may be re-cycled, then rq->end_io is cleared and kernel panic is caused,
+ * see blk_mq_put_rq_ref().
+ */
 bool is_flush_rq(struct request *rq)
 {
 	return rq->end_io == flush_end_io;




Thanks,
Ming

