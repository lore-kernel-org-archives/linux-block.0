Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839E2459C5;
	Tue, 19 May 2026 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177050; cv=none; b=AdncQa6olcO2fCIfQ4a9gD3eswP23eaRFKYOcH34rs9w9i76yYYk7nLpnwdYO/5mVAZGs/F562DZpx+PIxJtzfVznaSQ4oHj7F5bI8CoHPMtuoyayUefxQiPQUaUi+uHvUt2JqF1/7jJ370d+xyz4R5lB2AixvIFl+hJ3XhHuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177050; c=relaxed/simple;
	bh=ZVSoKWNwE/fLrAe2TbSPmVg6n/BxsyChM0yaAKsjfSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Av9gxFxdacGZT1nxSGkAsoCWPA4wRXf1JOm5OSeDysyP68Uaqte01S+aaM6eioIqCgelradZR7hUkc3dcvK8j+8IvbPLCvz6xCYBicJyf4qN+HQ9OHdxp9mYCBH2axgaC57+7UEcajpzg71zyREkVv1k2vuhB1CzI/24KVVxa0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6fdce3e6535711f1aa26b74ffac11d73-20260519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:360fb4f9-0ad2-4757-8f04-d62136ed362a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:2c59e22560394ab4418eebe409e8ad69,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6fdce3e6535711f1aa26b74ffac11d73-20260519
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1430405130; Tue, 19 May 2026 15:50:42 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH] tracing/blktrace: Use sysfs_emit() for sysfs show callbacks
Date: Tue, 19 May 2026 15:50:12 +0800
Message-Id: <20260519075012.3859119-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use sysfs_emit() and sysfs_emit_at() instead of sprintf() when
formatting blktrace sysfs show output.

No functional change intended.

Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 kernel/trace/blktrace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99e..1eda8158883ca 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2025,11 +2025,11 @@ static ssize_t blk_trace_mask2str(char *buf, int mask)
 
 	for (i = 0; i < ARRAY_SIZE(mask_maps); i++) {
 		if (mask & mask_maps[i].mask) {
-			p += sprintf(p, "%s%s",
+			p += sysfs_emit_at(buf, p - buf, "%s%s",
 				    (p == buf) ? "" : ",", mask_maps[i].str);
 		}
 	}
-	*p++ = '\n';
+	p += sysfs_emit_at(buf, p - buf, "\n");
 
 	return p - buf;
 }
@@ -2048,20 +2048,20 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 	bt = rcu_dereference_protected(q->blk_trace,
 				       lockdep_is_held(&q->debugfs_mutex));
 	if (attr == &dev_attr_enable) {
-		ret = sprintf(buf, "%u\n", !!bt);
+		ret = sysfs_emit(buf, "%u\n", !!bt);
 		goto out_unlock_bdev;
 	}
 
 	if (bt == NULL)
-		ret = sprintf(buf, "disabled\n");
+		ret = sysfs_emit(buf, "disabled\n");
 	else if (attr == &dev_attr_act_mask)
 		ret = blk_trace_mask2str(buf, bt->act_mask);
 	else if (attr == &dev_attr_pid)
-		ret = sprintf(buf, "%u\n", bt->pid);
+		ret = sysfs_emit(buf, "%u\n", bt->pid);
 	else if (attr == &dev_attr_start_lba)
-		ret = sprintf(buf, "%llu\n", bt->start_lba);
+		ret = sysfs_emit(buf, "%llu\n", bt->start_lba);
 	else if (attr == &dev_attr_end_lba)
-		ret = sprintf(buf, "%llu\n", bt->end_lba);
+		ret = sysfs_emit(buf, "%llu\n", bt->end_lba);
 
 out_unlock_bdev:
 	blk_debugfs_unlock_nomemrestore(q);
-- 
2.43.0

