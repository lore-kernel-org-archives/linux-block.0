Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FA28E0;
	Thu,  9 Apr 2026 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775716602; cv=none; b=iKULEdljjefftD/LbxyAYAQ0bEKisx6/jvTekpxo7ds94M8o+rzxyaVAiJWJQ/nH0SpVJHg7RS9vrCt/uL7SxO8q8ylJvZyy0O7xJt2ZgH4FHRHBmBIgtVIHDSnALIgCqQ4RlLboj3cr183l6PsP2pBSSjs6EuL2ynqfFr7o3rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775716602; c=relaxed/simple;
	bh=Mdt1/CTaPIuqmYPtLEFhJRxjidhAM8Jz4i3zvcKob+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dJZmprQJIQXJKbNV8Eyg8/9fTFIvE/eFQkaBYckl3xq7Dm45XGogmuaXTcxdVtnC+KBPofzw5b/hNb282rjfoI6he0JzAbM+9asb33NThEXh4NlmQoK/WzcsgFEEN23nHHR8T7Wo8oI/zh0tVVBzgw97tGCbXu8omS3jJDO3qMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m7kafzEa; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m7kafzEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=QR
	KMF95exbAEJOFMVOBOllgPfninD+Eg8P+VZ5T9aM0=; b=m7kafzEaAniSGEkz/E
	iq58V4wKPOP1DG1tFvSDT817r33z/qG83KJtHdkXjPo9pUuiz+HQhvv3fgUh49Qh
	M4Auiwl5G0sPk7UnbY40fpE5xEVS21eBmP4siBjwTOB9CrsnW/ualXW91ZNWp+x1
	I3Czpql0P1tvYPR3xcjaSOevM=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wB3NK7gSNdpjK3CEA--.589S2;
	Thu, 09 Apr 2026 14:36:18 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Zheng Qixing <zhengqixing@huawei.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Robert Garcia <rob_garcia@163.com>,
	Christoph Hellwig <hch@lst.de>,
	Yu Kuai <yukuai3@huawei.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] block: fix resource leak in blk_register_queue() error path
Date: Thu,  9 Apr 2026 14:36:16 +0800
Message-Id: <20260409063616.117503-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3NK7gSNdpjK3CEA--.589S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1fuw1kXrW3ZFyxJF4ktFb_yoW8GF1xpw
	43Wa1UWryvgr48WF4Dua1xGa4UGa1DKw1xWrWfJw1Yva9rKryjkr4v9343Wr18A397CFWx
	XrnxAFWrtay5CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMOJ5UUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAgOaBmnXSOMKyQAA3L

From: Zheng Qixing <zhengqixing@huawei.com>

[ Upstream commit 40f2eb9b531475dd01b683fdaf61ca3cfd03a51e ]

When registering a queue fails after blk_mq_sysfs_register() is
successful but the function later encounters an error, we need
to clean up the blk_mq_sysfs resources.

Add the missing blk_mq_sysfs_unregister() call in the error path
to properly clean up these resources and prevent a memory leak.

Fixes: 320ae51feed5 ("blk-mq: new multi-queue block IO queueing mechanism")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20250412092554.475218-1-zhengqixing@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ Change disk to q in blk_mq_sysfs_unregister(). ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 block/blk-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4ea84e46a665..c1917992e619 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -900,6 +900,8 @@ int blk_register_queue(struct gendisk *disk)
 	if (q->elevator)
 		kobject_uevent(&q->elevator->kobj, KOBJ_ADD);
 	mutex_unlock(&q->sysfs_lock);
+	if (queue_is_mq(q))
+		blk_mq_sysfs_unregister(q);
 
 	ret = 0;
 unlock:
-- 
2.34.1

