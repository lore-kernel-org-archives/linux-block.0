Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78082566F7;
	Wed,  4 Feb 2026 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170047; cv=none; b=LzcmgGzg1dCfoGXLY3sLKKdeNplsZfmENiiwpoAAC8BQWVbHfEsZ/ixYDNlIwNFtwB07Rl1767uypOhjj1UYAWUsNnP6BlLrZJcRfQBgD/X0ilejiky5XRSulqwP8l89OXo2t8S7KsX4PtC7m1Kvk1RamcW0RREuWQ7xnr8kWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170047; c=relaxed/simple;
	bh=WEjxltr5Xt9TcsRaRQ3bSIUoWWFGhZ95yRImxuAXmAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bgPzGd1sO/NtSV3yzmnLySA2AshTht7m5EHZQduH301e/3kgM7qeA4k0CSXJNuGVdpkDLEql35+aCA3wvJJgOt8VNLQ5GzVrAXab6tZQ3jtt68AU4IYE+VaHAsWef+P3YiKSSeOKcb4RMw5CfIiRIUQc3XXQb45Bl9UgQVmYZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5ddff97c016c11f1b0f03b4cfa9209d1-20260204
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
X-CID-O-INFO: VERSION:1.3.6,REQID:a5e7a100-3b33-43d2-963e-8b92dba2615b,IP:10,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-INFO: VERSION:1.3.6,REQID:a5e7a100-3b33-43d2-963e-8b92dba2615b,IP:10,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:8ee2fa70695bee6b271dd2c43c576882,BulkI
	D:260204095359LKVTL8IS,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5ddff97c016c11f1b0f03b4cfa9209d1-20260204
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.200.196)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2065433284; Wed, 04 Feb 2026 09:53:56 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v5 2/3] blktrace: Make init_blk_tracer() asynchronous
Date: Wed,  4 Feb 2026 09:53:53 +0800
Message-Id: <20260204015353.163331-1-tianyaxiong@kylinos.cn>
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

The init_blk_tracer() function causes significant boot delay as it
waits for the trace_event_sem lock held by trace_event_update_all().
Specifically, its child function register_trace_event() requires
this lock, which is occupied for an extended period during boot.

To resolve this, the execution of primary init_blk_tracer() is moved
to the trace_init_wq workqueue, allowing it to run asynchronously,
and prevent blocking the main boot thread.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/trace/blktrace.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d031c8d80be4..d611cd1f02ef 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1832,7 +1832,9 @@ static struct trace_event trace_blk_event = {
 	.funcs		= &trace_blk_event_funcs,
 };
 
-static int __init init_blk_tracer(void)
+static struct work_struct blktrace_works __initdata;
+
+static int __init __init_blk_tracer(void)
 {
 	if (!register_trace_event(&trace_blk_event)) {
 		pr_warn("Warning: could not register block events\n");
@@ -1852,6 +1854,25 @@ static int __init init_blk_tracer(void)
 	return 0;
 }
 
+static void __init blktrace_works_func(struct work_struct *work)
+{
+	__init_blk_tracer();
+}
+
+static int __init init_blk_tracer(void)
+{
+	int ret = 0;
+
+	if (trace_init_wq) {
+		INIT_WORK(&blktrace_works, blktrace_works_func);
+		queue_work(trace_init_wq, &blktrace_works);
+	} else {
+		ret = __init_blk_tracer();
+	}
+
+	return ret;
+}
+
 device_initcall(init_blk_tracer);
 
 static int blk_trace_remove_queue(struct request_queue *q)
-- 
2.25.1

