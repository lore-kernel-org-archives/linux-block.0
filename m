Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C088C4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746E560F43
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 09:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhHDJqM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbhHDJqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 05:46:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A43C0613D5
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=053zYUeByr3LczcSOCH+mDzkmIw4K3QOBJHeYRQgaJI=; b=RMWBuAWJk5/te6yytorZDG+DNA
        x0RDCU3iyxDmgIDDSYJDtRkU34tVOCPUPpekW/A93GItFeYOCH771K/J/J9xzcjE10MIAxrs/owfG
        K4xucTfQnJph1H8F/eqnJXkdC9tE6i391s15lI2jhMUSMgkTLu8VQZEMJgulsByYBRWm4sZo4Nc+y
        RlwBhN+qyWJbXYJLFoMGE2SGcTjE6H32P8LvKMd7hAOi8ZpskY4Lohz9EtT2/5cvbIEMpLgFzjJU2
        eumNXpKWtN5JrDvjgn1P9bmF1GXDnA1ie/ZjdFB2zsNBZrQvAOiSmbPy4J+25i1WKpAETwuC6eWxA
        824nDNbw==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBDSO-005e7C-I8; Wed, 04 Aug 2021 09:45:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 5/8] dm: cleanup cleanup_mapped_device
Date:   Wed,  4 Aug 2021 11:41:44 +0200
Message-Id: <20210804094147.459763-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804094147.459763-1-hch@lst.de>
References: <20210804094147.459763-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

md->queue is now always set when md->disk is set, so simplify the
conditionals a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2c5f9e585211..7971ec8ce677 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1694,13 +1694,9 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		md->disk->private_data = NULL;
 		spin_unlock(&_minor_lock);
 		del_gendisk(md->disk);
-	}
-
-	if (md->queue)
 		dm_queue_destroy_keyslot_manager(md->queue);
-
-	if (md->disk)
 		blk_cleanup_disk(md->disk);
+	}
 
 	cleanup_srcu_struct(&md->io_barrier);
 
-- 
2.30.2

