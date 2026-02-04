Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76C5C613;
	Wed,  4 Feb 2026 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770169876; cv=none; b=owoOpX5ryVQr6cHQ6Vj4w8QUlPLBJV5hXgMRkswQSFoYq9G+RJSWgqzFjiIhUDpTrbVJ3hxql6grszBiN2i/Q8d0HXpMxJiP1mfUzbtFCaxq6G577Qh0BJ0rDfFOjmEbpb13iMconBEQpwAL1InpmQn1oafEHofgzkzgO4toJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770169876; c=relaxed/simple;
	bh=54nwdJRmftDSGK0lCm3lrX2k3J78MlTyT329CzMp2Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YTFKi/Z25ohml/rlRbH8B2xOsWDtwoRP9xMSjZ4J2EQv9ujLdsV9y6plbfcpnRgzm4xQIrifRHMK6CYB7VBlUNPgAgGKdAPReYQcKYsSiehbBLih9+5b+lXG+wPNkLrTyon6WcqwnxVLQQ2EHC+lyfdpgTdvnp8zADFDfzF8W5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f8a8e19a016b11f1b0f03b4cfa9209d1-20260204
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:24f3f15d-5d49-433d-801c-db0ec77c720a,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:24f3f15d-5d49-433d-801c-db0ec77c720a,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:2ebec4dce1fb8c1c7111b5ccc247beaa,BulkI
	D:260204095108O8I9T427,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f8a8e19a016b11f1b0f03b4cfa9209d1-20260204
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.200.196)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 851231154; Wed, 04 Feb 2026 09:51:07 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v5 0/3] Tracing: Accelerate Kernel Boot by Asynchronizing
Date: Wed,  4 Feb 2026 09:51:03 +0800
Message-Id: <20260204015103.155025-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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
init_blk_tracer that are related to this lock to run asynchronously on this
workqueue. Also check for kprobe_event= grub parameter; if not provided,
init_kprobe_trace() returns directly. After optimization, boot time is
reduced by approximately 200ms.


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
https://lore.kernel.org/all/20260128125117.1704853-1-tianyaxiong@kylinos.cn/
Changes in v5:
- remove trace_async_init boot parameter (patch2 v4)
- remove make  Make setup_boot_kprobe_events() asynchronous (patch4 v4)
- Adjusted the patch sequence.


Yaxiong Tian (3):
  tracing: Rename `eval_map_wq` and allow other parts of tracing use it
  blktrace: Make init_blk_tracer() asynchronous
  tracing/kprobes: Skip setup_boot_kprobe_events() when no cmdline event

 kernel/trace/blktrace.c     | 23 ++++++++++++++++++++++-
 kernel/trace/trace.c        | 18 +++++++++---------
 kernel/trace/trace.h        |  1 +
 kernel/trace/trace_kprobe.c |  4 ++++
 4 files changed, 36 insertions(+), 10 deletions(-)

-- 
2.25.1

