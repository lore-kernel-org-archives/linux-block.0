Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7A41D109
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833340; cv=none; b=jokaHk1btRy/n9MwTWs3McsfKOxIN1h3T7tthSHe4hHRhtVFJ9ESZGSTluF7ToQO+TU50K4oJe54MVAhh2e1WBcpUhxPbzpnAMLKkjUBFO757oLBkVfV2eqJV2ZvqqBH42cZOFhno9R8VbBj0Xx8LMVTVPdxIWcBnswmc0uPD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833340; c=relaxed/simple;
	bh=K9aiR6f6rItVe48HU033ShTzVyNluWGton1JsFb99Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anEE6V7lt0eWop6ZEYrPpE6TuxFqypTJV8AYq2nbAlItSbfte9hkcPhX7JqPcPrsWICtBLXT0wsfP1LugGQMOIdoWZoBRVSaA4L28yhqi97dUs7fMtChP2YgV/Hdu+y1NF87d+QxKBO4dXO8q5TpF/fIqETDQMjTyBGyga/BRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hDnHc73TpzYQtxD
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 16:47:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1053240570
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 16:48:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgD35kVrp3Fq71VIBA--.52677S8;
	Tue, 04 Aug 2026 16:48:47 +0800 (CST)
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
Subject: [PATCH v6 4/8] nbd: remove queue freeze in nbd_add_socket
Date: Tue,  4 Aug 2026 16:39:18 +0800
Message-ID: <20260804083922.1927105-5-yangerkun@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260804083922.1927105-1-yangerkun@huawei.com>
References: <20260804083922.1927105-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD35kVrp3Fq71VIBA--.52677S8
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xAF43Kw13CFyktw47Arb_yoW8try3pF
	s8Ga9rGF4UKr45uan5AFWkXFyrtwn7Ka47GayxX34FvrsxCFySvFySya4rWFyUAr95u3W7
	Aay5Grs2kw18urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1-zstUUUUU==
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

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 45e58191c5d7..8aeffc0eaaa1 100644
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

