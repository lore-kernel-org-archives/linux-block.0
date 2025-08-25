Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3522C325D;
	Mon, 25 Aug 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114840; cv=none; b=dvSSJ3neOhLy9BaxxFgqnq7TEWOdUxjrnzNIIHCd86crkH1ym3PJfrkKxhZMPi002cog2+dGzeqA2H7hYhl69jgKF7ymSfHBbACTRrsPkGKI5QmoQGka9pbglrwrO7HzZCv5GJhX1WQQSNL3eMRm+7DmblqiGbaTp3GQAHn0AAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114840; c=relaxed/simple;
	bh=KCdWXka9iUATzabyiJtKJBa5aHa4D/RfatKkHfWhyLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YGWDoj1b64vowFNTKnmp7O2w5UxlGhru5IpJ1VNyM9A/1AZ/PlCUpdCdW1nso/y+H+5O6kR4+UprGuLA0QwOMMiggRFIxRje8+bt3aa45hd0OOUlMbxmweN3K775WKfMtzbybC9hAHjqQxw2J4QuDrVUO1xkGP97Cxw28eMKzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9Ql761g9zYQvc7;
	Mon, 25 Aug 2025 17:40:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 603FA1A0EB5;
	Mon, 25 Aug 2025 17:40:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAncIyOL6xoWDXxAA--.44691S4;
	Mon, 25 Aug 2025 17:40:32 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
	hch@infradead.org,
	axboe@kernel.dk,
	yukuai3@huawei.com,
	rajeevm@hpe.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2] loop: fix zero sized loop for block special file
Date: Mon, 25 Aug 2025 17:32:05 +0800
Message-Id: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAncIyOL6xoWDXxAA--.44691S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWrGFyUur47ZF47uw4kWFg_yoW8urWUpF
	W3uFyayryYgFnrCanrZw17Xa4rGan3u3yUury2g34093W3Arya9as5tFyrWr1jqFy3Ja1Y
	qayDJFy0kryDZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

By default, /dev/sda is block specail file from devtmpfs, getattr will
return file size as zero, causing loop failed for raw block device.

We can add bdev_statx() to return device size, however this may introduce
changes that are not acknowledged by user. Fix this problem by reverting
changes for block special file, file mapping host is set to bdev inode
while opening, and use i_size_read() directly to get device size.

Fixes: 47b71abd5846 ("loop: use vfs_getattr_nosec for accurate file size")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508200409.b2459c02-lkp@intel.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2:
 - don't call vfs_getattr_nosec() for block special file path, by Ming

 drivers/block/loop.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 57263c273f0f..053a086d547e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -139,20 +139,26 @@ static int part_shift;
 
 static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
 {
-	struct kstat stat;
 	loff_t loopsize;
 	int ret;
 
-	/*
-	 * Get the accurate file size. This provides better results than
-	 * cached inode data, particularly for network filesystems where
-	 * metadata may be stale.
-	 */
-	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
-	if (ret)
-		return 0;
+	if (S_ISBLK(file_inode(file)->i_mode)) {
+		loopsize = i_size_read(file->f_mapping->host);
+	} else {
+		struct kstat stat;
+
+		/*
+		 * Get the accurate file size. This provides better results than
+		 * cached inode data, particularly for network filesystems where
+		 * metadata may be stale.
+		 */
+		ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
+		if (ret)
+			return 0;
+
+		loopsize = stat.size;
+	}
 
-	loopsize = stat.size;
 	if (lo->lo_offset > 0)
 		loopsize -= lo->lo_offset;
 	/* offset is beyond i_size, weird but possible */
-- 
2.39.2

