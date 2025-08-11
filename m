Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A64C92;
	Mon, 11 Aug 2025 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895850; cv=none; b=iOSbKOz1LeJShy9XgHhzsFVKMDRyBhmGEhD7P3YFkoD6/8XmYlFvrXJ5v38VOoy8tAR2UKSc8peSYfW57u0c2JBCjudG46ObCM8A2Hq0srBj+LnE3JqirrZTOOKCALvZqaUz4Pf6IfYdh/nPUgqqXToqWWutERhftt2vdAsF0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895850; c=relaxed/simple;
	bh=JIPbetEpu3maNjCcPqdYM8ug+A8oaIjLNujTwnE3EL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qc4hjtwoEIvl6KRzZlRXA1ctD0TiJF20SjpipbavW9ts1hoAf5DuJV8AK0tcSqsHrZ5oz7rdo+JasDTfdpJkugj58quZCul3OStP4WtPwN4/uJBPvVzjesex5M9gXi5BuS9WSY+n1MWG076/cM1SfN7i+ictvc5pPza6CJniv20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c0lx10JDKzKHMYR;
	Mon, 11 Aug 2025 15:04:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3C6741A018D;
	Mon, 11 Aug 2025 15:04:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxDhlZloBiszDQ--.47588S4;
	Mon, 11 Aug 2025 15:04:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@lst.de,
	houtao1@huawei.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3] brd: use page reference to protect page lifetime
Date: Mon, 11 Aug 2025 14:56:28 +0800
Message-Id: <20250811065628.1829339-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxDhlZloBiszDQ--.47588S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr43Cw1DJrW3Aw18Xr4rAFb_yoWrZw13pF
	WUtF97A3y5GF4akw13Xwn8ur13K34IgayfKa4fJw4Skr4fCr9Fy3Wxt34Fqa15GrW8CrWD
	AFsxtF18CrsYq3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

As discussed [1], hold rcu for copying data from/to page is too heavy,
it's better to protect page with rcu around for page lookup and then
grab a reference to prevent page to be freed by discard.

[1] https://lore.kernel.org/all/eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk/

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes from v2:
 - move xas_reset() to error path;
 - remove unnecessary checking xa_is_value();
Changes from v1:
 - refer to filemap_get_entry(), use xas_load + xas_reload to fix
 concurrent problems.

 drivers/block/brd.c | 75 +++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 0c2eabe14af3..9778259b30d4 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -44,45 +44,74 @@ struct brd_device {
 };
 
 /*
- * Look up and return a brd's page for a given sector.
+ * Look up and return a brd's page with reference grabbed for a given sector.
  */
 static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 {
-	return xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
+	struct page *page;
+	XA_STATE(xas, &brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
+
+	rcu_read_lock();
+repeat:
+	page = xas_load(&xas);
+	if (xas_retry(&xas, page)) {
+		xas_reset(&xas);
+		goto repeat;
+	}
+
+	if (!page)
+		goto out;
+
+	if (!get_page_unless_zero(page)) {
+		xas_reset(&xas);
+		goto repeat;
+	}
+
+	if (unlikely(page != xas_reload(&xas))) {
+		put_page(page);
+		xas_reset(&xas);
+		goto repeat;
+	}
+out:
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
+		xa_unlock(&brd->brd_pages);
+		return page;
+	}
+
+	if (!xa_is_err(ret)) {
+		get_page(ret);
 		xa_unlock(&brd->brd_pages);
-		__free_page(page);
-		if (xa_is_err(ret))
-			return ERR_PTR(xa_err(ret));
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
@@ -95,7 +124,7 @@ static void brd_free_pages(struct brd_device *brd)
 	pgoff_t idx;
 
 	xa_for_each(&brd->brd_pages, idx, page) {
-		__free_page(page);
+		put_page(page);
 		cond_resched();
 	}
 
@@ -117,7 +146,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 
 	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
-	rcu_read_lock();
 	page = brd_lookup_page(brd, sector);
 	if (!page && op_is_write(opf)) {
 		page = brd_insert_page(brd, sector, opf);
@@ -135,13 +163,13 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
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
@@ -149,13 +177,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
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
@@ -170,7 +191,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
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

