Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D402C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74298610E8
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhHROz2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbhHROz0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:55:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F0C0613D9
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 07:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=z6gP+Sgjh/xdyvMaKhB1YrvAvetab/P3THFO9enj/W0=; b=gta/+3Mm8VjQnuzShRwjF9PKJ4
        iicbZAFQCw4GuYkDpEI1KMJ3nI+gN1W5XCtEs1D1iy5O2WJOR5ZiJ0nze84zp0tN+rZSQXpfrwQcE
        69XvCnNj+mZ3zZpUUAq54nf7cP0ZrQSsUp69A6Cg526eF6CWu0UndxcRQ2nVag54aN7lE9pgWNOSO
        zKvrFvCLjGL2wl0PQzY/lPjMkKb/zzdOnJIg4EtOUtHW524EXPFqmWUCfPeMvjZHuOG+PKFp2B/9t
        Sj5AMkzqnuQe5LVxrJ3W+gMyPUXnv+YVNqQXUqAzi7oq25lsnrAeuqw/zVTOC7Mms+6AZz69wD1Jd
        nZG+RNJg==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMwz-003wyF-7s; Wed, 18 Aug 2021 14:54:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 08/11] block: return errors from disk_alloc_events
Date:   Wed, 18 Aug 2021 16:45:39 +0200
Message-Id: <20210818144542.19305-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818144542.19305-1-hch@lst.de>
References: <20210818144542.19305-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Prepare for proper error handling in add_disk.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h         | 2 +-
 block/disk-events.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index c9727dd56da7..bbbcc1a64a2d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -362,7 +362,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 
 struct request_queue *blk_alloc_queue(int node_id);
 
-void disk_alloc_events(struct gendisk *disk);
+int disk_alloc_events(struct gendisk *disk);
 void disk_add_events(struct gendisk *disk);
 void disk_del_events(struct gendisk *disk);
 void disk_release_events(struct gendisk *disk);
diff --git a/block/disk-events.c b/block/disk-events.c
index 7445b8ff2775..8d5496e7592a 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -444,17 +444,17 @@ module_param_cb(events_dfl_poll_msecs, &disk_events_dfl_poll_msecs_param_ops,
 /*
  * disk_{alloc|add|del|release}_events - initialize and destroy disk_events.
  */
-void disk_alloc_events(struct gendisk *disk)
+int disk_alloc_events(struct gendisk *disk)
 {
 	struct disk_events *ev;
 
 	if (!disk->fops->check_events || !disk->events)
-		return;
+		return 0;
 
 	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
 	if (!ev) {
 		pr_warn("%s: failed to initialize events\n", disk->disk_name);
-		return;
+		return -ENOMEM;
 	}
 
 	INIT_LIST_HEAD(&ev->node);
@@ -466,6 +466,7 @@ void disk_alloc_events(struct gendisk *disk)
 	INIT_DELAYED_WORK(&ev->dwork, disk_events_workfn);
 
 	disk->ev = ev;
+	return 0;
 }
 
 void disk_add_events(struct gendisk *disk)
-- 
2.30.2

