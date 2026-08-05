Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7273E9C1C
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933547; cv=none; b=ml+5xM3DS/cMnPpsPAcZbX20vjAUuNpcFQSmP7iMbtzLsfUpf8SZ1pUxD7MkavYBUEglv+ipa/h3nHODoJle2vKdl00G6ve0c8OCRvOETjmtNc2XiMllfyLhyhGgF/XaeDIfgfUpaoylx3LfjqbYs5bNamaC4BL/m23o4uHXJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933547; c=relaxed/simple;
	bh=VO0nhiSl3ff3ZyPKkaK4X9tKiuAiGhXGb4Axpe3MDHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjMy+OsWWpBJ/kSuj4hZs6YXOIqQbtktFe9XqiiVYhT8BDbU3AxWGoTJkKMBPBFU1x+Avs/FnGosPoCanL7i76L+Wk4TWYUHH3yh3iTbhetOpzAQglbaEYBXEEVy9+pmn8cyhPZiAI2nOv1eNAhpdXUtuHsL0aeGyuzyyq4c8LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hFVMc1SN2zKHNQw
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 20:38:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6E4E740593
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 20:38:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkXfLnNqRJjWBA--.10386S7;
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
Subject: [PATCH v8 3/8] nbd: clear queue limits on disconnect
Date: Wed,  5 Aug 2026 20:29:25 +0800
Message-ID: <20260805122930.57647-4-yangerkun@huawei.com>
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
X-CM-TRANSID:_Ch0CgC3pkXfLnNqRJjWBA--.10386S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4UGw1rWFy7uryruF1xXwb_yoWrXw47pa
	17C3W7KayrtF47Aa1rWrWUZF15K397C34I9Fy7Gay5ZwsYkw1SyF9Iy34fJFy8JF9rXa15
	Ga9YkF92yryku37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	YxBIdaVFxhVjvjDU0xZFpf9x07UHwZ7UUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

An inactive nbd device may refuse any I/O operations. The nbd_config_put
function calls invalidate_disk, which sets the device capacity to zero
to reject all read and write I/O. For zero-sector flush I/O requests
from blkdev_issue_flush, if the write cache is disabled, the zero-sector
flush I/O immediately returns 0 in submit_bio_noacct. However, since
nbd_config_put does not clear the write cache state, an inactive nbd
device might still have the write cache enabled. In this situation,
zero-sector flush I/O will return -EIO because there is no active socket.
Additionally, BLK_FEAT_FUA and BLK_FEAT_ROTATIONAL flags may also remain
stale, resetting all of them ensures consistent behavior.

The limits update uses queue_limits_commit_update() (the non-freezing
variant) because config_refs == 0 here means every fd is closed and recv
threads have drained, so no in-flight I/O can read q->limits concurrently.

Reviewed-by: Yu Kuai <yukuai@fygo.io>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7ec85f94f742..78df6f459da6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -331,6 +331,26 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 	nsock->sent = 0;
 }
 
+static void nbd_apply_limits(struct queue_limits *lim, u32 flags)
+{
+	lim->features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA | BLK_FEAT_ROTATIONAL);
+	lim->max_hw_discard_sectors = 0;
+	lim->max_write_zeroes_sectors = 0;
+
+	if (flags & NBD_FLAG_SEND_TRIM)
+		lim->max_hw_discard_sectors = UINT_MAX >> SECTOR_SHIFT;
+	if (flags & NBD_FLAG_SEND_FLUSH) {
+		lim->features |= BLK_FEAT_WRITE_CACHE;
+		if (flags & NBD_FLAG_SEND_FUA)
+			lim->features |= BLK_FEAT_FUA;
+	}
+
+	if (flags & NBD_FLAG_ROTATIONAL)
+		lim->features |= BLK_FEAT_ROTATIONAL;
+	if (flags & NBD_FLAG_SEND_WRITE_ZEROES)
+		lim->max_write_zeroes_sectors = UINT_MAX >> SECTOR_SHIFT;
+}
+
 static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
 {
 	struct queue_limits lim;
@@ -352,23 +372,7 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
 		return 0;
 
 	lim = queue_limits_start_update(nbd->disk->queue);
-	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
-		lim.max_hw_discard_sectors = UINT_MAX >> SECTOR_SHIFT;
-	else
-		lim.max_hw_discard_sectors = 0;
-	if (!(nbd->config->flags & NBD_FLAG_SEND_FLUSH)) {
-		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
-	} else if (nbd->config->flags & NBD_FLAG_SEND_FUA) {
-		lim.features |= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA;
-	} else {
-		lim.features |= BLK_FEAT_WRITE_CACHE;
-		lim.features &= ~BLK_FEAT_FUA;
-	}
-	if (nbd->config->flags & NBD_FLAG_ROTATIONAL)
-		lim.features |= BLK_FEAT_ROTATIONAL;
-	if (nbd->config->flags & NBD_FLAG_SEND_WRITE_ZEROES)
-		lim.max_write_zeroes_sectors = UINT_MAX >> SECTOR_SHIFT;
-
+	nbd_apply_limits(&lim, nbd->config->flags);
 	lim.logical_block_size = blksize;
 	lim.physical_block_size = blksize;
 	error = queue_limits_commit_update_frozen(nbd->disk->queue, &lim);
@@ -1469,8 +1473,13 @@ static void nbd_config_put(struct nbd_device *nbd)
 	if (refcount_dec_and_mutex_lock(&nbd->config_refs,
 					&nbd->config_lock)) {
 		struct nbd_config *config = nbd->config;
+		struct queue_limits lim;
 		nbd_dev_dbg_close(nbd);
 		invalidate_disk(nbd->disk);
+		/* reset queue limits to default */
+		lim = queue_limits_start_update(nbd->disk->queue);
+		nbd_apply_limits(&lim, 0);
+		queue_limits_commit_update(nbd->disk->queue, &lim);
 		if (nbd->config->bytesize)
 			kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 		if (test_and_clear_bit(NBD_RT_HAS_PID_FILE,
-- 
2.52.0

