Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEA7C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868D42177B
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mn3yo1mF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfEAE3F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63878 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfEAE3F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685013; x=1588221013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kspJKdMdZeRt5kXl7cCUi9GcQA8xUX51CwUpRxbt5ik=;
  b=Mn3yo1mFP/bAYZiS7VgvqZ2JGFIsCzq7uPI4ZT1c9AvL0hktiTi7X0vW
   0+3uV/ypMYRv1PS4jDMn+itFrDhZx2SwjTIRng5oJcd5Z5CpI2pfvO+jV
   0OOVjGmyQKC6ncmqD8SymVbnUUhcTwQm9+qAW7zHsTxRpoon4gRYCm9RV
   ctocnalqCZuCEqcBtcFWUta4szYTdbdPeJoOrF4PdOUkAUX1ApNiL1qcw
   mAgDvRRh9eSOY9f26Jhmz9yORlPz026RV7d4QM0njbnhhd0npsTPXhjAZ
   JoZxOFC8c3Y8b9/EOMCOsLOCOrE1TJlNcl4FB3aKYNEYTXHHrtw7n71oC
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432280"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:13 +0800
IronPort-SDR: 4phUVbHLgE1VXFja5MJHx9ZSEOP/yyw41CLQyBksiWWEhGnqtviX1V1jnIxpw5daD1jkhDQJ+x
 Sufk8nqWB59uOKvslEG8gYwyGvFxdwTcMEzvj4lRtPWO9l3FaA0coKhFoHiey8Ow4kbqtA68tK
 pUolE6pBWlPVK/pQwNoVAVeopE27cuka5NeZDe/MMGTj6bpxyJKA6ULP//0NPCUZA+8+3fYPOf
 hD3CUyfB89HI5Lrsetm1LmbeoRm7uyK2yjcktegZxniWEyCzaSfdhQegdQOAxDG2J1UuRqP97b
 jOrUhl5vlFMVK/XKN2ym1Ua6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:34 -0700
IronPort-SDR: VIMlGzv/aba1HaEXflCtuvFh94XFvAaWebUEDs7vrrs6ectBupftQIFxYZz20odmq8Jl6UjLF+
 DxoQ4onldgfqxM1pPJzMPFen7mDX+eHcmhT4Z2ZTdDMCGfPJ/s9cMWgc6nVKGtX2iLFO0NMvK5
 KXo6RG0jQgiqs6i9u6QhDGAL2FYd02TyHb8ZdRts+CZAjt0orbOsqu/6gvvExbJBSv+yPBYroT
 JdQ3tVwNRqxBHPL1us7Yrpc+IybjWKIjXQFA9GDF2XKZcnRv4ERWtitgxE9YuDS8UT/121ij3D
 bes=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:05 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 07/18] blktrace: allow user to track iopriority
Date:   Tue, 30 Apr 2019 21:28:20 -0700
Message-Id: <20190501042831.5313-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we have added the support for to track the iopriority
update the blktrace extension code to actually track the priority
and use priority mask to filter out the log.

Priority mask just works same as action mask where we discard all the
traces where they don't match the priority mask.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 60 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 6d2b4adae76e..1b113ba284fe 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -16,6 +16,7 @@
 #include <linux/uaccess.h>
 #include <linux/list.h>
 #include <linux/blk-cgroup.h>
+#include <linux/ioprio.h>
 
 #include "../../block/blk.h"
 
@@ -189,6 +190,54 @@ EXPORT_SYMBOL_GPL(__trace_note_message);
 
 
 #ifdef CONFIG_BLKTRACE_EXT
+static bool prio_log_check(struct blk_trace *bt, u32 ioprio)
+{
+	bool ret;
+
+	switch (IOPRIO_PRIO_CLASS(ioprio)) {
+	case IOPRIO_CLASS_NONE:
+	case IOPRIO_CLASS_RT:
+	case IOPRIO_CLASS_BE:
+	case IOPRIO_CLASS_IDLE:
+		break;
+	default:
+		/*XXX: print rate limit warn here */
+		ret = false;
+		goto out;
+	}
+
+	switch (IOPRIO_PRIO_CLASS(ioprio)) {
+	case IOPRIO_CLASS_NONE:
+		if (bt->prio_mask & 0x01)
+			ret = true;
+		else
+			ret = false;
+		break;
+	case IOPRIO_CLASS_RT:
+		if (bt->prio_mask & 0x02)
+			ret = true;
+		else
+			ret = false;
+		break;
+	case IOPRIO_CLASS_BE:
+		if (bt->prio_mask & 0x04)
+			ret = true;
+		else
+			ret = false;
+		break;
+	case IOPRIO_CLASS_IDLE:
+		if (bt->prio_mask & 0x08)
+			ret = true;
+		else
+			ret = false;
+		break;
+	default:
+		ret = false;
+	}
+out:
+	return ret;
+}
+
 static int act_log_check(struct blk_trace *bt, u64 what, sector_t sector,
 			 pid_t pid)
 #else
@@ -279,6 +328,10 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	pid = tsk->pid;
 	if (act_log_check(bt, what, sector, pid))
 		return;
+#ifdef CONFIG_BLKTRACE_EXT
+	if (bt->prio_mask && !prio_log_check(bt, ioprio))
+		return;
+#endif /* CONFIG_BLKTRACE_EXT */
 	cpu = raw_smp_processor_id();
 
 	if (blk_tracer) {
@@ -324,6 +377,9 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 		t->sector = sector;
 		t->bytes = bytes;
 		t->action = what;
+#ifdef CONFIG_BLKTRACE_EXT
+		t->ioprio = ioprio;
+#endif /* CONFIG_BLKTRACE_EXT */
 		t->device = bt->dev;
 		t->error = error;
 		t->pdu_len = pdu_len + cgid_len;
@@ -574,6 +630,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 #ifdef CONFIG_BLKTRACE_EXT
 	if (!bt->act_mask)
 		bt->act_mask = (u64) -1ULL;
+	bt->prio_mask = buts->prio_mask;
 #else
 	if (!bt->act_mask)
 		bt->act_mask = (u16) -1;
@@ -1773,7 +1830,8 @@ static int blk_trace_setup_queue(struct request_queue *q,
 
 #ifdef CONFIG_BLKTRACE_EXT
 	bt->act_mask = (u64)-1ULL;
-
+	/* do not track priorities by default */
+	bt->prio_mask = 0;
 #else
 	bt->act_mask = (u16)-1;
 #endif /* CONFIG_BLKTRACE_EXT */
-- 
2.19.1

