Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D9202963
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682496; cv=none; b=Oyq72hLior+hoUAuSm8baDtpVCLOx03i8OAW2DqrVMGsvWQTdqzSfCl68YDqTFDSMTlOl6KQVt7Ne4dRAqy9k20qlOhJfeUi4w7BSjCK+GbDgXQK1AZBB9Ydp7GT35tGMM+5JHLUCdpjHNfXPIt3AP+kPHSQNEg+LovUtshTUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682496; c=relaxed/simple;
	bh=Zwc3js4ZUs0lQ4hrXG9MzKTg2F3VBcUzi2Ry5bJYy24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sL80UsjSzdi+J74z6lT9AN8NiGE0wzEWNgZXNNwBnQoG2YzfsNXPBpRQ/g/a7AeitaDbrCTeO/K+wzZNvqjldbJObhIqgiF4WdNes4oSGEhq8LreGk+kOr+vn0Y9aoXOZOPomPSyYdFKNCcrQAKBVD8J7wh1MDntAmc+/vyQkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=20ovAZp6; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="20ovAZp6"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8Q6695Tz1XM6Jh;
	Fri,  5 Jun 2026 18:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1780682488; x=1783274489; bh=viXZG61YNbBym6sFsbK1Z92hLPR9FZ7ZtEv
	1VG74dR4=; b=20ovAZp6S0wUwomC6Hc0/j6VYhlMw64eOFv04WB7SCu/hGgEKyN
	sr2221xTYrEIRl0OTdtysyBbYv3s8f+a4fQGR0MtnDLOD7oKXBd6Lgj7OUYk5DYK
	CgmbgYg4g7XU39azIqAHjmhsuTvVrlV88edTOKsWXYzuRoc9dew1PNqcChkcd088
	AK5XKiznIfvjr32/ZquAemFJTXMKSmoi+viMS+Vswfh9yFIMbBw6+Mf5KQD+sElX
	chim0+KrePKF1ec75kuNRobuAC6fqUO6gz/ln8WYbETRgnB080rQOPyOgWqVTJWl
	ggIIl79vmopTyC9YNJVa7ZUXJeYHTQg0+3A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zh3zZavab3lO; Fri,  5 Jun 2026 18:01:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8Pz0rtXz1XM31H;
	Fri,  5 Jun 2026 18:01:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v7 00/14] Enable lock context analysis for the block layer core
Date: Fri,  5 Jun 2026 11:00:53 -0700
Message-ID: <cover.1780682325.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Recently the following patch series has been merged: [PATCH v5 00/36]
Compiler-Based Context- and Locking-Analysis
(https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/)=
. That
patch series drops support for verifying lock context annotations with sp=
arse
and introduces support for verifying lock context annotations with Clang.=
 The
support in Clang for lock context annotation and verification is better t=
han
that in sparse. As an example, __cond_acquires() and __guarded_by() are
supported by Clang but not by sparse. Hence this patch series that enable=
s lock
context analysis for the block layer core.

Note: although the Linux kernel documentation specifies 22 as minimal
version for Clang for context analysis support, this patch series require=
s
Clang 23 because it annotates function pointers. As one can see here, a p=
atch
has been queued that fixes the kernel documentation:
https://lore.kernel.org/all/177926568868.711.3058599932884307249.tip-bot2=
@tip-bot2/

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v6:
 - In patch 10/14, change guard()() back to spin_lock() calls.

Changes compared to v5:
 - Made the description of patch "block/cgroup: Inline
   blkg_conf_{open,close}_bdev_frozen()" more clear.
 - Combined two error paths in ioc_qos_write().
 - Folded iocg_lock() and iocg_unlock() into their callers. Removed the t=
oken
   context lock "ioc_lock".
 - Introduced macros in the debugfs code that capture expressions with
   pointer casts.
 - Added two patches: "block/blk-iocost: Combine two error paths in
   ioc_qos_write()" and "block/blk-iocost: Split ioc_rqos_throttle()".

Changes compared to v4:
 - Rebased and retested on top of Jens' latest for-next branch.

Changes compared to v3:
 - Replaced the "block/bdev: Annotate the blk_holder_ops callback invocat=
ions"
   patch with a patch that adds __releases() annotations to the function
   pointers in struct blk_holder_ops.
 - Dropped the blk-zoned patch since a better patch from Christoph has
   been merged.

Changes compared to v2:
 - Retained the block layer core patches and left out the block driver pa=
tches.
 - Inlined blkg_conf_open_bdev_frozen() and blkg_conf_close_bdev_frozen()=
.
 - In blkg_conf_open_bdev(), added a return statement if the
   WARN_ON_ONCE() statement triggers.
 - Replaced the "block/ioctl: Add lock context annotations" patch with a
   __release() annotation.
 - Replaced the blk-zoned patch with a patch from Christoph.

Changes compared to v1:
 - Rebased this patch series on top of Jens' for-next branch.
 - Included two patches that split blkg_conf_prep() and blkg_conf_exit().
 - Modified how patches are split. Split the block layer core patch into
   multiple patches and moved the CONTEXT_ANALYSIS :=3D y assignments int=
o the
   block driver patches.
 - Made the new source code comments easier to comprehend.
 - Introduced macros in the mq-deadline and Kyber I/O schedulers to make =
the
   __acquires() expressions easier to read.
 - Removed the changes from this series that are not block layer changes.

Bart Van Assche (14):
  block: Annotate the queue limits functions
  block/bdev: Annotate the blk_holder_ops callback functions
  block/cgroup: Split blkg_conf_prep()
  block/cgroup: Split blkg_conf_exit()
  block/cgroup: Improve lock context annotations
  block/blk-iocost: Combine two error paths in ioc_qos_write()
  block/cgroup: Inline blkg_conf_{open,close}_bdev_frozen()
  block/crypto: Annotate the crypto functions
  block/blk-iocost: Split ioc_rqos_throttle()
  block/blk-iocost: Inline iocg_lock() and iocg_unlock()
  block/blk-mq-debugfs: Improve lock context annotations
  block/Kyber: Make the lock context annotations compatible with Clang
  block/mq-deadline: Make the lock context annotations compatible with
    Clang
  block: Enable lock context analysis

 block/Makefile             |   2 +
 block/bfq-cgroup.c         |  11 +-
 block/blk-cgroup.c         |  98 +++---------
 block/blk-cgroup.h         |  13 +-
 block/blk-crypto-profile.c |   2 +
 block/blk-iocost.c         | 306 +++++++++++++++++++++----------------
 block/blk-iolatency.c      |  19 ++-
 block/blk-mq-debugfs.c     |  24 ++-
 block/blk-throttle.c       |  34 +++--
 block/blk.h                |   4 +
 block/kyber-iosched.c      |   7 +-
 block/mq-deadline.c        |  12 +-
 include/linux/blkdev.h     |  21 ++-
 13 files changed, 297 insertions(+), 256 deletions(-)

