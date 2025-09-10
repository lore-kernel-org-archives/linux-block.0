Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9431158E;
	Wed, 10 Sep 2025 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492065; cv=none; b=aump5IrEEkVT79AuYkKk+VVI6bU4P4OaV5eOLFT3av4EJb9F9O3AffHvmnp9QwxElRiwRS0rcKIe+CqIAPH3rB63yB/CP5yY+5+nCh5gCILQ5uLWo57JY/NuXUUR7lOjSO68vXrBs5avUG4hJ5dZG9wifEoiZYGnsLB04NQrTuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492065; c=relaxed/simple;
	bh=0QBIETaXXTTvVgA6n9Qg1SE4aRgNz6YT48YXQsRlc8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XuxjrQvbDMpjgHojvibWLhwpaRFQP9Y6huk+tIHi+0SpolP3vKd689D3vnMcZu+UmhRiJalhVbMvglClvfoT5aNL0K9EQ0YeRjIN2DYCnNQhSH+Y8eVq1zgJkcLLG7L343KFcdt9l+drF4k8kxV6Qz/gSL+fZ6btRzbCbATmSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cMD480tXJzKHNLK;
	Wed, 10 Sep 2025 16:14:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 571AE1A133C;
	Wed, 10 Sep 2025 16:14:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5QM8Fo1ggRCA--.52270S14;
	Wed, 10 Sep 2025 16:14:16 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2 for-6.18/block 10/10] blk-mq: fix stale nr_requests documentation
Date: Wed, 10 Sep 2025 16:04:45 +0800
Message-Id: <20250910080445.239096-11-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250910080445.239096-1-yukuai1@huaweicloud.com>
References: <20250910080445.239096-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY5QM8Fo1ggRCA--.52270S14
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWDCryfKr15Zw1xKFWfZrb_yoW8WrW5p3
	yft3y2gwn5Zw18Wr10yay8tF13Aa93Aw43Jr4DKF1rKr98Awna9Fs2qr1rXF4xZrZ2yFWU
	urZ29r98Ca1jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU1aLvJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

The nr_requests documentation is still the removed single queue, remove
it and update to current blk-mq.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 Documentation/ABI/stable/sysfs-block | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0ddffc9133d0..0ed10aeff86b 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -603,16 +603,10 @@ Date:		July 2003
 Contact:	linux-block@vger.kernel.org
 Description:
 		[RW] This controls how many requests may be allocated in the
-		block layer for read or write requests. Note that the total
-		allocated number may be twice this amount, since it applies only
-		to reads or writes (not the accumulated sum).
-
-		To avoid priority inversion through request starvation, a
-		request queue maintains a separate request pool per each cgroup
-		when CONFIG_BLK_CGROUP is enabled, and this parameter applies to
-		each such per-block-cgroup request pool.  IOW, if there are N
-		block cgroups, each request queue may have up to N request
-		pools, each independently regulated by nr_requests.
+		block layer. Noted this value only represents the quantity for a
+		single blk_mq_tags instance. The actual number for the entire
+		device depends on the hardware queue count, whether elevator is
+		enabled, and whether tags are shared.
 
 
 What:		/sys/block/<disk>/queue/nr_zones
-- 
2.39.2

