Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78BA20C01C;
	Tue, 19 Aug 2025 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567447; cv=none; b=u/nIGeXZoBKIH+YuA0r1H/EX3H/pbMVaxksFaQcc1e6PWmcRUItbxbyScnOgqtuyvEZaWhGFFoyAk1yTVCFy0Pwwa5E4gbaKzKSuRibc9/K2gTW5Lj3EZ1ws3LZmMb6jhVSSlesbO2gkWAo5Z4ZksZK0GImjulXIdenyK4vvOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567447; c=relaxed/simple;
	bh=FSJudYQTSDZW86/RjY87jgMacmrvlS5RP+oQPt2SvGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCF23K07HyQfhrDjjdsL+S/U1mY+7tLmSy+APHo/6Cn4FKYV3orsh1W/jOcPIPiI/L5lRX7YZ7Rb9XVGR+bOFxmhiLfTZH6jVIOIykDbNE9hDhsqsPB8nNm/sjvieysUJePT/55dHYTCN1n07sXCy8vLz7/3RWL/LsQ0dFh5ywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c5XJN0QTqzKHMhm;
	Tue, 19 Aug 2025 09:37:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 751511A0359;
	Tue, 19 Aug 2025 09:37:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgA3sxNP1aNouL+mEA--.23100S6;
	Tue, 19 Aug 2025 09:37:22 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: yukuai3@huawei.com,
	axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	hare@suse.de,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 2/2] blk-mq: fix blk_mq_tags double free while nr_requests grown
Date: Tue, 19 Aug 2025 09:29:17 +0800
Message-Id: <20250819012917.523272-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250819012917.523272-1-yukuai1@huaweicloud.com>
References: <20250819012917.523272-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3sxNP1aNouL+mEA--.23100S6
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4DGr17tr47Ary8JFy3XFb_yoW8Gr18pF
	W3Ga1Ykr1agr12yFsrJ347Z345Kw4qqr1FgrsYv345Jr1j9r429r4kWr4IqF40vrs7Canr
	ZrZFkF98XryDG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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
et->tags is still the freed tags, hence later elevator exist will try to
free the tags again, causing kernel panic.

Fix this problem by replacing et->tags will new allocated tags as well.

Noted there are still some long term problems that will require some
refactor to be fixed thoroughly[1].

[1] https://lore.kernel.org/all/20250815080216.410665-1-yukuai1@huaweicloud.com/
Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
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

