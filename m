Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A57263B;
	Tue,  6 May 2025 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512776; cv=none; b=j29JiDX77dMgS50iJaz/r0iMbwBdMHhKCGX8JPAmP5aB00KLdIzQM48P3b1T18L8GyId6zo9nArV0zcm1jQBQRTyFXwhvlprad1/3Xk1IQKAH1OVtYZsnPo5F1dHmEXTAyww8oJUcPbwqEYvMZNZ8fQtANgaeggyyWpDGLkxZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512776; c=relaxed/simple;
	bh=h9j/+A/3YmNfuoPme7bzR2ONnW/ixZBV+7aJ62GHDHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4d//v1nmJBSjF5PMKTtgjwKsjrpW4hXzRNKP2l0XT532mOyemk27An6hQ3iy2hd/7ZyUIdVYrCF5Y5Ko7FR7pybjpusLwnVw6Uk9IUOqiiJbzyDLhcnAP9QdFUgd6SP0z+P5SQuZ/k1FAlnZqna/pxZrqwBthQVeuvBVi2Vbww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zs7gY3GrTz4f3lDG;
	Tue,  6 May 2025 14:25:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 67D521A018D;
	Tue,  6 May 2025 14:26:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9+qxlox3JULg--.34792S7;
	Tue, 06 May 2025 14:26:11 +0800 (CST)
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
Subject: [PATCH v3 for-6.16/block 3/3] brd: fix discard end sector
Date: Tue,  6 May 2025 14:17:56 +0800
Message-Id: <20250506061756.2970934-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDXOl9+qxlox3JULg--.34792S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rCrWxuFW7Kr4UGw15Arb_yoW8WryrpF
	4UJFZ29ry5Ar1Ut3W5X3s8uryFqayxGa4fKay7u3yYkr4fGr9Fvayxt34FqayUGr4fuFy5
	A3Zay34rZrykA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHWlkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

brd_do_discard() just aligned start sector to page, this can only work
if the discard size if at least one page. For example:

blkdiscard /dev/ram0 -o 5120 -l 1024

In this case, size = (1024 - (8192 - 5120)), which is a huge value.

Fix the problem by round_down() the end sector.

Fixes: 9ead7efc6f3f ("brd: implement discard support")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/brd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 2753fb21410b..a3725673cf16 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -167,18 +167,21 @@ static void brd_free_one_page(struct rcu_head *head)
 static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 {
 	sector_t aligned_sector = round_up(sector, PAGE_SECTORS);
+	sector_t aligned_end = round_down(
+			sector + (size >> SECTOR_SHIFT), PAGE_SECTORS);
 	struct page *page;
 
-	size -= (aligned_sector - sector) * SECTOR_SIZE;
+	if (aligned_end <= aligned_sector)
+		return;
+
 	xa_lock(&brd->brd_pages);
-	while (size >= PAGE_SIZE && aligned_sector < rd_size * 2) {
+	while (aligned_sector < aligned_end && aligned_sector < rd_size * 2) {
 		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
 		if (page) {
 			call_rcu(&page->rcu_head, brd_free_one_page);
 			brd->brd_nr_pages--;
 		}
 		aligned_sector += PAGE_SECTORS;
-		size -= PAGE_SIZE;
 	}
 	xa_unlock(&brd->brd_pages);
 }
-- 
2.39.2

