Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6934FF59;
	Wed, 28 Jan 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604921; cv=none; b=sdq1XKHXZunSDV1ImO+OynF9eJ4jEsFJJ8duoJKuKuQOig3IM1sGMk1DkYpUtlRSQW96rcz39iraJ2kW30KqBvVh/BV6j8NwalokMVJBDeoioPfUROgOgtU/KSNf6tfQ9D+MguPCkw/ErPuyDNcDuo5dEMzUvFli8/MuqpDneNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604921; c=relaxed/simple;
	bh=nvx0pzDMUCUQRnDLUIB4oTe85CB/B2famYO/awEkHsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z+uN7ZkZBqqro4jZqZUuqdZbkPv95jVs+xHz4G5fObp1GjKcn7QFx3ycVpiHZsgPKxeGOGBQ7zQuXL9wIOvP3EILaeqXQxNWJQe1A+/A4iTR0Ft2KEs+8KPj1n1y9sjTj6aPjgGn+fjFmM9+uBxKshQR3KNM88/qqHQNePFgixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9448c030fc4811f0b0f03b4cfa9209d1-20260128
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
X-CID-O-INFO: VERSION:1.3.6,REQID:168305d2-bc71-444d-a98e-7baeb28e2e6f,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:168305d2-bc71-444d-a98e-7baeb28e2e6f,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:232bfff06d43625ae7096e50e9305987,BulkI
	D:2601282055117T6T78JL,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9448c030fc4811f0b0f03b4cfa9209d1-20260128
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.149.138)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 339552490; Wed, 28 Jan 2026 20:55:10 +0800
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
Subject: [PATCH v4 3/5] tracing/kprobes: Skip setup_boot_kprobe_events() when no cmdline event
Date: Wed, 28 Jan 2026 20:55:07 +0800
Message-Id: <20260128125507.1715149-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260128125117.1704853-1-tianyaxiong@kylinos.cn>
References: <20260128125117.1704853-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the 'kprobe_event=' kernel command-line parameter is not provided,
there is no need to execute setup_boot_kprobe_events().

This change optimizes the initialization function init_kprobe_trace()
by skipping unnecessary work and effectively prevents potential blocking
that could arise from contention on the event_mutex lock in subsequent
operations.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 kernel/trace/trace_kprobe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9953506370a5..89d2740f7bb5 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -2048,6 +2048,10 @@ static __init int init_kprobe_trace(void)
 	trace_create_file("kprobe_profile", TRACE_MODE_READ,
 			  NULL, NULL, &kprobe_profile_ops);
 
+	/* If no 'kprobe_event=' cmd is provided, return directly. */
+	if (kprobe_boot_events_buf[0] == '\0')
+		return 0;
+
 	setup_boot_kprobe_events();
 
 	return 0;
-- 
2.25.1

