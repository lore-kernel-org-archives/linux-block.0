Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E1BC43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiFWTAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiFWTAR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:17 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BF6B8F89
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:45 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 9so161235pgd.7
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dTxO9J04Elz45/3vEyCUSSDzClsVp9+z6jqAAoby5c=;
        b=G6D6mtqUpHbd1hiyHjapeyGjKN3ty9dKpO34BbUADtwmxAzI5xJ8fUm0vNuCJ7RuQl
         jmDVULdOO1HFuiqmdu28thE9idkNJul2RfiRK51K4h1M7qVFFogetZk2yD1gSkNn9kAR
         v7F3CE3aifwC8CtMJa8xPuU5UZrAKVC7PAMq7saP2ICHtdmHVNN2l9j8R7FOz7WlzYxo
         8ea7/cHFJ3RelpuqE9UIC9RwPWgScNQku3rEZ5w3rQPUVyEM6IDRXwfJV0d7QzS9RD6N
         prtTAP6bWmhZTtdP+ByZH9tsXjRUgO0sljY82UmGpLvyqj6gOZgeTsjMWXS9+PieiAiY
         pqDA==
X-Gm-Message-State: AJIora9vBtoAcxhlG/jRgV0BpvM7d3Xb4LZdm8BQZvdxvrq8QhQcwW+0
        jWuUvyjilqDd/Fb63UgCkxk=
X-Google-Smtp-Source: AGRyM1u+ceztbV8BqMSu1bl0YS9khoj1JzbMJbT/HvmMv7jSyts0nRPwbhIRlLTQM6t8G0XTcS8sFw==
X-Received: by 2002:a63:3fcb:0:b0:40c:4da1:555a with SMTP id m194-20020a633fcb000000b0040c4da1555amr8574581pga.3.1656007544566;
        Thu, 23 Jun 2022 11:05:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Li Zefan <lizf@cn.fujitsu.com>,
        Steven Rostedt <srostedt@redhat.com>
Subject: [PATCH 07/51] blktrace: Use the new blk_opf_t type
Date:   Thu, 23 Jun 2022 11:04:44 -0700
Message-Id: <20220623180528.3595304-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for a function
argument that represents a combination of a request operation and request
flags. Rename that argument from 'op' into 'opf' to make its role more
clear.

Cc: Li Zefan <lizf@cn.fujitsu.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Steven Rostedt <srostedt@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blktrace_api.h |  3 ++-
 kernel/trace/blktrace.c      | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 623e22492afa..de9ef5bb57a7 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -7,6 +7,7 @@
 #include <linux/compat.h>
 #include <uapi/linux/blktrace_api.h>
 #include <linux/list.h>
+#include <linux/blk_types.h>
 
 #if defined(CONFIG_BLK_DEV_IO_TRACE)
 
@@ -115,7 +116,7 @@ struct compat_blk_user_trace_setup {
 
 #endif
 
-void blk_fill_rwbs(char *rwbs, unsigned int op);
+void blk_fill_rwbs(char *rwbs, blk_opf_t opf);
 
 static inline sector_t blk_rq_trace_sector(struct request *rq)
 {
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 10a32b0f2deb..f24c7351071c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -205,7 +205,7 @@ static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
 #define BLK_TC_PREFLUSH		BLK_TC_FLUSH
 
 /* The ilog2() calls fall out because they're constant */
-#define MASK_TC_BIT(rw, __name) ((rw & REQ_ ## __name) << \
+#define MASK_TC_BIT(rw, __name) ((__force u32)(rw & REQ_ ## __name) <<	\
 	  (ilog2(BLK_TC_ ## __name) + BLK_TC_SHIFT - __REQ_ ## __name))
 
 /*
@@ -213,8 +213,8 @@ static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
  * blk_io_trace structure and places it in a per-cpu subbuffer.
  */
 static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
-		     int op, int op_flags, u32 what, int error, int pdu_len,
-		     void *pdu_data, u64 cgid)
+		     enum req_op op, blk_opf_t op_flags, u32 what, int error,
+		     int pdu_len, void *pdu_data, u64 cgid)
 {
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
@@ -1895,14 +1895,14 @@ void blk_trace_remove_sysfs(struct device *dev)
  *     caller with resulting string.
  *
  **/
-void blk_fill_rwbs(char *rwbs, unsigned int op)
+void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
 {
 	int i = 0;
 
-	if (op & REQ_PREFLUSH)
+	if (opf & REQ_PREFLUSH)
 		rwbs[i++] = 'F';
 
-	switch (op & REQ_OP_MASK) {
+	switch (opf & REQ_OP_MASK) {
 	case REQ_OP_WRITE:
 		rwbs[i++] = 'W';
 		break;
@@ -1923,13 +1923,13 @@ void blk_fill_rwbs(char *rwbs, unsigned int op)
 		rwbs[i++] = 'N';
 	}
 
-	if (op & REQ_FUA)
+	if (opf & REQ_FUA)
 		rwbs[i++] = 'F';
-	if (op & REQ_RAHEAD)
+	if (opf & REQ_RAHEAD)
 		rwbs[i++] = 'A';
-	if (op & REQ_SYNC)
+	if (opf & REQ_SYNC)
 		rwbs[i++] = 'S';
-	if (op & REQ_META)
+	if (opf & REQ_META)
 		rwbs[i++] = 'M';
 
 	rwbs[i] = '\0';
