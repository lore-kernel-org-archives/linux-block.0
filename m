Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993D1E9B09;
	Fri, 11 Apr 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744356547; cv=none; b=srr7PujX4xSTQ1gwsqHf+86oJ+mW1xrJsnYJClyedt3F0/hCciAEJ6gWJdGomFj/f+mePQ5U+Y0j/mc9J+WOgaQ97/7zQizeIWZfVtUKOwSD1Ud/mzMTH18ZLvx/WkvFuHqN3y43WGsC+RcXcKutExVERSOC3WJWuUABO/jIJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744356547; c=relaxed/simple;
	bh=bDqGY1AtiCPNgiPrNANi8hsarVF01F4kRY7ffI9MP0k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AcygXVBrQmitGJNampK1QUkvUSEDs6I39PmMSpFoD8tFKLimHz0ba3h2j5PUMqNqq4dKw1c59p1JCI+fPH9S6zaB+aoF0nSmUgI0DPOD+atCnDfWC0ePGKA4TYojOvg+cefmb9xj7om21F+3TihMdTJlmTKRT8QWoFCF/SukUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 53B7T0gl066240;
	Fri, 11 Apr 2025 15:29:00 +0800 (+08)
	(envelope-from Yunlong.Xing@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 53B7SPXM062369;
	Fri, 11 Apr 2025 15:28:25 +0800 (+08)
	(envelope-from Yunlong.Xing@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4ZYpD85X3Gz2M5NG5;
	Fri, 11 Apr 2025 15:27:20 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 11 Apr 2025 15:28:21 +0800
From: Yunlong Xing <yunlong.xing@unisoc.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <niuzhiguo84@gmail.com>, <yunlongxing23@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yunlong.xing@unisoc.com>,
        <hao_hao.wang@unisoc.com>, <zhiguo.niu@unisoc.com>
Subject: [PATCH] loop: aio inherit the ioprio of original request
Date: Fri, 11 Apr 2025 15:28:16 +0800
Message-ID: <20250411072816.445035-1-yunlong.xing@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 53B7SPXM062369

Set cmd->iocb.ki_ioprio to the ioprio of loop device's request.
The purpose is to inherit the original request ioprio in the aio
flow.

Signed-off-by: Yunlong Xing <yunlong.xing@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 drivers/block/loop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 674527d770dc..ed73627af3ff 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -447,7 +447,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
-	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
 	if (rw == ITER_SOURCE)
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
@@ -1892,6 +1891,9 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	}
 
+	/* get original request ioprio */
+	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
+
 	/* always use the first bio's css */
 	cmd->blkcg_css = NULL;
 	cmd->memcg_css = NULL;
-- 
2.25.1

