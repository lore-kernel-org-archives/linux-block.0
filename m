Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF446143879;
	Wed, 14 Aug 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635603; cv=none; b=UmcHc61IKnEfmR784vCXjEEhte9sQwaICCjOdF+q9RrHQF3J0asuq6hJ6nOpQ4DatKpb4nFBqsuwE0vEZvKhLselr2TCQgjkZ/nffm3osINIjMy+MlzQKRAxaQhHfEwppfImkIXrdog0aYIc/ZjrIrL52gXJtaKrphgEeE2bCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635603; c=relaxed/simple;
	bh=btKu8VJ1jfYs9rI6c/X0Ble913oRKf3tSZDypJGz7K0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=atbJSLpj6KRbRAEvyBuHhg4zOBh3o0PiE+91ucqHs+VisI2XiG+lMXY9VCIExfiaBHOowiXXzeh62Wf26yvWaBZc04IMTfE5/wfb6qTUvySGP6JMmeio0BlOvHKI6UitrE9W3zYQMNJJlaHJnkLaNpc0tsve5DM2XoxoK4+FOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WkRB52J1xz4f3jd9;
	Wed, 14 Aug 2024 19:39:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 176B41A0A22;
	Wed, 14 Aug 2024 19:39:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBXfoSJl7xmeVisBg--.53651S4;
	Wed, 14 Aug 2024 19:39:54 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com,
	yukuai3@huawei.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH] block: Fix potential deadlock warning in blk_mq_mark_tag_wait
Date: Wed, 14 Aug 2024 19:35:42 +0800
Message-Id: <20240814113542.911023-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXfoSJl7xmeVisBg--.53651S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1DJF13KFWrJF48tryfXrb_yoW8Ary5pF
	WUGa15Kw48XryjqF4DKa9Fqr4I9anYgr4UJrs3Z3WfAr1Ykry3Wr18Ar1vvF40gFs7ArsF
	vr4UtrWFyF4DC37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUpwZcUUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

When interrupt is turned on while a lock holding by spin_lock_irq it
throws a warning because of potential deadlock.

blk_mq_mark_tag_wait
 spin_lock_irq(&wq->lock)
      --> turn off interrupt and get lockA
 blk_mq_get_driver_tag
  __blk_mq_tag_busy
   spin_lock_irq(&tags->lock)
   spin_unlock_irq(&tags->lock)
      --> release lockB and turn on interrupt accidentally
...
  --> Interrupt may be triggered and try get wq->lock while it is held
                                           blk_complete_reqs
                                            ...
                                            blk_mq_put_tag
                                             ...
                                             __wake_up_common_lock
                                              spin_lock_irqsave
                                              --> try get lock again
...
 spin_unlock_irq(&wq->lock)

Fix it by using spin_lock_irqsave to get lockB instead of spin_lock_irq.
Fixes: 4f1731df60f9 ("blk-mq: fix potential io hang by wrong 'wake_batch'")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 block/blk-mq-tag.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..2cafcf11ee8b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -38,6 +38,7 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
 void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned int users;
+	unsigned long flags;
 	struct blk_mq_tags *tags = hctx->tags;
 
 	/*
@@ -56,11 +57,11 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 			return;
 	}
 
-	spin_lock_irq(&tags->lock);
+	spin_lock_irqsave(&tags->lock, flags);
 	users = tags->active_queues + 1;
 	WRITE_ONCE(tags->active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
-	spin_unlock_irq(&tags->lock);
+	spin_unlock_irqrestore(&tags->lock, flags);
 }
 
 /*
-- 
2.31.1

