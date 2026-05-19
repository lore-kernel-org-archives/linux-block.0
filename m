Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC316DC28;
	Tue, 19 May 2026 04:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779163279; cv=none; b=JewVV7yVJHDxfLuf1jH6U4kwp82SWVAJIu0f7dz1cslHe0qbNsrXzvqZ0l+pusTA7yMMDcJ2V+Ejn4wx29e5KQHnalkRwyl1+X5htTDvZDtQ9W8k6B2cLoxUXsQTlPU6a/6+pNqmZF3iGYX9npN7yf7qOnsBqwpihHETfMJO478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779163279; c=relaxed/simple;
	bh=FY1LqN/8VaT+J54WIssvrtQtrefJqWdF8up9cXtRg5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S8edPrIjYJN2AiCSV+QjofRtsc5m7DuJt0PnKAIAGAa41orhq5u7VP9RwJmuS5igpZgqUky5JAelHm7H7VkwPVMzsLjT9xo4VR9/ZeW/EbudbHtoJi62p1I/UDD5BCIBkgOqjNZGsm9WyybprvolJb9OEtbOwQb9lw/YNQwYCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5dc2987e533711f1aa26b74ffac11d73-20260519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d263ba50-83c5-4cc1-b0b9-c658d2e86f58,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:6c69d603481f712dce00ed18a6ddd3fa,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5dc2987e533711f1aa26b74ffac11d73-20260519
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2065298138; Tue, 19 May 2026 12:01:08 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: axboe@kernel.dk,
	ming.lei@canonical.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] block/loop: Fix NULL pointer dereference in lo_rw_aio()
Date: Tue, 19 May 2026 12:01:03 +0800
Message-Id: <20260519040103.22776-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lo->lo_backing_file can be NULL when the loop device is being cleared,
causing NULL pointer dereference in lo_rw_aio(). Add a defensive check
to prevent kernel crash.

Also fix loop_attr_backing_file_show() to use PTR_ERR_OR_ZERO()
for correct NULL pointer handling.

Fixes: bc07c10a3603a ("block: loop: support DIO & AIO")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/block/loop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..d8db1b0d8018 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -397,6 +397,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		cmd->iocb.ki_flags = 0;
 	}
 
+	if (!file)
+		return -EIO;
+
 	if (rw == ITER_SOURCE) {
 		kiocb_start_write(&cmd->iocb);
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
@@ -662,7 +665,7 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 	spin_unlock_irq(&lo->lo_lock);
 
 	if (IS_ERR_OR_NULL(p))
-		ret = PTR_ERR(p);
+		ret = PTR_ERR_OR_ZERO(p);
 	else {
 		ret = strlen(p);
 		memmove(buf, p, ret);
-- 
2.25.1

