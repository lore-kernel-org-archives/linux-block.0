Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC320897F;
	Fri, 18 Apr 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744969540; cv=none; b=fwls1fP1OB845A7PGHYo2OiZgfLvYKZl5hPT8Dk1gAQgWzQuSqT1KIYov5ZKIlouUaVl29TYYik5Kl3i5nTxTqG2Nm5FnyT18lJlAqnXjOhGLymF46TURcYGcdYBya+aBeNimwdPNhtVslK+8rpjuUrpEOi/ndcP7yTIfUzPI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744969540; c=relaxed/simple;
	bh=Mck/DO6u1pZ0xBBp03punXg1wKhSA4AsVw2tCWvDC5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FiUHLu7RT6IRn1+FMEBJcdOEjeqXyA+D8tasibarlEqTf7+bvUESSAaHEyt8Ds/+Dw0Zxu3prITxMT97wQ9TzrS8Iz8hY7zNPf2kgJ+AcymVWWLFmmaeIMbRnTeaOAYmVCAEvZxxtVEp1v4U7qZQJwhcUO21Sh00uskMzq2MMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zf8xx68RVz4f3lDF;
	Fri, 18 Apr 2025 17:45:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2E13E1A06DC;
	Fri, 18 Apr 2025 17:45:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGA6HwJozQ1aJw--.29179S9;
	Fri, 18 Apr 2025 17:45:34 +0800 (CST)
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
Subject: [PATCH 5/5] brd: zero data for discard that is not aligned to page
Date: Fri, 18 Apr 2025 17:38:26 +0800
Message-Id: <20250418093826.3149293-6-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBHrGA6HwJozQ1aJw--.29179S9
X-Coremail-Antispam: 1UD129KBjvJXoW7urW5GF43uFWrAF1rAF43Jrb_yoW8Cw4DpF
	4DJryIkrW5Kr17Kw13Jwn8ZFyFv34xGayrGay7u3909w1rGF9Fyas5t3WSqFy8GrWfWF13
	Aan7tryF9r1kA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtV
	W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbPC7UUU
	UUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently brd_do_discard() will just skip unaligned sectors, and in this
case user will still get old data after discard. Fix this by writing
zero data to unaligned sectors.

Fixes: 9ead7efc6f3f ("brd: implement discard support")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/brd.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index bf1e1b2a0d28..b5908703fb4b 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -224,6 +224,21 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 	return err;
 }
 
+static void brd_zero_range(struct brd_device *brd, sector_t sector, u32 size)
+{
+	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
+	struct page *page;
+	void *dst;
+
+	page = brd_lookup_page(brd, sector);
+	if (!page)
+		return;
+
+	dst = kmap_local_page(page);
+	memset(dst + offset, 0, size);
+	kunmap_local(dst);
+}
+
 static void brd_free_one_page(struct rcu_head *head)
 {
 	struct page *page = container_of(head, struct page, rcu_head);
@@ -234,10 +249,17 @@ static void brd_free_one_page(struct rcu_head *head)
 static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 {
 	sector_t aligned_sector = round_up(sector, PAGE_SECTORS);
-	sector_t aligned_end = round_down(sector + (size >> SECTOR_SHIFT),
-					  PAGE_SECTORS);
+	sector_t sector_end = sector + (size >> SECTOR_SHIFT);
+	sector_t aligned_end = round_down(sector_end, PAGE_SECTORS);
 	struct page *page;
 
+	if (aligned_sector > sector)
+		brd_zero_range(brd, sector,
+			       (aligned_sector - sector) << SECTOR_SHIFT);
+	if (aligned_end < sector_end)
+		brd_zero_range(brd, aligned_end,
+			       (sector_end - aligned_end) << SECTOR_SHIFT);
+
 	if (aligned_end <= aligned_sector)
 		return;
 
-- 
2.39.2

