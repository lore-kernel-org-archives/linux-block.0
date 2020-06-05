Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7C1C433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 11:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C603206E6
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 11:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXprDcov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFELon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:44:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48913 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726324AbgFELon (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 07:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591357482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSBTkQslZwg/plu+onV+KKE4IiQyXf3qhK2vQeZ33VI=;
        b=DXprDcovS2URQMLUt6FEI6Oxr11RKkeeJupe5JsZC8mU2Ixr0wd3BhwZVVK5VdWR6in+0+
        dHtnMKmauUrDYZA3ZO/uHOpGD3WrkYDCSlZhWTqh9U0E4bOsnOowmvC7sC1ntGDk1Onqb+
        Jo7/BCvy9i3wABIR7MHPYTtPsvjQAj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-Q8AW9LagMjSVUXNptLCCqA-1; Fri, 05 Jun 2020 07:44:38 -0400
X-MC-Unique: Q8AW9LagMjSVUXNptLCCqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 257C1A0C00;
        Fri,  5 Jun 2020 11:44:37 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 790A919C58;
        Fri,  5 Jun 2020 11:44:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/2] blk-mq: fix blk_mq_all_tag_iter
Date:   Fri,  5 Jun 2020 19:44:10 +0800
Message-Id: <20200605114410.2416726-3-ming.lei@redhat.com>
In-Reply-To: <20200605114410.2416726-1-ming.lei@redhat.com>
References: <20200605114410.2416726-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_all_tag_iter() is added to iterate all requests, so we should
fetch the request from ->static_rqs][] instead of ->rqs[] which is for
holding in-flight request only.

Fix it by adding flag of BT_TAG_ITER_STATIC_RQS.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Tested-by: John Garry <john.garry@huawei.com>
Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cded7fdcad8e..44f3d0967cb4 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -296,6 +296,7 @@ struct bt_tags_iter_data {
 
 #define BT_TAG_ITER_RESERVED		(1 << 0)
 #define BT_TAG_ITER_STARTED		(1 << 1)
+#define BT_TAG_ITER_STATIC_RQS		(1 << 2)
 
 static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
@@ -309,9 +310,12 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 
 	/*
 	 * We can hit rq == NULL here, because the tagging functions
-	 * test and set the bit before assining ->rqs[].
+	 * test and set the bit before assigning ->rqs[].
 	 */
-	rq = tags->rqs[bitnr];
+	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
+		rq = tags->static_rqs[bitnr];
+	else
+		rq = tags->rqs[bitnr];
 	if (!rq)
 		return true;
 	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
@@ -366,11 +370,13 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
  *		indicates whether or not @rq is a reserved request. Return
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
+ *
+ * Caller has to pass the tag map from which requests are allocated.
  */
 void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv)
 {
-	return __blk_mq_all_tag_iter(tags, fn, priv, 0);
+	return __blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
 }
 
 /**
-- 
2.25.2

