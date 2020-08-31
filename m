Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD83CC433E6
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC42208DB
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PueprQvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgHaSPr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgHaSPq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 14:15:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C94C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xkbNJ6YZlWHPymEUUJSqRfOzitwcKU/z5DRcesvaD2g=; b=PueprQvZ6ynDcncrEV3LErQ9uK
        Zq1cjIXRNCpBCg4t3TL4WA+/FWazk1XrHxnEaAyL7Yy9FfY11BRsTLui4Ut+mEDubcpa8CVW5eBjy
        SFU5Nm6B/rlCN0E7igNbjuNsmrp9/SSgzykxw8nekzK2xneZUAsIsFXHGzXTeV+bSO0US94qZBrUK
        SjekB2OFdd3AE1ytA5DTqSxfudwPT0UpaQRR5D2L65GJ4v0Zk6DEZQS5/CaAzlcME/DpIxWGoVWy5
        LBB826j70eVcsUOQxBZxaYXe54UGjwduyCrpbA6U6i8ot3lTBMQC9oT7L75HLBmAZ6lZmLio8v5KU
        AwBxXGfA==;
Received: from 213-225-6-196.nat.highway.a1.net ([213.225.6.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCoLI-0002bf-UL; Mon, 31 Aug 2020 18:15:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 5/7] block: cleanup __alloc_disk_node
Date:   Mon, 31 Aug 2020 20:02:37 +0200
Message-Id: <20200831180239.2372776-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831180239.2372776-1-hch@lst.de>
References: <20200831180239.2372776-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use early returns and goto-based unwinding to simplify the flow a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 73 +++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 99c64641c3148c..055ce9cf18358a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1729,45 +1729,48 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	}
 
 	disk = kzalloc_node(sizeof(struct gendisk), GFP_KERNEL, node_id);
-	if (disk) {
-		disk->part0.dkstats = alloc_percpu(struct disk_stats);
-		if (!disk->part0.dkstats) {
-			kfree(disk);
-			return NULL;
-		}
-		init_rwsem(&disk->lookup_sem);
-		disk->node_id = node_id;
-		if (disk_expand_part_tbl(disk, 0)) {
-			free_percpu(disk->part0.dkstats);
-			kfree(disk);
-			return NULL;
-		}
-		ptbl = rcu_dereference_protected(disk->part_tbl, 1);
-		rcu_assign_pointer(ptbl->part[0], &disk->part0);
+	if (!disk)
+		return NULL;
 
-		/*
-		 * set_capacity() and get_capacity() currently don't use
-		 * seqcounter to read/update the part0->nr_sects. Still init
-		 * the counter as we can read the sectors in IO submission
-		 * patch using seqence counters.
-		 *
-		 * TODO: Ideally set_capacity() and get_capacity() should be
-		 * converted to make use of bd_mutex and sequence counters.
-		 */
-		hd_sects_seq_init(&disk->part0);
-		if (hd_ref_init(&disk->part0)) {
-			hd_free_part(&disk->part0);
-			kfree(disk);
-			return NULL;
-		}
+	disk->part0.dkstats = alloc_percpu(struct disk_stats);
+	if (!disk->part0.dkstats)
+		goto out_free_disk;
 
-		disk->minors = minors;
-		rand_initialize_disk(disk);
-		disk_to_dev(disk)->class = &block_class;
-		disk_to_dev(disk)->type = &disk_type;
-		device_initialize(disk_to_dev(disk));
+	init_rwsem(&disk->lookup_sem);
+	disk->node_id = node_id;
+	if (disk_expand_part_tbl(disk, 0)) {
+		free_percpu(disk->part0.dkstats);
+		goto out_free_disk;
 	}
+
+	ptbl = rcu_dereference_protected(disk->part_tbl, 1);
+	rcu_assign_pointer(ptbl->part[0], &disk->part0);
+
+	/*
+	 * set_capacity() and get_capacity() currently don't use
+	 * seqcounter to read/update the part0->nr_sects. Still init
+	 * the counter as we can read the sectors in IO submission
+	 * patch using seqence counters.
+	 *
+	 * TODO: Ideally set_capacity() and get_capacity() should be
+	 * converted to make use of bd_mutex and sequence counters.
+	 */
+	hd_sects_seq_init(&disk->part0);
+	if (hd_ref_init(&disk->part0))
+		goto out_free_part0;
+
+	disk->minors = minors;
+	rand_initialize_disk(disk);
+	disk_to_dev(disk)->class = &block_class;
+	disk_to_dev(disk)->type = &disk_type;
+	device_initialize(disk_to_dev(disk));
 	return disk;
+
+out_free_part0:
+	hd_free_part(&disk->part0);
+out_free_disk:
+	kfree(disk);
+	return NULL;
 }
 EXPORT_SYMBOL(__alloc_disk_node);
 
-- 
2.28.0

