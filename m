Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04C72620;
	Tue,  6 May 2025 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512776; cv=none; b=VwTNPEz33RhjQHHi9DlP1NG9eA7XUNVLfKLXxDs3fLOOgNd4iEFRj7algOSxDt6fUOu9YBpcFkXXMXJnrf2Mff+68QDBGBNE69oHFWyuOJjJMF8tSSNypSX8tnGabGll9k4e/adnh9LCaP9t3QfWFIT8NOKhr1eqRu/CpZzOw60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512776; c=relaxed/simple;
	bh=0j/acZtSYPFi2KyRkFRQqfl6iD1su31uZ5KJ3CDk2iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pptxWop3Dw/U+i6RxyMGOY5YszPrfy2E5jiRLR7q8tmVGRj3X19heqkBv9hPjePog1FuP9yrVmiCedbzUWoYj7VO3qRH9IGfFmbPaDERp836/yGGegZBxMOFmEXTdSF0oFlKjLmXD6Si2bx6a7+UsAfPuDok5ysRv2jqDm4SUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4Zs7h35Z4FzKHMWT;
	Tue,  6 May 2025 14:26:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8FA0D1A1AF7;
	Tue,  6 May 2025 14:26:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9+qxlox3JULg--.34792S5;
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
Subject: [PATCH v3 for-6.16/block 1/3] brd: protect page with rcu
Date: Tue,  6 May 2025 14:17:54 +0800
Message-Id: <20250506061756.2970934-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDXOl9+qxlox3JULg--.34792S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4xtF4fGr43ury5uryrtFb_yoW8KFWkpF
	47XFyIyrW5AF4akw17Xwn8AryrJ3s7Kay8KayxW3yYkw4fGr1qya4kAa4Sq345GrykCFZx
	ArsYya4rZr1kZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqkskUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, after fetching the page by xa_load() in IO path, there is no
protection and page can be freed concurrently by discard:

cpu0
brd_submit_bio
 brd_do_bvec
  page = brd_lookup_page
                          cpu1
                          brd_submit_bio
                           brd_do_discard
                            page = __xa_erase()
                            __free_page()
  // page UAF

Fix the problem by protecting page with rcu.

Meanwhile, if page is already freed, also prevent BUG_ON() by skipping
the write, and user will get zero data later if there is no page.

Fixes: 9ead7efc6f3f ("brd: implement discard support")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/brd.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index fa1290992a7f..fc793d48a9c6 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -132,12 +132,18 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 		}
 	}
 
+	rcu_read_lock();
 	page = brd_lookup_page(brd, sector);
 
 	kaddr = bvec_kmap_local(&bv);
 	if (op_is_write(opf)) {
-		BUG_ON(!page);
-		memcpy_to_page(page, offset, kaddr, bv.bv_len);
+		/*
+		 * Page can be removed by concurrent discard, it's fine to skip
+		 * the write and user will read zero data if page does not
+		 * exist.
+		 */
+		if (page)
+			memcpy_to_page(page, offset, kaddr, bv.bv_len);
 	} else {
 		if (page)
 			memcpy_from_page(kaddr, page, offset, bv.bv_len);
@@ -145,11 +151,19 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 			memset(kaddr, 0, bv.bv_len);
 	}
 	kunmap_local(kaddr);
+	rcu_read_unlock();
 
 	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
 	return true;
 }
 
+static void brd_free_one_page(struct rcu_head *head)
+{
+	struct page *page = container_of(head, struct page, rcu_head);
+
+	__free_page(page);
+}
+
 static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 {
 	sector_t aligned_sector = (sector + PAGE_SECTORS) & ~PAGE_SECTORS;
@@ -160,7 +174,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 	while (size >= PAGE_SIZE && aligned_sector < rd_size * 2) {
 		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
 		if (page) {
-			__free_page(page);
+			call_rcu(&page->rcu_head, brd_free_one_page);
 			brd->brd_nr_pages--;
 		}
 		aligned_sector += PAGE_SECTORS;
-- 
2.39.2

