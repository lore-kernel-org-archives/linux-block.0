Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28472C9D;
	Sun, 27 Apr 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745743631; cv=none; b=oxfr04E2dptANkPwAAC0UIi7O487cZH486wu4VarlBi1V+2AUrhHe/16yu60U0pkG6rFeLHcVOei68vQQrAlHD4HgI+6QpXp03uN6tr+ja3K1tZNJ9byLSNjS3iT3C80aRX4r3WFbjhnPH+u0DamUCSviyA6g6CnBeRjhgFBqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745743631; c=relaxed/simple;
	bh=NdQpLw1m48yB73asdCz4OM5Z1zplgmlenv4G7M0eaAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uc8usfVMSQxFaC7UZCaWOkaiAgN9pXfbHs8+w1Ct+CRCamqD8liTwh2poEA1CxLur5XLcr42YfAvEAKSD8sSEGWMOL6K/N6JGzgbWA0cau1AVE8JV/xLzrJFu27RzPF9/0bg/Y9sqXn9l965+2WGCsH1r9+SgPcGyAXHZYPsx6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ZlgDp5cPrzKHMh7;
	Sun, 27 Apr 2025 16:47:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C72A31A0A0D;
	Sun, 27 Apr 2025 16:47:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAXenoG7w1oOVIpKg--.9945S5;
	Sun, 27 Apr 2025 16:47:05 +0800 (CST)
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
Subject: [PATCH v2 1/3] brd: protect page with rcu
Date: Sun, 27 Apr 2025 16:39:23 +0800
Message-Id: <20250427083925.157984-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250427083925.157984-1-yukuai1@huaweicloud.com>
References: <20250427083925.157984-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXenoG7w1oOVIpKg--.9945S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4xtF4fGr43ury5uryrtFb_yoW8uw4rpF
	42qa4Iy398AF43C3W7Xwn8AryrA34kKay8Kay7u3yYkw4fGr9Fya48Aa4Sqa45GrWkCFZx
	Aan0ya48ZrykAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHc_fUUUUU=
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
 drivers/block/brd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 79e96221f887..98c9297beafe 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -132,23 +132,32 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 		}
 	}
 
+	rcu_read_lock();
 	page = brd_lookup_page(brd, sector);
 
 	kaddr = bvec_kmap_local(&bv);
 	if (op_is_write(opf)) {
-		BUG_ON(!page);
-		memcpy_to_page(page, offset, kaddr, bv.bv_len);
+		if (page)
+			memcpy_to_page(page, offset, kaddr, bv.bv_len);
 	} else if (page) {
 		memcpy_from_page(kaddr, page, offset, bv.bv_len);
 	} else {
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
@@ -159,7 +168,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
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

