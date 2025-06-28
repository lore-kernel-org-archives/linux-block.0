Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0DBF9CB;
	Sat, 28 Jun 2025 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751073719; cv=none; b=ngjBr7erVO8hY0nJF6ODVbCfuYDy6VKvc8Iwzz12otm7SQ47e+vHpkgpLNHiIh/Gg79bxzuJVIMS/WWHp9fwH65y/EY8mv9ZpkQnNAHyhDq9FEyO599T3MOg5HPOu2ZwLkGv8ugW0CmVBbDNDvxmgKvzp624IzSTsGLJfp9UllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751073719; c=relaxed/simple;
	bh=9iEULhb/XPU3L5BGh2VZhi02qzir0c9hgvK+zpaAsL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u2qyppcH9wk0MKztG2dagMCUNiFrNfmq3u201ppSiayDXkNXCcR+2L2UfIAEHw0jPzMspx3Ou1DJB7qU1ciDfe73p8g+1EjSUI3bHSjzO0yeWXLQQLq43uCOLAOiy45gUv8hmcfrHOFyGZB0IVAzyo256BND0AUp5SD+WrYDPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bTZQW1j8lzYQv7p;
	Sat, 28 Jun 2025 09:21:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 21DAC1A08FC;
	Sat, 28 Jun 2025 09:21:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1+wQ19oAwx+Qw--.4287S4;
	Sat, 28 Jun 2025 09:21:53 +0800 (CST)
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
Date: Sat, 28 Jun 2025 09:14:58 +0800
Message-Id: <20250628011459.832760-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu1+wQ19oAwx+Qw--.4287S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW5XFW7JFyUGr17WryfZwb_yoW8Gr4DpF
	ZF9Fy5Cry5CF42v3W7Z3WDCF1rGa95WayIka45Zw4F9rW3Ar9I934Ik34aq3W5GrW7AFs8
	ZFs8tw1kAFWUAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDU
	UUU
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

