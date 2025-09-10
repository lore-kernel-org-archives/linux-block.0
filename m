Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0B306B33;
	Wed, 10 Sep 2025 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492056; cv=none; b=kN8OOS6/rE0zTl2f/Gi5A+OkdY9HhhFK59wVTlvZKC1DerG7+FaooUHEz4miHnYMXk0aDYMax4uE1llWB0AxtO5fqHUbZ9a9y2PSlACwaEEY20+asD7y8W+QTXF+Me/GLGyWTAuLSZanZMaPyVKXJ6kJhoZ39su2QgeGDrXcr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492056; c=relaxed/simple;
	bh=M/O5ARlc8OOUmoVfXy23srFEQFFX5PlWa/9bfvCGkYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ApLNLtJUcv4Kbx/2W3ai4ieyGCZEAdVCBerzCcU8Sm7ug2//6Xtwxk0glj9+pERTsv+jHyp62AVnrg+EKY/3wiYjpyQEdPjlKxnS3WmFkJv7PAjrFl8lMyBxsHcUSUviJZ1c2SqOGNzBk5vgZwqEnBJSYw5VU1Y+GR2sey/YoDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cMD441sRPzYQvj1;
	Wed, 10 Sep 2025 16:14:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BFE681A14F1;
	Wed, 10 Sep 2025 16:14:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY5QM8Fo1ggRCA--.52270S4;
	Wed, 10 Sep 2025 16:14:10 +0800 (CST)
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
Subject: [PATCH v2 for-6.18/block 00/10] blk-mq: cleanup and fixes for updating nr_requests
Date: Wed, 10 Sep 2025 16:04:35 +0800
Message-Id: <20250910080445.239096-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY5QM8Fo1ggRCA--.52270S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4kGF1xJr1DJw47KF4xCrg_yoW8JFWUpa
	y3JF43uw1Sqw1xXF1aka17Jrn8Kws7Wr47JwsxtF1rCr1vkwn7JF18Xa1rWFyIyFWxAa9r
	Kw1DJryDGrnFqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
	1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes from v1:
 - add comments explaining accessing q->elevator without holding
   elevator_lock in patch 4;
 - add non-shared checking in patch 8;
 - add review tag by Nilay, patch 1-5,7,9,10;

Yu Kuai (10):
  blk-mq: remove useless checking in queue_requests_store()
  blk-mq: remove useless checkings in blk_mq_update_nr_requests()
  blk-mq: check invalid nr_requests in queue_requests_store()
  blk-mq: convert to serialize updating nr_requests with
    update_nr_hwq_lock
  blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
  blk-mq: split bitmap grow and resize case in
    blk_mq_update_nr_requests()
  blk-mq-sched: add new parameter nr_requests in
    blk_mq_alloc_sched_tags()
  blk-mq: fix potential deadlock while nr_requests grown
  blk-mq: remove blk_mq_tag_update_depth()
  blk-mq: fix stale nr_requests documentation

 Documentation/ABI/stable/sysfs-block | 14 ++----
 block/blk-mq-sched.c                 | 14 ++----
 block/blk-mq-sched.h                 |  2 +-
 block/blk-mq-tag.c                   | 53 ---------------------
 block/blk-mq.c                       | 71 ++++++++++++++--------------
 block/blk-mq.h                       | 18 +++++--
 block/blk-sysfs.c                    | 60 ++++++++++++++++++-----
 block/elevator.c                     |  3 +-
 8 files changed, 112 insertions(+), 123 deletions(-)

-- 
2.39.2

