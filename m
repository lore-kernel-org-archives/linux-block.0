Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CE8C6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiIUSF3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiIUSF0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B263F39
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4arqU9lgD09MH+zBZSjckurh1B/60S8BUuYi4fpNHqc=; b=GnCxh4uOQqW6879XzipnIWd9NT
        K/eciB5K21jDkrd0Bzk7xy8fGpI6ISBPsPyz4TetjH1GIUm4PCvPXdPlMk/mZ5BqmKEM67KP+4TZU
        RzjdQpl/oe17hCEPz60j5rCe9vh4p0lxzB2OxE/wFQqtsvYIVPQcz495gvpV0qYoA5Pk70WVXI2TM
        fihvFoNc+r/G7D1h37fk3Ow1SZMqywYF0/vlE2K4eUeMzmFDqsv5DdGLfbJK5nbmexdXa9fcWnmgu
        E0Vg0pRB8Ssdw5C+jGjrbdYNl5wEh+1tXC/TDYOv+MZ+zJ+bgbhZ0t8/mZW09uB5ofbwKHhWs/oT6
        5TCXN/lw==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob466-00CGZH-8a; Wed, 21 Sep 2022 18:05:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 08/17] blk-iolatency: pass a gendisk to blk_iolatency_init
Date:   Wed, 21 Sep 2022 20:04:52 +0200
Message-Id: <20220921180501.1539876-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass the gendisk to blk_iolatency_init as part of moving the blk-cgroup
infrastructure to be gendisk based.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c    | 2 +-
 block/blk-iolatency.c | 3 ++-
 block/blk.h           | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 89974fd0db3da..82a117ff54de5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1265,7 +1265,7 @@ int blkcg_init_disk(struct gendisk *disk)
 	if (ret)
 		goto err_ioprio_exit;
 
-	ret = blk_iolatency_init(q);
+	ret = blk_iolatency_init(disk);
 	if (ret)
 		goto err_throtl_exit;
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index e285152345a20..c6f61fe88b875 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -756,8 +756,9 @@ static void blkiolatency_enable_work_fn(struct work_struct *work)
 	}
 }
 
-int blk_iolatency_init(struct request_queue *q)
+int blk_iolatency_init(struct gendisk *disk)
 {
+	struct request_queue *q = disk->queue;
 	struct blk_iolatency *blkiolat;
 	struct rq_qos *rqos;
 	int ret;
diff --git a/block/blk.h b/block/blk.h
index d7142c4d2fefb..361db83147c6f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -389,9 +389,9 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
 }
 
 #ifdef CONFIG_BLK_CGROUP_IOLATENCY
-extern int blk_iolatency_init(struct request_queue *q);
+int blk_iolatency_init(struct gendisk *disk);
 #else
-static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
+static int blk_iolatency_init(struct gendisk *disk) { return 0 };
 #endif
 
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.30.2

