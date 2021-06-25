Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E608C2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 06:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6912161351
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 06:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhFYGnF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jun 2021 02:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhFYGnF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jun 2021 02:43:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08071C061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rcXnwngV+yk/QqxxgqHh9Y0+8jDcb1I1XYnPfJPe/BU=; b=t1TLsUFXJSMb+CCByfVJN6W/qz
        exP2kNHW/qXjcg3kXDxz7aKN5zTuuWxo402hVlIgRFjbZjK0UNo3aTL+uqxzrN8xIZ83AwblbQnZC
        t7wb2JDWztfyDr+I5Q4nbFG+IpThOdymuI6Ktg3IR511towwVmM4E0c2yXF5sJmS3fHk1UVRTkZsw
        j+M47NKdBSI9hYuWXHn0+52pC+rYy5w1UM/828UzCEYAIXp05szCKfLOuyN1aHbhRbW7BQLC2S3LN
        ypS76yc3EhyswSrLlWNaupBA8c93B0Q5poFjiT0/aF/4gtCrkOND+9K7WKBNMLd4mPA4CnX/wyJhP
        x8rILRsQ==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwfVz-00HNiE-9k; Fri, 25 Jun 2021 06:40:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] loop: remove the unused bdev variable in loop_set_status
Date:   Fri, 25 Jun 2021 08:38:24 +0200
Message-Id: <20210625063824.923354-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some compilers (rightly) complain that bdev is assigned to, but not used
now.

Fixes: 0384264ea8a3 ("block: pass a gendisk to bdev_disk_changed")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c6e73c051790..f96f047deeba 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1341,7 +1341,6 @@ static int
 loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
 	int err;
-	struct block_device *bdev;
 	kuid_t uid = current_uid();
 	int prev_lo_flags;
 	bool partscan = false;
@@ -1410,7 +1409,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (!err && (lo->lo_flags & LO_FLAGS_PARTSCAN) &&
 	     !(prev_lo_flags & LO_FLAGS_PARTSCAN)) {
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
-		bdev = lo->lo_device;
 		partscan = true;
 	}
 out_unlock:
-- 
2.30.2

