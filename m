Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91F3BE17B
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138982; cv=none; b=gQgf27O2pf52zi9LsuaSjAVIt5jItDC/+3Mcw5ZftGo1UpU9/F8GPoUn36yYEFhYvUbpfX5xSf581qdjeDzxFvaUxg3A4RVuzHmBgxFKjFObusCNuDQ0bn1hK/UoF2vne4oJTMXHf85zVnATczWDgZMNT3RPV1fI6zmIKpkQiYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138982; c=relaxed/simple;
	bh=IkTtbVWRFHJwOTI2T8kL6Oj1lKVAompi9lT4Npl4lyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=km6xTSRkTTXajVoA+O+wC6cyClLLc5o+X3t9z2SEj6u5VGpi2oMljHsU/oIGq2U5J7LU5WeOHG3NnAkfTvkGESW7u+O6qn6ZZZ3LCAQhz9bwfXPV+NJKZUVUK0AgrvATPj4gAN78vwUBpSY16475NuZi6B0UtdvCaBghd/c/gk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h7rVy12K7zYQtwq
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 15:55:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5FEC84058F
	for <linux-block@vger.kernel.org>; Mon, 27 Jul 2026 15:56:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkUbD2dqjEJ1AA--.26468S8;
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
Subject: [PATCH v4 4/7] nbd: skip queue freeze when setting size at device startup
Date: Mon, 27 Jul 2026 15:47:15 +0800
Message-ID: <20260727074718.414868-5-yangerkun@huawei.com>
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
X-CM-TRANSID:_Ch0CgC3pkUbD2dqjEJ1AA--.26468S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWkZFWDXw4kJw4rGF4rXwb_yoW5KF13pF
	W7Ca98KrW8KF4xur4DZFs5Ww45twn2k3sFg347G34F9F4qyrZayryIy34Sqa40qryDWFs8
	G398KF40kw1UXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbWxR3UUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

The commit 242a49e5c878 ("nbd: freeze the queue for queue limits
updates") introduced freezing and unfreezing of the queue in
nbd_set_size to prevent inflight commands from seeing inconsistent
limits. However, this protection appears unnecessary during the nbd
startup process because no I/O can occur before nbd_set_size is
called (with zero capability and write cache disabled).

To address this, nbd_set_size is split with a boolean parameter
'freeze': the startup path nbd_start_device passes false, while
runtime resize or reconfigure paths (such as ioctls and
nbd_genl_size_set) pass true. Although nbd_genl_connect calls
nbd_genl_size_set before nbd_start_device, nbd->pid is zero at that
point, so nbd_set_size returns early before applying the limits
commit. The 'true' parameter covers the nbd_genl_reconnect path,
which operates on a live device where concurrent I/O may occur.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1a31e621b6f7..e2fb787248c8 100644
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
@@ -2092,7 +2099,7 @@ static int nbd_genl_size_set(struct genl_info *info, struct nbd_device *nbd)
 		bsize = nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
 
 	if (bytes != config->bytesize || bsize != nbd_blksize(config))
-		return nbd_set_size(nbd, bytes, bsize);
+		return nbd_set_size(nbd, bytes, bsize, true);
 	return 0;
 }
 
-- 
2.52.0

