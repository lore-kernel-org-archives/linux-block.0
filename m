Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845E61EE7BE;
	Fri, 18 Apr 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744969539; cv=none; b=EP/saHjIRe7wnbTVE/ngOia9c12z5m5iDuXj0zUtt5lgA3NZKc3Py7mZwb7h+sOyINoOfxdNfUPwXlSc7rx1ve1UkShFS4Y2SEfooNpbD2PrA2Cmh1XK4RKulm9VvQoqzVAHHm43BkkKRMdjQGXgpFoBVcDOYOBXvdhSuwX8u7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744969539; c=relaxed/simple;
	bh=9OP0rY0s+GQSK1skRZFWmADM/fZR4WYEsAi8q5xSNJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g9Y0++nm/DiCIK39+akDGuVPxGC4vPj5r0HDY4p0j3rKtipk/Wxth3l5E/v4lNoKD1LWTItrkjGAZxAzPH1ajXGzqK4kmdyLv8xRozdvztrssjd3WHmNzHMCcuK19Ol1f8ox8BO5okqa/du3TeaUiJTVxS0YWf0ZJHxuWjxl1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zf8xw14Xqz4f3lff;
	Fri, 18 Apr 2025 17:45:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 712AF1A07BB;
	Fri, 18 Apr 2025 17:45:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGA6HwJozQ1aJw--.29179S5;
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
Subject: [PATCH 1/5] brd: fix oops if write concurrent with discard
Date: Fri, 18 Apr 2025 17:38:22 +0800
Message-Id: <20250418093826.3149293-2-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBHrGA6HwJozQ1aJw--.29179S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyrGFWUGw1kAF1fAr1rCrg_yoW5Ar4kpF
	43ArZ3J390qa15twnrXrn0kr15Wwn2kay8Way3Ca1Fgrs7uwnFyF1rJFWIq343Kr17CrZ3
	CrWDJay8Zr18uwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUtVW8Zw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5a0mUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

User can issue write and discard concurrently, causing following BUG_ON:
cpu0:
brd_submit_bio
 brd_do_bve
  copy_to_brd_setup
   brd_insert_page
    xa_lock
    __xa_insert
    xa_unlock
				cpu1
				brd_submit_bio
				 brd_do_discard
				  xa_lock
				  page = __xa_erase
				  __free_page
				  xa_unlock
  copy_to_brd
   brd_lookup_page
    page = xa_load
    BUG_ON(!page)

Fix this problem by skipping the write, and user will get zero data
later if the page is not here.

Also fix following checkpatch warnings:
WARNING: Deprecated use of 'kmap_atomic', prefer 'kmap_local_page' instead
WARNING: Deprecated use of 'kunmap_atomic', prefer 'kunmap_local' instead

Fixes: 9ead7efc6f3f ("brd: implement discard support")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/block/brd.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 292f127cae0a..a6e4f005cb76 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -133,22 +133,22 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
 	page = brd_lookup_page(brd, sector);
-	BUG_ON(!page);
-
-	dst = kmap_atomic(page);
-	memcpy(dst + offset, src, copy);
-	kunmap_atomic(dst);
+	if (page) {
+		dst = kmap_local_page(page);
+		memcpy(dst + offset, src, copy);
+		kunmap_local(dst);
+	}
 
 	if (copy < n) {
 		src += copy;
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
 		page = brd_lookup_page(brd, sector);
-		BUG_ON(!page);
-
-		dst = kmap_atomic(page);
-		memcpy(dst, src, copy);
-		kunmap_atomic(dst);
+		if (page) {
+			dst = kmap_local_page(page);
+			memcpy(dst, src, copy);
+			kunmap_local(dst);
+		}
 	}
 }
 
@@ -166,9 +166,9 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
 	page = brd_lookup_page(brd, sector);
 	if (page) {
-		src = kmap_atomic(page);
+		src = kmap_local_page(page);
 		memcpy(dst, src + offset, copy);
-		kunmap_atomic(src);
+		kunmap_local(src);
 	} else
 		memset(dst, 0, copy);
 
@@ -178,9 +178,9 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 		copy = n - copy;
 		page = brd_lookup_page(brd, sector);
 		if (page) {
-			src = kmap_atomic(page);
+			src = kmap_local_page(page);
 			memcpy(dst, src, copy);
-			kunmap_atomic(src);
+			kunmap_local(src);
 		} else
 			memset(dst, 0, copy);
 	}
@@ -208,7 +208,7 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 			goto out;
 	}
 
-	mem = kmap_atomic(page);
+	mem = kmap_local_page(page);
 	if (!op_is_write(opf)) {
 		copy_from_brd(mem + off, brd, sector, len);
 		flush_dcache_page(page);
@@ -216,7 +216,7 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 		flush_dcache_page(page);
 		copy_to_brd(brd, mem + off, sector, len);
 	}
-	kunmap_atomic(mem);
+	kunmap_local(mem);
 
 out:
 	return err;
-- 
2.39.2

