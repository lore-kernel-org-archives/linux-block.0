Received: from mta1.migadu.com (out-131.mta1.migadu.com [95.215.58.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B03596F8
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051962; cv=none; b=fZBRni1cy+OEEDVM4UqyKwyZFDIehTkEbTuVEgjBG7jeyog6amActpuiR6V+nGr/S4evU90fKcj+inrN4o4xaLQbnMsrr7Atj5w9J8PQP2pU966xqLeV3ZD/bUX49Dm7tf21s3qMnhKqrUP5WKVgpyWd8Gq9q/Vh2mPdR34PBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051962; c=relaxed/simple;
	bh=UXsAZ0ZIDITmqWOM2hM8N2RqkY0U1XHEV6bVpJvnAPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y94CP3msDmvTKajFWc3qAucjepVKeBsMEugdGQa7MgRgq3HrAyY7/0Wm5qIYvnynqv8VFZZ9Vy1/WHFmhmBwuJ+qauMkgrJkRpUj/5hUHLgTfrf9RnAQRg7H78STQQMdOlWzEHqV4DeHR+cqiuNKm4UaXRjlC1ZQVCk8bIoFSR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UXE6iDDk; arc=none smtp.client-ip=95.215.58.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UXE6iDDk"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UXsAZ0ZIDITmqWOM2hM8N2RqkY0U1XHEV6bVpJvnAPc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790051950; v=1; x=1790656750;
 b=UXE6iDDkyHzaIvaBzK3K+HaM/4uqXWHtBE1Kfzv8kx6WX42KrchnLLhwXOacdcx0w7Js91sP
 Jviw1olKLPUweCTp4oz39P3CQuRIq5u1VHFUXST6aLWY3eOJ3QWSahO+v65/dIMFu6WP6rLwUO0
 RLXFM8ZKn8XqHR8tpTuiSD24=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 013422bacf437b27;
	Tue, 22 Sep 2026 04:39:10 +0000
X-Mizu-Trace-ID: 013422bacf437b27
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	hch@infradead.org
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn
Subject: [PATCH v4 0/4] blk-iocost: charge flushes and zone appends
Date: Tue, 22 Sep 2026 12:38:52 +0800
Message-ID: <20260922043856.2020116-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>


While testing iocost's weight-based throttling under concurrent IO, we
observed that a cgroup limited to 1% weight could issue an unbounded
number of flushes without being throttled: an fsync loop produced ~510k
flushes in 12s with cost.usage staying at zero the entire time.  The
device was monopolized while iocost reported no activity.  Zone appends
were in the same position: the builtin linear cost model defines
coefficients only for READ and WRITE, so REQ_OP_ZONE_APPEND is priced
at zero and excluded from the latency statistics as well.

This series prices both, without changing the behavior of existing
setups:

 1/4: add a flushiops entry to io.cost.model, translated like the
      other iops coefficients (VTIME_PER_SEC / flushiops).  A bio with
      REQ_PREFLUSH is charged one flush on top of its data cost, and a
      bio with REQ_FUA one more flush on devices without native FUA
      support (bdev_fua()), mirroring the pre-flush and post-flush the
      block layer issues for them.  flushiops is zero in the builtin
      profiles with no fallback to the write coefficients, so nothing
      changes until it is configured.  Also documents flushiops in
      cgroup-v2.rst.
 2/4: treat zone appends as writes in the builtin cost model -
      REQ_OP_ZONE_APPEND falls through to the REQ_OP_WRITE
      coefficients.
 3/4: count zone append completions in the latency window so the vrate
      feedback loop can see ZA-induced latency.
 4/4: fix a stale comment in ioc_rqos_throttle().

Measured on virtio-blk with a bio test module issuing bios from a
cgroup (300 bios per phase):

  - plain writes cost 23.41 usec, unchanged
  - with the default model, WRITE|PREFLUSH and standalone flushes cost
    the same as before: the flush component is free until flushiops is
    configured
  - with flushiops=100, WRITE|PREFLUSH and WRITE|FUA are charged
    +10000 usec per bio and WRITE|PREFLUSH|FUA +20000, exactly
    VTIME_PER_SEC / 100 per flush (virtio-blk has no native FUA,
    confirmed via queue/fua)
  - standalone flushes are charged 10000.06 usec each, matching
    VTIME_PER_SEC / 100
  - with flushiops=10, a flush storm from a low-weight cgroup is
    throttled to one flush per 100ms

Changes in v4:
- 1/4 only, addressed Tejun's review comments: remove the always-true
  !is_merge wrapper and the separate flush_cost accumulator, charge
  flushes directly into cost before the empty bio check, trim the
  comment to the FUA case, and update the commit message and
  cgroup-v2.rst wording. No behavioral change: the whitebox numbers
  are identical.
- 2/4, 3/4 and 4/4 are unchanged except for the added Acked-by tags.

Changes in v2:
- charge the flush component of data-bearing REQ_PREFLUSH bios too,
  not only standalone flushes (Christoph)
- skip the iocg->cursor update for dataless flush bios

Changes in v3:
- the write-coefficient flush pricing is replaced by the flushiops
  model parameter: pricing a flush off the write coefficients is as
  arbitrary as pricing it at zero and changes what existing setups
  get charged, so flushes are only priced when flushiops is
  configured (Tejun)
- the zone append patch is reduced to the minimal change: ZA falls
  through to the REQ_OP_WRITE coefficients and the cursor is left
  alone (Tejun)
- the Fixes tags on 2/4 and 3/4 point at 0512a75b98f8, which added
  the op without pricing it; 3/4 is otherwise unchanged from v2

Tao Cui (4):
  blk-iocost: add flush cost support with the flushiops model parameter
  blk-iocost: charge zone appends as writes
  blk-iocost: account zone append completions in latency stats
  blk-iocost: fix stale comment in ioc_rqos_throttle()

 Documentation/admin-guide/cgroup-v2.rst |  7 +++++
 block/blk-iocost.c                      | 39 ++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.43.0
