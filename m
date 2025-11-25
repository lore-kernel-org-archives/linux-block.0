Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA22D0C72;
	Tue, 25 Nov 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059105; cv=none; b=eBt9lQkOYt0yBmArCi1WJUyXoXmBBTiEnza/w0PQt3Ct1kdv7YTrjSmZB2I/ealZKukYTh5xH8U7oPdJLE2qDKPS6rOTfGGThWTPd+y7TWmrVbtJ7aYRUBFqDrYUM2z7mDM18W/8B1HNi2lAIUklX1ELrgvTSPUIctJeYVdBhcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059105; c=relaxed/simple;
	bh=WjWUop7wo31rq07vxZFU+4o/C827wYh9UG5FmOtvBBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PbbGkjXPdwDn/JjEWiPqWZBu5+NH4dDPSgucnJG+p4n5odWq20wXZQariGEw0+SS91WIvRhq2cMyP3MRuVsarGw8pQP7IAqWj7XYqE5zNPpHxpIk1z+aJrZIc0SkA3Z8saNQ94WB3ol6ZwGIuTC6HY29lF9Kfxriu+bYYwa8l8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3860cf3ac9d811f0a38c85956e01ac42-20251125
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c03fc337-4191-4a23-a419-374f96124bb4,IP:15,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:10
X-CID-INFO: VERSION:1.3.6,REQID:c03fc337-4191-4a23-a419-374f96124bb4,IP:15,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-META: VersionHash:a9d874c,CLOUDID:df33ac9e34ad3034b42937c3710d1dcc,BulkI
	D:251125162454FMCX036Y,BulkQuantity:0,Recheck:0,SF:10|66|78|102|127|850|89
	8,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3860cf3ac9d811f0a38c85956e01ac42-20251125
X-User: hehuiwen@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <hehuiwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1774961297; Tue, 25 Nov 2025 16:24:54 +0800
From: Huiwen He <hehuiwen@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Huiwen He <hehuiwen@kylinos.cn>
Subject: [PATCH] blk-trace: Fix potential buffer overflow in blk_trace_setup()
Date: Tue, 25 Nov 2025 16:24:20 +0800
Message-Id: <20251125082420.856030-1-hehuiwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy struct blk_user_trace_setup has a 32-byte name field,
while buts2->name is a 64-byte buffer (BLKTRACE_BDEV_SIZE2).

Since commit 113cbd62824a ("blktrace: pass blk_user_trace2 to setup
functions"), blk_trace_setup() copied buts2->name into buts->name
using strcpy(). strcpy() performs no bounds checking on the destination
buffer, which can overflow if the source string exceeds 31 characters.

Replace deprecated [1] strcpy() with strscpy() to ensure proper bounds
checking and prevent potential buffer overflow.

Link: https://github.com/KSPP/linux/issues/88 [1]

Fixes: 113cbd62824a ("blktrace: pass blk_user_trace2 to setup functions")
Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d031c8d80be4..50460e2e7212 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -793,7 +793,7 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		return PTR_ERR(bt);
 	}
 	blk_trace_setup_finalize(q, name, 1, bt, &buts2);
-	strcpy(buts.name, buts2.name);
+	strscpy(buts.name, buts2.name);
 	mutex_unlock(&q->debugfs_mutex);
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
-- 
2.25.1

