Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F61CD15;
	Sun, 16 Nov 2025 03:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763265152; cv=none; b=rVT2xxL2LOziYuf7XhsibQ/O5/9LZK0N5r1x0Y7xWE3y3PAAnFmHGJIadTG3vEbVjOLFauJo5qLg6vMvOftpJgsiUZrFUaZwY7c3eUDCwXk5lVovP5bMyjuwfxtiSM/Hvkmi7Ra0FNFDMekydVIkEZWoSFC0dZYdNvSFmnkf1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763265152; c=relaxed/simple;
	bh=bZCnS4hH6wpSpSWSrq2n3TUPrpocZezChVsn/UDK548=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFBK+qyBo/rUoF+w/i4sPDS7mCwdCspciYzyOX0VOBzFZpvMD/8B2J3p2d9kzfxXWsWCbriVCsnrKvrWV0nBrtVunP1TyWhP2SHyHEdhz/UIuGWPfIgwRYwOUl2/8ksK00hKDbEfRwDgM+uPh9l5Kh2QWXbdp997OOVLfeomxD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FD5C113D0;
	Sun, 16 Nov 2025 03:52:29 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai@fnnas.com,
	nilay@linux.ibm.com,
	bvanassche@acm.org
Subject: [PATCH RESEND v5 0/7] blk-mq: introduce new queue attribute async_depth
Date: Sun, 16 Nov 2025 11:52:20 +0800
Message-ID: <20251116035228.119987-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:
 - just resend with new email server;
Changes in v4:
 - add review tag for the last patch 3;
 - rebase with my new email address, patches are not changed;
Changes in v3:
 - use guard()/scope_guard() in patch 3;
 - add review tag other than patch 3;
Changes in v2:
 - keep limit_depth() method for kyber and mq-deadline in patch 3;
 - add description about sysfs api change for kyber and mq-deadline;
 - improve documentation in patch 7;
 - add review tag for patch 1;

Background and motivation:

At first, we test a performance regression from 5.10 to 6.6 in
downstream kernel(described in patch 5), the regression is related to
async_depth in mq-dealine.

While trying to fix this regression, Bart suggests add a new attribute
to request_queue, and I think this is a good idea because all elevators
have similar logical, however only mq-deadline allow user to configure
async_depth.

patch 1-3 add new queue attribute async_depth;
patch 4 convert kyber to use request_queue->async_depth;
patch 5 covnert mq-dedaline to use request_queue->async_depth, also the
performance regression will be fixed;
patch 6 convert bfq to use request_queue->async_depth;

Yu Kuai (7):
  block: convert nr_requests to unsigned int
  blk-mq-sched: unify elevators checking for async requests
  blk-mq: add a new queue sysfs attribute async_depth
  kyber: covert to use request_queue->async_depth
  mq-deadline: covert to use request_queue->async_depth
  block, bfq: convert to use request_queue->async_depth
  blk-mq: add documentation for new queue attribute async_dpeth

 Documentation/ABI/stable/sysfs-block | 34 +++++++++++++++
 block/bfq-iosched.c                  | 45 ++++++++-----------
 block/blk-core.c                     |  1 +
 block/blk-mq-sched.h                 |  5 +++
 block/blk-mq.c                       | 64 +++++++++++++++++-----------
 block/blk-sysfs.c                    | 42 ++++++++++++++++++
 block/elevator.c                     |  1 +
 block/kyber-iosched.c                | 33 +++-----------
 block/mq-deadline.c                  | 39 +++--------------
 include/linux/blkdev.h               |  3 +-
 10 files changed, 152 insertions(+), 115 deletions(-)

-- 
2.51.0

