Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0740C125D6;
	Sat, 28 Jun 2025 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751073719; cv=none; b=nWDGDsvEEY25nJ71oZy7vlVPwAEdTeM/J96kW0QrSa1gFrZBezK750RXb/0YnG5eeaODyq7LbBN/Pl17KcCAnM/lXUgCSyjwLHgi+piDzMvnatIp3sJGJ2bA32/ShVK2lLiczcN8qztQGGBipEhTW00QjH0mFwusw2tzXc1K948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751073719; c=relaxed/simple;
	bh=9iEULhb/XPU3L5BGh2VZhi02qzir0c9hgvK+zpaAsL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+tx+xjWog+wk7MeRSeVVmKTz9yo0XnSaNI2r8P0H17gSBA6bikN1Qsbzi5v2u/C9hFCbPhzM+DcZzkai5B7gTaVqUfLt+XwIZ8T+wbB6g+46lXpy8TPtOOmqRmgH2/LAusFWNQB/yHQtuBzC5E+pBHBCCWJYqcryWdRyfuY2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bTZQX16VpzKHLwM;
	Sat, 28 Jun 2025 09:21:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8654C1A0B1A;
	Sat, 28 Jun 2025 09:21:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1+wQ19oAwx+Qw--.4287S5;
	Sat, 28 Jun 2025 09:21:54 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH] brd: fix leeping function called from invalid context in brd_insert_page()
Date: Sat, 28 Jun 2025 09:14:59 +0800
Message-Id: <20250628011459.832760-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250628011459.832760-1-yukuai1@huaweicloud.com>
References: <20250628011459.832760-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu1+wQ19oAwx+Qw--.4287S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW5XFW7JFyUGr17WryfZwb_yoW8Gr4DpF
	ZF9Fy5Cry5CF42v3W7Z3WDCF1rGa95WayIka45Zw4F9rW3Ar9I934Ik34aq3W5GrW7AFs8
	ZFs8tw1kAFWUAa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVW8ZVWrXw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRdManUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

__xa_cmpxchg() is called with rcu_read_lock(), and it will allocated
memory if necessary.

Fix the problem by moving rcu_read_lock() after __xa_cmpxchg, meanwhile,
it still should be held before xa_unlock(), prevent returned page to be
freed by concurrent discard.

Fixes: bbcacab2e8ee ("brd: avoid extra xarray lookups on first write")
Reported-by: syzbot+ea4c8fd177a47338881a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/685ec4c9.a00a0220.129264.000c.GAE@google.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/brd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index b1be6c510372..0c2eabe14af3 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -64,13 +64,15 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector,
 
 	rcu_read_unlock();
 	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
-	rcu_read_lock();
-	if (!page)
+	if (!page) {
+		rcu_read_lock();
 		return ERR_PTR(-ENOMEM);
+	}
 
 	xa_lock(&brd->brd_pages);
 	ret = __xa_cmpxchg(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT, NULL,
 			page, gfp);
+	rcu_read_lock();
 	if (ret) {
 		xa_unlock(&brd->brd_pages);
 		__free_page(page);
-- 
2.39.2

