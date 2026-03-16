Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C233C186
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691760; cv=none; b=kMh4lKhM0eu8e1escSZ9HYBgva5PSazc2Zu0ry561XILjOoQHFyscB7Il8GQguVK85tOUs/+y4giAu0YbObDD2I7bUO94bFB4Qs9VQhSO3OvRRmnFebrIuwXZgvqthlmmLx4Cek1c1vy8xMxECmobia2WKT8755o07LXlxmI4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691760; c=relaxed/simple;
	bh=vY8CwZzmDHreIv8TmTXmSRRqnfvIN14Bxtm5PlXlTeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F/pC6u0rXxGz7pgoK1LO13+449uVRcy1F7Wx1QhaHTPmc3Ht0zQJvUB0sqhg3gvafWCmXOqW6HpVZAmoX7z38iqdI+JS6tB0yATujLePufgumVDx2N/9mC3de6bPfGIIheyW58necQtkwCySom+qxwALN933E3TOMsApYp9Du4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LpdYNBf7; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LpdYNBf7"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR4t2wZRzlfgPq;
	Mon, 16 Mar 2026 20:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773691754; x=1776283755; bh=YMVF7
	w5Z7dAdwulp8Y7l3F4XgpLJch/SLt/hrtbI0Z0=; b=LpdYNBf72y7Dbu3FGjlGc
	jwTXTxIYGKIdP6WRWxAnQqPFBxPh6TBdijK8okcDld6PDJgVXYHMj3q6oNc39LzG
	R7uV1Ui+WI1rQMEKYzV+2vqaAV9FFIyZtwqvm/mcLxDVI/rhz/lc+/0r3OS+Pv9x
	vcCXGMWf8m0PgUJDDVSIE24DYkuhuSeLZDqtRJmOa36VKiNrjxnU1pOSl0nOi+/k
	U/x8wjaxfG9HRCyCAJewlcR5mIRwzTPufDbLziOq3YKbiPabiXG30DAQpxcBdQbu
	hRpyKRz5hpJjCXtoT/V9htN2OgS58c62NbtyQwceiWsf4Kc9ZE/bC5cH6UA1/+pB
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HtWYamf4vsPr; Mon, 16 Mar 2026 20:09:14 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR4m6YBWzlh1TJ;
	Mon, 16 Mar 2026 20:09:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 00/12] Enable lock context analysis
Date: Mon, 16 Mar 2026 13:08:36 -0700
Message-ID: <20260316200901.4111651-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jens,

During the most recent merge window the following patch series has been m=
erged:
[PATCH v5 00/36] Compiler-Based Context- and Locking-Analysis
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
context analysis for the block layer core and all block drivers.

The first patch in this series fixes a bug discovered in DRBD while enabl=
ing
lock context analysis.

Please consider this patch series for the upstream kernel.

Thanks,

Bart.

Changes compared to v1:
 - Dropped the blk-ioc and rnbd patches.
 - Fixed the DRBD and ublk patches.

Bart Van Assche (12):
  drbd: Balance RCU calls in drbd_adm_dump_devices()
  block: Make the lock context annotations compatible with Clang
  aoe: Add a lock context annotation
  drbd: Make the lock context annotations compatible with Clang
  loop: Add lock context annotations
  nbd: Add lock context annotations
  null_blk: Add more lock context annotations
  rbd: Add lock context annotations
  ublk: Fix the lock context annotations
  zloop: Add a lock context annotations
  zram: Add lock context annotations
  block: Enable lock context analysis for all block drivers

 block/Makefile                     |  2 +
 block/bdev.c                       |  8 ++-
 block/blk-cgroup.c                 |  7 ++-
 block/blk-crypto-profile.c         |  2 +
 block/blk-iocost.c                 |  2 +
 block/blk-mq-debugfs.c             | 12 ++--
 block/blk-zoned.c                  |  1 +
 block/blk.h                        |  4 ++
 block/ioctl.c                      |  1 +
 block/kyber-iosched.c              |  4 +-
 block/mq-deadline.c                |  8 +--
 drivers/block/Makefile             |  2 +
 drivers/block/aoe/Makefile         |  2 +
 drivers/block/aoe/aoecmd.c         |  1 +
 drivers/block/drbd/Makefile        |  3 +
 drivers/block/drbd/drbd_bitmap.c   | 26 ++++++---
 drivers/block/drbd/drbd_int.h      | 88 ++++++++++++++++++------------
 drivers/block/drbd/drbd_main.c     | 40 ++++++++++----
 drivers/block/drbd/drbd_nl.c       | 13 +++--
 drivers/block/drbd/drbd_receiver.c | 31 ++++++++---
 drivers/block/drbd/drbd_req.c      |  3 +
 drivers/block/drbd/drbd_state.c    |  2 +
 drivers/block/drbd/drbd_state.h    |  4 --
 drivers/block/drbd/drbd_worker.c   |  6 +-
 drivers/block/loop.c               |  4 ++
 drivers/block/mtip32xx/Makefile    |  2 +
 drivers/block/nbd.c                |  3 +
 drivers/block/null_blk/Makefile    |  2 +
 drivers/block/null_blk/main.c      |  7 ++-
 drivers/block/null_blk/zoned.c     |  2 +
 drivers/block/rbd.c                |  7 +++
 drivers/block/rnbd/Makefile        |  2 +
 drivers/block/ublk_drv.c           |  4 ++
 drivers/block/xen-blkback/Makefile |  3 +
 drivers/block/zloop.c              |  1 +
 drivers/block/zram/Makefile        |  2 +
 drivers/block/zram/zcomp.c         |  3 +-
 drivers/block/zram/zcomp.h         |  6 +-
 drivers/block/zram/zram_drv.c      |  1 +
 include/linux/backing-dev.h        |  2 +
 include/linux/blkdev.h             |  9 ++-
 include/linux/bpf.h                |  1 +
 42 files changed, 236 insertions(+), 97 deletions(-)

