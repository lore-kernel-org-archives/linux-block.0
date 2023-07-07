Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F91AC0015E
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 09:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGGJqd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jul 2023 05:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGGJqd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 05:46:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC8BFF
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 02:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bFNjkpFVsr0wX1IV59D92iuCTOU9SUmgiQChjqVJEPc=; b=obTgho+S4+Lljrco8JLmiY2oi9
        f3DZwV0FkvGkUzi4jVg6U34s3cnUla0ewA5QrnzHSyMh2U9Luyuii0G9jCz2qfAN31fwPOyNZk7nT
        soVMXd6VB/tYwOhixK8nvbc9fYTmzYM1pvDKz8ikYK/xVJZs+fPE5fO+mj3DWcQH6rWW14IsHoNur
        PmYktIDT7DTAaZPjuGi9zzIS0r2ragnPjJ/W6Kuc+OOL/MFWgfx/e47g2iiUbY5VNp+cp/NTyiHrh
        KkfAEBqHBBe0BoEqvvQy5AvRDqokQxh0K96KXFIBuoB0b2z+ia2V1Q13OBjtRzbZ78ReHsDpm5DKY
        ZceqJp+Q==;
Received: from [89.144.223.112] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHi2o-0049h8-2h;
        Fri, 07 Jul 2023 09:46:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] block: don't unconditionally set max_discard_sectors in blk_queue_max_discard_sectors
Date:   Fri,  7 Jul 2023 11:46:13 +0200
Message-Id: <20230707094616.108430-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707094616.108430-1-hch@lst.de>
References: <20230707094616.108430-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

max_discard_sectors is split into a hardware and a tunable value, but
blk_queue_max_discard_sectors sets both unconditionally, thus dropping
any user stored value on a rescan.  Fix blk_queue_max_discard_sectors to
only set max_discard_sectors if it either wasn't set, or the new hardware
limit is smaller than the previous user limit.

Fixes: 0034af036554 ("block: make /sys/block/<dev>/queue/discard_max_bytes writeable")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0046b447268f91..978d2e1fd67a51 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -179,7 +179,9 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors)
 {
 	q->limits.max_hw_discard_sectors = max_discard_sectors;
-	q->limits.max_discard_sectors = max_discard_sectors;
+	if (!q->limits.max_discard_sectors ||
+	     q->limits.max_discard_sectors > max_discard_sectors)
+		q->limits.max_discard_sectors = max_discard_sectors;
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
-- 
2.39.2

