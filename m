Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D5554913;
	Tue, 21 May 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716293397; cv=none; b=dI3WPAy6H/OmIbv3YZfjemIwaMvfzAjWIqwV/456gJqVkNGcYwdXINX3aUDl5DQD+HlQefDu9gVQgvFMbGlSnfKn3vtSo8tB1MydRcyrWiJFoNlvU2QIpiQWq81gMFs7DUQBTo3ffLlozgI1bSdFsMGMCdhFPgU29MPz+kUXWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716293397; c=relaxed/simple;
	bh=dVsOdFQiVBeglDIVdK3rYbYBYaDLeM7asWAWgTWT+kY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TJfKrUrxvhFCKvzufljQIK/wOwK4BEWoMVruRGP/B6nQrBGwteuqNmaubq+MCsoGHwM2OkKsabLAo3KUqow1lHqgxDVnNGTb0JDHvKqOkU6XL7sbP41rYVnAZ4mLOD7PkgBNeOXuWH6199hTdWfLEHxaLirMLY9HszP221PM9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VkCt12btrz4f3jkk;
	Tue, 21 May 2024 20:09:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 215331A0568;
	Tue, 21 May 2024 20:09:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RELj0xmeyEbNQ--.4945S4;
	Tue, 21 May 2024 20:09:49 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: czhong@redhat.com,
	xni@redhat.com,
	axboe@kernel.dk,
	yukuai3@huawei.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH -next] block: fix bio lost for plug enabeld bio based device
Date: Wed, 22 May 2024 04:03:08 +0800
Message-Id: <20240521200308.983986-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAGVVp+UZ4stcktsHw0r8ks8LCfXvYJyT+zv93wEfGuuLswArnw@mail.gmail.com>
References: <CAGVVp+UZ4stcktsHw0r8ks8LCfXvYJyT+zv93wEfGuuLswArnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RELj0xmeyEbNQ--.4945S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW5Xw4DWr13Cr4DJFW5Wrg_yoW5uF4DpF
	Z8K3ZxKFWUGF4Igw48XFy7G3WrKFyDWry7JFW5Ca9xJr1jvr4jqw1kJ34FqFWrCrWkWrW3
	Ar93KryDGw4xCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0p
	RQo7tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

With the following two conditions, bio will be lost:

1) blk plug is not enabled, for example, __blkdev_direct_IO_simple() and
__blkdev_direct_IO_async();
2) bio plug is enabled, for example write IO for raid1/raid10 while
bitmap is enabled;

Root cause is that blk_finish_plug() will add the bio to
curent->bio_list, while such bio will not be handled:

__submit_bio_noacct
 current->bio_list = bio_list_on_stack;
 blk_start_plug

 do {
  dm_submit_bio
   md_handle_request
    raid10_write_request
     -> generate new bio for underlying disks
     raid1_add_bio_to_plug -> bio is added to plug
 } while ((bio = bio_list_pop(&bio_list_on_stack[0])))
 -> previous bio are all handled

 blk_finish_plug
  raid10_unplug
   raid1_submit_write
    submit_bio_noacct
     if (current->bio_list)
      bio_list_add(&current->bio_list[0], bio)
      -> add new bio

 current->bio_list = NULL
 -> new bio is lost

Fix the problem by moving plug into the while loop, so that
current->bio_list will still be handled after blk_finish_plug().

By the way, enable plug for raid1/raid10 in this case will also prevent
delay IO handling into daemon thread, which should also improve IO
performance.

Fixes: 060406c61c7c ("block: add plug while submitting IO")
Reported-by: Changhui Zhong <czhong@redhat.com>
Closes: https://lore.kernel.org/all/CAGVVp+Xsmzy2G9YuEatfMT6qv1M--YdOCQ0g7z7OVmcTbBxQAg@mail.gmail.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 01186333c88e..dd29d5465af6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -613,9 +613,14 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 
 static void __submit_bio(struct bio *bio)
 {
+	/* If plug is not used, add new plug here to cache nsecs time. */
+	struct blk_plug plug;
+
 	if (unlikely(!blk_crypto_bio_prep(&bio)))
 		return;
 
+	blk_start_plug(&plug);
+
 	if (!bio->bi_bdev->bd_has_submit_bio) {
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
@@ -624,6 +629,8 @@ static void __submit_bio(struct bio *bio)
 		disk->fops->submit_bio(bio);
 		blk_queue_exit(disk->queue);
 	}
+
+	blk_finish_plug(&plug);
 }
 
 /*
@@ -648,13 +655,11 @@ static void __submit_bio(struct bio *bio)
 static void __submit_bio_noacct(struct bio *bio)
 {
 	struct bio_list bio_list_on_stack[2];
-	struct blk_plug plug;
 
 	BUG_ON(bio->bi_next);
 
 	bio_list_init(&bio_list_on_stack[0]);
 	current->bio_list = bio_list_on_stack;
-	blk_start_plug(&plug);
 
 	do {
 		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
@@ -688,23 +693,19 @@ static void __submit_bio_noacct(struct bio *bio)
 		bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
 	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
 
-	blk_finish_plug(&plug);
 	current->bio_list = NULL;
 }
 
 static void __submit_bio_noacct_mq(struct bio *bio)
 {
 	struct bio_list bio_list[2] = { };
-	struct blk_plug plug;
 
 	current->bio_list = bio_list;
-	blk_start_plug(&plug);
 
 	do {
 		__submit_bio(bio);
 	} while ((bio = bio_list_pop(&bio_list[0])));
 
-	blk_finish_plug(&plug);
 	current->bio_list = NULL;
 }
 
-- 
2.39.2

