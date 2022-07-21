Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360C3CCA48B
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 13:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiGUNJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiGUNJ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 09:09:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E72710D
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 06:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fhurzq5Ky3KZAEeKT61HqARYTnyoiALrdPLL7WycFIg=; b=Z6DCqURQmvedNkZeXgA8S4tznx
        7eAkCV2sOmiJS/7F2K7IUxn6zDLXJy6s1SROpmvDbGa02E3CwV/pU9nI3+GIIz+SbH1wmjJu048oI
        kTc0Vj3DR6+TogSqOfPXqsvqcfIV76MLX28ARn7eKnv0Rpb9pjrTW2FUOSOvVz13vLNjnKgKGqUI8
        jx3UxSpsvToNFalObHQpf3YowH+xZXpG6Nny/ynq2ToTlLl6P4/b1NUHYEei1itOT6VVXTLTpREku
        WMLa10jD0WSJzPcy1PiyaoN8HZH5ax/W3RHbN8VYs5C2hwkrOjU9p/lnpa4g87xnt+G1bcfyDm8+v
        2Ez09Uig==;
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEVvg-006mmJ-Eu; Thu, 21 Jul 2022 13:09:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/8] ublk: remove UBLK_IO_F_PREFLUSH
Date:   Thu, 21 Jul 2022 15:09:10 +0200
Message-Id: <20220721130916.1869719-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721130916.1869719-1-hch@lst.de>
References: <20220721130916.1869719-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

REQ_PREFLUSH is turned into REQ_OP_FLUSH by the flush state machine
and thus never seen by a blk-mq based driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
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

