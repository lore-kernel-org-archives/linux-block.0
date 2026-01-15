Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3932C11CA
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495109; cv=none; b=T2ySq5rbf00yAMk4BL13or7pGfbi+K2/t2wOGF3+7QakUpJg2ISjt9Tr2iuNwWCJBpZbLN0val3w2Vo8h96LUcuxP8FuuhdcGQwOP87+KMIVUw4XdbCJwqyCkjf46rU+uAz2MTe6AffHumd11F09tbj7ezW5NZkmdpq4RkXmgK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495109; c=relaxed/simple;
	bh=vNHNLLUNIFtaQjwUWjOUcKAm7mWdL8GvLgxJAOV6gjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYMIUZfw2TWKwqtYZz7382DpxqyRFbTTAyRF+40bkL1l8FRrmnnSt3C5t2YhE2mnscVz7GksvyFtzZurTWzm0FiBqZO6FmW3xCIjLsUbCkS5/5dVLGxJeMn4YiiTV/FG3aZB4WhjgreGlv5lfALMyB/Ak+0z72sOdK9LwOhxUws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58956C116D0;
	Thu, 15 Jan 2026 16:38:25 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com,
	zhengqixing@huawei.com,
	mkoutny@suse.com,
	hch@infradead.org
Subject: [PATCH 0/6] blk-cgroup: fix races in blkcg_activate_policy()
Date: Fri, 16 Jan 2026 00:38:12 +0800
Message-ID: <20260115163818.162968-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes race conditions between blkcg_activate_policy() and
blkg destruction, and optimizes the policy activation path.

Patches 1-2 add missing blkcg_mutex protection for q->blkg_list iteration.

Patches 3-5 from Zheng Qixing fix use-after-free and memory leak issues
caused by races between policy activation and blkg destruction.

Patch 6 restructures blkcg_activate_policy() to allocate pds before
freezing the queue. This is a prep patch to fix deadlocks related to
percpu allocation with queue frozen, since some policies like iocost
and iolatency do percpu allocation in pd_alloc_fn(). Future work is to
remove all queue freezing before blkcg_activate_policy() to fix the
deadlocks thoroughly.

Yu Kuai (3):
  blk-cgroup: protect q->blkg_list iteration in blkg_destroy_all() with
    blkcg_mutex
  bfq: protect q->blkg_list iteration in bfq_end_wr_async() with
    blkcg_mutex
  blk-cgroup: allocate pds before freezing queue in
    blkcg_activate_policy()

Zheng Qixing (3):
  blk-cgroup: fix race between policy activation and blkg destruction
  blk-cgroup: skip dying blkg in blkcg_activate_policy()
  blk-cgroup: factor policy pd teardown loop into helper

 block/bfq-cgroup.c  |   3 +-
 block/bfq-iosched.c |   2 +
 block/blk-cgroup.c  | 148 +++++++++++++++++++-------------------------
 3 files changed, 66 insertions(+), 87 deletions(-)

-- 
2.51.0

