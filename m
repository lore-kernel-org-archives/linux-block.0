Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210A2E83F;
	Mon,  3 Jun 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397634; cv=none; b=ajy5UZ8WPuXMo50P22F0jCldCHxx3hXNT+oOBVdgr8L87YCaLKWSmUPYXbAfTtZvF03Sbl/kbUHFb1xjhp2zsNzwZl4a8BfMsQEWKkb0bRsR33909IG6+FQYYjdbtu0vTN7hiShQ+T270ubV0GZjNcGypactutixSWakBo8OI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397634; c=relaxed/simple;
	bh=PSpnKx1vqGSTY+XAOBgB8tYxuVovad6Oht5s6dBoYKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cxtDnaie7j/ZrXPt36HkrgpAYI9b9bJrZzO9zl5hoRGz0tp0ReUCIHJVn3JUzXYxNxgb64VZvBQLVFtlc88f1sz79b5bvoHjwfqucgN++2zHALp5CuY0ryygnOFd+DDCXYY+izgtUsHrwXxTunEUaG3ZuDiC9RY0UpJhu6WdoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vt4FJ41QDz4f3kkH;
	Mon,  3 Jun 2024 14:53:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C65B61A016E;
	Mon,  3 Jun 2024 14:53:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgDnpp53aF1ms5njOA--.30852S4;
	Mon, 03 Jun 2024 14:53:44 +0800 (CST)
From: linan666@huaweicloud.com
To: ming.lei@redhat.com,
	axboe@kernel.dk,
	ZiyangZhang@linux.alibaba.com
Cc: czhong@redhat.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2] ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()
Date: Mon,  3 Jun 2024 14:53:50 +0800
Message-Id: <20240603065350.1619493-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnpp53aF1ms5njOA--.30852S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3JF47uFyUKw18uFyxGrg_yoW8uFWDpF
	Z8Kw1DGrZ5tF4UZF4UtwsrJFy5G3WYkFy7Wws3Aa4F9asIyF9Iv3y3Ga1qgFW7GFWxCFyU
	ZF4Du34093WUGF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYuc_UUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

When two UBLK_CMD_START_USER_RECOVERY commands are submitted, the
first one sets 'ubq->ubq_daemon' to NULL, and the second one triggers
WARN in ublk_queue_reinit() and subsequently a NULL pointer dereference
issue.

Fix it by adding the check in ublk_ctrl_start_recovery() and return
immediately in case of zero 'ub->nr_queues_ready'.

  BUG: kernel NULL pointer dereference, address: 0000000000000028
  RIP: 0010:ublk_ctrl_start_recovery.constprop.0+0x82/0x180
  Call Trace:
   <TASK>
   ? __die+0x20/0x70
   ? page_fault_oops+0x75/0x170
   ? exc_page_fault+0x64/0x140
   ? asm_exc_page_fault+0x22/0x30
   ? ublk_ctrl_start_recovery.constprop.0+0x82/0x180
   ublk_ctrl_uring_cmd+0x4f7/0x6c0
   ? pick_next_task_idle+0x26/0x40
   io_uring_cmd+0x9a/0x1b0
   io_issue_sqe+0x193/0x3f0
   io_wq_submit_work+0x9b/0x390
   io_worker_handle_work+0x165/0x360
   io_wq_worker+0xcb/0x2f0
   ? finish_task_switch.isra.0+0x203/0x290
   ? finish_task_switch.isra.0+0x203/0x290
   ? __pfx_io_wq_worker+0x10/0x10
   ret_from_fork+0x2d/0x50
   ? __pfx_io_wq_worker+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Fixes: c732a852b419 ("ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support")
Reported-and-tested-by: Changhui Zhong <czhong@redhat.com>
Closes: https://lore.kernel.org/all/CAGVVp+UvLiS+bhNXV-h2icwX1dyybbYHeQUuH7RYqUvMQf6N3w@mail.gmail.com
Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
v2: add the check to ublk_ctrl_start_recovery().

 drivers/block/ublk_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4e159948c912..ebd997095b65 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2661,6 +2661,8 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	mutex_lock(&ub->mutex);
 	if (!ublk_can_use_recovery(ub))
 		goto out_unlock;
+	if (!ub->nr_queues_ready)
+		goto out_unlock;
 	/*
 	 * START_RECOVERY is only allowd after:
 	 *
-- 
2.39.2

