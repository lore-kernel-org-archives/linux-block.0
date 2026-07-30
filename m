Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BD93B9D9E
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400200; cv=none; b=EhXx6TXY2N3RmxT1j0V8LKXzjvUbIyFIVUMsNST9tOhBfXvzGYGeRXQrrWaByWyxmdiYwZxXEGPhGaH9b13nipkG8h/RP4AdOcm+IqZXq/lZ26BGisX/UAkfoPxDNGBMUyHpDB68lx82Bj6Gl/gVScqEl7ey833zgv/97ZO6kTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400200; c=relaxed/simple;
	bh=vMkxh4PQy9rlmAxPxh5zUpWNaQ2aMtRhwJxkYyH+5as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGU9WJvtKVV/leKlVAWuU1g/j6DT69i7L/2mr68Tpudg12Gmv/TW/ykI4Z4qH5Y8lhPclxxITGP5PRoLmQkxfN1z9cqzhCUHr7DoD4bFderAg3eBTBaz5irv62BzD7tDkGA4XzJmlrPcoMuwoUWrLU1PnO7J5Rc9l7wgwO9nxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h9j622zYKzKHMgv
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:28:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CDD8540572
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:29:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgCnlkV9C2tqwObjAQ--.20420S8;
	Thu, 30 Jul 2026 16:29:54 +0800 (CST)
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
Subject: [PATCH v5 4/8] nbd: remove queue freeze in nbd_add_socket
Date: Thu, 30 Jul 2026 16:20:42 +0800
Message-ID: <20260730082046.3459239-5-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260730082046.3459239-1-yangerkun@huawei.com>
References: <20260730082046.3459239-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnlkV9C2tqwObjAQ--.20420S8
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xAF43Kw13CFyktw47Arb_yoW8try3pF
	45Ga9rGF4UKr45uan5AFWkXFyrtwn7K347GayIq34YvrsxAFySvFyFy3WrWFyUAr95u3W7
	Aay5Krs2kw18WrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4U
	JVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1-zstUUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

nbd_add_socket() kreallocs config->socks, which a concurrent reader in
nbd_handle_cmd() could UAF; commit b98e762e3d71 ("nbd: freeze the queue
while we're adding connections") froze the queue to block that.  But
the freeze costs an RCU grace period on every socket added, and setup
adds them one by one.

After the previous patch, nbd_add_socket() is rejected once nbd->pid is
set, so it only runs during setup.  There the capacity is 0 and the
write cache is off (cleared on disconnect by the preceding patch, and
re-enabled only later in nbd_set_size), so submit_bio_noacct() rejects
every bio before it reaches the driver -- non-zero-sector ones via
bio_check_eod(), and flush-only ones via the !bdev_write_cache() branch.
No I/O is in flight, so the freeze is unnecessary.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index da4b48ef3c79..ce25c254e5fb 100644
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

