Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AD3AEF52;
	Thu, 22 Jan 2026 03:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052268; cv=none; b=qitgPqgs4Aa74VJ/5ifRxid19tsNXSzjqkw7+o0mT0b71IC2l7qu70IcBrPqVNglPiTFklO+4rnY8xt5FtOJcmh4MZn7IO4sw8cpgqq1O5zQYPuViUsNxN5YWEgkR3P/PWbGSbycL/RTTHm0/ypvj2H8p1L5VSYc1OqKBWbZTT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052268; c=relaxed/simple;
	bh=IHt3QoFBpFtm67ho07WWIachXhji5tbdAbUQtgPYIsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BjMB5/7uA3L/YIyJ6gGitalvzEJpWITy/Mo9ogaCZJTxuuBNaMH/Y95utFaWxfoMQMNE+bgICe4LoMYtcyAEBqAusAiZkQCq8NXq80FDKuOTBH88GiR4DDVBTvc2Mvhz8T6SssBxSVfTOcYwAuy+/NjjAGeuNAR0wArdE9Ows+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d62a1c76f74111f0b0f03b4cfa9209d1-20260122
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
X-CID-O-INFO: VERSION:1.3.6,REQID:7e321fd9-8414-4de1-98c0-e6c172e1d01d,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:7e321fd9-8414-4de1-98c0-e6c172e1d01d,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:3aa29e557e2fbca1f38d3ccc574cf47a,BulkI
	D:260122112420TUBVNIWT,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d62a1c76f74111f0b0f03b4cfa9209d1-20260122
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(223.153.93.110)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1884983693; Thu, 22 Jan 2026 11:24:18 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 1/3] tracing: Export eval_map_wq for asynchronous use by other modules
Date: Thu, 22 Jan 2026 11:24:15 +0800
Message-Id: <20260122032415.395548-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260122032051.386331-1-tianyaxiong@kylinos.cn>
References: <20260122032051.386331-1-tianyaxiong@kylinos.cn>
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

Making eval_map_wq extern allows other modules to schedule their
work asynchronously on this queue,  preventing it from blocking
the main boot thread.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/trace/trace.c | 2 +-
 kernel/trace/trace.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e18005807395..cb073d0c86a6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10774,7 +10774,7 @@ int tracing_init_dentry(void)
 extern struct trace_eval_map *__start_ftrace_eval_maps[];
 extern struct trace_eval_map *__stop_ftrace_eval_maps[];
 
-static struct workqueue_struct *eval_map_wq __initdata;
+struct workqueue_struct *eval_map_wq __initdata;
 static struct work_struct eval_map_work __initdata;
 static struct work_struct tracerfs_init_work __initdata;
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index de4e6713b84e..44aaabc46a7a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -770,6 +770,8 @@ extern unsigned long nsecs_to_usecs(unsigned long nsecs);
 
 extern unsigned long tracing_thresh;
 
+extern struct workqueue_struct *eval_map_wq __initdata;
+
 /* PID filtering */
 
 bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
-- 
2.25.1

