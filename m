Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB507368D4C
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926307; cv=none; b=U/cZ7t17m0VEuhHTvjiDm/uv9PBpSGfXqdM7TeSaq9o63NWAq45DxOOsnNjY2uvywvXcfytntWhd9h3yKHt6Dj10AXLsqF6tLkypdLI8+iidJ2OAe7qumecHuAJQBO2fA9WbQ0jPVMmF0VZUcLlVVuJea2GfaQc7wSQFtmgwNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926307; c=relaxed/simple;
	bh=zFJt1so5nbTWf1dqIhfEut7PV5CrUvlNOhEbC2OMwu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYbo1i0jTAB8pQED/EXPpLwUalGt7DfMNEyPcDXDOxQob5pY1JfchpG9IPK7j0jBW35wxM+ZHLE0AD9J1XUnogJEm19UsgtB01IYPSJcKBF92KmoEJJjoiG5H+HYs6BpAcn7NSzavzmhrgvwa4Y/p7LUeSWAOq9UGvEZEp7qPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gzD2N2sD5zKHMPN
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 191594058D
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgD3B3QQjlRq9dc7BA--.38720S7;
	Mon, 13 Jul 2026 15:04:56 +0800 (CST)
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
	yangerkun@huawei.com,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH v3 3/6] nbd: remove queue freeze in nbd_add_socket
Date: Mon, 13 Jul 2026 14:56:41 +0800
Message-ID: <20260713065644.1637594-4-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260713065644.1637594-1-yangerkun@huawei.com>
References: <20260713065644.1637594-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3B3QQjlRq9dc7BA--.38720S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw43XrW8CF13CF18KFy5XFb_yoW8Cw15pF
	43Ka9rCr4UKF4Uuan8AFWDXFyft3Z7K347KrWxX34FvrZxCFySva4Iya18Wa4UAryDXF47
	ZFW5KFs2kw1UWrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s026xCa
	FVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
	Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
	6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7IU14CJPUUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

nbd_add_socket can never run concurrently with inflight I/O:

 - netlink path: nbd_genl_connect calls nbd_add_socket before
   nbd_start_device, so no I/O can happened when invoking nbd_add_socket,
   nbd_genl_reconfigure cannot too since it won't call nbd_add_socket

 - ioctl path: NBD_SET_SOCK cannot be called after NBD_DO_IT with
   the previous commit, so capability of nbd will keep 0 while
   invoking NBD_SET_SOCK

Removing the freeze in nbd_add_socket to speed up nbd device startup.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a15553ab4b97..0755b7046ed4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1272,7 +1272,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	struct socket *sock;
 	struct nbd_sock **socks;
 	struct nbd_sock *nsock;
-	unsigned int memflags;
 	int err;
 
 	/* Arg will be cast to int, check it to avoid overflow */
@@ -1283,12 +1282,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
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

