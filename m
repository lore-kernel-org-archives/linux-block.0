Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245772566F7;
	Wed,  4 Feb 2026 01:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170038; cv=none; b=O6XjakdFsos+NgMRZN7NrO0gsATqmQqKrTGmIlFW0lH8+V7d4VWlbLoTPRgVSFPLq40/xcEhpxdb2vP/BjMGEDHfXE0KxNMvY7Sdlufw1zGrxWV1DHDiHOYiaOfEUSIofDQpKoQ6dhy4K9W/CUkbf9fPFigqc51ZDyIjedAta5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170038; c=relaxed/simple;
	bh=gb8+RLwH1mLnHCvquqykDWLMdPea4d3L/yrMxNd7l2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6cSfweKBTAYkA7azLYpamalyKtJXhVgoyzkxQ3DajVQBJ5aATrK5ervhlTDnwMOvXeazCUcSJdt1mQWUNc1ASNhRRaUpm8dbxQxZgQlmIQfKmbbk+L5r9+xaCU6M9ERmK3VQsYRcOuCiec5egXqe2eQDyU0f6E/JGEnF//xqC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 58a04980016c11f1b0f03b4cfa9209d1-20260204
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:385d6458-5ae6-411f-80d3-ade1a969d0a0,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:385d6458-5ae6-411f-80d3-ade1a969d0a0,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:0afb1723e33868daa67ba680e2d5be25,BulkI
	D:260128205414BPB3US2C,BulkQuantity:2,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 58a04980016c11f1b0f03b4cfa9209d1-20260204
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.200.196)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1253373005; Wed, 04 Feb 2026 09:53:48 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v5 1/3] tracing: Rename `eval_map_wq` and allow other parts of tracing use it
Date: Wed,  4 Feb 2026 09:53:44 +0800
Message-Id: <20260204015344.162818-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260204015103.155025-1-tianyaxiong@kylinos.cn>
References: <20260204015103.155025-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The eval_map_work_func() function, though queued in eval_map_wq,
holds the trace_event_sem read-write lock for a long time during
kernel boot. This causes blocking issues for other functions.

Rename eval_map_wq to trace_init_wq and make it global, thereby
allowing other parts of tracing to schedule work on this queue
asynchronously and avoiding blockage of the main boot thread.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/trace/trace.c | 18 +++++++++---------
 kernel/trace/trace.h |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b1cb30a7b83d..01df88e77818 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10774,7 +10774,7 @@ int tracing_init_dentry(void)
 extern struct trace_eval_map *__start_ftrace_eval_maps[];
 extern struct trace_eval_map *__stop_ftrace_eval_maps[];
 
-static struct workqueue_struct *eval_map_wq __initdata;
+struct workqueue_struct *trace_init_wq __initdata;
 static struct work_struct eval_map_work __initdata;
 static struct work_struct tracerfs_init_work __initdata;
 
@@ -10790,15 +10790,15 @@ static int __init trace_eval_init(void)
 {
 	INIT_WORK(&eval_map_work, eval_map_work_func);
 
-	eval_map_wq = alloc_workqueue("eval_map_wq", WQ_UNBOUND, 0);
-	if (!eval_map_wq) {
-		pr_err("Unable to allocate eval_map_wq\n");
+	trace_init_wq = alloc_workqueue("trace_init_wq", WQ_UNBOUND, 0);
+	if (!trace_init_wq) {
+		pr_err("Unable to allocate trace_init_wq\n");
 		/* Do work here */
 		eval_map_work_func(&eval_map_work);
 		return -ENOMEM;
 	}
 
-	queue_work(eval_map_wq, &eval_map_work);
+	queue_work(trace_init_wq, &eval_map_work);
 	return 0;
 }
 
@@ -10807,8 +10807,8 @@ subsys_initcall(trace_eval_init);
 static int __init trace_eval_sync(void)
 {
 	/* Make sure the eval map updates are finished */
-	if (eval_map_wq)
-		destroy_workqueue(eval_map_wq);
+	if (trace_init_wq)
+		destroy_workqueue(trace_init_wq);
 	return 0;
 }
 
@@ -10969,9 +10969,9 @@ static __init int tracer_init_tracefs(void)
 	if (ret)
 		return 0;
 
-	if (eval_map_wq) {
+	if (trace_init_wq) {
 		INIT_WORK(&tracerfs_init_work, tracer_init_tracefs_work_func);
-		queue_work(eval_map_wq, &tracerfs_init_work);
+		queue_work(trace_init_wq, &tracerfs_init_work);
 	} else {
 		tracer_init_tracefs_work_func(NULL);
 	}
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index de4e6713b84e..9e8d52503618 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -769,6 +769,7 @@ extern cpumask_var_t __read_mostly tracing_buffer_mask;
 extern unsigned long nsecs_to_usecs(unsigned long nsecs);
 
 extern unsigned long tracing_thresh;
+extern struct workqueue_struct *trace_init_wq __initdata;
 
 /* PID filtering */
 
-- 
2.25.1

