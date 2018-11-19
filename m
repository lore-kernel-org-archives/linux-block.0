Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6433C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ED02087A
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 03:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eenaSNxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74ED02087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeKSOOT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:14:19 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62746 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeKSOOR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 09:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542599521; x=1574135521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Xnqma5d37U1rxyzamL4z6UnYEUN6VPkgOpnFiZGCoA=;
  b=eenaSNxEhz1ZvQhwtXTiIw71spRoU3YDFv5ckm5x7o6MDuPng/AxifcA
   U01s0Cx1q+1oLhtVgklv6WDRyO8tYbyF5zGa4tClf+SZpKqHMmk4j9dcE
   KORPtjdjZKtrCKU98+493zMg0jKR5yCPQBV167x+UON0Nn5rikq3gRIw5
   ZRVNoUn5QvCd/frCbPts2+Azx6mANImJsGasSQ5nF9xfaFf2T1/ViVZwM
   n8a9Sje5UVG3N11FRcatWUBedL7G1hKKOpNzn3OLNNvQcbpDOaVq9V4Xa
   FZavbTL6sAL9iB71Y8Ovr69DU9JEHGL+NArUGJkPjTxRsKXWaRC9pRdDJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,250,1539619200"; 
   d="scan'208";a="96272470"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2018 11:51:52 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 18 Nov 2018 19:34:50 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2018 19:51:50 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/7] block: Initialize BIO I/O priority early
Date:   Mon, 19 Nov 2018 12:51:31 +0900
Message-Id: <20181119035131.11255-8-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119035131.11255-1-damien.lemoal@wdc.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the synchronous I/O path case (read(), write() etc system calls), a
BIO I/O priority is not initialized until the execution of
blk_init_request_from_bio() when the BIO is submitted and a request
initialized for the BIO execution. This is due to the ki_ioprio field of
the struct kiocb defined on stack being always initialized to
IOPRIO_CLASS_NONE, regardless of the calling process I/O context ioprio
value set with ioprio_set(). This late initialization can result in the
BIO being merged to pending requests even when the I/O priorities
differ.

Fix this by initializing the ki_iopriority field of on stack struct
kiocb using the get_current_ioprio() helper, ensuring that all BIOs
allocated and submitted for the system call execution see the correct
intended I/O priority early. With this, since a BIO I/O priority is
always set to the intended effective value for both the sync and async
path, blk_init_request_from_bio() can be simplified.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-core.c   | 5 +----
 include/linux/fs.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index dde30b08aa14..04f5be473638 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -814,10 +814,7 @@ void blk_init_request_from_bio(struct request *req, struct bio *bio)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
 
 	req->__sector = bio->bi_iter.bi_sector;
-	if (ioprio_valid(bio_prio(bio)))
-		req->ioprio = bio_prio(bio);
-	else
-		req->ioprio = get_current_ioprio();
+	req->ioprio = bio_prio(bio);
 	req->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(req->q, req, bio);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c95c0807471f..a1ab233e6469 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2021,7 +2021,7 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 		.ki_filp = filp,
 		.ki_flags = iocb_flags(filp),
 		.ki_hint = ki_hint_validate(file_write_hint(filp)),
-		.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0),
+		.ki_ioprio = get_current_ioprio(),
 	};
 }
 
-- 
2.19.1

