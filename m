Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB278C4742C
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 376A420709
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 08:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ItZ20ZPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgKMIrR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 03:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKMIrP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 03:47:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E5CC0613D6
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 00:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WpiyVXtqiCWXFBRyHGyTenQZ2ST5ZuL7SzCG33d70no=; b=ItZ20ZPRKKew0RS7N4Z0K86PeX
        3+KidpKB9UqrSZZvdHoEj6Jf2xXuJiradIVj7JnN0/O/mceWu+z6ORW4D7rF+MEwRZEUoBDTesASF
        B2fdKMt+RWbdWlX5VtX9Ic/vccjLMZBHejRgq3bn2SZ0o/A2+jKBviHq5MsR9wegD5PF9jFyFQfAf
        lesVobCM4cxaMZuuc+0Xw5bvkKbNgqYCryrJpT13Yf0ElOkMhOQ8Cagi09MHXUFuZfh1qC6Kjn5CV
        1iSKcZawPmutRmNsqdS2RIUHcVQW/IdHKiu+O9/ruoOjcWLUQ61ADnW2V7+2vDT2e17dI3pdIkcT7
        FIQMFasQ==;
Received: from [2001:4bb8:180:6600:bcb2:53c8:d87f:72a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdUjb-0000Qg-DK; Fri, 13 Nov 2020 08:47:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: replace hd_struct.make_it_fail with a flag
Date:   Fri, 13 Nov 2020 09:47:02 +0100
Message-Id: <20201113084702.4164912-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113084702.4164912-1-hch@lst.de>
References: <20201113084702.4164912-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a single bit in ->state instead of a whole int.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c      |  3 ++-
 block/genhd.c         | 11 +++++++----
 include/linux/genhd.h |  4 +---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b6dea07e08c9c7..de20aeb7d5f0e0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -668,7 +668,8 @@ __setup("fail_make_request=", setup_fail_make_request);
 
 static bool should_fail_request(struct hd_struct *part, unsigned int bytes)
 {
-	return part->make_it_fail && should_fail(&fail_make_request, bytes);
+	return test_bit(HD_FAIL_REQUEST, &part->state) &&
+		should_fail(&fail_make_request, bytes);
 }
 
 static int __init fail_make_request_debugfs(void)
diff --git a/block/genhd.c b/block/genhd.c
index 65f6b744f4ebd5..bd49fb43554213 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1407,7 +1407,7 @@ ssize_t part_fail_show(struct device *dev,
 {
 	struct hd_struct *p = dev_to_part(dev);
 
-	return sprintf(buf, "%d\n", p->make_it_fail);
+	return sprintf(buf, "%d\n", test_bit(HD_FAIL_REQUEST, &p->state));
 }
 
 ssize_t part_fail_store(struct device *dev,
@@ -1417,9 +1417,12 @@ ssize_t part_fail_store(struct device *dev,
 	struct hd_struct *p = dev_to_part(dev);
 	int i;
 
-	if (count > 0 && sscanf(buf, "%d", &i) > 0)
-		p->make_it_fail = (i == 0) ? 0 : 1;
-
+	if (count > 0 && sscanf(buf, "%d", &i) > 0) {
+		if (i)
+			clear_bit(HD_FAIL_REQUEST, &p->state);
+		else
+			set_bit(HD_FAIL_REQUEST, &p->state);
+	}
 	return count;
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 2609bc78ff131b..91b37a738b52b5 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -70,10 +70,8 @@ struct hd_struct {
 	int partno;
 	unsigned long state;
 #define HD_RO_POLICY			0
+#define HD_FAIL_REQUEST			1
 	struct partition_meta_info *info;
-#ifdef CONFIG_FAIL_MAKE_REQUEST
-	int make_it_fail;
-#endif
 	struct rcu_work rcu_work;
 };
 
-- 
2.28.0

