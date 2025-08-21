Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248618FDBE;
	Thu, 21 Aug 2025 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756870; cv=none; b=p67ajnWfNZkKf8vr+7s2jHlBsU4QCZuan9oik7XM+HDEdRBTGE8B6gGXMNUAfLbsJvxWkAlkDvmb26U8DPUndIGQabh5Ia4MRaU5eGdpbSNJc3+0YNWuEwjyDi8V852OTVyBLgccZt5gI4FE8E5hOmR7k9BOOIM6UGsPy9JPBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756870; c=relaxed/simple;
	bh=2F8qj9LXUdJK53J3zDVrtY3qsXgrM+dpOM5dxd5zV+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G3Jg2GPdkvXljRubPXWUyv1ko6IN8jPt8XHLsqA+vXAd9c2hLl+SGIK6CY/DMgF2SAtIu2jXHmQ3yAquP/34OTIXJLGeYuk5fUPSZC6dVlwSUVoLhFmxfsAv2DbvJucp7BZo8aElYck/4YTvEmb9iYFyklOoUQFcOxnvBp42Vts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c6tM50vmczKHNXx;
	Thu, 21 Aug 2025 14:14:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 930551A0B8F;
	Thu, 21 Aug 2025 14:14:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHERI+uaZoxBuhEQ--.58405S4;
	Thu, 21 Aug 2025 14:14:24 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: yukuai3@huawei.com,
	axboe@kernel.dk,
	bvanassche@acm.org,
	ming.lei@redhat.com,
	nilay@linux.ibm.com,
	hare@suse.de
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 0/2] blk-mq: fix update nr_requests regressions
Date: Thu, 21 Aug 2025 14:06:10 +0800
Message-Id: <20250821060612.1729939-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHERI+uaZoxBuhEQ--.58405S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWfKFy5JrWDWF1DCr1xZrb_yoWkGrg_GF
	WDAa4kJr4DWF45GFW7KF15JrWxK3yrtr4kGa4DJrWkt34fJF4rArW5Ar4Y9Fs8uFWUGFn5
	G3sYqr18tr1jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v3:
 - call depth_updated() directly in init_sched() method in patch 1;
 - fix typos in patch 2;
 - add review for patch 2;
Changes in v2:
 - instead of refactor and cleanups and fix updating nr_requests
 thoroughly, fix the regression in patch 2 the easy way, and dealy
 refactor and cleanups to next merge window.

patch 1 fix regression that elevator async_depth is not updated correctly
if nr_requests changes, first from error path and then for mq-deadline,
and recently for bfq and kyber.

patch 2 fix regression that if nr_requests grow, kernel will panic due
to tags double free.

Yu Kuai (2):
  blk-mq: fix elevator depth_updated method
  blk-mq: fix blk_mq_tags double free while nr_requests grown

 block/bfq-iosched.c   | 22 +++++-----------------
 block/blk-mq-sched.h  | 11 +++++++++++
 block/blk-mq-tag.c    |  1 +
 block/blk-mq.c        | 23 ++++++++++++-----------
 block/elevator.h      |  2 +-
 block/kyber-iosched.c | 19 +++++++++----------
 block/mq-deadline.c   | 16 +++-------------
 7 files changed, 42 insertions(+), 52 deletions(-)

-- 
2.39.2

