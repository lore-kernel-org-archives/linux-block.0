Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF32FF660;
	Thu, 14 Aug 2025 03:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142993; cv=none; b=E/kN5+Vpv5xYvZr1dG2H0rCacbDujNEJOgNkbJT9VybCmREqRJwEKBL4D9sOA0hdY+n/rJfP21cpOGQjWFNkmuodIegaksmaVqShWiwozXAa6gNNIgbzJ7bHFDUki82FDdhq5BqsoOi3vX2ThuSWiN8Km1JgZ+QrAW6Rpa8khrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142993; c=relaxed/simple;
	bh=jC6oI7rRAbAjUrisCPWDlL475SGNNs1YyfBpEci0GIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KDElMUBkmNBtEuFiiggGl/j/P/9yQ/al+ib+e7FH2eLTK1tqTGeR9znm/1pfWaPqm0Cr3QXuxbdAfRDQqnwBS3amQUA8OULkp5Qae1GilYCz5vUkjlwNW2/x+tdmw734FbLQNAzNd20YjhrGGsVwz9g+2mnobd+fZ6qwKzkhRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c2WKn03t0zKHMSH;
	Thu, 14 Aug 2025 11:43:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4A3A61A018D;
	Thu, 14 Aug 2025 11:43:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxRKW51ogs93Dg--.15627S4;
	Thu, 14 Aug 2025 11:43:08 +0800 (CST)
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
Subject: [PATCH 00/16] blk-mq: introduce new queue attribute asyc_dpeth
Date: Thu, 14 Aug 2025 11:35:06 +0800
Message-Id: <20250814033522.770575-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxRKW51ogs93Dg--.15627S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWkGw4rWFWfCF17tF45Awb_yoW5GFWxp3
	y3tF4akw1xKryxWF4fJw43Xr1rCws3ur43JrnxKr1rJr90kws2vFn5X3WrXryIvrWxCanF
	gr1qgas8GrnFvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Backgroud and motivation:

At first, we test a performance regression from 5.10 to 6.6 in
downstream kernel(described in patch 13), the regression is related to
async_depth in mq-dealine.

While trying to fix this regression, Bart suggests add a new attribute
to request_queue, and I think this is a good idea because all elevators
have similar logical, however only mq-deadline allow user to configure
async_depth. And this is patch 9-16, where the performance problem is
fixed in patch 13;

Because async_depth is related to nr_requests, while reviewing related
code, patch 2-7 are cleanups and fixes to nr_reqeusts.

I was planning to send this set for the next merge window, however,
during test I found the last block pr(6.17-rc1) introduce a regression
if nr_reqeusts grows, exit elevator will panic, and I fix this by
patch 1,8.

So I send this set for now, and hope we can consider it for this merge
window. If not, I'll have to rework the whole set and send the second
kernel panic regression first.

Yu Kuai (16):
  blk-mq-sched: add new parameter nr_requests in
    blk_mq_alloc_sched_tags()
  blk-mq: remove useless checking from queue_requests_store()
  blk-mq: remove useless checkings from blk_mq_update_nr_requests()
  blk-mq: check invalid nr_requests in queue_requests_store()
  blk-mq: fix elevator depth_updated method
  blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
  blk-mq: split bitmap grow and resize case in
    blk_mq_update_nr_requests()
  blk-mq: fix blk_mq_tags double free while nr_requests grown
  block: convert nr_requests to unsigned int
  blk-mq-sched: unify elevators checking for async requests
  blk-mq: add a new queue sysfs attribute async_depth
  kyber: covert to use request_queue->async_depth
  mq-deadline: covert to use request_queue->async_depth
  block, bfq: convert to use request_queue->async_depth
  blk-mq: fix stale nr_requests documentation
  blk-mq: add documentation for new queue attribute async_dpeth

 Documentation/ABI/stable/sysfs-block | 24 ++++---
 block/bfq-iosched.c                  | 64 +++++++------------
 block/blk-core.c                     |  1 +
 block/blk-mq-sched.c                 | 14 +++--
 block/blk-mq-sched.h                 | 18 +++++-
 block/blk-mq-tag.c                   | 23 +------
 block/blk-mq.c                       | 93 +++++++++++++++++-----------
 block/blk-mq.h                       |  2 +-
 block/blk-sysfs.c                    | 63 ++++++++++++++++++-
 block/elevator.c                     |  3 +-
 block/elevator.h                     |  2 +-
 block/kyber-iosched.c                | 40 ++----------
 block/mq-deadline.c                  | 55 ++--------------
 include/linux/blkdev.h               |  3 +-
 14 files changed, 194 insertions(+), 211 deletions(-)

-- 
2.39.2

