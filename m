Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368BC433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC52961027
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 17:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhJRRxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhJRRxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 13:53:24 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DC7C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:13 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id x1so17256265iof.7
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6KyFvc9/cRpsVEldC9hLwi1Bm5WYTo8xsA740Oti4I=;
        b=uY070Cu39UZOIfxSbB8Ls4g+mTGycigkPKHFSZswHBChYP5IuXhNE7WISmhMgAPJ5M
         xGeaqr7+x53EuZzbN5Xk7yyvE/PKCy64Nm/QtZ+LqTiutpI1/JumLMU74f2k5ybrwr1r
         LI56K2s6DibElVZCAHcuxXsOSCRDZx2SfiiIgtBx7j2sBUq0GYXv1bCGtjM9GcEOJLQO
         fvFyogLgOu1dpsOf2P1bCrNKEhovbBIv/+NoAY/fXvB7tnsdNj4xDW7QUXAvXuzB8xzf
         +L2y/S29xuR9GUzj0XEnwhu8tfyBsmo6wXRLfHghxcY3k7YDVReYAjfJ6bmnAXXoA8nk
         PlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C6KyFvc9/cRpsVEldC9hLwi1Bm5WYTo8xsA740Oti4I=;
        b=JSHtzWI1mRQyo2xuvNjKPGpasBgYO68E63McGkkfDTbZ0s1WUyUuhB/ACNcvIU2f/3
         TYr2Oq44X4t27QhirjuPUBKPByPQcvYknqvFL/NXWZIIz4j8QQ/iuum0ZSwIsPiiW2tO
         tMK371VjNbwA9/HGiwM6/HHHQBQlZUOZXDmwrgnEg/YlvE6IYcSG23xOMIvaGcozUHRA
         ycVo/PTj9fpuIsRwB6lmIkArG2k1wN66BHxeDFEp520sm7OBiWS8SfX+QpqlpOVHuQxp
         8Y1To4GkgeSZ7YClyx6258Z4KJPsqt5NetY+AjAmUifLT1wA6IS307VimcV65FZdCY7S
         StgA==
X-Gm-Message-State: AOAM530IjiHcBhknwIWBeWwkgqPAp+Eyez6leZqco51q4Ok63io2yjS1
        up71IlgNB96VfBziY8w4Bb77ey3Hwc5TIw==
X-Google-Smtp-Source: ABdhPJzvDtv/FgT6zwhpuNOr2Re9j+qLdfFFODD2j5sNJGm70gR7RXrvBBna6V8t2zp4cfqJUP0Mbw==
X-Received: by 2002:a6b:8f44:: with SMTP id r65mr15458436iod.156.1634579472392;
        Mon, 18 Oct 2021 10:51:12 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v17sm7380017ilh.67.2021.10.18.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:51:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] block: don't call blk_status_to_errno in blk_update_request
Date:   Mon, 18 Oct 2021 11:51:04 -0600
Message-Id: <20211018175109.401292-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018175109.401292-1-axboe@kernel.dk>
References: <20211018175109.401292-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

We only need to call it to resolve the blk_status_t -> errno mapping for
tracing, so move the conversion into the tracepoints that are not called
at all when tracing isn't enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c               | 2 +-
 include/trace/events/block.h | 6 +++---
 kernel/trace/blktrace.c      | 7 ++++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f7c610f5f3e7..e3ef55f76701 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -672,7 +672,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 {
 	int total_bytes;
 
-	trace_block_rq_complete(req, blk_status_to_errno(error), nr_bytes);
+	trace_block_rq_complete(req, error, nr_bytes);
 
 	if (!req->bio)
 		return false;
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index cc5ab96a7471..a95daa4d4caa 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -114,7 +114,7 @@ TRACE_EVENT(block_rq_requeue,
  */
 TRACE_EVENT(block_rq_complete,
 
-	TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
+	TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
 
 	TP_ARGS(rq, error, nr_bytes),
 
@@ -122,7 +122,7 @@ TRACE_EVENT(block_rq_complete,
 		__field(  dev_t,	dev			)
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
-		__field(  int,		error			)
+		__field(  int	,	error			)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__dynamic_array( char,	cmd,	1		)
 	),
@@ -131,7 +131,7 @@ TRACE_EVENT(block_rq_complete,
 		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
 		__entry->sector    = blk_rq_pos(rq);
 		__entry->nr_sector = nr_bytes >> 9;
-		__entry->error     = error;
+		__entry->error     = blk_status_to_errno(error);
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index fa91f398f28b..1183c88634aa 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -816,7 +816,7 @@ blk_trace_request_get_cgid(struct request *rq)
  *     Records an action against a request. Will log the bio offset + size.
  *
  **/
-static void blk_add_trace_rq(struct request *rq, int error,
+static void blk_add_trace_rq(struct request *rq, blk_status_t error,
 			     unsigned int nr_bytes, u32 what, u64 cgid)
 {
 	struct blk_trace *bt;
@@ -834,7 +834,8 @@ static void blk_add_trace_rq(struct request *rq, int error,
 		what |= BLK_TC_ACT(BLK_TC_FS);
 
 	__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, req_op(rq),
-			rq->cmd_flags, what, error, 0, NULL, cgid);
+			rq->cmd_flags, what, blk_status_to_errno(error), 0,
+			NULL, cgid);
 	rcu_read_unlock();
 }
 
@@ -863,7 +864,7 @@ static void blk_add_trace_rq_requeue(void *ignore, struct request *rq)
 }
 
 static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
-			int error, unsigned int nr_bytes)
+			blk_status_t error, unsigned int nr_bytes)
 {
 	blk_add_trace_rq(rq, error, nr_bytes, BLK_TA_COMPLETE,
 			 blk_trace_request_get_cgid(rq));
-- 
2.33.1

