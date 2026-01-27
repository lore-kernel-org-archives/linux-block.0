Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACED199E94;
	Tue, 27 Jan 2026 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769476829; cv=none; b=o1HTIMfx3C8CCGzUrvaLILPZkTv+qqL0ZP7/LpqjPJmC0qMKnG9nDQQvJCk2kVo0uPjtTSlWxRSg6gjh6b9XBRiAfFqc0vDebh82hQDDUrYWp55K9HztcXUm6hZzH7DsLgnov7KyzT+xszjQXJTjAfiNmgJq+VXRty+DEaKfA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769476829; c=relaxed/simple;
	bh=8mfetCrZP74D2sqDqt7GC12sKjnAQMeRGv4/KWaUjw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VgS+X6oRpraDqS82C2bNEyFz2jzYUPT1R62vnkuT8EOwGBYfS+zS/I7NbN5tTbEDWMMIzBWMlpdChpWvUJ8q1GXRcsN3exDDJqVQVgWLXfxF7Jz2/4jOtuy0eee9jtagNlDK0ssshFMWJ9N+2b7ijKcotKwIWneQ5+C+yLt5XNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 58592c8efb1e11f0b0f03b4cfa9209d1-20260127
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
X-CID-O-INFO: VERSION:1.3.6,REQID:ed83315c-d473-40ae-b85c-320bd3b34dab,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:ed83315c-d473-40ae-b85c-320bd3b34dab,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:583654df13fc3f53443175fa62d85539,BulkI
	D:260127092020IZI2QH0M,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 58592c8efb1e11f0b0f03b4cfa9209d1-20260127
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.158.168)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 632687073; Tue, 27 Jan 2026 09:20:19 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rostedt@goodmis.org,
	axboe@kernel.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v3 0/3] Tracing: Accelerate Kernel Boot by Asynchronizing
Date: Tue, 27 Jan 2026 09:20:16 +0800
Message-Id: <20260127012016.76713-1-tianyaxiong@kylinos.cn>
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
other modules to be blocked either directly or indirectly.

To resolve this issue, I rename `eval_map_wq` and make it global and moved
other initialization functions under the tracing subsystem that are
related to this lock to run asynchronously on this workqueue. After this
optimization, boot time is reduced by approximately 200ms.

---
Changes in v2:
- Rename eval_map_wq to trace_init_wq.
Changes in v3:
- Opt PATCH 1/3 commit

Yaxiong Tian (3):
  tracing: Rename `eval_map_wq` and allow other parts of tracing use it
  tracing/kprobes: Make setup_boot_kprobe_events() asynchronous
  blktrace: Make init_blk_tracer() asynchronous

 kernel/trace/blktrace.c     | 23 ++++++++++++++++++++++-
 kernel/trace/trace.c        | 18 +++++++++---------
 kernel/trace/trace.h        |  2 ++
 kernel/trace/trace_kprobe.c | 14 +++++++++++++-
 4 files changed, 46 insertions(+), 11 deletions(-)

-- 
2.25.1

