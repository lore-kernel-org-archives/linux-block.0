Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814223164BF
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706513; cv=none; b=cu6x7hj6Y+Y4ggZPwYiozRnJpHm39TMdoWkC2oDoKYKLnjp3kyx7Qg+/Iyldinfd9kl4OxxMcvrKSv0v6Y6noUCfdplb/D9DM6KUzh5W6QRouuOYW1zC8fxMIWWPbM5Vn3lQkpQ5y/U21NA1vqxIhiB+mEfmwqGhQIhYqVTQM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706513; c=relaxed/simple;
	bh=aQOY6oeZPlgOxwKBFsyJlom3hi43gW2qNo+Tx8/TjF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lf5FpEVwID7i7xZ3GwUYNGEJpw3bez8yx3z0SYDjgZLOlddn33G9xWlAoZyweyqbFQjGUIWN4DhQ4mHbett1HsIVjkr/+h5AgM1uXlUE4XEbAQAGr3zYa7GP4twbh0xvBP2Xwx4FpWP4WGmtLwcViwzFI5MSpoF78i1VrpokHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B90AC4CEF1;
	Fri, 21 Nov 2025 06:28:31 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v2 0/9] blk-mq: fix possible deadlocks
Date: Fri, 21 Nov 2025 14:28:20 +0800
Message-ID: <20251121062829.1433332-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes in v2:
 - combine two set into one;

Yu Kuai (9):
  blk-mq-debugfs: factor out a helper to register debugfs for all rq_qos
  blk-rq-qos: fix possible debugfs_mutex deadlock
  blk-mq-debugfs: make blk_mq_debugfs_register_rqos() static
  blk-mq-debugfs: warn about possible deadlock
  block/blk-rq-qos: add a new helper rq_qos_add_frozen()
  blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iocost: fix incorrect lock order for rq_qos_mutex and freeze queue
  blk-iolatency: fix incorrect lock order for rq_qos_mutex and freeze
    queue
  block/blk-rq-qos: cleanup rq_qos_add()

 block/blk-cgroup.c     | 38 ++++++++++++++++++++-------
 block/blk-iocost.c     | 15 +++++------
 block/blk-iolatency.c  | 11 +++++---
 block/blk-mq-debugfs.c | 58 ++++++++++++++++++++++++++++++------------
 block/blk-mq-debugfs.h |  4 +--
 block/blk-rq-qos.c     | 27 ++++----------------
 block/blk-sysfs.c      |  4 +++
 block/blk-wbt.c        | 10 +++++++-
 8 files changed, 105 insertions(+), 62 deletions(-)

-- 
2.51.0

