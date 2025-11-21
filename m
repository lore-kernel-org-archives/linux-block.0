Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58C1B85F8;
	Fri, 21 Nov 2025 05:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702948; cv=none; b=Vwqqo0kCtOe34N5FK2aGhUdVX0GygIJMxngEYjBxiHH8hDUs6H7pqfntyyM6xqS4v23EEDPCxlTnG/0IbRAtLcwNAi9GGvuMeF0tp7cOqGk4ZmMlunes4sSH39D4Dd+cRYfZ2htgSz3PTD3F9XmeE+9/riz6rl1dvLrEpHSFNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702948; c=relaxed/simple;
	bh=ZuKIERSCBfoenlmcD+EjyXuf5+g4UCWxgOOL8aRF7Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5DrZrb22cBHWiWdblsybfxJHBuDRTm65nzr3FidemZjHQjxlFexIAWQVGVXeV60nMw551z8GrF5L7ZIJ3G1l4n3iI0AUX4y6Evxd1gj4C0tg+4oQgKbo/UAv5tK9imrrXB/f0cjCLSAzguf9zZnhy2WIZfXt6apZQ45pkllfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FBCC4CEF1;
	Fri, 21 Nov 2025 05:29:04 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai@fnnas.com
Subject: [PATCH v6 0/8] blk-mq: introduce new queue attribute async_depth
Date: Fri, 21 Nov 2025 13:28:47 +0800
Message-ID: <20251121052901.1341976-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v6:
 - split patch 3 to factor out a helper;
 - improve some wording;
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

patch 1-4 add new queue attribute async_depth;
patch 5 convert kyber to use request_queue->async_depth;
patch 6 covnert mq-dedaline to use request_queue->async_depth, also the
performance regression will be fixed;
patch 7 convert bfq to use request_queue->async_depth;

Yu Kuai (8):
  block: convert nr_requests to unsigned int
  blk-mq-sched: unify elevators checking for async requests
  blk-mq: factor out a helper blk_mq_limit_depth()
  blk-mq: add a new queue sysfs attribute async_depth
  kyber: covert to use request_queue->async_depth
  mq-deadline: covert to use request_queue->async_depth
  block, bfq: convert to use request_queue->async_depth
  blk-mq: add documentation for new queue attribute async_dpeth

 Documentation/ABI/stable/sysfs-block | 34 ++++++++++++++
 block/bfq-iosched.c                  | 45 ++++++++----------
 block/blk-core.c                     |  1 +
 block/blk-mq-sched.h                 |  5 ++
 block/blk-mq.c                       | 68 ++++++++++++++++++----------
 block/blk-sysfs.c                    | 42 +++++++++++++++++
 block/elevator.c                     |  1 +
 block/kyber-iosched.c                | 33 ++------------
 block/mq-deadline.c                  | 39 ++--------------
 include/linux/blkdev.h               |  3 +-
 10 files changed, 156 insertions(+), 115 deletions(-)

-- 
2.51.0

