Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7822324;
	Wed, 29 May 2024 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948025; cv=none; b=SkCQfImEihzqJNSLCkTi0s9uzQnk6MTSFIv6aBCQ/5fki0nqcXkM7/k6eC++z7xpN896TeSvSArxY+8l/Za1zAFFks+eWT0d9g9O/RaNO+3LcfnXP7scZKDR1yPArVkI92J5cnZB6HtmVQrxq3m4sNtlbu+kI9soRBH3xH69f64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948025; c=relaxed/simple;
	bh=MLY6d+dey32u/YtCdHWv2+v7aHSlG95uLNl6Wt1dpk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R2nFfjqu30tSIvDhrDaSO9YDARq/wAPapAdZQCsJdHw6fnXtCeO0b1626FzPSxG88gk8BLlpmj49gu9ACeppG3ko5UUBVsSH8rrb3OJyHp2rlO6xw+042RiUfxaDvXKt5IlDuCG4AwxbviMXtToGfNHejAOnnf1Dl/m+N8H35Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vpsyz12mZz4f3jcv;
	Wed, 29 May 2024 10:00:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6E2C01A01B9;
	Wed, 29 May 2024 10:00:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBEzjFZm5ofbNw--.62628S4;
	Wed, 29 May 2024 10:00:20 +0800 (CST)
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
Subject: [PATCH] ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()
Date: Wed, 29 May 2024 17:53:13 +0800
Message-Id: <20240529095313.2568595-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBEzjFZm5ofbNw--.62628S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3JF47uFyUKw18Kr4rZrb_yoW8tFyUpF
	W5Gw1Ykrs5tF4rZF4kA3srJryrJ3WrKry7WrZ3ZF1Fva98ArZxZ3y7Ca1YvFZ7GFyfWFyU
	AF4q934Ikw1UCF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE
	52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAV
	WUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAK
	I48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07
	xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRy
	89tUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

When two UBLK_CMD_START_USER_RECOVERY commands are submitted, the
first one sets 'ubq->ubq_daemon' to NULL, and the second one triggers
WARN in ublk_queue_reinit() and subsequently a NULL pointer dereference
issue.

Continuing execution after WARN is incorrect, as 'ubq->ubq_daemon' is
known to be NULL. Fix it by return directly if the WARN is triggered.

Note that WARN will still be triggered after the fix if anyone tries to
start recovery twice.

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
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4e159948c912..99b621b2d40f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2630,7 +2630,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 {
 	int i;
 
-	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
+	if (WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq))))
+		return;
 
 	/* All old ioucmds have to be completed */
 	ubq->nr_io_ready = 0;
-- 
2.39.2

