Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E33293B46;
	Fri, 25 Jul 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427547; cv=none; b=CCQzWAiLyNc3OWwktzdReCJBsLxrgjg016Nu69dMexzbiEC1RX/20QwXd9DmtF/OZ7BQN18Rl8bwhEZo97xsAWZBtSIAiFAjceMwCPb9APW5YAR4m9Ox1qK4tdPI9fIKFeIOfZvbIaQ6/mIjGcOOfR2GOusFks5Rz310YQwX2Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427547; c=relaxed/simple;
	bh=x6bk3cjY1ul5JiJpYA6H5zOp7uJ+3WzhtbtJDGiUGOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V7yj/E1ENkMdTZ657u9QateA6r2eujNCZhn4FmBaK6xkQSbHd/j+88QLbiuKIudfMOpAuybojb7pXJmkvLkpzTLepg0GWltoRo/zRtPpbOcfV77p89rdQrktMLTOQ0iBQxndVJ2dOH1yb1JJC+EAKYyfgswn59e1MCcUxu4bOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bpJwR1xFHzYQv9L;
	Fri, 25 Jul 2025 15:12:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F11C41A1503;
	Fri, 25 Jul 2025 15:12:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3QBFRLoNonnivBQ--.56345S4;
	Fri, 25 Jul 2025 15:12:19 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	dlemoal@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 0/3] blk-ioc: convert ioc_lookup_icq() to lockless version
Date: Fri, 25 Jul 2025 15:05:44 +0800
Message-Id: <20250725070547.3953398-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3QBFRLoNonnivBQ--.56345S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWDGFWDtFW5Xw18uF4Durg_yoWfZFg_uF
	95Cas5Jr13XFy8Ja4ftF1vvrZYgrWrGFnYya4DGrW3Jw17Jr4fArs3JrWFqF15ua17K398
	Jr4FyrWrJr1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently issue io can grab queue_lock three times from bfq_bio_merge(),
bfq_limit_depth() and bfq_prepare_request(), the queue_lock is not
necessary if icq is already created because both queue and ioc can't be
freed before io issuing is done.

This set first add a lockless helper ioc_lookup_icq_rcu() and then
covert to use the new helper.

Noted this is also a prep set to support request batch dispatching[1].

1. https://lore.kernel.org/all/20250722072431.610354-1-yukuai1@huaweicloud.com/

Yu Kuai (3):
  blk-ioc: add a new helper ioc_lookup_icq_rcu()
  block, bfq: convert to use ioc_lookup_icq_rcu()
  blk-ioc: convert to use ioc_lookup_icq_rcu()

 block/bfq-iosched.c | 23 ++++++-----------------
 block/blk-ioc.c     | 46 ++++++++++++++++++++++-----------------------
 block/blk.h         |  2 +-
 3 files changed, 29 insertions(+), 42 deletions(-)

-- 
2.39.2

