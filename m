Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F503EE1C1;
	Wed,  8 Jul 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496839; cv=none; b=RbBx5HdHoY+QX0+qGhu6UkGVaMy4Vzq1PHgv2BqQu1KoKIK/jDiO3UVBZWHD5XbJdwELcgg3MVTPqyYGiKKR8pG9/EDy16HwGzrclSgdeGQONJxEmw4WHjyyTe4/9TN20Rs/qjqKNh/ri9SEwHo9LwHEl3aJuo2gdvocjagxkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496839; c=relaxed/simple;
	bh=VTLm2Q13VPAuj5dzdF6Pmz5D4NOfxDwmIri/EFvBunw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbSjNtWR4lDrrT7x9xn52hGjzt7ZKld+RRsS0xahv9//FerXUQKHgWaiqR2MOH/PEjC7KVvKm7QS0FSGkMLL/409xRtzoiK19RYym8e+5Ula2X7yCBeqsR9bdq3frojo4mmlUrOSJRYWzsFsGlEZG1xKKLlsAZyWO6bODDG0Nbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gw9Cn19XYzYQtkf;
	Wed,  8 Jul 2026 15:47:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D16D74056E;
	Wed,  8 Jul 2026 15:47:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCnt3N4AE5qQOTkAQ--.19577S7;
	Wed, 08 Jul 2026 15:47:05 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	bvanassche@acm.org,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V3 3/6] null_blk: move unregister_blkdev() after destroying dev in null_exit()
Date: Wed,  8 Jul 2026 15:39:14 +0800
Message-ID: <20260708073917.2172392-4-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
References: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnt3N4AE5qQOTkAQ--.19577S7
X-Coremail-Antispam: 1UD129KBjvJXoWrZr4kuw1fAw15ZFyfGr15urg_yoW8JrW5pr
	W5W340kr1jkF1UZw4UCa1xGFy5Jan7Jry09rWUCa4rZwsxZry2kr1DJa45XF1UJw4xCFsa
	vF1vqa4fJayDCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFF4i
	UUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

In null_exit(), unregister_blkdev() is called before the null_blk instances
are destroyed, which is inconsistent with the cleanup order in null_init().
Move it after null_destroy_dev() so that teardown happens in the reverse
order of initialization.

No functional change intended.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 4613035222cd..6cb213779cc5 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2194,8 +2194,6 @@ static void __exit null_exit(void)
 
 	configfs_unregister_subsystem(&nullb_subsys);
 
-	unregister_blkdev(null_major, "nullb");
-
 	mutex_lock(&lock);
 	while (!list_empty(&nullb_list)) {
 		nullb = list_entry(nullb_list.next, struct nullb, list);
@@ -2203,6 +2201,8 @@ static void __exit null_exit(void)
 	}
 	mutex_unlock(&lock);
 
+	unregister_blkdev(null_major, "nullb");
+
 	if (tag_set.ops)
 		blk_mq_free_tag_set(&tag_set);
 
-- 
2.52.0

