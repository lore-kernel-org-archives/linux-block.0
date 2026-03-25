Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5F387572
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475135; cv=none; b=R4cl9rBVLuooe1n2U9c7SuBnDrwZrr9Yc53odXAhWTybW0kCtCi4n4ZfGsuFdtqV3W/tgJC4w4gQXUjRKCsIRI0EAshs+suW0pe6oCal5Yy0g/JyxpGe6ktplPjB7p+4jwF1vLVENt6SdS+9iZzF6sfwfc4mYwSkI0sSA7XPzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475135; c=relaxed/simple;
	bh=INscOA8vl2vS+ZCYcHHqSGECE9afaCMyDt/DZzkyA50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rePcG/efNMKFuEtUOYD47t7B9bEQPcMEH+nvdJ97Omn9x1RwC47gVsQrzlVFNLiurwnjcj/fwy19J7gn30fnSqjpkS9W/QQO5OEGk5Fj1g4YvX5v2ZZ4vgy4qXkza96fO54ocTOW6U1Xld+7uDBpKlAIHVjOHJTxMShLJG8cB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qaPcGgx8; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qaPcGgx8"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0nn3jtlzlgyGT;
	Wed, 25 Mar 2026 21:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475128; x=1777067129; bh=Qgxl/
	pDjfUnsoei1XFBezC1iRd0adV77OnJ2EqOEI1Y=; b=qaPcGgx8oXlluESKWt7fR
	9EHOEmsxGHXOsUrcU//lSDmhON0Gd7SPnUm0fjInMaUjXqpBPG+WoRv89bZDyw1h
	kAcoEaGayBxv8sJDenbqpgF+7meLhGCCXBpa35tQAb0TBtaVeqRlXJcWhR23kjnU
	oBkr7sy3dg9fGnPd0fl9AmnqEcnC7SjPdDho4eA14l/FjuEx1QvLmXOseVbI4xnS
	Yg5VFqy3C+kAZai10tO+TpLmPxnqGlUzh67sRJuOgRJ2TZTq03XTw1kGgdnkKWZR
	7Er55DJfXt2C9nbFa+aDgnVINhIPiZxCV2MxxH5WiUGBYF3mnL8Dku5bOwbq2D5l
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id N8WChMjymHe1; Wed, 25 Mar 2026 21:45:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0ng1wwfzlfvpM;
	Wed, 25 Mar 2026 21:45:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 00/26] Enable lock context analysis
Date: Wed, 25 Mar 2026 14:44:41 -0700
Message-ID: <20260325214518.2854494-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
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

Please consider this patch series for the next merge window.

Thanks,

Bart.

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

Bart Van Assche (26):
  block: Annotate the queue limits functions
  block: Annotate the block device functions
  block/cgroup: Split blkg_conf_prep()
  block/cgroup: Split blkg_conf_exit()
  block/cgroup: Modify the blkg_conf_open_bdev_frozen() calling
    convention
  block/crypto: Annotate the crypto functions
  block/blk-iocost: Add lock context annotations
  block/blk-mq-debugfs: Improve lock context annotations
  block/blk-zoned: Add lock context annotations
  block/ioctl: Add lock context annotations
  block/Kyber: Make the lock context annotations compatible with Clang
  block/mq-deadline: Make the lock context annotations compatible with
    Clang
  block: Enable lock context analysis
  aoe: Add a lock context annotation
  drbd: Balance RCU calls in drbd_adm_dump_devices()
  drbd: Make the lock context annotations compatible with Clang
  loop: Add lock context annotations
  mtip32: Enable lock context analysis
  nbd: Enable lock context analysis
  null_blk: Enable lock context analysis
  rbd: Enable lock context analysis
  ublk: Enable lock context analysis
  xen-blkback: Enable lock context analysis
  zram: Enable lock context analysis
  rnbd: Enable lock context analysis
  block: Enable lock context analysis for all block drivers

 block/Makefile                     |  2 +
 block/bdev.c                       | 10 +++-
 block/bfq-cgroup.c                 | 11 +++-
 block/blk-cgroup.c                 | 82 +++++++++++++---------------
 block/blk-cgroup.h                 | 19 +++++--
 block/blk-crypto-profile.c         |  2 +
 block/blk-iocost.c                 | 77 ++++++++++++++------------
 block/blk-iolatency.c              | 19 ++++---
 block/blk-mq-debugfs.c             | 12 ++--
 block/blk-throttle.c               | 34 +++++++-----
 block/blk-zoned.c                  |  1 +
 block/blk.h                        |  4 ++
 block/ioctl.c                      |  1 +
 block/kyber-iosched.c              |  7 ++-
 block/mq-deadline.c                | 12 ++--
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
 drivers/block/rbd.c                |  8 +++
 drivers/block/rnbd/Makefile        |  2 +
 drivers/block/ublk_drv.c           |  4 ++
 drivers/block/xen-blkback/Makefile |  3 +
 drivers/block/zram/Makefile        |  2 +
 drivers/block/zram/zcomp.c         |  3 +-
 drivers/block/zram/zcomp.h         |  6 +-
 drivers/block/zram/zram_drv.c      |  1 +
 include/linux/blkdev.h             |  9 ++-
 43 files changed, 369 insertions(+), 203 deletions(-)

