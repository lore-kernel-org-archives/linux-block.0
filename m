Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9756260565;
	Thu,  9 Oct 2025 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996399; cv=none; b=ipvzg/IoJeSPDJYBNUyOGDNo5UzBjv58dJO6HFmVNhsJdvptOsDlrKm/cxc12GyYz8+aFmpVrtubx7mBlsauFzeBumCvFt2NzCIBHuPjE839Xs7sueZn9ZuCch1FsF0NZYbq3qTNXD8S5qQ89qpscvmo1VtxsVOR5U7ZBfW/B9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996399; c=relaxed/simple;
	bh=QUX5rA5OMoh5rzqVatDsfKqyFigx0L1oPdOhsFcXrEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=duw/PjAvDyh6sf58n25iDZTwOHke1LLAWvew5d9PsQCOFAOcoSrAr3+IVrMeJYLLeZ4DZ6T4ngE9Sc4qhb2q5oxIapNXkiqfvQguR6qSQ/wN2WugANq2sGz4FsKhqLQLAnn35B+7aLwbIui6/74B5WZ3nwhy1qf6soCt1u7JrsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cj2Cz2VtYzKHMdD;
	Thu,  9 Oct 2025 15:52:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DBFF31A12F1;
	Thu,  9 Oct 2025 15:53:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.159.234])
	by APP4 (Coremail) with SMTP id gCh0CgA3+mHqaedo7Fo7CQ--.38248S4;
	Thu, 09 Oct 2025 15:53:15 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	jmoyer@redhat.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [patch v2 0/7] blk-mq: introduce new queue attribute async_depth
Date: Thu,  9 Oct 2025 15:46:27 +0800
Message-Id: <20251009074634.527661-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3+mHqaedo7Fo7CQ--.38248S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1kKr13uw1rXF1kXryrZwb_yoW8Crykp3
	93tF1Skr17Kr47WryfJw13Xr1fAwn3Cr43Jr13KryxJry5ArsFvFnYqF1rXr97ZryrAanF
	gr1qya95Kry2vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Changes in v2:
 - keep limit_depth() method for kyber and mq-deadline in patch 3;
 - add description about sysfs api change for kyber and mq-deadline;
 - improve documentation in patch 7;
 - add review tag for patch 1;

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

 Documentation/ABI/stable/sysfs-block | 34 +++++++++++++++
 block/bfq-iosched.c                  | 45 ++++++++-----------
 block/blk-core.c                     |  1 +
 block/blk-mq-sched.h                 |  5 +++
 block/blk-mq.c                       | 64 +++++++++++++++++-----------
 block/blk-sysfs.c                    | 47 ++++++++++++++++++++
 block/elevator.c                     |  1 +
 block/kyber-iosched.c                | 33 +++-----------
 block/mq-deadline.c                  | 39 +++--------------
 include/linux/blkdev.h               |  3 +-
 10 files changed, 157 insertions(+), 115 deletions(-)

-- 
2.39.2

