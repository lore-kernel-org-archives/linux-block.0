Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1C423E91
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833340; cv=none; b=Fw4xIMVcUraN+bQzZ8BCma8owbfahWiu+wUqJavQr/P472q2zbc6WxaJANsje2PtAoT/T5Tw8lqqmqlY+xbO83TFmNFxSLel24SE9JXkhLcaQG4uHYYZbCfbzKhfNY1tCtw5ha3hFf2S7wRMkaSZnDm0pjKNne2sd/nGLIModw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833340; c=relaxed/simple;
	bh=6mkM/g6Nz8ZGtYGSHh6EtcKDfNHKbGp/EI0sgUvV6aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzMl531CqkS72Nmy/nfxUMsL6UeVW6Rvxavt/Kv0i3t7ueJaHlkEufRoN8ieMg7DZAYs0SpBRwXFyXxlFARW3jh+iTeMWdKB8SRBDt2QqLXSt45NSUOc1ONqkOIlzNS0i6GCi3C9RwfTbDq63iUMVUcnTcG8G7P4mO+bYbw4f/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hDnHd0FXVzYQv3d
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 16:47:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 179BF40A87
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 16:48:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgD35kVrp3Fq71VIBA--.52677S9;
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
Subject: [PATCH v6 5/8] nbd: skip queue freeze when setting size at device startup
Date: Tue,  4 Aug 2026 16:39:19 +0800
Message-ID: <20260804083922.1927105-6-yangerkun@huawei.com>
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
X-CM-TRANSID:_Ch0CgD35kVrp3Fq71VIBA--.52677S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4UuF1fZw1ktry8CF1fCrg_yoW8Xr47pr
	WDuayUK3y0gF43ZF97Xr4xZa4rJayDCry2gFy7G3sI9rZxAF1SgrZxZFyfWFZ7Xr93Jw4a
	kF1DKaykA3W8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1-zstUUUUU==
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

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 drivers/block/nbd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8aeffc0eaaa1..66f1b3263b94 100644
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

