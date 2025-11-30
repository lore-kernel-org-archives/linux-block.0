Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA9125A9
	for <linux-block@vger.kernel.org>; Sun, 30 Nov 2025 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764470634; cv=none; b=pxseyyXPS/WD2sftLhPAbStxeyWJuFjLyngIBoLFuRCwcLR8bYv2TFOmU56wQEaDEFnj/sBxVQBdZTOdk8hIJ4EmBroCAM7CS7KgBOOXg38jLa1tWTN4JvjKmYqWcHo7sNl1RmKeBIPp2IMDMpTadekXSos1kLIKgEnSpH1WdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764470634; c=relaxed/simple;
	bh=TR5IR1l63YfuPkt443mAMZX2PP1bwyIGCxsuXuNDG5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPB69PTv4DM+o93ZBeGBUP/v3li28XtCOrGnqu6DPP1Cicm6P4GgW8cgwR+6Ax/xu5H51l+pckFY88EfdB5bldfsMa/Mib+8PzQTxpUyUxCV1zJJuE5F5QlvvwsiQxGmu4tUNXR2oOB6RtFJxH7Ap9GnUO+SeRS2F/y7Ls5Jjfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6CEC4CEF7;
	Sun, 30 Nov 2025 02:43:51 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v3 00/10] blk-mq: fix possible deadlocks
Date: Sun, 30 Nov 2025 10:43:39 +0800
Message-ID: <20251130024349.2302128-1-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes in v3:
 - remove changes for blk-iolatency and blk-iocost in patch 2, since
   they don't have debugfs entries.
 - add patch 9 to fix lock order for blk-throttle.
changes in v2:
 - combine two set into one;

Yu Kuai (10):
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

 block/blk-iocost.c     | 15 ++++++-----
 block/blk-iolatency.c  | 11 +++++---
 block/blk-mq-debugfs.c | 57 ++++++++++++++++++++++++++++++------------
 block/blk-mq-debugfs.h |  4 +--
 block/blk-rq-qos.c     | 27 ++++----------------
 block/blk-sysfs.c      |  4 +++
 block/blk-throttle.c   | 11 ++------
 block/blk-throttle.h   |  3 ++-
 block/blk-wbt.c        | 10 +++++++-
 9 files changed, 79 insertions(+), 63 deletions(-)

-- 
2.51.0

