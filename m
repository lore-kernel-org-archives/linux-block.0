Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805A7DA66;
	Mon, 26 Jan 2026 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769395421; cv=none; b=cQK1HBkhby8TKkT0FujcAwaGi72tv4tsGhvNrSs9IuXfzR+xkO8SrXM3xV/78FEvhBzOdOt7FBBITOiZbTUVpTiZjD7ng/uQlZEh0gHjuJGe6gKV4JVdTEc4Z0zYR8XzE5KCUDy9tEU1F1eZQG7YL8pOfsot5I4aut59ridc5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769395421; c=relaxed/simple;
	bh=1l7yt29Ik8g5nJiW6lmtDICUMJlfEgiDjCFUGw7mZDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZpAUUEf/mMRAKAjgBOVEo8CItkLCJGhSzbTgMWGC951PDfEp1/PpT3l/WPnrQ15mEW+ja4GTPEVFFMc9IGLMlT0eKKb6ctSsoQ/YiOxumwZk0MUXYz6RkXJyrCwU/vDQwY8PU/f5iRGUGOgdfogANA7s1IlplTMWkdVzAO2LSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cc8b0e2efa6011f0b0f03b4cfa9209d1-20260126
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
X-CID-O-INFO: VERSION:1.3.6,REQID:f5d8a836-423e-4815-84d0-db0a48a34133,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:f5d8a836-423e-4815-84d0-db0a48a34133,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:8497e752e683fcde637bed06aa353b8c,BulkI
	D:260126104333XKEST3MK,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cc8b0e2efa6011f0b0f03b4cfa9209d1-20260126
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(223.153.105.152)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1967147986; Mon, 26 Jan 2026 10:43:30 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rostedt@goodmis.org,
	axboe@kernel.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 2/3] tracing/kprobes: Make setup_boot_kprobe_events() asynchronous
Date: Mon, 26 Jan 2026 10:43:26 +0800
Message-Id: <20260126024326.297650-1-tianyaxiong@kylinos.cn>
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

During kernel boot, the setup_boot_kprobe_events() function causes
significant delays, increasing overall startup time.

The root cause is a lock contention chain: its child function
enable_boot_kprobe_events() requires the event_mutex, which is
already held by early_event_add_tracer(). early_event_add_tracer()
itself is blocked waiting for the trace_event_sem  read-write lock,
which is held for an extended period by trace_event_update_all().

To resolve this, we have moved the execution of
setup_boot_kprobe_events() to the trace_init_wq workqueue, allowing
it to run asynchronously.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/trace/trace_kprobe.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9953506370a5..4c6621f02696 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -2031,6 +2031,13 @@ static __init int init_kprobe_trace_early(void)
 }
 core_initcall(init_kprobe_trace_early);
 
+static struct work_struct kprobe_trace_work __initdata;
+
+static void __init kprobe_trace_works_func(struct work_struct *work)
+{
+	setup_boot_kprobe_events();
+}
+
 /* Make a tracefs interface for controlling probe points */
 static __init int init_kprobe_trace(void)
 {
@@ -2048,7 +2055,12 @@ static __init int init_kprobe_trace(void)
 	trace_create_file("kprobe_profile", TRACE_MODE_READ,
 			  NULL, NULL, &kprobe_profile_ops);
 
-	setup_boot_kprobe_events();
+	if (trace_init_wq) {
+		INIT_WORK(&kprobe_trace_work, kprobe_trace_works_func);
+		queue_work(trace_init_wq, &kprobe_trace_work);
+	} else {
+		setup_boot_kprobe_events();
+	}
 
 	return 0;
 }
-- 
2.25.1

