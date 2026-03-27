Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97125EFBE;
	Fri, 27 Mar 2026 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603459; cv=none; b=U4seKdFTXSUIQOBcFMr9ZNDLfM6V5wiG7lUmmnOeRdUlhNkaHxFcd39N+1j3JJbQmjt7R68IC1gTEB5EKS9OFz/Z3yn5H8a2FhJQX0zQgyIsfCMXTe2dWHDyoqODaIIO0INOZ/xPhfCcvdFn7SBetPm7YOCXzLjo+k1bP5jMsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603459; c=relaxed/simple;
	bh=UCisZ4qEhhpNY8uzul2+Xkm4y2bCuPqQmPEJxuXiDuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CeuSHWBMc91gEj7oJj3eHnwQGoX/V3hrInPfovcgjSGDkyOGgt7QTCfImeCwLFWxxhganW2eS9/JiEaFg9OLsKEVlChbVHwQxBDmsSl6mhloSP9dVoXqR+z1FWLPgQvJ6maUcrg2IAYyluMLfE6R3Hz6viM4dP9Zb0vo8s/Vdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fhwFC6gLYzYQvDQ;
	Fri, 27 Mar 2026 17:23:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 706D140573;
	Fri, 27 Mar 2026 17:24:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP1 (Coremail) with SMTP id cCh0CgAHC9uyTMZpTlaWCQ--.27625S8;
	Fri, 27 Mar 2026 17:24:13 +0800 (CST)
From: leo.lilong@huaweicloud.com
To: josef@toxicpanda.com,
	axboe@kernel.dk
Cc: leo.lilong@huawei.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lonuxli.64@gmail.com
Subject: [PATCH 4/4] nbd: remove queue freeze in nbd_add_socket
Date: Fri, 27 Mar 2026 17:12:23 +0800
Message-Id: <20260327091223.4147956-5-leo.lilong@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260327091223.4147956-1-leo.lilong@huaweicloud.com>
References: <20260327091223.4147956-1-leo.lilong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHC9uyTMZpTlaWCQ--.27625S8
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWxuryUtw4DCw48Ww1xZrb_yoW8ArWfpF
	WDCay7GrWUKF4UurW0ya97WFyfKws7K347KayxJa40vrZ8CFySvFyIya4rWrWrtrykZF17
	Zay5KF4vk3WUGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_JF
	0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwID7UUUU
	U
X-CM-SenderInfo: hohrhzxlor0w46kxt4xhlfz01xgou0bp/

From: Long Li <leo.lilong@huawei.com>

The queue freeze was originally needed to prevent concurrent requests
from accessing config->socks while the backing array was being
reallocated. Since config->socks is now an xarray, insertions are
safe under RCU without freezing the queue.

This significantly reduces connection setup time when using a large
number of connections (-C 256):

  before: real 4.510s
  after:  real 0.263s

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 drivers/block/nbd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1606cdaa868d..24aa65c723af 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1263,7 +1263,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	struct nbd_config *config = nbd->config;
 	struct socket *sock;
 	struct nbd_sock *nsock;
-	unsigned int memflags;
 	unsigned int index;
 	int err;
 
@@ -1274,12 +1273,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	if (!sock)
 		return err;
 
-	/*
-	 * We need to make sure we don't get any errant requests while we're
-	 * reallocating the ->socks array.
-	 */
-	memflags = blk_mq_freeze_queue(nbd->disk->queue);
-
 	if (!netlink && !nbd->task_setup &&
 	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
 		nbd->task_setup = current;
@@ -1316,12 +1309,10 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 
 	config->num_connections++;
 	atomic_inc(&config->live_connections);
-	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
 
 	return 0;
 
 put_socket:
-	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
 	sockfd_put(sock);
 	return err;
 }
-- 
2.39.2

