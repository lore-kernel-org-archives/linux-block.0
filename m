Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05411C4360C
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 23:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D520E21929
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 23:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfJJXgb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:36:31 -0400
Received: from ale.deltatee.com ([207.54.116.67]:57852 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfJJXga (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 19:36:30 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iIhyu-0006HU-S1; Thu, 10 Oct 2019 17:36:29 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iIhyt-0004Al-Fl; Thu, 10 Oct 2019 17:36:27 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 10 Oct 2019 17:36:26 -0600
Message-Id: <20191010233626.15998-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, axboe@kernel.dk, sbates@raithlin.com, logang@deltatee.com, hch@lst.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] block: account statistics for passthrough requests
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Presently, passthrough requests are not accounted for because
blk_do_io_stat() expressly rejects them. Based on some digging
in the history, this doesn't seem like a concious decision but
one that evolved from the change from blk_fs_request() to
blk_rq_is_passthrough().

To support this, call blk_account_io_start() in blk_execute_rq_nowait()
and remove the passthrough check in blk_do_io_stat().

Link: https://lore.kernel.org/linux-block/20191010100526.GA27209@lst.de/
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
---

This change is needed for the NVMe-of passthru work that is in progress.
Christoph suggested sending it as its own patch. (See the link
in the commit message for more information.)

 block/blk-exec.c | 2 ++
 block/blk.h      | 7 ++-----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 1db44ca0f4a6..e20a852ae432 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -55,6 +55,8 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
 	rq->rq_disk = bd_disk;
 	rq->end_io = done;

+	blk_account_io_start(rq, true);
+
 	/*
 	 * don't check dying flag for MQ because the request won't
 	 * be reused after dying flag is set
diff --git a/block/blk.h b/block/blk.h
index 47fba9362e60..2bea40180b6f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -242,14 +242,11 @@ int blk_dev_init(void);
  * Contribute to IO statistics IFF:
  *
  *	a) it's attached to a gendisk, and
- *	b) the queue had IO stats enabled when this request was started, and
- *	c) it's a file system request
+ *	b) the queue had IO stats enabled when this request was started
  */
 static inline bool blk_do_io_stat(struct request *rq)
 {
-	return rq->rq_disk &&
-	       (rq->rq_flags & RQF_IO_STAT) &&
-		!blk_rq_is_passthrough(rq);
+	return rq->rq_disk && (rq->rq_flags & RQF_IO_STAT);
 }

 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
--
2.20.1
