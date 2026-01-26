Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394C7DA66;
	Mon, 26 Jan 2026 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769395408; cv=none; b=ZxBqpgepOtO9RP/DEL6hgWrEYhhIN8xEmmIO7cg8bO+JLZkHVVf7OQQLo5pOukxqL22BTbWrcqxhwbhsDtrAAfw6gSGb69sNAjXYSk681zSpm2x6XnEENOMUdPawCIaM+ASSgAL2IMkzt6M8Vdl/DvwPPqQ0hnL9Ec4fVUgUaF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769395408; c=relaxed/simple;
	bh=4TdlL4iladGctkLRvzlbmw3NeoTlujsqOI+g2elIzVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MCBERQguGhfzdfLWjW8OFTDHA7PIetDeQbMUPelQyBNQ1kk1q+/ajiDERTNw3i3wrzzfBns4YKQVF+VU+vNlEBtICCh7Ir0SbwqQ2I7qQtNqUdXpixOa57yU94WldtfCRTKO+Fto+cx/RTTMd453icnxHXvEQVNLm++haFimGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c6d7bfd6fa6011f0b0f03b4cfa9209d1-20260126
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
X-CID-O-INFO: VERSION:1.3.6,REQID:31ddab7f-1e5e-4267-8943-fe852fd87ed9,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:31ddab7f-1e5e-4267-8943-fe852fd87ed9,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:4210cfb6fccb232f9bc3a0d4290bdcc0,BulkI
	D:260126104321OHI01H1F,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c6d7bfd6fa6011f0b0f03b4cfa9209d1-20260126
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(223.153.105.152)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2105670250; Mon, 26 Jan 2026 10:43:20 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rostedt@goodmis.org,
	axboe@kernel.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 1/3] tracing: Rename `eval_map_wq` and export it for asynchronous use by other modules
Date: Mon, 26 Jan 2026 10:43:16 +0800
Message-Id: <20260126024316.297178-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260126024033.290136-1-tianyaxiong@kylinos.cn>
References: <20260126024033.290136-1-tianyaxiong@kylinos.cn>
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

Rename eval_map_wq to trace_init_wq and export it, thereby allowing
other modules to schedule work on this queue asynchronously and
avoiding blockage of the main boot thread.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/trace/trace.c | 18 +++++++++---------
 kernel/trace/trace.h |  2 ++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e18005807395..c61e30cb7339 100644
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
index de4e6713b84e..e52f259f8945 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -770,6 +770,8 @@ extern unsigned long nsecs_to_usecs(unsigned long nsecs);
 
 extern unsigned long tracing_thresh;
 
+extern struct workqueue_struct *trace_init_wq __initdata;
+
 /* PID filtering */
 
 bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
-- 
2.25.1

