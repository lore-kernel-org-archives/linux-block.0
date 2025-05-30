Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264738B;
	Fri, 30 May 2025 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748592549; cv=none; b=HPQdME1PdQKkK3fBpc0A9H26caaR68VcSx308JNABagdYL0CoZvFampJ4A7qSZXYH67QXNtj2WJeTFe6Lje7AyURslR+MGWw88u5W3dgfcZELILQizVfs+FNWyLH4Xy8NtGZBjd89xnLX8cixW+RQKUy2bg9UlpeTANmh8dh4/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748592549; c=relaxed/simple;
	bh=aC7ZZT5vqDvhPiQdxbOwr/UJHbnVRNUppLn4j5pfyOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mjNlC+zfOmmUYOwIqC1/AcT0tsmIJZytTJBhjDZqBAAYdbUu9GcJx1zf0RB0P9E85XOY+lVmkHl7k5frVWVMVlVmh43PNuihelz4dpDRjwEpxEC3xtN9kUiDmdG4/wwooEFkenAPyacMNEAKOXA9ulSw/xaBBPvJp4+hinNe2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b7wqj6KzQzYQvFM;
	Fri, 30 May 2025 16:09:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id F0DDE1A0D46;
	Fri, 30 May 2025 16:09:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgAne8WfZzloSi3_Ng--.6274S4;
	Fri, 30 May 2025 16:09:04 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH RFC 0/4] blk-mq-sched: support request batch dispatching for sq elevator
Date: Fri, 30 May 2025 16:03:51 +0800
Message-Id: <20250530080355.1138759-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAne8WfZzloSi3_Ng--.6274S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyrKF1fuw4DJr1rZrWxXrb_yoW8Gry5pr
	4fKa9xKr1jqr1fZF1a93W7J34rJws7WasxGrnrJ3W8GFnxCr13JF18K3WkXFyxZrWfAFsr
	Wr18tF97WFyUCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
	UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Lock contention for sq elevator is quite intense when multiple contexts
are dispatching request, main reason is that a global lock is held and
release for each request:

while
  spin_lock
  disaptch one request
  spin_unlock

This set support request batch dispatching to reduce the lock contention
a bit.

A simple test for null_blk in my VM:
32 job randwrite

| elevator                   | bandwidth Mib/s |
| -------------------------- | --------------- |
| none                       | 813             |
| deadline before this patch | 531             |
| deadline after this patch  | 689             |

The test is one-sided, however, this is just a quick test to show this
set might be meaningful. I'm sending this RFC and want to get some
feedbacks before I continue work on this set.

Noted: do not test bfq for this set, it's not changed yet(like patch 2
for deadline).

Yu Kuai (4):
  elevator: introduce global lock for sq_shared elevator
  mq-deadline: switch to use elevator lock
  blk-mq-sched: refactor __blk_mq_do_dispatch_sched()
  blk-mq-sched: support request batch dispatching for sq elevator

 block/blk-mq-sched.c | 224 +++++++++++++++++++++++++++++--------------
 block/blk-mq.c       |   5 +-
 block/blk-mq.h       |  21 ++++
 block/elevator.c     |   1 +
 block/elevator.h     |  62 +++++++++++-
 block/mq-deadline.c  |  60 +++++-------
 6 files changed, 259 insertions(+), 114 deletions(-)

-- 
2.39.2

