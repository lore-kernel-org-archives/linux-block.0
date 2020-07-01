Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD0C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 12:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014C520772
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 12:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a3Umgkyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgGAMyN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbgGAMyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 08:54:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B5EC03E979
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BnrtnZzjsCykP50N+5cmw+mZwPi2cq0eihdwLcUWrmw=; b=a3Umgkygrlelpkiueg29qMexTB
        XiDo7yen4E+b/rcw1bjziW53l/rOZoan0Z18fDTy1Fl0hGvKT/no/SRpIgX1snwh7ljLl7cNwVDLC
        uTbHJW9RuxcxcdNHOBrODYHFbbJj36RFNtZIMEtUSljB3APCqo+EyrFFXZczK1sntl81NndVI0FL8
        naiXzTWXiyYCSLS0k9snsex8w96Sfum1Y4WWvWHbX/tLIQPBgTlu21iQQ//5gGewVC9EVkDR7H9Xx
        KX+hDU3n2ljdi0Kd3Fkhhnc8Zdvcqg1oRLsGsta25D4tfNQlkzOGiZg5+KGklCiGJgG+zs6rfYqau
        YkuB9Dug==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqcFd-0003se-Qm; Wed, 01 Jul 2020 12:54:10 +0000
Date:   Wed, 1 Jul 2020 13:54:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] blk-mq: streamline handling of q->mq_ops->queue_rq result
Message-ID: <20200701125409.GA13335@infradead.org>
References: <20200701101617.2434985-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701101617.2434985-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 01, 2020 at 06:16:17PM +0800, Ming Lei wrote:
> Current handling of q->mq_ops->queue_rq result is a bit ugly:
> 
> - two branches which needs to 'continue' have to check if the
> dispatch local list is empty, otherwise one bad request may
> be retrieved via 'rq = list_first_entry(list, struct request, queuelist);'
> 
> - the branch of 'if (unlikely(ret != BLK_STS_OK))' isn't easy
> to follow, since it is actually one error branch.
> 
> Streamline this handling, so the code becomes more readable, meantime
> potential kernel oops can be avoided in case that the last request in
> local dispatch list is failed.

I don't really find that much easier to read.  If we want to clean
this up for rea we should use a proper switch statement.  Something like
this:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9aa6d1e44cf32..f3721f274b800e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1275,30 +1275,28 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		}
 
 		ret = q->mq_ops->queue_rq(hctx, &bd);
-		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
-			blk_mq_handle_dev_resource(rq, list);
+		switch (ret) {
+		case BLK_STS_OK:
+			queued++;
 			break;
-		} else if (ret == BLK_STS_ZONE_RESOURCE) {
+		case BLK_STS_RESOURCE:
+		case BLK_STS_DEV_RESOURCE:
+			blk_mq_handle_dev_resource(rq, list);
+			goto out;
+		case BLK_STS_ZONE_RESOURCE:
 			/*
 			 * Move the request to zone_list and keep going through
 			 * the dispatch list to find more requests the drive can
 			 * accept.
 			 */
 			blk_mq_handle_zone_resource(rq, &zone_list);
-			if (list_empty(list))
-				break;
-			continue;
-		}
-
-		if (unlikely(ret != BLK_STS_OK)) {
+			break;
+		default:
 			errors++;
 			blk_mq_end_request(rq, BLK_STS_IOERR);
-			continue;
 		}
-
-		queued++;
 	} while (!list_empty(list));
-
+out:
 	if (!list_empty(&zone_list))
 		list_splice_tail_init(&zone_list, list);
 
