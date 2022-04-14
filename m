Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Apr 2022 01:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiDNBlN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 21:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDNBlM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 21:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88F221FCFD
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 18:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649900328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UmwpZWnvhLIfbrDAcU7n09qD5B9k5m1qGSzzA5XOGCA=;
        b=YbeAJJ/oQ3Vp+JGBus1OLjSXkLCoKPjqD0ra+StgnppPE2KuWw8moAbrpTJXc9xi+2bxPd
        Dzc61kQkrg0zGqsHm3Dm+2cOOrFQyqJ4n0PT4DP9PKJC7GNWUAj3oPiRv4hpR/D2Ech0O+
        IvmEQ5hCCmBZYnNrHdrF5VGGEXFqpN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-UH7sATRROl-4qfsDZBjQMQ-1; Wed, 13 Apr 2022 21:38:47 -0400
X-MC-Unique: UH7sATRROl-4qfsDZBjQMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CD9080B71C;
        Thu, 14 Apr 2022 01:38:47 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B51207C43;
        Thu, 14 Apr 2022 01:38:40 +0000 (UTC)
Date:   Thu, 14 Apr 2022 09:38:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH] block: avoid io timeout in case of sync polled dio
Message-ID: <Yld7GwWuzbnHr6Qi@T590>
References: <20220413084805.1571884-1-ming.lei@redhat.com>
 <Ylb/gciNitj7yd/c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylb/gciNitj7yd/c@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 09:51:13AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 13, 2022 at 04:48:05PM +0800, Ming Lei wrote:
> > If the bio is marked as POLLED after submission,
> 
> Umm, a bio should never be marked POLLED after submission.

I meant its POLLED flag is still kept after submission since either
bio split or the submission check code may clear it.

> 
> > bio_poll() should be
> > called for reaping io since there isn't irq for completing the request,
> > so we can't call into blk_io_schedule() in case that bio_poll() returns
> > zero.
> > 
> > Also for calling bio_poll(), current->plug has to be flushed out,
> > otherwise bio may not be issued to driver, and ->bi_cookie won't
> > be set.
> 
> I think we just need to bypass the plug to start with for synchronous
> polled I/O. 

That should work, something like the following. But I guess it may hurt
performance on io_uring workload, which does flush plug explicitly.

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 7771dacc99cb..f15dee40ed02 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -1040,6 +1040,9 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 	struct blk_plug *plug;
 	struct request *rq;
 
+	if (blk_bypass_plug(bio))
+		return false;
+
 	plug = blk_mq_plug(q, bio);
 	if (!plug || rq_list_empty(plug->mq_list))
 		return false;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ed3ed86f7dd2..aa6b1e6b6d8c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2851,7 +2851,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		return;
 	}
 
-	if (plug)
+	if (plug && !blk_bypass_plug(bio))
 		blk_add_rq_to_plug(plug, rq);
 	else if ((rq->rq_flags & RQF_ELV) ||
 		 (rq->mq_hctx->dispatch_busy &&
diff --git a/block/blk.h b/block/blk.h
index 8ccbc6e07636..65b3e0bac322 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -507,4 +507,12 @@ static inline int req_ref_read(struct request *req)
 	return atomic_read(&req->ref);
 }
 
+static inline bool blk_bypass_plug(struct bio *bio)
+{
+	if (op_is_sync(bio->bi_opf) && (bio->bi_opf & REQ_POLLED))
+		return true;
+
+	return false;
+}
+
 #endif /* BLK_INTERNAL_H */

> 
> Do you have a reproducer?  We'd also need to sort all this out for
> polled file system I/O as well.

Yeah, we should cover swap_readpage()/__iomap_dio_rw(), and the issue
can be reproduced pretty easily, so not sure if there is real users of
sync polled dio, and the issue is found by Changhui in RH lab test.

fio --bs=4k --ioengine=pvsync2 --norandommap --hipri=1 \
    --filename=$DEV --direct=1 --runtime=10 --numjobs=1 --rw=rw \
    --name=test --group_reporting

$DEV can be nvme/null_blk, both can be triggered reliably & easily.

I'd suggest to fix it in __blkdev_direct_IO_simple()/swap_readpage()/__iomap_dio_rw()
for avoiding to hurt io_uring.


Thanks,
Ming

