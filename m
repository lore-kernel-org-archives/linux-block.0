Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BB25BEE5;
	Thu, 21 Aug 2025 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756872; cv=none; b=or6wR3/oO4mDEOhTxPLvx2pfs83VThUCJznZNwdpi+b7+fHrGbu6bdRyqpEWR8ntKub7reiNcT1/YRT91gdp2ZYOJtX9NR5FSpEgamRitn/EhgSp0lIN8mwCGQzCURA3GQYkIfhhJ9V17FJW/c7OgXcpv/oVRGO18XgYMs2Huho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756872; c=relaxed/simple;
	bh=KYTBw6/xpdbfF0Dzd2lC+0PXXgqCUK9J81leywdKgWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CI+n7zBtQYCydd1c3IWCuE49AEtxbfSoQThzQkwNpy9EZakEJp8oiRL5yYV6ah5neESG5EZP0rrD7ZN+e+DAwVl3z3hAHx+aRoYpgbojjvrI8Mjs4NTwLXERoLDcux/hTxIrSYDn9omCcyTGI9o7cIPwapMMksa613GgdM5ZO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c6tM80jV7zKHNXh;
	Thu, 21 Aug 2025 14:14:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8B5841A07E8;
	Thu, 21 Aug 2025 14:14:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHERI+uaZoxBuhEQ--.58405S6;
	Thu, 21 Aug 2025 14:14:25 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: yukuai3@huawei.com,
	axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	hare@suse.de
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 2/2] blk-mq: fix blk_mq_tags double free while nr_requests grown
Date: Thu, 21 Aug 2025 14:06:12 +0800
Message-Id: <20250821060612.1729939-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
References: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERI+uaZoxBuhEQ--.58405S6
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4DGr17tr47Ary3uF4kZwb_yoW8Gw17pF
	W3Ga1jkrySgr12yFZrGa4xZ345Kw4DXr1FgrsYy34rGr1j9r4S9rs2grs2qF18Zrs2ka9x
	ZrZFkF93XryDG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

In the case user trigger tags grow by queue sysfs attribute nr_requests,
hctx->sched_tags will be freed directly and replaced with a new
allocated tags, see blk_mq_tag_update_depth().

The problem is that hctx->sched_tags is from elevator->et->tags, while
et->tags is still the freed tags, hence later elevator exit will try to
free the tags again, causing kernel panic.

Fix this problem by replacing et->tags with new allocated tags as well.

Noted there are still some long term problems that will require some
refactor to be fixed thoroughly[1].

[1] https://lore.kernel.org/all/20250815080216.410665-1-yukuai1@huaweicloud.com/
Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Nilay Shroff<nilay@linux.ibm.com>
---
 block/blk-mq-tag.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d880c50629d6..5cffa5668d0c 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -622,6 +622,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 			return -ENOMEM;
 
 		blk_mq_free_map_and_rqs(set, *tagsptr, hctx->queue_num);
+		hctx->queue->elevator->et->tags[hctx->queue_num] = new;
 		*tagsptr = new;
 	} else {
 		/*
-- 
2.39.2

