Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA8EC43603
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4501764F69
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhCRQuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232216AbhCRQt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 12:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616086197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+D7R0dmx1EexdXy1yf5Y6TiIr7C7M/actiCutRe5+Uw=;
        b=W69nYkNAj8bbxSvLoe9eGlJEDlJ5N9Gw9x+mwjuFmWKW2TVH+H4w0/uD+Bdj0L2WIkQeju
        3C48BtbkkTALzVnPW67Dsb6zaYGpgl3MRzoVRkIaYrq0lT2JyYkTJ74gKtaSNrdxn4v9pZ
        OTWwEWhK4C/e6Zw3VJXKk5sryZmyWVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-j0q2OQDtNGWYX08WOhzwrQ-1; Thu, 18 Mar 2021 12:49:54 -0400
X-MC-Unique: j0q2OQDtNGWYX08WOhzwrQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2738D9CC02;
        Thu, 18 Mar 2021 16:49:51 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C11C5D9C6;
        Thu, 18 Mar 2021 16:49:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: [RFC PATCH V2 10/13] block: add queue_to_disk() to get gendisk from request_queue
Date:   Fri, 19 Mar 2021 00:48:24 +0800
Message-Id: <20210318164827.1481133-11-ming.lei@redhat.com>
In-Reply-To: <20210318164827.1481133-1-ming.lei@redhat.com>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jeffle Xu <jefflexu@linux.alibaba.com>

Sometimes we need to get the corresponding gendisk from request_queue.

It is preferred that block drivers store private data in
gendisk->private_data rather than request_queue->queuedata, e.g. see:
commit c4a59c4e5db3 ("dm: stop using ->queuedata").

So if only request_queue is given, we need to get its corresponding
gendisk to get the private data stored in that gendisk.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
---
 include/linux/blkdev.h       | 2 ++
 include/trace/events/kyber.h | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 89a01850cf12..bfab74b45f15 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -686,6 +686,8 @@ static inline bool blk_account_rq(struct request *rq)
 	dma_map_page_attrs(dev, (bv)->bv_page, (bv)->bv_offset, (bv)->bv_len, \
 	(dir), (attrs))
 
+#define queue_to_disk(q)	(dev_to_disk(kobj_to_dev((q)->kobj.parent)))
+
 static inline bool queue_is_mq(struct request_queue *q)
 {
 	return q->mq_ops;
diff --git a/include/trace/events/kyber.h b/include/trace/events/kyber.h
index c0e7d24ca256..f9802562edf6 100644
--- a/include/trace/events/kyber.h
+++ b/include/trace/events/kyber.h
@@ -30,7 +30,7 @@ TRACE_EVENT(kyber_latency,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= disk_devt(dev_to_disk(kobj_to_dev(q->kobj.parent)));
+		__entry->dev		= disk_devt(queue_to_disk(q));
 		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
 		strlcpy(__entry->type, type, sizeof(__entry->type));
 		__entry->percentile	= percentile;
@@ -59,7 +59,7 @@ TRACE_EVENT(kyber_adjust,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= disk_devt(dev_to_disk(kobj_to_dev(q->kobj.parent)));
+		__entry->dev		= disk_devt(queue_to_disk(q));
 		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
 		__entry->depth		= depth;
 	),
@@ -81,7 +81,7 @@ TRACE_EVENT(kyber_throttled,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= disk_devt(dev_to_disk(kobj_to_dev(q->kobj.parent)));
+		__entry->dev		= disk_devt(queue_to_disk(q));
 		strlcpy(__entry->domain, domain, sizeof(__entry->domain));
 	),
 
-- 
2.29.2

