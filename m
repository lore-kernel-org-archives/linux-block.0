Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAA2F616E
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766658778; cv=none; b=CS9eC/cvyN71sk6IMygSCBf6wP2JQ/eV7tyqRPjEZmD/gfV5tinrNedKUOTlshJ7z97wAlHZIeUyGOvd1KRiI8skpuI25bW34+qv6HjzbJS6tdO+7EwFvtrTGh+9t1pFw7H7lTI7oX7zYSXVaI6FZ8RvBALI0anqiqxA8dUdoKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766658778; c=relaxed/simple;
	bh=LI2HLGAHJpkpCgYZSY2T1MdXT7OxHlvtdyYlNV56DmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKAQgp/ujk24NoeKV9aiIxUhYXKkZGP4qf8CEpsN1Akdfuipbm9ZZuDIsUJgSYj1QtFgG6/v4TElqhuyKuXxLC4rTkUW6nFDNJf5ty3LOqrgeENAm1p/PQ9gSRH26OH/61S+DAe8der9ZFmtOUgZeCpibXSItY3PcT8oNGSXJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1E7C4CEF1;
	Thu, 25 Dec 2025 10:32:55 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v6 00/13] blk-mq: fix possible deadlocks
Date: Thu, 25 Dec 2025 18:32:35 +0800
Message-ID: <20251225103248.1303397-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 - patch 3-7, debugfs_mutex under q_usage_counter;
 - patch 8, fs_reclaim under rq_qos_mutex in blk-throttle;
 - patch 9-13, q_usage_counter under rq_qos_mutex;

Yu Kuai (13):
  blk-wbt: factor out a helper wbt_set_lat()
  blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under
    q_usage_counter
  blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
  blk-rq-qos: fix possible debugfs_mutex deadlock
  blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
  blk-mq-debugfs: remove blk_mq_debugfs_unregister_rqos()
  blk-mq-debugfs: warn about possible deadlock
  blk-throttle: fix possible deadlock for fs reclaim under rq_qos_mutex
  block/blk-rq-qos: add a new helper rq_qos_add_frozen()
  blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iocost: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iolatency: fix incorrect lock order for rq_qos_mutex and freeze
    queue
  block/blk-rq-qos: cleanup rq_qos_add()

 block/blk-iocost.c     |  15 ++--
 block/blk-iolatency.c  |  11 +--
 block/blk-mq-debugfs.c |  66 +++++++++++-------
 block/blk-mq-debugfs.h |   8 +--
 block/blk-rq-qos.c     |  31 ++-------
 block/blk-sysfs.c      |  39 +----------
 block/blk-throttle.c   |  27 ++++----
 block/blk-wbt.c        | 153 +++++++++++++++++++++++++++++++----------
 block/blk-wbt.h        |   7 +-
 9 files changed, 194 insertions(+), 163 deletions(-)

-- 
2.51.0

