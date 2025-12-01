Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE2296BCF
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578059; cv=none; b=GzTChzL6NCNnWnLVm1G8w76hmn+hBDHVKYx1rT06zkkACOc4Ipayp4oKu35JZ0R68HkyQyvHA3Wy8qffFxKumPIRhQ+kAz3GBQNTmW6T9zsqmzyo53M1fZiXcAms7/aCcvX2/XWUSeXfWgxGVrlnsOVIV6BNJD/+LUaMcgYk7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578059; c=relaxed/simple;
	bh=WaNYIzMECKizr3HVMRtlLUAd/VmiGZetIR5JZt9VyyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMDrryJNI2CEUjwHho+G1ra+94WfjC0UUDSdcDcQEyDptS1qC9uFh5LIaBgRy1QheQUBmnE9yOkiAWSllylDDfZ4ts4kThDMdsrrF8cixtss/rXT1GdDUsMbDmRRqjpy6X+GzUfQhbn178XHiC/UKxIvl2fxCbVmnBsZWMAsJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F201C4CEF1;
	Mon,  1 Dec 2025 08:34:17 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v4 00/12] blk-mq: fix possible deadlocks
Date: Mon,  1 Dec 2025 16:34:03 +0800
Message-ID: <20251201083415.2407888-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes in v4:
 - add patch 1,2 to fix a new deadlock;
changes in v3:
 - remove changes for blk-iolatency and blk-iocost in patch 2, since
   they don't have debugfs entries.
 - add patch 9 to fix lock order for blk-throttle.
changes in v2:
 - combine two set into one;

patch 1-2 fix deadlock pcpu_alloc_mutex under q_usage_counter;
patch 3-6 fix deadlock debugfs_mutex under q_usage_counter;
patch 7-12 fix deadlock q_usage_counter under rq_qos_mutex;

Yu Kuai (12):
  blk-wbt: factor out a helper wbt_set_lat()
  blk-wbt: fix possible deadlock to nest pcpu_alloc_mutex under
    q_usage_counter
  blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
  blk-rq-qos: fix possible debugfs_mutex deadlock
  blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
  blk-mq-debugfs: warn about possible deadlock
  block/blk-rq-qos: add a new helper rq_qos_add_frozen()
  blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iocost: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iolatency: fix incorrect lock order for rq_qos_mutex and freeze
    queue
  blk-throttle: remove useless queue frozen
  block/blk-rq-qos: cleanup rq_qos_add()

 block/blk-iocost.c     |  15 ++---
 block/blk-iolatency.c  |  11 ++--
 block/blk-mq-debugfs.c |  57 +++++++++++-----
 block/blk-mq-debugfs.h |   4 +-
 block/blk-rq-qos.c     |  27 ++------
 block/blk-sysfs.c      |  39 +----------
 block/blk-throttle.c   |  11 +---
 block/blk-throttle.h   |   3 +-
 block/blk-wbt.c        | 145 +++++++++++++++++++++++++++++++----------
 block/blk-wbt.h        |   8 +--
 10 files changed, 181 insertions(+), 139 deletions(-)

-- 
2.51.0

