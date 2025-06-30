Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2373B25D21A;
	Mon, 30 Jun 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283339; cv=none; b=boxu4FlYDTb4CvFMsLtRD57btB1BSiZinRL/7R1R640OWWvhmdW4jWlZDmBKB6pADMeAKziVQa8liL81+RENCtRQ75BO8s4mHRlMebZCy1yMKNvyNX5qwsFNVgWwANr4jq+zwS8mJFM6O9kOL0+54yEiZoE/WKxQKAhyXhMxNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283339; c=relaxed/simple;
	bh=j8vjuXopMOzgU6kVsIB49GXlMX2NKPWeeErZMdyvwJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K8Te/yFUI95U5gLZ0rj5n9PWA+eAhffFd3yog5RGn8KZsEysfKYvMUa+FAFnWiKmodTULvbyyL0hGjsHJR2PTMDPLkfJ1AMVzoEd/AORkup9F7o4yipjKMNyWTmjqD+7ImJnbPmk24Pz1TSOX+F2Kd1n9cF3yLv22BiRC7cohDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bW3xg3sxFzYQvwn;
	Mon, 30 Jun 2025 19:35:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 68F031A1741;
	Mon, 30 Jun 2025 19:35:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgBnxySCdmJomWTTAA--.54607S4;
	Mon, 30 Jun 2025 19:35:32 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@lst.de,
	axboe@kernel.dk,
	yukuai3@huawei.com
Cc: penguin-kernel@I-love.SAKURA.ne.jp,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2] brd: fix sleeping function called from invalid context in brd_insert_page()
Date: Mon, 30 Jun 2025 19:28:28 +0800
Message-Id: <20250630112828.421219-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnxySCdmJomWTTAA--.54607S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW5XFW7JFyUGr17WryfZwb_yoW8Xr1xpF
	ZIvFy7Cry5CF42v3W7Z3ZrCF1rGa93WayIkFyYqw1F9rW3Jry2934Ik34Yq3W5GrWxAFs8
	ZFs0ywn5AFWDA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

__xa_cmpxchg() is called with rcu_read_lock(), and it will allocate
memory if necessary.

Fix the problem by moving rcu_read_lock() after __xa_cmpxchg(), meanwhile,
it still should be held before xa_unlock(), prevent returned page to be
freed by concurrent discard.

Fixes: bbcacab2e8ee ("brd: avoid extra xarray lookups on first write")
Reported-by: syzbot+ea4c8fd177a47338881a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/685ec4c9.a00a0220.129264.000c.GAE@google.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes in v2:
 - fix typo in the subject
 - add review tag.

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

