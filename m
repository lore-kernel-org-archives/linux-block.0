Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC91C43441
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1CC2080C
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 01:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YPr++mYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1CC2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbeKTMTd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:19:33 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40409 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbeKTMTd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 07:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542678777; x=1574214777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5eQNOqIzW2mPuqeCDTvKL8q4KeDRbXvNiXn6QDbW7w4=;
  b=YPr++mYl5L3r9pTKArNvdVG3684K9C0xTIAjjEZjeXyD852FqpKxbP1u
   1jgVswlH7RrjaiRcFb4+3mN+EvXFCr6xSjMnnUj1lfQEdQTcAtJzZb5sA
   44qyru1CTM1O/PCI9ulZvY7WyVvGrgp3jVsTO959PLiQGvPyM5IxlA6E0
   3WIdxfUcvg9O8zJAzI7rB5Vwt2/wDNsNZ6ZFDlgqLxQbO+r+UwEb2i8jP
   09wNpiCSbt0L1MgGKaGmpfngbniMhb1mo+Jd7BhIVStSEmhhL78xwPWqV
   Zrlut2tFIorwiNHqp/xq/bvCGLKceuh5KjGGFF3juVVFWVJAcbE1zw2Fq
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,255,1539619200"; 
   d="scan'208";a="95813298"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 09:52:56 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 19 Nov 2018 17:36:11 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2018 17:52:54 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Adam Manzanares <adam.manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 6/6] block: Initialize BIO I/O priority early
Date:   Tue, 20 Nov 2018 10:52:38 +0900
Message-Id: <20181120015238.26467-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120015238.26467-1-damien.lemoal@wdc.com>
References: <20181120015238.26467-1-damien.lemoal@wdc.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Adam Manzanares <adam.manzanares@wdc.com>
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

