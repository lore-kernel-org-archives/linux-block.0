Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8A6138
	for <linux-block@vger.kernel.org>; Tue, 11 Jun 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091349; cv=none; b=GueOpSUAKOfwMQWPLAWCsVTYge54GALE/r4BRzFV3540kzBucZ9uz+6Ggrl+s68gqJB8s2xr0rlf8lP9m8Fx8v/AWG5uh4iO6BsNZjWCtMDf1KnTMKZ4kGfkTcAiq+qh8kdSUXU5A1vczIaq0ZNp+fd+48Tpl5uOvVpUL4LGQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091349; c=relaxed/simple;
	bh=uJnDfuouCf0ofiaadXE2js0RA0ImI73q/IfYZIwKOkg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TQ0nk8zuahkzl21bXX6BeiW6T2eLlFCOQDSpJ+2Lp2DVXO9316M13R/gU2UPbd7cy8JgW4jA8EbuRLm5qNmnjj5wmUKJB99GoY1uFCib7mjENEJuin0fmNlSyZPLnicufhiEZIuZszWIRZUkZ7HMdFlm532xBJVnVgdE/RanWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45B7ZQWO082600;
	Tue, 11 Jun 2024 15:35:26 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Vz0hx41q6z2RdZvm;
	Tue, 11 Jun 2024 15:31:13 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 11 Jun 2024 15:35:21 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <ebiggers@kernel.org>
CC: <ke.wang@unisoc.com>, <hongyu.jin.cn@gmail.com>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <akailash@google.com>,
        <cuidongliang390@gmail.com>, Dongliang Cui <dongliang.cui@unisoc.com>
Subject: [PATCH v4] block: Add ioprio to block_rq tracepoint
Date: Tue, 11 Jun 2024 15:35:19 +0800
Message-ID: <20240611073519.323680-1-dongliang.cui@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 45B7ZQWO082600

Sometimes we need to track the processing order of requests with
ioprio set. So the ioprio of request can be useful information.

Example：

block_rq_insert: 8,0 RA 16384 () 6500840 + 32 be,0,6 [binder:815_3]
block_rq_issue: 8,0 RA 16384 () 6500840 + 32 be,0,6 [binder:815_3]
block_rq_complete: 8,0 RA () 6500840 + 32 be,0,6 [0]

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
---
Changes in v4:
 - Use macros to split ioprio.
 - Print ioprio hint.
 - Only storage ioprio in __entry.
---
---
 include/trace/events/block.h | 77 +++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 27 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 0e128ad51460..209d54dc9dce 100644
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
 
@@ -79,27 +87,32 @@ TRACE_EVENT(block_rq_requeue,
 	TP_ARGS(rq),
 
 	TP_STRUCT__entry(
-		__field(  dev_t,	dev			)
-		__field(  sector_t,	sector			)
-		__field(  unsigned int,	nr_sector		)
-		__array(  char,		rwbs,	RWBS_LEN	)
-		__dynamic_array( char,	cmd,	1		)
+		__field(  dev_t,		dev			)
+		__field(  sector_t,		sector			)
+		__field(  unsigned int,		nr_sector		)
+		__field(  unsigned short,	ioprio			)
+		__array(  char,			rwbs,	RWBS_LEN	)
+		__dynamic_array( char,		cmd,	1		)
 	),
 
 	TP_fast_assign(
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
@@ -109,12 +122,13 @@ DECLARE_EVENT_CLASS(block_rq_completion,
 	TP_ARGS(rq, error, nr_bytes),
 
 	TP_STRUCT__entry(
-		__field(  dev_t,	dev			)
-		__field(  sector_t,	sector			)
-		__field(  unsigned int,	nr_sector		)
-		__field(  int	,	error			)
-		__array(  char,		rwbs,	RWBS_LEN	)
-		__dynamic_array( char,	cmd,	1		)
+		__field(  dev_t,		dev			)
+		__field(  sector_t,		sector			)
+		__field(  unsigned int,		nr_sector		)
+		__field(  int	,		error			)
+		__field(  unsigned short,	ioprio			)
+		__array(  char,			rwbs,	RWBS_LEN	)
+		__dynamic_array( char,		cmd,	1		)
 	),
 
 	TP_fast_assign(
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
@@ -176,13 +194,14 @@ DECLARE_EVENT_CLASS(block_rq,
 	TP_ARGS(rq),
 
 	TP_STRUCT__entry(
-		__field(  dev_t,	dev			)
-		__field(  sector_t,	sector			)
-		__field(  unsigned int,	nr_sector		)
-		__field(  unsigned int,	bytes			)
-		__array(  char,		rwbs,	RWBS_LEN	)
-		__array(  char,         comm,   TASK_COMM_LEN   )
-		__dynamic_array( char,	cmd,	1		)
+		__field(  dev_t,		dev			)
+		__field(  sector_t,		sector			)
+		__field(  unsigned int,		nr_sector		)
+		__field(  unsigned int,		bytes			)
+		__field(  unsigned short,	ioprio			)
+		__array(  char,			rwbs,	RWBS_LEN	)
+		__array(  char,			comm,   TASK_COMM_LEN	)
+		__dynamic_array( char,		cmd,	1		)
 	),
 
 	TP_fast_assign(
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

