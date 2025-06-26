Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37BD1AAE28;
	Thu, 26 Jun 2025 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939485; cv=none; b=hgaue+tzJGSAwJ2mAP/P/HBlktUTl9AgNWudvEYzqDcREgDbwyvDQfjuxKAULM1BedgQo0081mTU/q5TIVbCOcM0cHYXCKXB8p5LYPWIFqJ07Au67KruZRywpRqPlJQ9wf9Vrf+FTXqY2qpWsEmxwlal5+jgpRw9RKvj+u11K0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939485; c=relaxed/simple;
	bh=NX5QkGsObuNd/W50D8W9CoOzLMwdieS+6zPOd+QbUdI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AL0LHtbw5Llu6KByibUlheGY6k2fPF+9qN66b7qOGRqi8YZIdrPvDgeLuHu1zxaO2s175uI+ws88nL8A7ekvLVQAT/avKjlnUt5m/ElC4Dq7p972ra+GQe2aDF9m1JYznn3nbTqnqoWDRTo3mkbjMNF3Gx4hHuCspHRUNfn69NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bScgZ3q7lz10XTj;
	Thu, 26 Jun 2025 19:59:54 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 561F51401F4;
	Thu, 26 Jun 2025 20:04:32 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Jun
 2025 20:04:31 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <axboe@kernel.dk>, <hare@suse.de>, <hch@infradead.org>,
	<john.g.garry@oracle.com>, <yukuai3@huawei.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@redhat.com>, <calvin@wbinvd.org>, <david@fromorbit.com>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<johnny.chenyi@huawei.com>
Subject: [PATCH v2] block: fix false warning in bdev_count_inflight_rw()
Date: Thu, 26 Jun 2025 19:57:43 +0800
Message-ID: <20250626115743.1641443-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500007.china.huawei.com (7.202.194.92)

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
Changes in v2:
 - fix comments grammar;
 - add signed int for percpu summation to prevent overflow;

 block/genhd.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8171a6bc3210..c26733f6324b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -128,23 +128,27 @@ static void part_stat_read_all(struct block_device *part,
 static void bdev_count_inflight_rw(struct block_device *part,
 		unsigned int inflight[2], bool mq_driver)
 {
+	int write = 0;
+	int read = 0;
 	int cpu;
 
 	if (mq_driver) {
 		blk_mq_in_driver_rw(part, inflight);
-	} else {
-		for_each_possible_cpu(cpu) {
-			inflight[READ] += part_stat_local_read_cpu(
-						part, in_flight[READ], cpu);
-			inflight[WRITE] += part_stat_local_read_cpu(
-						part, in_flight[WRITE], cpu);
-		}
+		return;
+	}
+
+	for_each_possible_cpu(cpu) {
+		read += part_stat_local_read_cpu(part, in_flight[READ], cpu);
+		write += part_stat_local_read_cpu(part, in_flight[WRITE], cpu);
 	}
 
-	if (WARN_ON_ONCE((int)inflight[READ] < 0))
-		inflight[READ] = 0;
-	if (WARN_ON_ONCE((int)inflight[WRITE] < 0))
-		inflight[WRITE] = 0;
+	/*
+	 * While iterating all CPUs, some IOs may be issued from a CPU already
+	 * traversed and complete on a CPU that has not yet been traversed,
+	 * causing the inflight number to be negative.
+	 */
+	inflight[READ] = read > 0 ? read : 0;
+	inflight[WRITE] = write > 0 ? write : 0;
 }
 
 /**
-- 
2.39.2

