Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F408295DA6
	for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765707254; cv=none; b=MTmcgaoPoAZFVXGnemEqHfl8R2/g2poiFG8XT1nAVNfeGkKl07KFSibYg5BVMgEi4447MpUIVNjj8YNEocliZ/semDxyuqE8lBfcKdvtkb1EfnJLoZp38jq9QINAGcXsZHn/8eYvOgGqYp4x/bIgaiUNzBKf4XXZZouwV8m9RjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765707254; c=relaxed/simple;
	bh=pbTnQEaBjxiQwDsQjog2/eDHHBAK0/kgu01VZkgSZkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGspUgdLtY+grFACcfqYlP1IZ8HbXV0ExkEs0cTc1xeAaPWRXJ1+yAAM9D69FazGbM9PDH/HRvEsxk/PSx0fwdQNGmu04q1d3DJ37Ff8VK59bU3B6IMlqLNaKeVuxNx1/1RcI9ZGVtpnSgRcfiF5hBD+yD8/iAGy8SBrLS84eC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530C2C4CEF1;
	Sun, 14 Dec 2025 10:14:11 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v5 00/13] blk-mq: fix possible deadlocks
Date: Sun, 14 Dec 2025 18:13:55 +0800
Message-ID: <20251214101409.1723751-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fix deadlock:
 - patch 1-2, pcpu_alloc_mutex under q_usage_counter;
 - patch 3-6, debugfs_mutex under q_usage_counter;
 - patch 7, fs_reclaim under q_usage_counter;
 - patch 8-13, q_usage_counter under rq_qos_mutex;

Yu Kuai (13):
  blk-wbt: factor out a helper wbt_set_lat()
  blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under
    q_usage_counter
  blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
  blk-rq-qos: fix possible debugfs_mutex deadlock
  blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
  blk-mq-debugfs: warn about possible deadlock
  blk-throttle: convert to GFP_NOIO in blk_throtl_init()
  block/blk-rq-qos: add a new helper rq_qos_add_frozen()
  blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iocost: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iolatency: fix incorrect lock order for rq_qos_mutex and freeze
    queue
  blk-throttle: remove useless queue frozen
  block/blk-rq-qos: cleanup rq_qos_add()

 block/blk-iocost.c     |  15 ++--
 block/blk-iolatency.c  |  11 +--
 block/blk-mq-debugfs.c |  57 +++++++++++-----
 block/blk-mq-debugfs.h |   4 +-
 block/blk-rq-qos.c     |  27 ++------
 block/blk-sysfs.c      |  39 +----------
 block/blk-throttle.c   |  13 +---
 block/blk-throttle.h   |   3 +-
 block/blk-wbt.c        | 151 ++++++++++++++++++++++++++++++-----------
 block/blk-wbt.h        |   8 +--
 10 files changed, 184 insertions(+), 144 deletions(-)

-- 
2.51.0

