Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845381E5B94;
	Tue, 29 Jul 2025 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753773373; cv=none; b=W6wq6HcoaAQgUwVcMy79FM2BWHqS3SUesEROhbl+a+t75dO0fwJWvOcp95tqGEwyguyB2axdpdpdtUmQBDpmwo971WTWiHJNNkwNFqn3HBR1zu7Ekb7uJh89H4VNTBX6u5LpOJwXv8bGKCvUgszHFL3MzXommB2cnNVpXIHRWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753773373; c=relaxed/simple;
	bh=YwIIX28t6zg6jgTGVFbAVEXjIe+ZB2IG9sTN09C154E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eoRZI55iK8M2UfB4z1tjGwsCwEEJrjh3kRPVooLJDEi5w7FGWKRssHSz9/lYpClSlk30mZodQW4dJk2epQYay28dI+Qg08ExtfP9v/5xnHmKIpfrAByI4QPC7lFGm4V1ZcZHNBbxjWAVQfWkcCDw4QBLliYAC/GU3l8VF4ot0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4brmps73z6zYQtdv;
	Tue, 29 Jul 2025 15:16:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A8DE01A133C;
	Tue, 29 Jul 2025 15:16:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxAwdYhogZ5vBw--.21003S4;
	Tue, 29 Jul 2025 15:16:02 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@lst.de,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH] brd: use page reference to protect page lifetime
Date: Tue, 29 Jul 2025 15:09:15 +0800
Message-Id: <20250729070915.487189-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxAwdYhogZ5vBw--.21003S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr43Cw4kKw18tF13XFy7Wrg_yoWrXFWkpF
	WUtF92y3y5Gr4ak3W7Xwn8Cr15KryIgayxKa4fJw4Skr4fCr9Fy3WIy34Fqa45GrW8CrWD
	AFsxtF1UCrs5X3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

As discussed [1], hold rcu for copying data from/to page is too heavy.
it's better to protect page with rcu around for page lookup and then
grab a reference to prevent page to be freed by discard.

[1] https://lore.kernel.org/all/eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk/

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/brd.c | 56 +++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 0c2eabe14af3..ce311d054cab 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -44,45 +44,55 @@ struct brd_device {
 };
 
 /*
- * Look up and return a brd's page for a given sector.
+ * Look up and return a brd's page with reference grabbed for a given sector.
  */
 static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 {
-	return xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
+	struct page *page;
+
+	rcu_read_lock();
+	page = xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
+	if (page)
+		get_page(page);
+	rcu_read_unlock();
+
+	return page;
 }
 
 /*
  * Insert a new page for a given sector, if one does not already exist.
+ * The returned page will grab reference.
  */
 static struct page *brd_insert_page(struct brd_device *brd, sector_t sector,
 		blk_opf_t opf)
-	__releases(rcu)
-	__acquires(rcu)
 {
 	gfp_t gfp = (opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO;
 	struct page *page, *ret;
 
-	rcu_read_unlock();
 	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
-	if (!page) {
-		rcu_read_lock();
+	if (!page)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	xa_lock(&brd->brd_pages);
 	ret = __xa_cmpxchg(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT, NULL,
 			page, gfp);
-	rcu_read_lock();
-	if (ret) {
+	if (!ret) {
+		brd->brd_nr_pages++;
+		get_page(page);
 		xa_unlock(&brd->brd_pages);
-		__free_page(page);
-		if (xa_is_err(ret))
-			return ERR_PTR(xa_err(ret));
+		return page;
+	}
+
+	if (!xa_is_err(ret)) {
+		get_page(ret);
+		xa_unlock(&brd->brd_pages);
+		put_page(page);
 		return ret;
 	}
-	brd->brd_nr_pages++;
+
 	xa_unlock(&brd->brd_pages);
-	return page;
+	put_page(page);
+	return ERR_PTR(xa_err(ret));
 }
 
 /*
@@ -95,7 +105,7 @@ static void brd_free_pages(struct brd_device *brd)
 	pgoff_t idx;
 
 	xa_for_each(&brd->brd_pages, idx, page) {
-		__free_page(page);
+		put_page(page);
 		cond_resched();
 	}
 
@@ -117,7 +127,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 
 	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
-	rcu_read_lock();
 	page = brd_lookup_page(brd, sector);
 	if (!page && op_is_write(opf)) {
 		page = brd_insert_page(brd, sector, opf);
@@ -135,13 +144,13 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 			memset(kaddr, 0, bv.bv_len);
 	}
 	kunmap_local(kaddr);
-	rcu_read_unlock();
 
 	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
+	if (page)
+		put_page(page);
 	return true;
 
 out_error:
-	rcu_read_unlock();
 	if (PTR_ERR(page) == -ENOMEM && (opf & REQ_NOWAIT))
 		bio_wouldblock_error(bio);
 	else
@@ -149,13 +158,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 	return false;
 }
 
-static void brd_free_one_page(struct rcu_head *head)
-{
-	struct page *page = container_of(head, struct page, rcu_head);
-
-	__free_page(page);
-}
-
 static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 {
 	sector_t aligned_sector = round_up(sector, PAGE_SECTORS);
@@ -170,7 +172,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 	while (aligned_sector < aligned_end && aligned_sector < rd_size * 2) {
 		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
 		if (page) {
-			call_rcu(&page->rcu_head, brd_free_one_page);
+			put_page(page);
 			brd->brd_nr_pages--;
 		}
 		aligned_sector += PAGE_SECTORS;
-- 
2.39.2

