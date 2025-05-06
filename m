Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9A7261D;
	Tue,  6 May 2025 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512776; cv=none; b=HbXfF6qwoHaUuK9ybijFAIMYU9OXxmXC00u2UWyWL3xys3yyLwqyWsqWf1IBar7NbwX5765j1BpD7Q+GgIYtaLcanoZcM17pElDVDWe84Kn1Ci/A0Xv0C4clcXc9Qjt3j9TO7aVPqXxGjBH93ZCJ4C/7fC4Ons25AFljTA0ruzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512776; c=relaxed/simple;
	bh=i+4CpUcjYi2IJC4QF70+5uiAh/GJf2E+2qi1DVoBrHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZXy5cfDnqpVBastr4/Xdp/ZAmxHChCDmw6TXG6vSxHd0QrRFE8Qy+XEOYSe7zoT0h4VZ1HPVIhp/5pvS/2gaeAbnGg8RLVx37dgSaL022rrFUANMe37rLXuyNw4AlY3aXywdYAQ+URpAfRMZGT23BdIuzYtAvd2Rb8VLz+AbVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zs7gY0Gqfz4f3lDF;
	Tue,  6 May 2025 14:25:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 021621A07BB;
	Tue,  6 May 2025 14:26:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9+qxlox3JULg--.34792S6;
	Tue, 06 May 2025 14:26:10 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 for-6.16/block 2/3] brd: fix aligned_sector from brd_do_discard()
Date: Tue,  6 May 2025 14:17:55 +0800
Message-Id: <20250506061756.2970934-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250506061756.2970934-1-yukuai1@huaweicloud.com>
References: <20250506061756.2970934-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl9+qxlox3JULg--.34792S6
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4fXFW7ur45Ar1fXF1kKrg_yoWfGwc_C3
	WYvF4xXr95Jr1jkr1Yya4fZrZIv3WjvrZ5uF1Sqr93XFW8X3ZrZ34qvrZ8ZryUWFW5Aa4a
	y3ZrXr47Xw42gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbQxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v2
	6r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj5Ef7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The calculation is just wrong, fix it by round_up().

Fixes: 9ead7efc6f3f ("brd: implement discard support")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index fc793d48a9c6..2753fb21410b 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -166,7 +166,7 @@ static void brd_free_one_page(struct rcu_head *head)
 
 static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 {
-	sector_t aligned_sector = (sector + PAGE_SECTORS) & ~PAGE_SECTORS;
+	sector_t aligned_sector = round_up(sector, PAGE_SECTORS);
 	struct page *page;
 
 	size -= (aligned_sector - sector) * SECTOR_SIZE;
-- 
2.39.2

