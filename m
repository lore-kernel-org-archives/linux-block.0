Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5A12EBD6
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351409; cv=none; b=de6HPgLcJzr8RWR3vvhp91hc2qthz3eD2Gj5F9vZADcrmhvxZrG8UwaCyTnqGntUjA7xtnpcMYL/r3UJX4vg3DcXSmlGC6Vrfhuoj8V/AVtxMMD93YvtbMOwdGblD/Qq58C5M3/brp2hAXV+yWFM0c0Tgqg6grufVCgCxvobyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351409; c=relaxed/simple;
	bh=Ia62ZQlXIBEvcF6Cn2AYPvblXrtFyt9cKO4gD7R9fhU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LnXNPuQRFI3E2twRRZdKSBJxMw2gC6goD+0Buac+LR+0eY4h5laPKrNKibLE5Fj3qA2xBJpWOTP80H54wIHeXQZasuFPB6JN4NRl46hBlYCZk/oeVGRlx/Jy51Sej88bqNlrgA6tFaHr4H4KB4gpQwNQgvDMrM0m7OX+Sg6tTGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45E7nkcg067511;
	Fri, 14 Jun 2024 15:49:46 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W0rsz65KPz2S7Bgg;
	Fri, 14 Jun 2024 15:45:27 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 14 Jun 2024 15:49:43 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <ebiggers@kernel.org>,
        <bvanassche@acm.org>
CC: <ke.wang@unisoc.com>, <hongyu.jin.cn@gmail.com>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <akailash@google.com>,
        <cuidongliang390@gmail.com>, Dongliang Cui <dongliang.cui@unisoc.com>
Subject: [PATCH v5] block: Add ioprio to block_rq tracepoint
Date: Fri, 14 Jun 2024 15:49:36 +0800
Message-ID: <20240614074936.113659-1-dongliang.cui@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 45E7nkcg067511

Sometimes we need to track the processing order of requests with
ioprio set. So the ioprio of request can be useful information.

Example：

block_rq_insert: 8,0 RA 16384 () 6500840 + 32 be,0,6 [binder:815_3]
block_rq_issue: 8,0 RA 16384 () 6500840 + 32 be,0,6 [binder:815_3]
block_rq_complete: 8,0 RA () 6500840 + 32 be,0,6 [0]

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
---
Changes in v5:
 - Remove redundant changes.
---
---
 include/trace/events/block.h | 41 ++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 0e128ad51460..1527d5d45e01 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -9,9 +9,17 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/tracepoint.h>
+#include <uapi/linux/ioprio.h>
 
 #define RWBS_LEN	8
 
+#define IOPRIO_CLASS_STRINGS \
+	{ IOPRIO_CLASS_NONE,	"none" }, \
+	{ IOPRIO_CLASS_RT,	"rt" }, \
+	{ IOPRIO_CLASS_BE,	"be" }, \
+	{ IOPRIO_CLASS_IDLE,	"idle" }, \
+	{ IOPRIO_CLASS_INVALID,	"invalid"}
+
 #ifdef CONFIG_BUFFER_HEAD
 DECLARE_EVENT_CLASS(block_buffer,
 
@@ -82,6 +90,7 @@ TRACE_EVENT(block_rq_requeue,
 		__field(  dev_t,	dev			)
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
+		__field(  unsigned short, ioprio		)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__dynamic_array( char,	cmd,	1		)
 	),
@@ -90,16 +99,20 @@ TRACE_EVENT(block_rq_requeue,
 		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
+		__entry->ioprio    = rq->ioprio;
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
-	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
+	TP_printk("%d,%d %s (%s) %llu + %u %s,%u,%u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, 0)
+		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
+				   IOPRIO_CLASS_STRINGS),
+		  IOPRIO_PRIO_HINT(__entry->ioprio),
+		  IOPRIO_PRIO_LEVEL(__entry->ioprio),  0)
 );
 
 DECLARE_EVENT_CLASS(block_rq_completion,
@@ -113,6 +126,7 @@ DECLARE_EVENT_CLASS(block_rq_completion,
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
 		__field(  int	,	error			)
+		__field(  unsigned short, ioprio		)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__dynamic_array( char,	cmd,	1		)
 	),
@@ -122,16 +136,20 @@ DECLARE_EVENT_CLASS(block_rq_completion,
 		__entry->sector    = blk_rq_pos(rq);
 		__entry->nr_sector = nr_bytes >> 9;
 		__entry->error     = blk_status_to_errno(error);
+		__entry->ioprio    = rq->ioprio;
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
-	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
+	TP_printk("%d,%d %s (%s) %llu + %u %s,%u,%u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->error)
+		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
+				   IOPRIO_CLASS_STRINGS),
+		  IOPRIO_PRIO_HINT(__entry->ioprio),
+		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->error)
 );
 
 /**
@@ -180,6 +198,7 @@ DECLARE_EVENT_CLASS(block_rq,
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
 		__field(  unsigned int,	bytes			)
+		__field(  unsigned short, ioprio		)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__array(  char,         comm,   TASK_COMM_LEN   )
 		__dynamic_array( char,	cmd,	1		)
@@ -190,17 +209,21 @@ DECLARE_EVENT_CLASS(block_rq,
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 		__entry->bytes     = blk_rq_bytes(rq);
+		__entry->ioprio	   = rq->ioprio;
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
-	TP_printk("%d,%d %s %u (%s) %llu + %u [%s]",
+	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u,%u [%s]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __entry->bytes, __get_str(cmd),
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
+				   IOPRIO_CLASS_STRINGS),
+		  IOPRIO_PRIO_HINT(__entry->ioprio),
+		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->comm)
 );
 
 /**
-- 
2.25.1

