Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB74E2F17
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680055; cv=none; b=AE8KH4/TZWM5xTGMxxL/+PhCPVyKSkCcWNzblzRbtliId0pM3FsLT+yILYec9QF/01BPTn27NmfXt6PrVvTKu3o7O+NsnjBlm6UonnSCGzkUEHVvTxz+emQs9NwaFvT+v3PREHs0fBtshj+/9tkL6SbHgDazRRyER4Lqc33jwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680055; c=relaxed/simple;
	bh=GKTt+mFIqyf9/wKLRuhVwf3rD7QO8NxhaDpQp0aZ7c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwidIhjHLLRr9vRBVIMSid70SFd8geHgZkA5m4gLGBun+3SwU/f7NVldE0GRNc2bQnqSbAah2Sn9djmKJywjCAxD2t2HCZ/rJJNzi0hFp1Tl/A4jZp4cs/dfAxVs0djIAjFFvGethgmd8mJYT38QdDFsEPRo2aL4rGLac9XDyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=PY1rp8yI; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="PY1rp8yI"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hm7vw591qzlfvpc;
	Thu, 17 Sep 2026 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1789680041; x=1792272042; bh=niJ+z7WcxY+AEcsLCl5fD4dQktt1sA6NHLm
	FcagC8GI=; b=PY1rp8yIYYaauyv+xhUoVMgIA3KfUmXcCkGGs/Bl4hyNtwrBSW1
	G2kzxlKExPfYPZrrbS4aiQaHs7MPkvVCxIZ1EUv6wjA8dR6qJaVIWcVdItWOionB
	z9nKk/nJdzZA8pu//X32s9vgeuipwIDXmkDpB2NPkRruN8pwZkLLHNt1JEy7L34e
	nLurcJJ3fsGOAEbGyLe7ALNbH41hW1+LYWQmxfuUxEVJTap3spDfQOrQPvCA9LTA
	PTHp4cPwcuN1GN2HAlTufI1hSWZVgNiKH9jNZVdXjV+LczEKzeqW5o9DJM84Sj6P
	859mOWh6+MHAYTig8a2MmnUu3Jm7GI424FA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZVY9Rq9SMtE7; Thu, 17 Sep 2026 21:20:41 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hm7vq38dFzlfvpK;
	Thu, 17 Sep 2026 21:20:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/2] loop: Fix teardown
Date: Thu, 17 Sep 2026 14:20:24 -0700
Message-ID: <cover.1789679858.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This series fixes loop driver teardown. When tearing down an autoclear lo=
op
device, the loop driver must drain in-flight I/O and flush workqueues to
prevent NULL pointer dereferences in lo_rw_aio() and related I/O paths.

The .release() block device callback is invoked while holding
disk->open_mutex. Freezing the request queue or draining workqueues under
disk->open_mutex causes lock inversion and circular locking dependencies
(e.g., when worker threads or I/O completion paths also acquire open_mute=
x
or interact with request queue synchronization).

This patch series resolves the lock inversion by:
1. Adding a .post_release() block device operation that is called
   synchronously from bdev_release() immediately after disk->open_mutex
   is released.
2. Migrating __loop_clr_fd() to .post_release(), allowing loop device
   teardown and queue freezing to happen outside of disk->open_mutex.

This series is inspired by Tetsuo's loop driver patch series.

Please consider applying this patch series.

Thanks,

Bart.

Bart Van Assche (1):
  loop: Perform __loop_clr_fd() after disk->open_mutex is dropped

Tetsuo Handa (1):
  block: Add post_release() operation

 block/bdev.c                     |  3 ++
 drivers/block/loop.c             | 60 +++++++++++++++++++++++---------
 include/linux/blkdev.h           |  8 +++++
 rust/kernel/block/mq/gen_disk.rs |  1 +
 4 files changed, 56 insertions(+), 16 deletions(-)

