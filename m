Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC53546F6
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933543; cv=none; b=u5FgzR1p3Dl6bQFQ8uCqkvNgFR6330SaCGRmUqg8gSwPXOEIdDtWy67fFIdQCFoymkxInP56AykYCIaQh4+MbmFz/mH2j7+B5juLle5c/M6tUh72TWaOonuYyBJZMGFIMEAfQ8an3qJWTKxbYZV+V2XJdGU0o+WDxohfaURO/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933543; c=relaxed/simple;
	bh=toYtBXVbUZjBnG0M/PpJrUwMEPeavmuVoZ/4CMgCAOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKE42KGsEjEGHxw7pqgVfb19nXcG5mdzTjLdFRYP7kTjMMHUsH7aP0zjI8QIxP8QjwpsImWJdoecJCUYAGn77VS0Og33Gw+AZq5wEV+G8PMxL0cZ+ZxLwH7fnbEAlpINQZlufDklTSaNESPLouQzDR7Ey6HcPHr6ywfij3EWm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hFVMc1wqyzKHNQN
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 20:38:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7F61340996
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 20:38:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkXfLnNqRJjWBA--.10386S9;
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
Subject: [PATCH v8 5/8] nbd: skip queue freeze when setting size at device startup
Date: Wed,  5 Aug 2026 20:29:27 +0800
Message-ID: <20260805122930.57647-6-yangerkun@huawei.com>
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
X-CM-TRANSID:_Ch0CgC3pkXfLnNqRJjWBA--.10386S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4UuF1fZw1ktry8CF1fCrg_yoW8XF1Dpr
	Wq9ayDK3y0gF43ZF97Xr47Za4rJayDCry2gFy7J3sI9FZxAF1SgrZxZFyfWFZ7Xryktw4a
	kF4DKaykA3W8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	6r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUoF4EDUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Commit 242a49e5c878 ("nbd: freeze the queue for queue limits updates")
added the freeze to keep in-flight commands from seeing
torn queue_limits.  But at startup the capacity is still 0
(invalidate_disk cleared it) and the write cache is off (the previous
patch cleared it on disconnect, and nbd_set_size sets it back only after
the commit), so submit_bio_noacct() rejects any bio before it reaches
the driver and no I/O is in flight.  Drop the freeze by checking
capacity and write cache state in nbd_set_size.

Reviewed-by: Yu Kuai <yukuai@fygo.io>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index cb7c1f8502f4..cb662ae4b91d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -375,7 +375,11 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
 	nbd_apply_limits(&lim, nbd->config->flags);
 	lim.logical_block_size = blksize;
 	lim.physical_block_size = blksize;
-	error = queue_limits_commit_update_frozen(nbd->disk->queue, &lim);
+	/* No need freeze with 0 capacity and write cache disabled */
+	if (!get_capacity(nbd->disk) && !blk_queue_write_cache(nbd->disk->queue))
+		error = queue_limits_commit_update(nbd->disk->queue, &lim);
+	else
+		error = queue_limits_commit_update_frozen(nbd->disk->queue, &lim);
 	if (error)
 		return error;
 
-- 
2.52.0

