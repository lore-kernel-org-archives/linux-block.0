Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEBBC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 06:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiGRGaS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 02:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGRGaR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 02:30:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EB3B66
        for <linux-block@vger.kernel.org>; Sun, 17 Jul 2022 23:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HOQI90wh9y26+O2sklbLpSQzoKAr/9Wi8wQwvftRb6Q=; b=4y3MdT6M02+8WsYVE9Sorz5XgJ
        z16yDxBlfqYHPoAQqLqEBUUecYbIxbFVSBSklAYiTSjaTFTfRe5I57rM4TL6knEpw7aUUfbHUWRNa
        0jB1viEUfRnoW9wRkFfeqFZU+qX9n8rujGwypvhHNxvjiIJ9qKdJf5nPJi2cuJDI9LwtvNpBSbkrO
        u2okFBJro1Valh1qw1UGTt/rwdTLxgg6alFDy/O5a387vZFbILQcoo8lsN+bKEbYpPusklrV7pXO+
        xQu8tzbKEcIjqIKjv/u4dl7ssVMOI0vpCqpkKEptl7V94KVFwIjlslxILLdX7nAk0/jX0o1dTc6tg
        lzGDjaeA==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDKGl-00BDMo-Ny; Mon, 18 Jul 2022 06:30:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH] ublk: remove UBLK_IO_F_INTEGRITY
Date:   Mon, 18 Jul 2022 08:30:13 +0200
Message-Id: <20220718063013.335531-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The ublk protocol has no mechanism to actually transfer the integrity
metadata, so don't define this flag, which requires that an integrity
payload is attached to a bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ublk_drv.c      | 3 ---
 include/uapi/linux/ublk_cmd.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2c1b01d7f27dd..b633d268b90ae 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -389,9 +389,6 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 	if (req->cmd_flags & REQ_META)
 		flags |= UBLK_IO_F_META;
 
-	if (req->cmd_flags & REQ_INTEGRITY)
-		flags |= UBLK_IO_F_INTEGRITY;
-
 	if (req->cmd_flags & REQ_FUA)
 		flags |= UBLK_IO_F_FUA;
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a3f5e7c21807c..d6879eea2fde0 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -106,7 +106,6 @@ struct ublksrv_ctrl_dev_info {
 #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
 #define		UBLK_IO_F_FAILFAST_DRIVER	(1U << 10)
 #define		UBLK_IO_F_META			(1U << 11)
-#define		UBLK_IO_F_INTEGRITY		(1U << 12)
 #define		UBLK_IO_F_FUA			(1U << 13)
 #define		UBLK_IO_F_PREFLUSH		(1U << 14)
 #define		UBLK_IO_F_NOUNMAP		(1U << 15)
-- 
2.30.2

