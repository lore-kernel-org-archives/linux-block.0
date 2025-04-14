Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6189C17A31C;
	Mon, 14 Apr 2025 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744599790; cv=none; b=i8MYgNEsYSCoVcCGAnErk7F366FnaiPUl63ZbmXyY2ER6IQjwyrLoBiPe9JggIAh4D9TDqzhPE5Kql4uac92WQfVgJ3akggWdl9EI1FmX64kk68//APb39DXwWUQy1TS0r5oXbPiLv4ZZt49MHYB8cWUQ2oRp4Znt1QNm4DDVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744599790; c=relaxed/simple;
	bh=LKIFe5JPppNtFd1XjOtRi87X4iO2e9aUB6eXsxN/luA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MRyMPLMdqswBIzeuvhRb9IT/hXwhbybo3ggPcBlPPtJItJxMcWsbPYD3QijLSIcnpz8nzHG85HvpcDHLupiAwrVacBEgPWNhSPfQ07el4s69ngi0qeX+6Aj7bIr6RFihZMn/RiXwj9Tud8QLDMkjdFntv+9TkXCtMwOLI7mAEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 53E325NM013800;
	Mon, 14 Apr 2025 11:02:05 +0800 (+08)
	(envelope-from Yunlong.Xing@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4ZbX9M5Rf0z2LH777;
	Mon, 14 Apr 2025 11:00:55 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 14 Apr 2025 11:02:02 +0800
From: Yunlong Xing <yunlong.xing@unisoc.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <bvanassche@acm.org>
CC: <niuzhiguo84@gmail.com>, <yunlongxing23@gmail.com>,
        <linux-kernel@vger.kernel.org>, <hao_hao.wang@unisoc.com>,
        <zhiguo.niu@unisoc.com>
Subject: [PATCH V2] loop: aio inherit the ioprio of original request
Date: Mon, 14 Apr 2025 11:01:59 +0800
Message-ID: <20250414030159.501180-1-yunlong.xing@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 53E325NM013800

Set cmd->iocb.ki_ioprio to the ioprio of loop device's request.
The purpose is to inherit the original request ioprio in the aio
flow.

Signed-off-by: Yunlong Xing <yunlong.xing@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>=
---
V2:
- Assign cmd->iocb.ki_ioprio in lo_rw_aio()
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 674527d770dc..dd7f33d47f4f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -447,7 +447,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
-	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
 
 	if (rw == ITER_SOURCE)
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
-- 
2.25.1

