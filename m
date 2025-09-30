Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AC62066DE;
	Tue, 30 Sep 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216914; cv=none; b=usPuluArM22vHRTA7GtA+H4nrp2LdtHDYqmz2hC+a1jBHKnc3pc2fOXpXcl2QrakJj/uNuiT49kznRpQYma+uvf0PCa7N9B6Y98WsqMI6G7xt0aAqyTfp8N7hoX0HhlOtGlvVQKGJ2enBfR7qK3f2wKk24nSYeF25Bs8D2ZNj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216914; c=relaxed/simple;
	bh=5QkxVEND5FDv2/8ZoKW2LRHDchuqt9Ymtq4LrVU34dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWpkXjHLEyB7BmlEYK8Kwh8+uOemJLD2jxAn9ECRLhVaoMWd9gatt38Sw2E/gfHqv5Bz0JICD2K544sXqKtyJV8DRGCR0oalooevcLzUHXRQn0Z9HeYiTNM5EVMhECTTKx3eMeEbs10QytgBBOvOC2oyNWOEXkHODDMfDGdJEJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cbTy51mq6zYQttC;
	Tue, 30 Sep 2025 15:21:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 76B1C1A0D00;
	Tue, 30 Sep 2025 15:21:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjGQLhdtoC9s4BQ--.44849S5;
	Tue, 30 Sep 2025 15:21:50 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 1/7] block: convert nr_requests to unsigned int
Date: Tue, 30 Sep 2025 15:11:05 +0800
Message-Id: <20250930071111.1218494-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
References: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjGQLhdtoC9s4BQ--.44849S5
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4DJFW7Cw18ur17CrWxJFb_yoW3ZrgEka
	4qkFs2gr4fJF1xXw4UtF4IqF1qgwn3JFZ7u3Z5JF1jqan8Wan3ta1kGF9rWF42ga17GF97
	Xan5WwsYvr1Y9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkxFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUjnXo7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

This value represents the number of requests for elevator tags, or drivers
tags if elevator is none. The max value for elevator tags is 2048, and
in drivers at most 16 bits is used for tag.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 066e5309bd45..02c006fb94c5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -541,7 +541,7 @@ struct request_queue {
 	/*
 	 * queue settings
 	 */
-	unsigned long		nr_requests;	/* Max # of requests */
+	unsigned int		nr_requests;	/* Max # of requests */
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
-- 
2.39.2

