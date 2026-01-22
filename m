Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE2364021;
	Thu, 22 Jan 2026 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052068; cv=none; b=uNq8Qo+oZNTaTdqVXbzU3DiiW+FVKsn9m34DPZdUvPEdzRdNLZYlgbxwHUXzB5KP2yl2OQlNxxAB1fp9qZvIP7G/TZa4oV87kMb8JGDSlmfDJvxxS5/NuKZjvPgcLCbH3Kbh4dtaUx6cY3Ue60BgjK88AS/kPDp/IvEEhJEzD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052068; c=relaxed/simple;
	bh=Dg3xrbG19bmf7BvMEY5Oi5oo6yyTybta1g+N+AuC80I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pV+S+4VmcbRYaJFBKvv7Wt8CMH5qPDJ48IN0to8loRgGJn3OlcVL9YLJRj9uhuuDuz1ncbgOvu3Dd0R84Ai5NBns8mONTVk6SWk447o2uYmizdf0Pyqc8/n9dlZEbYvF6+Y4U3oZ1PDCO3JU5lwpYDWY7mjMdv5s1fda0+JmoMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c895adaf74111f0b0f03b4cfa9209d1-20260122
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ec27543e-0d6c-4838-9801-62110f39717f,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:ec27543e-0d6c-4838-9801-62110f39717f,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:9d064d2d8753d9b6baceed23da2edd8a,BulkI
	D:260122112056D80L1X2Q,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5c895adaf74111f0b0f03b4cfa9209d1-20260122
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(223.153.93.110)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1706183838; Thu, 22 Jan 2026 11:20:54 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: axboe@kernel.dk,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 0/3] Tracing: Accelerate Kernel Boot by Asynchronizing
Date: Thu, 22 Jan 2026 11:20:51 +0800
Message-Id: <20260122032051.386331-1-tianyaxiong@kylinos.cn>
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

To resolve this issue, I exported eval_map_wq and moved other
initialization functions under the tracing subsystem that are related
to this lock to run asynchronously on this workqueue. After this
optimization, boot time is reduced by approximately 200ms.

Yaxiong Tian (3):
  tracing: Export eval_map_wq for asynchronous use by other modules
  tracing/kprobes: Make setup_boot_kprobe_events() asynchronous
  blktrace: Make init_blk_tracer() asynchronous

 kernel/trace/blktrace.c     | 23 ++++++++++++++++++++++-
 kernel/trace/trace.c        |  2 +-
 kernel/trace/trace.h        |  2 ++
 kernel/trace/trace_kprobe.c | 14 +++++++++++++-
 4 files changed, 38 insertions(+), 3 deletions(-)

-- 
2.25.1

