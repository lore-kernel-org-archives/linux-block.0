Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950C350A3B;
	Wed, 28 Jan 2026 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604908; cv=none; b=cXVa7HkBGiR6HhgU5VL7okS8LRkhNwDDonEAF8WxbKTHd0mi06bkheXhUsx0A/G6W5U/gvRuvuujKqBp9/vmxSf3JiIsOruso/Tv4TepRz0z6Xz4N7R0dQVyDhZfiKDyObVfgl+uqjyQx4JbNRxmUU6p9zB7nyfKK+g3u76xvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604908; c=relaxed/simple;
	bh=u9s4Zh7bGHBx/TNk9+6VMEO/0lMdaa8WI35PIY7T4Uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=or9HZZHUAQtfviHBBpdFYV5LVePGmud8yLn62LiokuwhSsHTdkfCatZzANVgE7kBGEgfcAc+ypXNgiUuM+jIwBd/DkZkJwP3M/8OlQjOOfEvjMSGOFmMHzSg7ViKsxYN4YrrWCI0owZYu5YBAUtp0vCdoLhQj08QXtZkeFxdG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8be6e48afc4811f0b0f03b4cfa9209d1-20260128
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a3bf609d-aa25-4953-b91c-91bb7fbcfcfe,IP:10,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-45
X-CID-INFO: VERSION:1.3.6,REQID:a3bf609d-aa25-4953-b91c-91bb7fbcfcfe,IP:10,URL
	:0,TC:0,Content:-25,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,AC
	TION:release,TS:-45
X-CID-META: VersionHash:a9d874c,CLOUDID:3a6db0938442dd24d7d66b8726d0fb8c,BulkI
	D:260128205459GMRIXNBL,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8be6e48afc4811f0b0f03b4cfa9209d1-20260128
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.149.138)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1348324856; Wed, 28 Jan 2026 20:54:56 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: mhiramat@kernel.org,
	rostedt@goodmis.org,
	axboe@kernel.dk,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v4 2/5] tracing: add trace_async_init boot parameter
Date: Wed, 28 Jan 2026 20:54:21 +0800
Message-Id: <20260128125421.1713134-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260128125117.1704853-1-tianyaxiong@kylinos.cn>
References: <20260128125117.1704853-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some users prioritize faster kernel boot time. However, the tracing
subsystem, being a critical infrastructure, traditionally initializes
serially. To balance the need for deterministic timing in tracing
against the demand for quicker startup, the trace_async_init boot
parameter is introduced.

When users do not require strict timing determinism for trace
features—or do not use tracing at all during boot—they can add this
cmdline parameter to accelerate kernel startup.

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 kernel/trace/trace.c                            | 9 +++++++++
 kernel/trace/trace.h                            | 1 +
 3 files changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6b3460701910..d46fdfbfa961 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7851,6 +7851,14 @@ Kernel parameters
 			This option can also be set at run time via the sysctl
 			option:  kernel/traceoff_on_warning
 
+	trace_async_init
+			[FTRACE] Enable this option when faster boot time is the
+			priority. It is beneficial in scenarios where users either
+			do not require a strict initialization order for certain
+			tracing features during boot, or do not use tracing at all
+			in the early boot phase. This can lead to measurable
+			improvements in kernel startup speed.
+
 	transparent_hugepage=
 			[KNL]
 			Format: [always|madvise|never]
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 01df88e77818..9d571841fc84 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1725,6 +1725,15 @@ static int __init set_tracing_thresh(char *str)
 }
 __setup("tracing_thresh=", set_tracing_thresh);
 
+bool trace_async_init __initdata;
+
+static int __init setup_trace_async_init(char *str)
+{
+	trace_async_init = true;
+	return 1;
+}
+__setup("trace_async_init", setup_trace_async_init);
+
 unsigned long nsecs_to_usecs(unsigned long nsecs)
 {
 	return nsecs / 1000;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9e8d52503618..63ae83d7bd1c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -769,6 +769,7 @@ extern cpumask_var_t __read_mostly tracing_buffer_mask;
 extern unsigned long nsecs_to_usecs(unsigned long nsecs);
 
 extern unsigned long tracing_thresh;
+extern bool trace_async_init __initdata;
 extern struct workqueue_struct *trace_init_wq __initdata;
 
 /* PID filtering */
-- 
2.25.1

