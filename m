Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CBF270EBB;
	Thu, 14 Aug 2025 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142999; cv=none; b=lXyGEQSwsDUuyLTdn+VIOgHN+vWJZgdgD6b17aSgWGSutNAa3yxLtgVNA6ApuhAVOG5dYJ095PyMPR2FvGwJIwJyRTvS9gi3v2EPLWV7mgR14IvEBjQjyKE0lmgH4/vjfHvkcydvWK3U2yd1KN14zB1mdK8YxOWPyXKFyPhGwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142999; c=relaxed/simple;
	bh=EknLAK2gLRyPv6Yw7SLp+eYJNTIbHKFqWvdA/PDvUlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k85lfF7u75m9nTjvrI5rLCSw/fv/Ai1lCoe5Rw+taf3kEJwmjNgqWcBaAleQO3gjMtUh4BfUljxVeKX2JJyv9bfI1J4LiCpaL6yZKChWv6S8B3k3pS/jSMfQS08MREE06gQJY26zIRbVpjg29i20RQ0skoaY/TjWmb4J1Yq946Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKw5rF7zKHMST;
	Thu, 14 Aug 2025 11:43:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1BCCE1A0BDE;
	Thu, 14 Aug 2025 11:43:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S20;
	Thu, 14 Aug 2025 11:43:15 +0800 (CST)
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
Subject: [PATCH 16/16] blk-mq: add documentation for new queue attribute async_dpeth
Date: Thu, 14 Aug 2025 11:35:22 +0800
Message-Id: <20250814033522.770575-17-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S20
X-Coremail-Antispam: 1UD129KBjvdXoWruF1rAFWrCryktr4fuw47CFg_yoWDXFbEgF
	WDKFnYg3ykAF1YvFWjyF4kAF12g3y5KFy8G3WkAry5Zry3taySka95XrZ8CFZrXFs29rn3
	uws5XrWUKrnaqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 Documentation/ABI/stable/sysfs-block | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 0ed10aeff86b..09b9b3db9a1f 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -609,6 +609,16 @@ Description:
 		enabled, and whether tags are shared.
 
 
+What:		/sys/block/<disk>/queue/async_depth
+Date:		August 2025
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This controls how many async requests may be allocated in the
+		block layer. If elevator is none, then this value is nr_requests.
+		By default, this value is 75% of nr_requests for bfq and kyber,
+		abd nr_requests for mq-deadline.
+
+
 What:		/sys/block/<disk>/queue/nr_zones
 Date:		November 2018
 Contact:	Damien Le Moal <damien.lemoal@wdc.com>
-- 
2.39.2

