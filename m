Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98809C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFD920823
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pujLVFEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFD920823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeKSOOR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:14:17 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62743 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeKSOOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 09:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542599520; x=1574135520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=opAle5GdR+avzfDAyhIIsXOTcGEeTgm1Sxii3yZO8es=;
  b=pujLVFEqkMSeuI8cyKxumuf9iHU+7KwXnG7ZHL2zHYKPyuhW1pamJfx9
   QeddaARwOSJ161QYKOe/R+to1hffJDv+5dtqR0FTJsNNOIpInpC7QXN6x
   ezjucM9cZzcdMygEepInqfkGIZ1jE8Z87mFZ3zgVu6BRV26T9GwDD6EIE
   c+IAJjFu/gTLSXRduiEvRZ2cr8Xxr5RlaS9X6uuxfRwazefaXnXw3vcmW
   LwSWxqzlPXe2r4x5yEkvucRXQ2iaIZooLScDu/omk6TBnExBk9jke/TjL
   061MACbd2CkqMU+Y7hXbPaiYnQl6jFj73qr+ZDL9rj/0Q1+LtlDWErYI9
   w==;
X-IronPort-AV: E=Sophos;i="5.56,250,1539619200"; 
   d="scan'208";a="96272456"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2018 11:51:45 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 18 Nov 2018 19:34:43 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2018 19:51:43 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] block: Introduce get_current_ioprio()
Date:   Mon, 19 Nov 2018 12:51:28 +0900
Message-Id: <20181119035131.11255-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119035131.11255-1-damien.lemoal@wdc.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define get_current_ioprio() as an inline helper to obtain the caller
I/O priority from its task I/O context. Use this helper in
blk_init_request_from_bio() to set a request ioprio.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-core.c       |  6 +-----
 include/linux/ioprio.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 492648c96992..4450d3c08f25 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -813,18 +813,14 @@ unsigned int blk_plug_queued_count(struct request_queue *q)
 
 void blk_init_request_from_bio(struct request *req, struct bio *bio)
 {
-	struct io_context *ioc = current->io_context;
-
 	if (bio->bi_opf & REQ_RAHEAD)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
 
 	req->__sector = bio->bi_iter.bi_sector;
 	if (ioprio_valid(bio_prio(bio)))
 		req->ioprio = bio_prio(bio);
-	else if (ioc)
-		req->ioprio = ioc->ioprio;
 	else
-		req->ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+		req->ioprio = get_current_ioprio();
 	req->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(req->q, req, bio);
 }
diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index 9e30ed6443db..e9bfe6972aed 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -70,6 +70,19 @@ static inline int task_nice_ioclass(struct task_struct *task)
 		return IOPRIO_CLASS_BE;
 }
 
+/*
+ * If the calling process has set an I/O priority, use that. Otherwise, return
+ * the default I/O priority.
+ */
+static inline int get_current_ioprio(void)
+{
+	struct io_context *ioc = current->io_context;
+
+	if (ioc)
+		return ioc->ioprio;
+	return IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+}
+
 /*
  * For inheritance, return the highest of the two given priorities
  */
-- 
2.19.1

