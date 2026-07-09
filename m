Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDF410D0F;
	Thu,  9 Jul 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591976; cv=none; b=orALeN70S4YtKiMN7vSADxLlOSqgIoNwcqGWGm+RyI8niKkY3cpWaYN5zVfyFJAEa8z5Gypuxu7BSzyymIWva1L7bQ1iLZScLLng0UAxWKy4szTAFo0lehQPBXm8T/Vsd0mIoh8WHKpDNYdkmHzfZ3n9OHGECkfXIRQ4qvDPtBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591976; c=relaxed/simple;
	bh=2QGJJ4iVSjxH4FEnvA/WLDRsLUOS2Fjya/hifzxEVOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkZ7Z+NQnHNLgt+9WIgLkvVt8XuONo5IZnQStMsMVH1op87cORdU5ucmtZjVI9xgLu/fs19LnOi4ezvu7lYg4NpT2CDJ75Mf+Y2V33IytSPG7sVvvlfcBWZLT9/EFHc8B3JQnPlT5epEXuh+DcoDUeTDZxNTqnsqWQF+zWKPRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwrPK4bdhzYQthT;
	Thu,  9 Jul 2026 18:12:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3658E4058F;
	Thu,  9 Jul 2026 18:12:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHV3MadE9qn4RpAg--.38318S8;
	Thu, 09 Jul 2026 18:12:44 +0800 (CST)
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
Subject: [PATCH V4 4/9] null_blk: free global tag_set on init error path
Date: Thu,  9 Jul 2026 18:04:46 +0800
Message-ID: <20260709100452.3520482-5-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
References: <20260709100452.3520482-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHV3MadE9qn4RpAg--.38318S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4UGFyUWw1xAFy7XryftFb_yoW8GFy3pF
	W5Wa4UKryYkF17ZFWjya42kFyFgan7GryUKryak34F9r43Ar9Fkr1kJas8XF15Z393JrZa
	vFn7XFyfJFWUGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

If shared_tags is enabled, null_setup_tagset() allocates the global tag_set
via null_init_global_tag_set(). If device creation later fails, err_dev
destroys the default devices and calls unregister_blkdev(), but never frees
the global tag_set. Since module init failed, null_exit() is never invoked,
so the global tag_set's tags and maps are permanently leaked.

Free the global tag_set in err_dev, matching null_exit() which does
if (tag_set.ops) blk_mq_free_tag_set(&tag_set).

Fixes: 82f402fefa50 ("null_blk: add support for shared tags")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 6cb213779cc5..df85189f0b69 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2183,10 +2183,12 @@ static int __init null_init(void)
 	while (!list_empty(&nullb_list)) {
 		nullb = list_entry(nullb_list.next, struct nullb, list);
 		null_destroy_dev(nullb);
 	}
 	unregister_blkdev(null_major, "nullb");
+	if (tag_set.ops)
+		blk_mq_free_tag_set(&tag_set);
 	return ret;
 }
 
 static void __exit null_exit(void)
 {
-- 
2.52.0

