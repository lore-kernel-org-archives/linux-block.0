Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005522F16E;
	Fri, 10 Oct 2025 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063300; cv=none; b=X6sW2z6aepT0S9BimWWUfcaCzSB1ak5rWU/Ulf+SMl3dcrW4N7D5DDeqo5hQnMpF5zlJ+4ZT+jVWEmReDk5t6V/l/N79QVjk98SvsDdh0hUm/w/5kGP+8J3UK47epvnlix3pR6utm+NWfuB+pkQ9NKeqqeRNDxbKgVbxz9uda1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063300; c=relaxed/simple;
	bh=PkHlXZp6ScUnG3D1az7EMmTZEmssxrzEjpBBdh1XINA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfXlxMLl+4Wpx2YWna0HFK0Bid2rU0OqoH83VWBI6C9iyTyz0tvXhDBZh3pLNCZx0MbR+ZtY5vBYZlq4VFjZkMHVzTGHWvSUk2Fag5h4cPh4NhuyrP99M3ik5f/pRw61E9FZiCAjy9RYUY9h2kLiuL+/NQEtyOSXbHW3VqunLXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzDYBwhK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzDYBwhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CB8C4CEE7;
	Fri, 10 Oct 2025 02:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760063300;
	bh=PkHlXZp6ScUnG3D1az7EMmTZEmssxrzEjpBBdh1XINA=;
	h=From:To:Cc:Subject:Date:From;
	b=VzDYBwhKPHvvTQUKR+PRRDTEW8MvERkNZ4Mzhe39Q2AQhK8wfzXvW12ObtHSQSCZb
	 yNp9lBMrAhiY0euE5tUT4u2fVgfHLCB8MuNVOL2Lchw/s4AtKtkCiaJuGWFTBK3Pq3
	 O10J7twAr/PQcRX773OPSjX/VmqQpQoR3hosTTyownQhadDunp+YEQwiRi4wr7rJzq
	 wZOif4my8TcqpH13skUzS3U6PQkipcluQVxWmmifyqvAK1m8/jppPHnWVbsdTXQRIH
	 BJgTaOwp+muMjkxsJz5kO92Comxmdtz/UZL/gw6wjEDd0omuA1BfqBIikowenZchR6
	 SVX7K+WqST8PA==
From: Yu Kuai <yukuai@kernel.org>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	nilay@linux.ibm.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v3 0/7] blk-mq: introduce new queue attribute async_depth
Date: Fri, 10 Oct 2025 10:28:02 +0800
Message-ID: <20251010022812.2985286-1-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

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

