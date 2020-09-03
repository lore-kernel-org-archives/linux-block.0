Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAF9C43461
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 06:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABD220737
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 06:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="az6KM5UM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgICGHN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgICGHI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 02:07:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F13C061247
        for <linux-block@vger.kernel.org>; Wed,  2 Sep 2020 23:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ztx2v6g6TfTPwG8fGwX4pVZiRfgOtSqWCsAXvkNBs2A=; b=az6KM5UMQre99chWET8yWtA4Vv
        pXmz62XQ6Hh5CNMoXoeVYgZziuUTWuGOQ9wSmDJmX81H07spv6DrpJIedHbQaN5as9rZMWBQMUx2g
        EoTCRv54cBeO+XePvn/CDIxyuObrTC7F1cAAuGpvihqlDIzGRMnC/IzB8yKuQTrl/Vry0uW4zL7tn
        uUgEUQqDwn+FG/pJD9dVjHCKZMDj+ZQ3DfORPqiEQAlGb2mfMPMkFJaqDyEtBvtewHERBUknuKkiX
        21pZun8mIntvto5E49L2ziK2Ld9IXT+FXXuykCozeOCfWop027MLFLOaZHgi6NDWxxENl5vdEOySk
        7zitGf7w==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDiOo-0000Tg-4I; Thu, 03 Sep 2020 06:07:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: make QUEUE_SYSFS_BIT_FNS more useful
Date:   Thu,  3 Sep 2020 08:07:01 +0200
Message-Id: <20200903060701.229481-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903060701.229481-1-hch@lst.de>
References: <20200903060701.229481-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch to the naming used by the other entries so that we can use the
QUEUE_RW_ENTRY helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9df877d3dae28b..81722cdcf0cb21 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -260,14 +260,14 @@ static ssize_t queue_max_hw_sectors_show(struct request_queue *q, char *page)
 
 #define QUEUE_SYSFS_BIT_FNS(name, flag, neg)				\
 static ssize_t								\
-queue_show_##name(struct request_queue *q, char *page)			\
+queue_##name##_show(struct request_queue *q, char *page)		\
 {									\
 	int bit;							\
 	bit = test_bit(QUEUE_FLAG_##flag, &q->queue_flags);		\
 	return queue_var_show(neg ? !bit : bit, page);			\
 }									\
 static ssize_t								\
-queue_store_##name(struct request_queue *q, const char *page, size_t count) \
+queue_##name##_store(struct request_queue *q, const char *page, size_t count) \
 {									\
 	unsigned long val;						\
 	ssize_t ret;							\
@@ -610,23 +610,9 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
 	.show = queue_logical_block_size_show,
 };
 
-static struct queue_sysfs_entry queue_nonrot_entry = {
-	.attr = {.name = "rotational", .mode = 0644 },
-	.show = queue_show_nonrot,
-	.store = queue_store_nonrot,
-};
-
-static struct queue_sysfs_entry queue_iostats_entry = {
-	.attr = {.name = "iostats", .mode = 0644 },
-	.show = queue_show_iostats,
-	.store = queue_store_iostats,
-};
-
-static struct queue_sysfs_entry queue_random_entry = {
-	.attr = {.name = "add_random", .mode = 0644 },
-	.show = queue_show_random,
-	.store = queue_store_random,
-};
+QUEUE_RW_ENTRY(queue_nonrot, "rotational");
+QUEUE_RW_ENTRY(queue_iostats, "iostats");
+QUEUE_RW_ENTRY(queue_random, "add_random");
 
 static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
-- 
2.28.0

