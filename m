Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAAA524D7;
	Wed, 22 May 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366008; cv=none; b=WnA8eopRnmozFoKNGWieHG4Q0CIczyU1+onNXe0O65btowEpACc9EC1zg3xrrAj7t0tpjx02ngSCk8pgSm/cRSRnjYKSGJxe2esCuKenAmBWUMTaXVbCrJleyFOrhF9WbwrqfntSACN4MUPE3DxnVLTEMQ2lfc0GqxoMpsE6+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366008; c=relaxed/simple;
	bh=O9Sp924WkGSr0BtgRunOXnOH4VOLkaCkXQizxmQia+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PllNhzFB5aQm/99x/9KWx0Hb5FPJbPrOD6BmuJdLcWh6thWBKCGPIaK5xs7lQpCNmW7eiLN8zg2lCDV30grqZvt4b1FbtcpT3KwqUhaLU2PzMkn5KipGCLsO3zqTduCv8vI3Yq7CpHJl7eVSpQfgW8bXM6lYZyMnw8dOBXN5GqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 44M7n0Jw013913;
	Wed, 22 May 2024 15:49:00 +0800 (+08)
	(envelope-from Yunlong.Xing@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44M7maIC012784;
	Wed, 22 May 2024 15:48:36 +0800 (+08)
	(envelope-from Yunlong.Xing@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Vkjy76cltz2Pp6xc;
	Wed, 22 May 2024 15:45:03 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 22 May 2024 15:48:34 +0800
From: Yunlong Xing <yunlong.xing@unisoc.com>
To: <axboe@kernel.dk>, <yunlongxing23@gmail.com>, <niuzhiguo84@gmail.com>,
        <Hao_hao.Wang@unisoc.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] loop: inherit the ioprio in loop woker thread
Date: Wed, 22 May 2024 15:48:29 +0800
Message-ID: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 44M7maIC012784

The loop worker thread only inherit the blkcg of original request,
but does not inherit it's ioprio. So, when a task with the high
ioprio but in root blkcg accesses the loop device, the worker
thread handle this cmd with a normal ioprio. This results in the
request of high ioprio task doesn't be prioritized.

Signed-off-by: Yunlong Xing <yunlong.xing@unisoc.com>
---
 drivers/block/loop.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28a95fd366fe..404ac113c71b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -442,7 +442,6 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
-	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
 	if (rw == ITER_SOURCE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
@@ -1856,6 +1855,9 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	}
 
+	/* get request's ioprio */
+	cmd->iocb.ki_ioprio = rq->ioprio;
+
 	/* always use the first bio's css */
 	cmd->blkcg_css = NULL;
 	cmd->memcg_css = NULL;
@@ -1886,12 +1888,18 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 	int ret = 0;
 	struct mem_cgroup *old_memcg = NULL;
 	const bool use_aio = cmd->use_aio;
+	int ori_ioprio = 0;
+	int cmd_ioprio = cmd->iocb.ki_ioprio;
 
 	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
 		ret = -EIO;
 		goto failed;
 	}
 
+	ori_ioprio = get_current_ioprio();
+	if (ori_ioprio != cmd_ioprio)
+		set_task_ioprio(current, cmd_ioprio);
+
 	if (cmd_blkcg_css)
 		kthread_associate_blkcg(cmd_blkcg_css);
 	if (cmd_memcg_css)
@@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 		set_active_memcg(old_memcg);
 		css_put(cmd_memcg_css);
 	}
+
+	if (ori_ioprio != cmd_ioprio)
+		set_task_ioprio(current, ori_ioprio);
+
  failed:
 	/* complete non-aio request */
 	if (!use_aio || ret) {
-- 
2.25.1

