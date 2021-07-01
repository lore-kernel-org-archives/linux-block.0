Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31474C11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 08:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB8F61480
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 08:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhGAIUe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 04:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhGAIUd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jul 2021 04:20:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF63C061756
        for <linux-block@vger.kernel.org>; Thu,  1 Jul 2021 01:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VMSe1aXbttJh3PPdaTVvJi/GA9/xwFWa4Vu+8+GS59s=; b=U/sjH85TB2j7iFUgbli7mYb/YV
        PqrnRt5JTpH1WAALtEaLUTAZlZC/cKRgVZsX07UAlmFRvlJPvODhoEDmivdaQT4u5GgLc3gy3zZAz
        nYCQsO1A4LyR5Xax/pHNdsrKOm7msHFEo6uBpZnZ0s4Q4VjlrMn6dbGd6whYZbJm//j2jN2H0hK1r
        skSPwxZ9aanSQpOgp2WiCprhQZg41DkSMVfuyDHbkEMZQS3jyHq/E0j3Y20040iIBvHS3gdgyl+UZ
        VWAx8t5vaUAZ8Ogm5S2/SlbBo2u8tJoP6wkBtztbG0LxvBTedfTjekZQWrZ+ctySkDLCfSnHSQEWs
        +pNNmuNQ==;
Received: from [2001:4bb8:180:285:b614:ad7e:3c44:605c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyrt4-006Kth-Ez; Thu, 01 Jul 2021 08:17:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: remove the bdgrab in blk_drop_partitions
Date:   Thu,  1 Jul 2021 10:16:38 +0200
Message-Id: <20210701081638.246552-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701081638.246552-1-hch@lst.de>
References: <20210701081638.246552-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to hold a bdev reference when removing the partition.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 347c56a51d87..3907cebd2be9 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -537,12 +537,8 @@ void blk_drop_partitions(struct gendisk *disk)
 
 	lockdep_assert_held(&disk->open_mutex);
 
-	xa_for_each_start(&disk->part_tbl, idx, part, 1) {
-		if (!bdgrab(part))
-			continue;
+	xa_for_each_start(&disk->part_tbl, idx, part, 1)
 		delete_partition(part);
-		bdput(part);
-	}
 }
 
 static bool blk_add_partition(struct gendisk *disk,
-- 
2.30.2

