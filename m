Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80EE368284
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926307; cv=none; b=DKV5OfcDQ40irVfcBdKW5id5ziNT9TdsuiyaUnTgGfFeql0Mp7fuC6xnVXBcITs4cqy3akqIrMVaNOTBcDSLlmvnCXGHmMK8R4AUl7mnL1c3GAHMTKNysJC1G71gYiZbzmf9tP/Mw2+MOcC6sblI0pHXxNOsjFe7B2p1A5zdfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926307; c=relaxed/simple;
	bh=TSwYAl4Xdtvll5Dyy6WnVcj9kpfEqN2XIx61xvKBBH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTr90HBsjRn3/drUcj9Bb1jqAsuh0SsbK7TEdeA7axkIaU3wybmsYmJ+VgFcOt3W2FBugX33TnExtwIHToGrf+Q8qmE2QtX35u7DcWOWi5yR18prDYedadPyEAXzNvrGphw15H0wkHP4hGgBhYg+seRfMmfyvTgVa0bpx74ykeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzD2h0QPgzYQtdk
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3F4FB40DC4
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:04:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgD3B3QQjlRq9dc7BA--.38720S9;
	Mon, 13 Jul 2026 15:04:57 +0800 (CST)
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
Subject: [PATCH v3 5/6] nbd: skip queue freeze when setting size at device startup
Date: Mon, 13 Jul 2026 14:56:43 +0800
Message-ID: <20260713065644.1637594-6-yangerkun@huawei.com>
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
X-CM-TRANSID:cCh0CgD3B3QQjlRq9dc7BA--.38720S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4xXw18XFy3ZFy5ury5CFg_yoW5CFyxpF
	4UAa95GrW8KF4xur4vvFs5Xw45twnrC3sFg347G34F9F1qy392yry0yryaqw10qryDWFs8
	Ga98KF4Iya4UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	xVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFPETDUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Commit 242a49e5c878 ("nbd: freeze the queue for queue limits updates")
introduce queue freeze/unfreeze in nbd_set_size to avoid inflight
commands see this inconsistent limits. However, this cannot be happened
when device setup since the capacity is still 0.

time nbd-client --name myexport --connections 96 127.0.0.1 1234

Before this patchset:
real    0m2.195s
user    0m0.005s
sys     0m0.022s

After this patchset:
real    0m0.090s
user    0m0.004s
sys     0m0.018s

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 400f638e832e..2c7b09c70da2 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -331,7 +331,8 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 	nsock->sent = 0;
 }
 
-static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
+static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize,
+			bool freeze)
 {
 	struct queue_limits lim;
 	int error;
@@ -371,7 +372,13 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
 
 	lim.logical_block_size = blksize;
 	lim.physical_block_size = blksize;
-	error = queue_limits_commit_update_frozen(nbd->disk->queue, &lim);
+
+	if (freeze)
+		error = queue_limits_commit_update_frozen(nbd->disk->queue,
+				&lim);
+	else
+		error = queue_limits_commit_update(nbd->disk->queue, &lim);
+
 	if (error)
 		return error;
 
@@ -1563,7 +1570,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		args->index = i;
 		queue_work(nbd->recv_workq, &args->work);
 	}
-	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
+	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config), false);
 }
 
 static int nbd_start_device_ioctl(struct nbd_device *nbd)
@@ -1631,13 +1638,13 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	case NBD_SET_SOCK:
 		return nbd_add_socket(nbd, arg, false);
 	case NBD_SET_BLKSIZE:
-		return nbd_set_size(nbd, config->bytesize, arg);
+		return nbd_set_size(nbd, config->bytesize, arg, true);
 	case NBD_SET_SIZE:
-		return nbd_set_size(nbd, arg, nbd_blksize(config));
+		return nbd_set_size(nbd, arg, nbd_blksize(config), true);
 	case NBD_SET_SIZE_BLOCKS:
 		if (check_shl_overflow(arg, config->blksize_bits, &bytesize))
 			return -EINVAL;
-		return nbd_set_size(nbd, bytesize, nbd_blksize(config));
+		return nbd_set_size(nbd, bytesize, nbd_blksize(config), true);
 	case NBD_SET_TIMEOUT:
 		nbd_set_cmd_timeout(nbd, arg);
 		return 0;
@@ -2122,7 +2129,7 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
 		bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
 
 	if (bytes != config->bytesize || bsize != nbd_blksize(config))
-		return nbd_set_size(nbd, bytes, bsize);
+		return nbd_set_size(nbd, bytes, bsize, true);
 	return 0;
 }
 
-- 
2.52.0

