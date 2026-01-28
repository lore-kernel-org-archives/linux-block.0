Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37C1DE2AD;
	Wed, 28 Jan 2026 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604705; cv=none; b=XWmVzUxxaxrd8mJdl0YOJrMAZn1C3zG53oJ7skt0GyTLgsSwc8Xn96kVlLFbLAfUIPrP/ICTHrKgolpF8mXDPt5y50THckmxdlt2lxbuOCIl16Gt0CMDDnRKTtfiC4qNxFiiBHpqCcopnHiB+xn0yi0SAVScmkSYm40PPKweAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604705; c=relaxed/simple;
	bh=VfeSfNy9tmSOGhyx/aNm4BRVYjFdieR57cjNXNADOAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jI8Z29v15dCqNO8leFVNLHdMJDS20pGu9/j0BmD3OEEDTfGhxEGSFJtqgBAqFgXBprkYLFxkSht4I91dQ6D7rgXDBw7/vDkdcFnSG27lFpZVrntWDbIexeKXMmQkNrR/ksFp0gjtCY9efILxiU32N4YOSAuTlh1Mv/TRhL52pJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1251b942fc4811f0b0f03b4cfa9209d1-20260128
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
X-CID-O-INFO: VERSION:1.3.6,REQID:a70827dc-b6c5-4361-bdbe-a8f4e1ad788a,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:a70827dc-b6c5-4361-bdbe-a8f4e1ad788a,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:ae0ae57303552be8df558628df9162d0,BulkI
	D:260128205135MNOENJBZ,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1251b942fc4811f0b0f03b4cfa9209d1-20260128
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.149.138)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1134550984; Wed, 28 Jan 2026 20:51:32 +0800
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
Subject: [PATCH v4 0/5] Tracing: Accelerate Kernel Boot by Asynchronizing
Date: Wed, 28 Jan 2026 20:51:17 +0800
Message-Id: <20260128125117.1704853-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On my ARM64 platform, I observed that certain tracing module
initializations run for up to 200ms—for example, init_kprobe_trace().
Analysis reveals the root cause: the execution flow eval_map_work_func()
→trace_event_update_with_eval_map()→trace_event_update_all()
is highly time-consuming. Although this flow is placed in eval_map_wq
for asynchronous execution, it holds the trace_event_sem lock, causing
other modules to be blocked either directly or indirectly. Also in
init_blk_tracer(), this functions require trace_event_sem device_initcall.

To resolve this issue, I rename `eval_map_wq` and make it global and moved
other initialization functions under the tracing subsystem that are
related to this lock to run asynchronously on this workqueue. After this
optimization, boot time is reduced by approximately 200ms.

Given that asynchronous initialization makes it indeterminate when tracing
will begin, we introduce the trace_async_init kernel parameter.Asynchronous
behavior is enabled only when this parameter is explicitly provided.

Based on my analysis and testing, I've identified that only these two
locations significantly impact timing. Other initcall_* functions do not
exhibit relevant lock contention.

A brief summary of the test results is as follows:
Before this PATCHS:
[    0.224933] calling  init_kprobe_trace+0x0/0xe0 @ 1
[    0.455016] initcall init_kprobe_trace+0x0/0xe0 returned 0 after 230080 usecs

Only opt setup_boot_kprobe_events() can see:
[    0.258609] calling  init_blk_tracer+0x0/0x68 @ 1
[    0.454991] initcall init_blk_tracer+0x0/0x68 returned 0 after 196377 usecs

After this PATCHS:
[    0.224940] calling  init_kprobe_trace+0x0/0xe0 @ 1
[    0.224946] initcall init_kprobe_trace+0x0/0xe0 returned 0 after 3 usecs
skip --------
[    0.264835] calling  init_blk_tracer+0x0/0x68 @ 1
[    0.264841] initcall init_blk_tracer+0x0/0x68 returned 0 after 2 usecs

---
Changes in v2:
- Rename eval_map_wq to trace_init_wq.
Changes in v3:
- Opt PATCH 1/3 commit
Changes in v4:
- add trace_async_init boot parameter in patch2
- add init_kprobe_trace's skip logic in patch3
- add Suggested-by tag 
- Other synchronous optimizations related to trace_async_init

Yaxiong Tian (5):
  tracing: Rename `eval_map_wq` and allow other parts of tracing use it
  tracing: add trace_async_init boot parameter
  tracing/kprobes: Skip setup_boot_kprobe_events() when no cmdline event
  tracing/kprobes: Make setup_boot_kprobe_events() asynchronous when
    trace_async_init set
  blktrace: Make init_blk_tracer() asynchronous when trace_async_init
    set

 .../admin-guide/kernel-parameters.txt         |  8 ++++++
 kernel/trace/blktrace.c                       | 23 +++++++++++++++-
 kernel/trace/trace.c                          | 27 ++++++++++++-------
 kernel/trace/trace.h                          |  2 ++
 kernel/trace/trace_kprobe.c                   | 18 ++++++++++++-
 5 files changed, 67 insertions(+), 11 deletions(-)

-- 
2.25.1

