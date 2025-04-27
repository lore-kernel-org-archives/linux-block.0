Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894F1F2BB8;
	Sun, 27 Apr 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745743630; cv=none; b=hTqnW2gLiJGplrtl7hs/W/LyC6S8NpU0+XTdDYIaKO5hXDrkOu7SsJqhjhC6Ov7Fy+WcrckzBGExTBsysMm5eFhgFWkUl/qj3ySkSI5FPKAzYJ9R4zqh+qQlSlUvUsdJyCb+kyjGx8VOTNvsj8+t19oWEqOBfeRoePR6LHujM7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745743630; c=relaxed/simple;
	bh=XwrSdbCLA/EQUOEI9aDPZreHP0OwEiSLKYCMdVl49tM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tBr/RR4+U+7qhahoRpck67VFbhweIi1ba7NWls/ktMc72ASBSLvJm0OBjhgThSEAhXEU2RkBnsSyV/EiE7FoBU6IaRRy0kSv9Y2YvmskjbpBP7K943orUniSEsF7Bib9qZV9fQ5BhQ4734+I1rojzjZXkYigV4TJZEC+zUxPixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ZlgDq4jpwzKHMjY;
	Sun, 27 Apr 2025 16:47:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A67071A13B4;
	Sun, 27 Apr 2025 16:47:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAXenoG7w1oOVIpKg--.9945S7;
	Sun, 27 Apr 2025 16:47:06 +0800 (CST)
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
Subject: [PATCH v2 3/3] brd: fix discard end sector
Date: Sun, 27 Apr 2025 16:39:25 +0800
Message-Id: <20250427083925.157984-4-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAXenoG7w1oOVIpKg--.9945S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rCrWxuFW7Kr4UGw15Arb_yoW8WryrpF
	4UJFZ2vry5Ar1Ut3W3X3s8uryFqayxGa4ftay7u3yY9r4fGr9F9ayxt34FqayUGrWfWFy3
	A3Zay34rZrykA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUCg4hUUUUU=
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
index 567aee2f882c..10381a1dd44e 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -161,18 +161,21 @@ static void brd_free_one_page(struct rcu_head *head)
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

