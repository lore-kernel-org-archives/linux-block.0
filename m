Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70D1EBA14;
	Tue, 30 Sep 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216915; cv=none; b=mXi9WzYchNdM78HaA5NAgDPhZpw970VIxmnkSOjFkTf+TvHyn5x7377HSM67frS95Swy2zPUKSRJEX9M1wxR5kT/zc/mN864KvAF6Sshp+0yP6swk3eaKuD3RVJW1niGUqMBkZH/QI355jYUhNFQT9aOOfotMWgNLfl87t7a0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216915; c=relaxed/simple;
	bh=DdGibbdnVzYcM3M5kcfmw7XHsl668t2rnZL8EpqTGYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NvGJhZ7lovuXiT3z7hs/lYv4tGuhxwISE7HwyS1nX75WoWttM3vaLGllGt48+rS1IelAoJkvaiJ/uXhGk6xvCTgsVhohNe7/EaAqLi8zcWCc7vPbUd9B95HVE2hD0o7yaCzZY9dhuYi/KGD0Bsvla5HYyeUsYpeO2qOkHLJTdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cbTy45G7TzYQtsp;
	Tue, 30 Sep 2025 15:21:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EE7471A12E7;
	Tue, 30 Sep 2025 15:21:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDHjGQLhdtoC9s4BQ--.44849S4;
	Tue, 30 Sep 2025 15:21:49 +0800 (CST)
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
Subject: [PATCH 0/7] blk-mq: introduce new queue attribute async_depth
Date: Tue, 30 Sep 2025 15:11:04 +0800
Message-Id: <20250930071111.1218494-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjGQLhdtoC9s4BQ--.44849S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4ruFyDGw15Aw1fJr17GFg_yoW8WF13pa
	93JFySkr17Kr4xuryfJw13Xr1fAwn3Cr43Jr13K34xJry5ArsrZFn5XF18XrZ7Zry8Aa1q
	gr1qya95GFy29aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Background and motivation:

At first, we test a performance regression from 5.10 to 6.6 in
downstream kernel(described in patch 5), the regression is related to
async_depth in mq-dealine.

While trying to fix this regression, Bart suggests add a new attribute
to request_queue, and I think this is a good idea because all elevators
have similar logical, however only mq-deadline allow user to configure
async_depth.

patch 1-3 add new queue attribute async_depth;
patch 4 convert kyber to use request_queue->async_depth;
patch 5 covnert mq-dedaline to use request_queue->async_depth, also the
performance regression will be fixed;
patch 6 convert bfq to use request_queue->async_depth;

Yu Kuai (7):
  block: convert nr_requests to unsigned int
  blk-mq-sched: unify elevators checking for async requests
  blk-mq: add a new queue sysfs attribute async_depth
  kyber: covert to use request_queue->async_depth
  mq-deadline: covert to use request_queue->async_depth
  block, bfq: convert to use request_queue->async_depth
  blk-mq: add documentation for new queue attribute async_dpeth

 Documentation/ABI/stable/sysfs-block | 10 ++++++
 block/bfq-iosched.c                  | 45 +++++++++++---------------
 block/blk-core.c                     |  1 +
 block/blk-mq-sched.h                 |  5 +++
 block/blk-mq.c                       |  4 +++
 block/blk-sysfs.c                    | 47 ++++++++++++++++++++++++++++
 block/elevator.c                     |  1 +
 block/kyber-iosched.c                | 36 ++-------------------
 block/mq-deadline.c                  | 42 ++-----------------------
 include/linux/blkdev.h               |  3 +-
 10 files changed, 94 insertions(+), 100 deletions(-)

-- 
2.39.2

