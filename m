Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96752C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EBC6108E
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhHROy4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbhHROyz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:54:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2944AC061764
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ay7ccmcF0PEcU74GdHCeiao/NWdqMbIpxVXMo32S+IQ=; b=oEWdT4FlP+4Bj4tQ2E6glgmbha
        EdFDIFyR1wulkxaVwcHgCZXLd+BJLoGwS+JY39x59e8USumpV2DCzMLv8EHbH/vJVY6MbGX4YwZAV
        KX1/HkRri2VJ/p1OEG235OgvO8COvZfZkXm3b5Xict16bRF7P1v5Ma63rU/lZvbfb/zanTo6flVyN
        cyUD9IwfWXKWHg7FfjQvbxOS34a96LP0mkUb7yTzUYJ46aKnEMOMvfqgEgGN6eylJ+9fPZfIBKnVc
        5gmRRZiRZ8XpYagUFW7paIzVsljTnksdTVWoXwFCtbMRsrsFvQJBAWmB/ad/0IIqo1YRlkxFbKfGp
        PijALhTg==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMvq-003wuq-L6; Wed, 18 Aug 2021 14:52:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 07/11] block: return errors from blk_integrity_add
Date:   Wed, 18 Aug 2021 16:45:38 +0200
Message-Id: <20210818144542.19305-8-hch@lst.de>
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
 block/blk-integrity.c | 12 +++++++-----
 block/blk.h           |  5 +++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 410da060d1f5..69a12177dfb6 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -431,13 +431,15 @@ void blk_integrity_unregister(struct gendisk *disk)
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
 
-void blk_integrity_add(struct gendisk *disk)
+int blk_integrity_add(struct gendisk *disk)
 {
-	if (kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
-				 &disk_to_dev(disk)->kobj, "%s", "integrity"))
-		return;
+	int ret;
 
-	kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
+	ret = kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
+				   &disk_to_dev(disk)->kobj, "%s", "integrity");
+	if (!ret)
+		kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
+	return ret;
 }
 
 void blk_integrity_del(struct gendisk *disk)
diff --git a/block/blk.h b/block/blk.h
index 148bdcd3aa08..c9727dd56da7 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -132,7 +132,7 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
 				bip_next->bip_vec[0].bv_offset);
 }
 
-void blk_integrity_add(struct gendisk *);
+int blk_integrity_add(struct gendisk *disk);
 void blk_integrity_del(struct gendisk *);
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline bool blk_integrity_merge_rq(struct request_queue *rq,
@@ -166,8 +166,9 @@ static inline bool bio_integrity_endio(struct bio *bio)
 static inline void bio_integrity_free(struct bio *bio)
 {
 }
-static inline void blk_integrity_add(struct gendisk *disk)
+static inline int blk_integrity_add(struct gendisk *disk)
 {
+	return 0;
 }
 static inline void blk_integrity_del(struct gendisk *disk)
 {
-- 
2.30.2

