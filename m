Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C23DDDC1
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138980; cv=none; b=X8I9P4fSv04AsQP7k3/PVlAFQu7JPsTHHVl7+47CqzN4RTFaCgy2GHL6ggbQu9jnaU7esWu/unhBQh+qLgVRSBIp7J4gdTuZLcPMM+iQ1oBUBeckbk9OU8AdHYptN/jOVstGbUEhdqmnIKSBHxXTbEA1SEU/qnEv4Dd6TC1cvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138980; c=relaxed/simple;
	bh=grEP2HEEQorKCFQjveTTyc34+lGryggtvS2I8i6rolE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mh7/BmSaDyQm3n3xK8yIy95nKLQgwv9n4jZWYw1wgjM+Kt1oyDf0gtpC2HZqX3XEIjTpb2fWTUel3vFZ17ni9uTLO5/fZQnMa297FUq5jWVc6ShBBv0mqgs1hx+WH1jeqCMWsnIApZZl9TYCm6BqlvkKBPEvlofEm2sCPJs7poI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h7rVy0PyFzYQtwm
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 15:55:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5339B40573
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 15:56:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkUbD2dqjEJ1AA--.26468S7;
	Mon, 27 Jul 2026 15:56:15 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk,
	hch@lst.de,
	yukuai@kernel.org
Cc: yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	echo.chenlin@huawei.com,
	leo.lilong@huaweicloud.com,
	wangkefeng.wang@huawei.com,
	huawei.libin@huawei.com,
	leijitang@huawei.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v4 3/7] nbd: remove queue freeze in nbd_add_socket
Date: Mon, 27 Jul 2026 15:47:14 +0800
Message-ID: <20260727074718.414868-4-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727074718.414868-1-yangerkun@huawei.com>
References: <20260727074718.414868-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3pkUbD2dqjEJ1AA--.26468S7
X-Coremail-Antispam: 1UD129KBjvJXoWxArWkXr1DAr4UKr43JFW5KFg_yoW5Jw1fpr
	Z8Kay2kr4jgr4xuw4DAayDWF1rtw1fG34xG3yxJ3yj9rs8CFyFvayIva4rWa4UArykW3W7
	ZFW5GF1vyw1UurUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7IUbdMaUUUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

The function nbd_add_socket use krealloc to expand the config->socks
array when adding new sockets. If I/O operations concurrently, this can
lead to UAF when accessing config->socks. Commit b98e762e3d71 ("nbd:
freeze the queue while we're adding connections") addressed this by
freezing the request_queue during the addtion. However, freezing and
unfreezing for multiprocess environments introduces noticeable latency,
espically there can be multi call for nbd_add_socket when one nbd setup.

Actually, after previous commit, nbd_add_socket cannot be called
after nbd_start_device, causing the device's capabilities to remain 0
and write cache disabled. This will make sure no I/O can happened
simultaneously(nbd accept I/O from bio):

 - read/write bios with sectors are rejected by bio_check_eod in
   submit_bio_noacct
 - flush-only bio for write cache disabled device will directly return 0
   in submit_bio_noacct (ps: we cannot enable write_cache for nbd device
   since without BLK_FEAT_WRITE_CACHE)

Removing the freeze in nbd_add_socket to speed up nbd device startup.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7ec85f94f742..1a31e621b6f7 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1272,7 +1272,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	struct socket *sock;
 	struct nbd_sock **socks;
 	struct nbd_sock *nsock;
-	unsigned int memflags;
 	int err;
 
 	/* Arg will be cast to int, check it to avoid overflow */
@@ -1290,12 +1289,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 		return err;
 	nbd_reclassify_socket(sock);
 
-	/*
-	 * We need to make sure we don't get any errant requests while we're
-	 * reallocating the ->socks array.
-	 */
-	memflags = blk_mq_freeze_queue(nbd->disk->queue);
-
 	if (!netlink && !nbd->task_setup &&
 	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
 		nbd->task_setup = current;
@@ -1335,12 +1328,10 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
 	socks[config->num_connections++] = nsock;
 	atomic_inc(&config->live_connections);
-	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
 
 	return 0;
 
 put_socket:
-	blk_mq_unfreeze_queue(nbd->disk->queue, memflags);
 	sockfd_put(sock);
 	return err;
 }
-- 
2.52.0

