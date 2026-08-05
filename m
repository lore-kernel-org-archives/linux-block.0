Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6D3EA979
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933545; cv=none; b=ugVJH9085jY2/+lFxJFg1apmh+jEwHkvquCdIflV3JXRUD3et+S5SRBmzbP9HCYJXu6AkRA5yqtmnDvaW2Gcz6Cf7SBombkT8eiLCr9eCL4lxN3jeIhrU9DSJ8JchrMJCv8L+kBixDpIaJa8JAZwtK6SgxMxdQlH6KPgZ9ESRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933545; c=relaxed/simple;
	bh=5DHaZpcGBnavuDFMYhbEy+0kcnFt7s31kEpLK8oMMzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5lJCTakDzclIEB48FnBPvnVLt0XaD8K52RRjzMJcz3ubyODN196hl0yW3/7BhbVYtAgL5iTfiZuL7Q2oq3DgaOT2eDeBX8EUYRaNHq5+RdetfUtFvIg6fxqLrotZmfAzdR+Q7rXKqgrv+rcqQOpqdKaf9+ycaW5rzL7nTsQqao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hFVLj33PDzYQvY9
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 20:38:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 77BFB4056E
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 20:38:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkXfLnNqRJjWBA--.10386S8;
	Wed, 05 Aug 2026 20:38:58 +0800 (CST)
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
Subject: [PATCH v8 4/8] nbd: remove queue freeze in nbd_add_socket
Date: Wed,  5 Aug 2026 20:29:26 +0800
Message-ID: <20260805122930.57647-5-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260805122930.57647-1-yangerkun@huawei.com>
References: <20260805122930.57647-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3pkXfLnNqRJjWBA--.10386S8
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xAF43Kw13CFyktw47Arb_yoW8tFyUpF
	s8Ga9rGF4Utr45Wa1kAFWkXFyrtwn7K347GayxX34YvrsxAFySvFyft3WrWFyUArykZ3W7
	AFW5Krs2kw18WrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUoF4EDUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

nbd_add_socket() kreallocs config->socks, which a concurrent reader in
nbd_handle_cmd() could UAF; commit b98e762e3d71 ("nbd: freeze the queue
while we're adding connections")froze the queue to block that.  But the
freeze costs an RCU grace period on every socket added, and setup adds
them one by one.

After the previous patch, nbd_add_socket() is rejected once nbd->pid is
set, so it only runs during setup.  There the capacity is 0 and the
write cache is off (cleared on disconnect by the preceding patch, and
re-enabled only later in nbd_set_size), so submit_bio_noacct() rejects
every bio before it reaches the driver -- non-zero-sector ones via
bio_check_eod(), and flush-only ones via the !bdev_write_cache() branch.
No I/O is in flight, so the freeze is unnecessary.

Reviewed-by: Yu Kuai <yukuai@fygo.io>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 78df6f459da6..cb7c1f8502f4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1276,7 +1276,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	struct socket *sock;
 	struct nbd_sock **socks;
 	struct nbd_sock *nsock;
-	unsigned int memflags;
 	int err;
 
 	/* Arg will be cast to int, check it to avoid overflow */
@@ -1294,12 +1293,6 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
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
@@ -1339,12 +1332,10 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
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

