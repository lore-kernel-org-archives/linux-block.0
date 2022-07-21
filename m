Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E65DC43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 05:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiGUFQp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 01:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUFQp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 01:16:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772D979ECE
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 22:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rAHuZq0/QpMekqaktnMhPEYUBHuKO2r9CpyMgqptQcc=; b=oVkqfdRSCy4Z7AZVaY+C5lo90X
        Vyz/1cacy6raJrnFrBBEvYCbuRnMbum0iYHxOP2D9WYh+u8wA8HjlXEX55VX4+Oyz8GOY3uVBFmPH
        fyYGRm/fp846XFzG2tRcJ6vOYxSx1PFME06Dn0pKttStwbdVlx0F5dxReYuAHM33WymKgCBO/5pYI
        A6RpSzaTi8pzYu4XsSc2OLIhFvEWviKVjOHowC1YCFY6uqIvOv72SRJBYQtdrOSgGoqE4fHLFHq1f
        Of6NRV75Am4i/Xc8eYQYPxBtlTmEtnfKGeX4Xnd5UJXFHsOFGbIIb8O8wSTzBomhx676RUjVfsuOm
        ToLEhKrA==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEOYE-00HDUq-S8; Thu, 21 Jul 2022 05:16:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/8] ublk: remove UBLK_IO_F_PREFLUSH
Date:   Thu, 21 Jul 2022 07:16:26 +0200
Message-Id: <20220721051632.1676890-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721051632.1676890-1-hch@lst.de>
References: <20220721051632.1676890-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

REQ_PREFLUSH is turned into REQ_OP_FLUSH by the flush state machine
and thus never seen by a blk-mq based driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ublk_drv.c      | 3 ---
 include/uapi/linux/ublk_cmd.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b90481b295a74..07913b5bccd90 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -392,9 +392,6 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 	if (req->cmd_flags & REQ_FUA)
 		flags |= UBLK_IO_F_FUA;
 
-	if (req->cmd_flags & REQ_PREFLUSH)
-		flags |= UBLK_IO_F_PREFLUSH;
-
 	if (req->cmd_flags & REQ_NOUNMAP)
 		flags |= UBLK_IO_F_NOUNMAP;
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index d6879eea2fde0..917580b341984 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -107,7 +107,6 @@ struct ublksrv_ctrl_dev_info {
 #define		UBLK_IO_F_FAILFAST_DRIVER	(1U << 10)
 #define		UBLK_IO_F_META			(1U << 11)
 #define		UBLK_IO_F_FUA			(1U << 13)
-#define		UBLK_IO_F_PREFLUSH		(1U << 14)
 #define		UBLK_IO_F_NOUNMAP		(1U << 15)
 #define		UBLK_IO_F_SWAP			(1U << 16)
 
-- 
2.30.2

