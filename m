Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64895C282DD
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 21:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F9320868
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 21:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbfEWVtm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 17:49:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388134AbfEWVtm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 17:49:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 753D1772FA;
        Thu, 23 May 2019 21:49:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-113.rdu2.redhat.com [10.10.122.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E18705D71B;
        Thu, 23 May 2019 21:49:41 +0000 (UTC)
From:   John Pittman <jpittman@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, djeffery@redhat.com,
        John Pittman <jpittman@redhat.com>
Subject: [PATCH] block: print offending values when cloned rq limits are exceeded
Date:   Thu, 23 May 2019 17:49:39 -0400
Message-Id: <20190523214939.30277-1-jpittman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 23 May 2019 21:49:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While troubleshooting issues where cloned request limits have been
exceeded, it is often beneficial to know the actual values that
have been breached.  Print these values, assisting in ease of
identification of root cause of the breach.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 block/blk-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 419d600e6637..af62150bb1ba 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1199,7 +1199,9 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
 				      struct request *rq)
 {
 	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
-		printk(KERN_ERR "%s: over max size limit.\n", __func__);
+		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
+			__func__, blk_rq_sectors(rq),
+			blk_queue_get_max_sectors(q, req_op(rq)));
 		return -EIO;
 	}
 
@@ -1211,7 +1213,8 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
 	 */
 	blk_recalc_rq_segments(rq);
 	if (rq->nr_phys_segments > queue_max_segments(q)) {
-		printk(KERN_ERR "%s: over max segments limit.\n", __func__);
+		printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
+			__func__, rq->nr_phys_segments, queue_max_segments(q));
 		return -EIO;
 	}
 
-- 
2.17.2

