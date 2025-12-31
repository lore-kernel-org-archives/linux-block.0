Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B5251795
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767171097; cv=none; b=STe7D6wykxEVmT0VL8sFo+qJM5My9HTVCl1Lfkq++G8C0XYAPXK4RzGT6s4Xfgxftboj6i+EeZrN9CsKv45rGf5HBzmv8kKNg8MlmVUhfEv4TRW/w/JPMdb+DqDhyrO6qRcpDyF2FX56W5RfYZW8BeTBeXCNl9yIw+4UCG4p72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767171097; c=relaxed/simple;
	bh=0vTCEH6C2Ip1e+q3ZZ0IGlufW6PngYstlGx0WaFN4p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYx8HXve3gg055t5IYy312qqepBNxrMRwvVegVhZCrFpipVjrB0xPzBnCdsQ4Tiu9sD685btbncW/yy01Zmcu1EmZoUaRVLt2WRwTuJs+l4Rp1j0Vwh5skTzGwW7nbfjIk3B/x1eCsJ+bfjBgZ4vXlqOgnb6xoqQ0KgUcd/j9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65B9C113D0;
	Wed, 31 Dec 2025 08:51:35 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v7 00/16] blk-mq: fix possible deadlocks
Date: Wed, 31 Dec 2025 16:51:10 +0800
Message-ID: <20251231085126.205310-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes in v7:
 - add patch 7 to fix missing debugfs_mutex for hctxs' debugfs;
 - add patch 15,16 to cleanup unnecessary queue frozen;
changes in v6:
 - rebase on the top of block-6.19;
 - add patch 6 to cleanup  blk_mq_debugfs_unregister_rqos();
 - change patch 8, from GFP_NOIO to blkg_conf_open_bdev_frozen();
changes in v5:
 - free rwb from wbt_init() caller in patch 2;
 - don't recheck rwb in patch 2 to make code cleaner, concurrent callers
   will fail from rq_qos_add();
 - add patch 7 to fix possible deadlock in blk-throtle;
changes in v4:
 - add patch 1,2 to fix a new deadlock;
changes in v3:
 - remove changes for blk-iolatency and blk-iocost in patch 2, since
   they don't have debugfs entries.
 - add patch 9 to fix lock order for blk-throttle.
changes in v2:
 - combine two set into one;

Fix deadlocks:
 - patch 1-2, pcpu_alloc_mutex under q_usage_counter in blk-wbt;
 - patch 3-8, debugfs_mutex under q_usage_counter;
 - patch 9, fs_reclaim under rq_qos_mutex in blk-throttle;
 - patch 10-14, q_usage_counter under rq_qos_mutex;

Yu Kuai (16):
  blk-wbt: factor out a helper wbt_set_lat()
  blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under
    q_usage_counter
  blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
  blk-rq-qos: fix possible debugfs_mutex deadlock
  blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
  blk-mq-debugfs: remove blk_mq_debugfs_unregister_rqos()
  blk-mq-debugfs: add missing debugfs_mutex in
    blk_mq_debugfs_register_hctxs()
  blk-mq-debugfs: warn about possible deadlock
  blk-throttle: fix possible deadlock for fs reclaim under rq_qos_mutex
  block/blk-rq-qos: add a new helper rq_qos_add_frozen()
  blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iocost: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iolatency: fix incorrect lock order for rq_qos_mutex and freeze
    queue
  block/blk-rq-qos: cleanup rq_qos_add()
  blk-rq-qos: remove queue frozen from rq_qos_del()
  blk-cgroup: remove queue frozen from blkcg_activate_policy()

 block/blk-cgroup.c     |   7 +-
 block/blk-iocost.c     |  15 ++--
 block/blk-iolatency.c  |  11 +--
 block/blk-mq-debugfs.c |  68 +++++++++++-------
 block/blk-mq-debugfs.h |   8 +--
 block/blk-rq-qos.c     |  35 ++--------
 block/blk-sysfs.c      |  39 +----------
 block/blk-throttle.c   |  27 ++++----
 block/blk-wbt.c        | 153 +++++++++++++++++++++++++++++++----------
 block/blk-wbt.h        |   7 +-
 10 files changed, 199 insertions(+), 171 deletions(-)

-- 
2.51.0

