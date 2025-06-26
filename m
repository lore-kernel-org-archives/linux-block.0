Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE732D3EC2;
	Thu, 26 Jun 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927583; cv=none; b=qiXCmojySQgcilso6kVa0dVx830ev17Pf2Hxj7+MCAPh8G0k4QYYKJ5yMhsikDamjZxM2I3XXjOoZ7prPnvh108UVQK1GrKhGFXdCAhjBFifBcF+6O/wlvmiemNHOPOl525wqEOVirtJhnJWkFoynp6J6cfbMlgMmaKgX0dQeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927583; c=relaxed/simple;
	bh=EBIMriXYLknyxbuxf7NSXkhKwNDOPZ5by7UkqYR9Al4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sDkz3QwKRRK3vKUuVP6Z1XT0deFO7x09GF1DMKIneriaW3wNoztSC0PU25YRY/Ae32k/wDqxQoxwAdhkKf3aYKutVbRTfEMtDelUBQEqXhrpzA169Fqjap2D/yVA3VfBEmj4dwdI9n5a6fTSiH4jqgpEq4U6/imqDeoqHf5RygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bSXNB4JLyzYQvMC;
	Thu, 26 Jun 2025 16:46:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7AAF71A0A0F;
	Thu, 26 Jun 2025 16:46:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl_WCF1oD6HNQg--.23903S4;
	Thu, 26 Jun 2025 16:46:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	hare@suse.de,
	hch@infradead.org,
	yukuai3@huawei.com,
	john.g.garry@oracle.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@redhat.com,
	calvin@wbinvd.org,
	david@fromorbit.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH] block: fix false warning in bdev_count_inflight_rw()
Date: Thu, 26 Jun 2025 16:39:27 +0800
Message-Id: <20250626083927.576207-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl_WCF1oD6HNQg--.23903S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4rJFWUAFWrXFykWFyUZFb_yoW8ZFWfpF
	4UGws8JFyUWr93ta1jgwn7XFy3ta1kJryxur17Zw13AFWkAr1Uu34vvr4Dtr9Fq393Gry0
	9F1akFyxKa4v937anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

While bdev_count_inflight is interating all cpus, if some IOs are issued
from traversed cpu and then completed from the cpu that is not traversed
yet:

cpu0
		cpu1
		bdev_count_inflight
		 //for_each_possible_cpu
		 // cpu0 is 0
		 infliht += 0
// issue a io
blk_account_io_start
// cpu0 inflight ++

				cpu2
				// the io is done
				blk_account_io_done
				// cpu2 inflight --
		 // cpu 1 is 0
		 inflight += 0
		 // cpu2 is -1
		 inflight += -1
		 ...

In this case, the total inflight will be -1, causing lots of false
warning. Fix the problem by removing the warning.

Noted there is still a valid warning for nvme-mpath(From Yi) that is not
fixed yet.

Fixes: f5482ee5edb9 ("block: WARN if bdev inflight counter is negative")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/aFtUXy-lct0WxY2w@mozart.vkv.me/T/#mae89155a5006463d0a21a4a2c35ae0034b26a339
Reported-and-tested-by: Calvin Owens <calvin@wbinvd.org>
Closes: https://lore.kernel.org/linux-block/aFtUXy-lct0WxY2w@mozart.vkv.me/T/#m1d935a00070bf95055d0ac84e6075158b08acaef
Reported-by: Dave Chinner <david@fromorbit.com>
Closes: https://lore.kernel.org/linux-block/aFuypjqCXo9-5_En@dread.disaster.area/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8171a6bc3210..680fa717082f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -141,9 +141,14 @@ static void bdev_count_inflight_rw(struct block_device *part,
 		}
 	}
 
-	if (WARN_ON_ONCE((int)inflight[READ] < 0))
+	/*
+	 * While iterating all cpus, some IOs might issued from traversed cpu
+	 * and then completed from the cpu that is not traversed yet, causing
+	 * the inflight number to be negative.
+	 */
+	if ((int)inflight[READ] < 0)
 		inflight[READ] = 0;
-	if (WARN_ON_ONCE((int)inflight[WRITE] < 0))
+	if ((int)inflight[WRITE] < 0)
 		inflight[WRITE] = 0;
 }
 
-- 
2.39.2

