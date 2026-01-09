Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85B28689A
	for <linux-block@vger.kernel.org>; Fri,  9 Jan 2026 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767941566; cv=none; b=I9cD8G3xgrx5ytkN40o57ZN5fyH1aGueaEANv3xuzfy/fLawLUoDNEa6nA+yLe58LME9EZ/jjq3HRW7KY3Hkpi9SS53zjBsD6FacSruPzHWgWafDoM5lXtz4MGKY5uuxrIPUuoKXUZjn6EIAkY5sMORI0e0f9LaXpSzWaYZka5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767941566; c=relaxed/simple;
	bh=Qv6m+kE3IddqUHWvm2bZC5BlvYEm5/WoeGMcDyvtlE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0ZFlcWRurlqGlyMu9SMRBflrWOqPL/cKYZ8o24af4Srgoc3BUTyOfBmHIJTfB7F31j8nX4QJTbKiuRllm87i+WkgrYPbGlT273aLbzPw5adhpFaA2QKYFxl/ufdwOhBv7iFB6qVOqNj4WT7eCyBeS6fa7UPi90eFlmxt6HlA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7ECC4CEF1;
	Fri,  9 Jan 2026 06:52:43 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v8 0/8] blk-mq: fix possible deadlocks
Date: Fri,  9 Jan 2026 14:52:22 +0800
Message-ID: <20260109065230.653281-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chagnes in v8:
 - split patch 1-8 that is ready to merge, other deadlocks still need
   some discuss about the solution.
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

Yu Kuai (8):
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

 block/blk-mq-debugfs.c |  68 ++++++++++++-------
 block/blk-mq-debugfs.h |   8 +--
 block/blk-rq-qos.c     |  11 ---
 block/blk-sysfs.c      |  39 +----------
 block/blk-wbt.c        | 149 ++++++++++++++++++++++++++++++-----------
 block/blk-wbt.h        |   7 +-
 6 files changed, 159 insertions(+), 123 deletions(-)

-- 
2.51.0

