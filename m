Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243A30B51F;
	Mon,  9 Feb 2026 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625799; cv=none; b=OmPJbzDR8NSrhES2huw1jIITId3OmjD65f5s4mtBXVYXnT9mpHOehq1HeMKBvswAwbv/WFHV24HZs2GvNFS8vfg+D+me4wcR+tpe+/5uqi5/BypU+E4nmFDX4Xyuv+8x125EqECJ2+suoflj/rSwkfnkG+uppBVyeoYdJwuMQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625799; c=relaxed/simple;
	bh=Y30VaqXqnnOsPN802ANk1eUUyWOV0QoCglLcETN/U4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxwKLKvD/qa0v/nrRBtsZpdusAY9MRkUuwImIUONmRem0egUBBoETAxTxcLejxPaR2VcR8zStT9Mf9/s0fJFtWcUKIA0gZDiqdDLUxBrIPHEjNGcmpMoAIjUA5yH4a2n/phIPFHWQq6BQ9ddjd50GpxTVpIbzkLBd7axhC37t+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F83DC116C6;
	Mon,  9 Feb 2026 08:29:55 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	sven@kernel.org,
	j@jannau.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	yukuai@fnnas.com
Subject: [PATCH 0/4] blk-mq/nvme: fix debugfs creation with frozen queue
Date: Mon,  9 Feb 2026 16:29:49 +0800
Message-ID: <20260209082953.3053721-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
When callers pre-freeze the queue before calling this function, the
freeze depth becomes 2. The internal unfreeze only decrements it to 1,
leaving the queue still frozen when debugfs_create_files() is called.

This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
debugfs_create_files() and risks deadlock.

Patch 1-3 fix nvme drivers by moving nvme_unfreeze() before
blk_mq_update_nr_hw_queues() so the queue is unfrozen before the call.

Patch 4 fixes the block layer debugfs_create_files() itself. I checked
all callers of debugfs_create_files():

  - blk_mq_debugfs_register() from blk_register_queue(): queue not frozen
  - blk_mq_debugfs_register_hctx() from blk_mq_debugfs_register_hctxs():
    called after blk_mq_elv_switch_back() which unfreezes the queue
  - blk_mq_debugfs_register_sched() from elv_register_queue():
    called after blk_mq_unfreeze_queue()
  - blk_mq_debugfs_register_rqos() from wbt paths:
    called after blk_mq_unfreeze_queue()

All callers have the queue unfrozen. However, the queue can be frozen
from another context at any time, so the WARN_ON_ONCE check is racy.
Replace it with blk_queue_enter()/blk_queue_exit() which properly waits
for the queue to be unfrozen and prevents new freezes while creating
debugfs files.

Yu Kuai (4):
  nvme-rdma: move blk_mq_update_nr_hw_queues after nvme_unfreeze
  nvme-tcp: move blk_mq_update_nr_hw_queues after nvme_unfreeze
  nvme-apple: move blk_mq_update_nr_hw_queues after nvme_unfreeze
  blk-mq: use blk_queue_enter/exit to protect debugfs file creation

 block/blk-mq-debugfs.c    | 15 ++++++++++-----
 drivers/nvme/host/apple.c |  2 +-
 drivers/nvme/host/rdma.c  |  2 +-
 drivers/nvme/host/tcp.c   |  2 +-
 4 files changed, 13 insertions(+), 8 deletions(-)

--
2.51.0

