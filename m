Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF740D579;
	Thu,  9 Jul 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591975; cv=none; b=l4i+Irg+veGL6CP9bcc87H/GaC5IE1pgk7DXwkg8yrTs4wBNRyEyjYUD60RjK50e2KtnMKjcRSu5vm8fesHK7OzWXwrSXX/DEXl2oCuV21LTj+pr7gwPawOg1L+a6BOK6mNrG+NVN1SwPe7JeSDduivoJxYpw9F2RemkllfuHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591975; c=relaxed/simple;
	bh=UYYjlAxvuTvlqK+Z8zs2KbyUdHUGa8BClF0xhKYZYlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFD98dYZAa9SgVdDSK49qn5XS5aBQVVJi/eqRC8qgWAcMB+wbcYYGAueunFk6mVxP3pRtaj8drKtjktSbx+OJBQ8SOftZPSAWq9AeHcf4zUnux0f9LEwEPBEM0X6e8Bvx6NOH87Ckm/3NnVAlzd4dD1HDOZbhPINMVfOjV6dE0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwrPK4HJbzYQtyS;
	Thu,  9 Jul 2026 18:12:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2C0774056F;
	Thu,  9 Jul 2026 18:12:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHV3MadE9qn4RpAg--.38318S7;
	Thu, 09 Jul 2026 18:12:43 +0800 (CST)
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
Subject: [PATCH V4 3/9] null_blk: move unregister_blkdev() after destroying dev in null_exit()
Date: Thu,  9 Jul 2026 18:04:45 +0800
Message-ID: <20260709100452.3520482-4-wozizhi@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBHV3MadE9qn4RpAg--.38318S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47ZF4xKFWrury8CryDWrg_yoW8Jw4xpF
	45Ww1jkr1jkF1UZr4qka1IkFyrtan3Gry09rWUCa4rZwsxZry2vrnrJa4rXF1Ut3y7CFsI
	vF1qqa4fXayDCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 4613035222cd..6cb213779cc5 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2192,19 +2192,19 @@ static void __exit null_exit(void)
 {
 	struct nullb *nullb;
 
 	configfs_unregister_subsystem(&nullb_subsys);
 
-	unregister_blkdev(null_major, "nullb");
-
 	mutex_lock(&lock);
 	while (!list_empty(&nullb_list)) {
 		nullb = list_entry(nullb_list.next, struct nullb, list);
 		null_destroy_dev(nullb);
 	}
 	mutex_unlock(&lock);
 
+	unregister_blkdev(null_major, "nullb");
+
 	if (tag_set.ops)
 		blk_mq_free_tag_set(&tag_set);
 
 	mutex_destroy(&lock);
 }
-- 
2.52.0

