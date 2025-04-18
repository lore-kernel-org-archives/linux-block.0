Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65121E2007;
	Fri, 18 Apr 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744969539; cv=none; b=AArPcT3PPsWOjSHEZKYbiwRe9/+b1rp2oAzU61ah1CjC3mBULrt0ubLRSXVRUpdP3FpqxWSbg1E/p2HhmOYWWIWSg/HGygMZ9HqIUfywcRFKYfZfpP+9o19QHVka/FAv1GopfuklIcgmeq0+gLp/0VCw+ud74SbSHi3uNokTS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744969539; c=relaxed/simple;
	bh=CoasF90lxrVxf/2zxueq4tsA/XQ/Fum79XSA0kCbV1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtUrmXnlzOyG33S8pr65yqmuQ9bUTPT3VVGKSvzGgUaP3417uYIRn5KxVOo8l2abLW489jl2H4M4DvwoxJafe5YuqIGzQdQkG11azZSFYyiJ5WSygRiIv7uPYRCqPybJ987HE7hEtKWuIf0EwwgCoF5sDnMiMY950QY08ScABaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zf8y33DFHz4f3jtW;
	Fri, 18 Apr 2025 17:45:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D98981A058E;
	Fri, 18 Apr 2025 17:45:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGA6HwJozQ1aJw--.29179S6;
	Fri, 18 Apr 2025 17:45:33 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	kbusch@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 2/5] brd: synchronize using page and free page with rcu
Date: Fri, 18 Apr 2025 17:38:23 +0800
Message-Id: <20250418093826.3149293-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250418093826.3149293-1-yukuai1@huaweicloud.com>
References: <20250418093826.3149293-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGA6HwJozQ1aJw--.29179S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4xtF4fJw1kXF45tr4xWFg_yoW8CF18pF
	4UJ34xArZ8Cr4ay3WUX3Z0vFyrX3s7Gay8Gayxu3y5Kw4fGr9Fya48ta4Sqa45GryrCrW3
	Zan0y3y8A34rCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtVW8Zw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8yCGUUUUU
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

Fixes: 9ead7efc6f3f ("brd: implement discard support")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/brd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index a6e4f005cb76..740ed13faaff 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -208,6 +208,7 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 			goto out;
 	}
 
+	rcu_read_lock();
 	mem = kmap_local_page(page);
 	if (!op_is_write(opf)) {
 		copy_from_brd(mem + off, brd, sector, len);
@@ -217,11 +218,19 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 		copy_to_brd(brd, mem + off, sector, len);
 	}
 	kunmap_local(mem);
+	rcu_read_unlock();
 
 out:
 	return err;
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
@@ -232,7 +241,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
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

