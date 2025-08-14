Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD144262FC0;
	Thu, 14 Aug 2025 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142997; cv=none; b=CQgcpHMzmyveDpBgcOeSx+BCJ3IxjPLuZQ1NCCcFyJ3iXQknkT9PqXF0hGy+6Qs7bB/1LpkTyc3vz941A00+G/A0FKM/h9q9QsSFUa06ORpoKpfJSXCrWGpqnahEijRalDy50WAFXef6Ka0fsPxzZri6HtiwmcagWHw10R4oF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142997; c=relaxed/simple;
	bh=+ZYFiXz6XEMMB/z859pfgQTuxR1Xl5UD4q07I/9BRGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bKomIQQfMaAft2zIgO9pW7QbT/cIdX8LSREUrElZeh6RFIh5DUGLZRLMD0zf5X2V36ntHLrF1mpNuDkMOhbgg9/6S8l4cFO/3LWedFe6sl1T8Y7woWJ10JrkhFs5dPkLv/F0xp/GZb3c7MOZicdecgD1ugl/+ZGqMHKlvx+f2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKs3CyvzKHLwq;
	Thu, 14 Aug 2025 11:43:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B50C61A0CED;
	Thu, 14 Aug 2025 11:43:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S13;
	Thu, 14 Aug 2025 11:43:12 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	yukuai3@huawei.com,
	bvanassche@acm.org,
	nilay@linux.ibm.com,
	hare@suse.de,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 09/16] block: convert nr_requests to unsigned int
Date: Thu, 14 Aug 2025 11:35:15 +0800
Message-Id: <20250814033522.770575-10-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250814033522.770575-1-yukuai1@huaweicloud.com>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S13
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4DJFW7Cw18ur17CrWxJFb_yoW3ZrgEka
	9FkFs2gw4fJF1Iqw4UtFs7tFyqgwn3JFZ7u3Z3JF1jqan8WanYqa1kGF9rGF42gFW7CF97
	Xan5W39Yvr1YgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
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
index 95886b404b16..ad5087d5cade 100644
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

