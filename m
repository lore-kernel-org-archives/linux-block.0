Return-Path: <SRS0=/LTC=27=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838DFC282DD
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50147206ED
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 22:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efinDRd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgAJWP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:15:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37819 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgAJWP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 17:15:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so1628868pga.4;
        Fri, 10 Jan 2020 14:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWkp+6IlDTdQR3jfDXnE50J1pJdLQxYNCBBcAlGMgAc=;
        b=efinDRd9eQKKcJetwzOjbawwuftcYm9BOfOqRuWQZCCuN+PGp/i2iJRc7jr35JfRYB
         6AUzlovgKgJECoaMASj6vYEw1lmSbIrFWtIZPOTliuGAw+l6ypx5OdfbLBSqIJWa4nJ3
         Xzhd7lLtjPz02D8UR0XW5siqWWe2ze87rbYeLyRoxUnghohlwAvuRGA35tzKkMz/d5aG
         u2KdT5Y3bHMP6iVWDcIP5YBGf7s7fOeqH/77qd8eIgt+RWIFiwRINc1Zhca9AcXxg6d4
         akL2b2OwxfDwabYsxv0ry7QTK25R37R9KqJwnIenP5eQ49IBu/AuE+BzxJ4ce5rjE3DV
         jiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWkp+6IlDTdQR3jfDXnE50J1pJdLQxYNCBBcAlGMgAc=;
        b=lZUq7/kPvQqpjz4NBCHTKhHhD+DB27syIFjsLGKTUBg5k2PvfF/bBW5t1W6KPfoDRb
         Eiz/gkcRHPU+7W8GexHqz6QHiR1Dhqo2KVhpbvYlfZcgojZDGdR9yzkJ7KQucHyDk8PN
         k5TkGcQ8CRw1Axq4bpv1GNCA8oKvgUE1Dldp6OGvO9SK/jOCGWyZI2HBfXQ8l4guueX/
         OuubFEDs9GRn3pmyNuQB1UmMMPINMxiJqvZ3eMWwQuNIWXmzQC45AhXhwSg+Tz573ymC
         XwUvpMYNIzO7uo/dK5jA6bDiIchlijYC0bgM8ZXWaU1E0ZE7Dz3zscVWfMQ5/ihfdb9x
         Y3Dw==
X-Gm-Message-State: APjAAAV2r6PfIaM/oSDI/9FEsksUl4O06iWrXqnATR1BXZV50KVN6EhM
        dy7fA6vXSF2+uv+xLTkymgL3T/b9ke4=
X-Google-Smtp-Source: APXvYqw7PcrqVIbPf751rD4U+YEFqDa2oD7cvkpNZNm3MLqCVyylcxRtq4cMP18UpPLUaixi3sATnA==
X-Received: by 2002:a62:5bc4:: with SMTP id p187mr6671903pfb.82.1578694528541;
        Fri, 10 Jan 2020 14:15:28 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id q199sm4307435pfq.163.2020.01.10.14.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:15:28 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] block: introduce block_rq_error tracepoint
Date:   Fri, 10 Jan 2020 14:15:00 -0800
Message-Id: <20200110221500.19678-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, rasdaemon uses the existing tracepoint block_rq_complete
and filters out non-error cases in order to capture block disk errors.

But there are a few problems with this approach:

1. Even kernel trace filter could do the filtering work, there is
   still some overhead after we enable this tracepoint.

2. The filter is merely based on errno, which does not align with kernel
   logic to check the errors for print_req_error().

3. block_rq_complete only provides dev major and minor to identify
   the block device, it is not convenient to use in user-space.

So introduce a new tracepoint block_rq_error just for the error case
and provides the device name for convenience too. With this patch,
rasdaemon could switch to block_rq_error.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 block/blk-core.c             |  4 +++-
 include/trace/events/block.h | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..0c7ad70d06be 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1450,8 +1450,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
 #endif
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET)))
+		     !(req->rq_flags & RQF_QUIET))) {
+		trace_block_rq_error(req, blk_status_to_errno(error), nr_bytes);
 		print_req_error(req, error, __func__);
+	}
 
 	blk_account_io_completion(req, nr_bytes);
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 81b43f5bdf23..a0f63f4d50c4 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -145,6 +145,49 @@ TRACE_EVENT(block_rq_complete,
 		  __entry->nr_sector, __entry->error)
 );
 
+/**
+ * block_rq_error - block IO operation error reported by device driver
+ * @rq: block operations request
+ * @error: status code
+ * @nr_bytes: number of completed bytes
+ *
+ * The block_rq_error tracepoint event indicates that some portion
+ * of operation request has failed as reported by the device driver.
+ */
+TRACE_EVENT(block_rq_error,
+
+	TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
+
+	TP_ARGS(rq, error, nr_bytes),
+
+	TP_STRUCT__entry(
+		__field(  dev_t,	dev			)
+		__field(  char *,	name			)
+		__field(  sector_t,	sector			)
+		__field(  unsigned int,	nr_sector		)
+		__field(  int,		error			)
+		__array(  char,		rwbs,	RWBS_LEN	)
+		__dynamic_array( char,	cmd,	1		)
+	),
+
+	TP_fast_assign(
+		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
+		__entry->name	   = rq->rq_disk ? rq->rq_disk->disk_name : "?";
+		__entry->sector    = blk_rq_pos(rq);
+		__entry->nr_sector = nr_bytes >> 9;
+		__entry->error     = error;
+
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);
+		__get_str(cmd)[0] = '\0';
+	),
+
+	TP_printk("%d,%d %s %s (%s) %llu + %u [%d]",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->name, __entry->rwbs, __get_str(cmd),
+		  (unsigned long long)__entry->sector,
+		  __entry->nr_sector, __entry->error)
+);
+
 DECLARE_EVENT_CLASS(block_rq,
 
 	TP_PROTO(struct request_queue *q, struct request *rq),
-- 
2.21.1

