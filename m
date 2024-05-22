Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816BC18EB1
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368487; cv=none; b=YxgQv3qGmkhTdxqv3fScSc5Q8FKyT8aM2sxNEqnEaKUiqnfFScrc6rD7BXuJ6JiPzLt7EQTvi8gj+HzeMXWDzm8Jph1o1ZfETdwT9XBCSStgBSJAJLrb3P9GRpyWIugJLIyXfVVerJIDjwo8Wy2CL82bYfFiXZQL3drKU0lg7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368487; c=relaxed/simple;
	bh=4UzTD7C9lHLWck3Qurn1hE1jt9KY6qkwQLk+zDYylDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gcwJI27yB43H9E+pyLa9TcNP2MUjES+/dFPwxwJbFZsb70i+hwW+tgbTSP8MKGvFzJmct3mqSyu6AzdCHIBHGChgBLul9++M4/jj1DzqoX8oeseTJjT6mfM6xEKB9eAU+GivXjhPMKHsn/f4FaCYL3HXz2F9GSzxehrkxduv7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44M918Eh051203;
	Wed, 22 May 2024 17:01:08 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VklYq6l8Xz2PrQJr;
	Wed, 22 May 2024 16:57:35 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 22 May 2024 17:01:06 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <ebiggers@kernel.org>
CC: <ke.wang@unisoc.com>, <hongyu.jin.cn@gmail.com>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <akailash@google.com>,
        <cuidongliang390@gmail.com>, Dongliang Cui <dongliang.cui@unisoc.com>
Subject: [PATCH v3] block: Add ioprio to block_rq tracepoint
Date: Wed, 22 May 2024 17:01:04 +0800
Message-ID: <20240522090104.1751148-1-dongliang.cui@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 44M918Eh051203

Sometimes we need to track the processing order of requests with
ioprio set. So the ioprio of request can be useful information.

Example：

block_rq_insert: 8,0 WS 4096 () 16573296 + 8 rt,4 [highpool[1]]
block_rq_issue: 8,0 WS 4096 () 16573296 + 8 rt,4 [kworker/7:0H]
block_rq_complete: 8,0 WS () 16573296 + 8 rt,4 [0]

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
---
Changes in v3:
 - Change the location of the priority macro definition.
---
---
 include/trace/events/block.h | 43 +++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 0e128ad51460..4563c852ad65 100644
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
 
@@ -82,6 +90,8 @@ TRACE_EVENT(block_rq_requeue,
 		__field(  dev_t,	dev			)
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
+		__field(  unsigned int,	ioprio_class		)
+		__field(  unsigned int, ioprio_value		)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__dynamic_array( char,	cmd,	1		)
 	),
@@ -90,16 +100,19 @@ TRACE_EVENT(block_rq_requeue,
 		__entry->dev	   = rq->q->disk ? disk_devt(rq->q->disk) : 0;
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
+		__entry->ioprio_class = rq->ioprio >> IOPRIO_CLASS_SHIFT & 0x3;
+		__entry->ioprio_value = rq->ioprio & 0xff;
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
-	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
+	TP_printk("%d,%d %s (%s) %llu + %u %s,%u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, 0)
+		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __print_symbolic(__entry->ioprio_class, IOPRIO_CLASS_STRINGS),
+		  __entry->ioprio_value, 0)
 );
 
 DECLARE_EVENT_CLASS(block_rq_completion,
@@ -113,6 +126,8 @@ DECLARE_EVENT_CLASS(block_rq_completion,
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
 		__field(  int	,	error			)
+		__field(  unsigned int,	ioprio_class		)
+		__field(  unsigned int, ioprio_value		)
 		__array(  char,		rwbs,	RWBS_LEN	)
 		__dynamic_array( char,	cmd,	1		)
 	),
@@ -122,16 +137,19 @@ DECLARE_EVENT_CLASS(block_rq_completion,
 		__entry->sector    = blk_rq_pos(rq);
 		__entry->nr_sector = nr_bytes >> 9;
 		__entry->error     = blk_status_to_errno(error);
+		__entry->ioprio_class = rq->ioprio >> IOPRIO_CLASS_SHIFT & 0x3;
+		__entry->ioprio_value = rq->ioprio & 0xff;
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 	),
 
-	TP_printk("%d,%d %s (%s) %llu + %u [%d]",
+	TP_printk("%d,%d %s (%s) %llu + %u %s,%u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __get_str(cmd),
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->error)
+		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __print_symbolic(__entry->ioprio_class, IOPRIO_CLASS_STRINGS),
+		  __entry->ioprio_value, __entry->error)
 );
 
 /**
@@ -180,8 +198,10 @@ DECLARE_EVENT_CLASS(block_rq,
 		__field(  sector_t,	sector			)
 		__field(  unsigned int,	nr_sector		)
 		__field(  unsigned int,	bytes			)
+		__field(  unsigned int,	ioprio_class		)
+		__field(  unsigned int, ioprio_value		)
 		__array(  char,		rwbs,	RWBS_LEN	)
-		__array(  char,         comm,   TASK_COMM_LEN   )
+		__array(  char,		comm,   TASK_COMM_LEN	)
 		__dynamic_array( char,	cmd,	1		)
 	),
 
@@ -190,17 +210,20 @@ DECLARE_EVENT_CLASS(block_rq,
 		__entry->sector    = blk_rq_trace_sector(rq);
 		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
 		__entry->bytes     = blk_rq_bytes(rq);
+		__entry->ioprio_class = rq->ioprio >> IOPRIO_CLASS_SHIFT & 0x3;
+		__entry->ioprio_value = rq->ioprio & 0xff;
 
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 		__get_str(cmd)[0] = '\0';
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
-	TP_printk("%d,%d %s %u (%s) %llu + %u [%s]",
+	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u [%s]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->rwbs, __entry->bytes, __get_str(cmd),
-		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  (unsigned long long)__entry->sector, __entry->nr_sector,
+		  __print_symbolic(__entry->ioprio_class, IOPRIO_CLASS_STRINGS),
+		  __entry->ioprio_value, __entry->comm)
 );
 
 /**
-- 
2.25.1

