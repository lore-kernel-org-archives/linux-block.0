Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535BA1A2545;
	Mon, 25 Aug 2025 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103494; cv=none; b=QEbq2JZBbyaL2dLuuNh7wIL2F06+ZBAsV5LUf8qEVkDRH1wXabc4heU0ItKBUjNkHlOlIbzG9/jwzOt0yYlOa+/d0m4TVXiZtT7b47Bx/KSQ/BNTJHRIzvQa52aEyphwHlbZnPEvJl6b4qpc8vZGe/kEOVBdwnzlz6ICOMgSWPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103494; c=relaxed/simple;
	bh=qxNFBtrUHyxUH0+Kcfo1VIL72NHUL68DVR49bWxAakI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gO3XZp+gA2lvmqJcU0Nw2yzfCumq1ZEAKYfXaEFn2ovY2Q296wmvexurZyHh5YlAPBqpad4RT3eQJutRsDXHMSyB/fk2jhm5isrpYdi/5v75VZTUrIZ8f839VO+wes/jzeKxwEKJgLxu1Cz6dglf1CAurQppIoHTyb3l8In96Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9LXx2LLJzKHNP1;
	Mon, 25 Aug 2025 14:31:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E23771A15CE;
	Mon, 25 Aug 2025 14:31:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Iw9A6xov_fhAA--.56599S4;
	Mon, 25 Aug 2025 14:31:27 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
	axboe@kernel.dk,
	rajeevm@hpe.com,
	yukuai3@huawei.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH] loop: fix zero sized loop for block special file
Date: Mon, 25 Aug 2025 14:23:00 +0800
Message-Id: <20250825062300.2485281-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Iw9A6xov_fhAA--.56599S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWrGFyUur47ZF47uw4kWFg_yoW8Jw4UpF
	43Ga4YyryFkF4qga1DJw17Za4rKanxurW7ua4jvw1S9ayayrnI9as5tay3W3WjqrZxJF4Y
	qan8Jry8ZryUXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
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
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 57263c273f0f..cde235bd883c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -153,6 +153,9 @@ static loff_t lo_calculate_size(struct loop_device *lo, struct file *file)
 		return 0;
 
 	loopsize = stat.size;
+	if (!loopsize && S_ISBLK(stat.mode))
+		loopsize = i_size_read(file->f_mapping->host);
+
 	if (lo->lo_offset > 0)
 		loopsize -= lo->lo_offset;
 	/* offset is beyond i_size, weird but possible */
-- 
2.39.2

