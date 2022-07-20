Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE6EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 14:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiGTOZI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiGTOZG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 10:25:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9031BE
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Bwi5l72H7GNPf+RDSL2kW4qayh3POT+VKwKbW6G7s0U=; b=nrVbwDU0lV+MsrOjN1Qz60aB2+
        XkNfKNuSSqmpE3rggP0QxCf1Rrp+VcRMIGpbTEIrxXxbRrYWXzcMU4jpHiY77ac6zA55lszR2ggyx
        6MPd9J4MtQxeozWnz6VkhresWZe9+y+FSJhFTQcvdYBgtZJDI5Bm6ul43SFz5wi1JPDidHLZxRUcr
        vuMf/QbUo1AcwRbQ3D4CrZg/XA3Sa4qRt5yfWsd60neTtXaEXJnpZCL/G1snmyj6KNdRVbsnJiVzl
        QlZ6cUfmc3bgNVdKG28Vr6JHXXIWSHcH6Ucxh0m8OLX3QuiZLpG7Srw94NFqs/epId7nnzrW1wjFT
        gtGSMraw==;
Received: from [2001:4bb8:18a:6f7a:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEAdM-006nhq-FO; Wed, 20 Jul 2022 14:25:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/5] block: fix max_zone_append_sectors inheritance in blk_stack_limits
Date:   Wed, 20 Jul 2022 16:24:53 +0200
Message-Id: <20220720142456.1414262-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220720142456.1414262-1-hch@lst.de>
References: <20220720142456.1414262-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As we start out with a default of 0, this needs a min_not_zero to
actually work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8bb9eef5310eb..9f6e271ca67f4 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -554,7 +554,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
-	t->max_zone_append_sectors = min(t->max_zone_append_sectors,
+	t->max_zone_append_sectors = min_not_zero(t->max_zone_append_sectors,
 					b->max_zone_append_sectors);
 	t->bounce = max(t->bounce, b->bounce);
 
-- 
2.30.2

