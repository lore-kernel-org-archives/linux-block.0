Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E4A3CCA07
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653743; cv=none; b=Q9U/AXmvTrNtK5ivw+rxrfPEvm3Y8O3COrUxZCRQtwsUBQ17JD8Jq0Uv5C69ULTs7vyuQYtpIOH+/HW1icbOFxI+jctLfMZAxFp3QQ1e4gtHVvWPtsyA0Bag3AMaU7pzPe2t+o8z20aas5zru0y8/LHu6jvQq36Gcrcf8B9AhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653743; c=relaxed/simple;
	bh=Uf0dbPMpeXsXGa69WrDxZiv2IN18mXiCQRtTZ6Sb1gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=siuEn4mup13mQYt5hc4QQO5vZtj3VxxEXC6OttCb/SOQASwIE8X6F0mDtE1Fa3EZgdZwoOGys2f8XhC5rqkxUfRfLKtjf3QJmDUHBU4ZAgRutHuDbY5YRic+D9TivSblfmgVTA6v92sSKrGlddYACS6U8c8lrK2qO3RfmAMzieI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=W2syi55h; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="W2syi55h"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3C164ybz1XM0pH;
	Wed,  4 Mar 2026 19:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653736; x=1775245737; bh=wrTqR
	ailX3WzInCczkv+MgmHJXIQDkqn25mHBO3AMM4=; b=W2syi55h+0hH2JA015CwM
	tB8tPzLQeuGpu6a/o111Der+bO5ENuUjx54TmEUugBN+V8XgKrtgWevu5Z5upS+s
	0rBudwwRGmaLDcx690VclXtxqlHSbX0gxtvWGSUotXWYTNvO4tymRukn+0BGMdpD
	nJ+2KZh2Bp7Phw+xZSMbIKEEXFUr8Qlje7ND+7ZKBNNIStI2FNFV5Pny7l8W6E6A
	74EqRDzlWkRqfPWxSBSP1KerBJoTCPeiaQ545OAup0m8UVWBuOME8HY49nlpKT8I
	owD4+B0Yw/RCxOW+Or7k1q/udQuJMOCz++hplsUhIdHEC+DA5eiXXhqNWjoh2ctV
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gVArRNv4kj8H; Wed,  4 Mar 2026 19:48:56 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3Bv31qlz1XM5kt;
	Wed,  4 Mar 2026 19:48:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/14] Enable lock context analysis
Date: Wed,  4 Mar 2026 11:48:19 -0800
Message-ID: <20260304194843.760669-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
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
and introduced support for verifying lock context annotations with Clang.=
 The
support in Clang for lock context annotation and verification is better t=
han
that in sparse. Hence this patch series that enables lock context analysi=
s for
the block layer core and all block drivers.

The first patch in this series fixes a bug discovered in DRBD while enabl=
ing
lock context analysis.

Please consider this patch series for the upstream kernel.

Thanks,

Bart.

Bart Van Assche (14):
  drbd: Balance RCU calls in drbd_adm_dump_devices()
  blk-ioc: Prepare for enabling thread-safety analysis
  block: Make the lock context annotations compatible with Clang
  aoe: Add a lock context annotation
  drbd: Make the lock context annotations compatible with Clang
  loop: Add lock context annotations
  nbd: Add lock context annotations
  null_blk: Add more lock context annotations
  rbd: Add lock context annotations
  rnbd: Add more lock context annotations
  ublk: Fix the lock context annotations
  zloop: Add a lock context annotations
  zram: Add lock context annotations
  block: Enable lock context analysis for all block drivers

 block/Makefile                     |  2 ++
 block/bdev.c                       |  7 +++--
 block/blk-cgroup.c                 |  7 +++--
 block/blk-crypto-profile.c         |  2 ++
 block/blk-ioc.c                    |  2 +-
 block/blk-iocost.c                 |  2 ++
 block/blk-mq-debugfs.c             | 12 ++++----
 block/blk-zoned.c                  |  1 +
 block/blk.h                        |  4 +++
 block/ioctl.c                      |  1 +
 block/kyber-iosched.c              |  4 +--
 block/mq-deadline.c                |  8 +++---
 drivers/block/Makefile             |  2 ++
 drivers/block/aoe/Makefile         |  2 ++
 drivers/block/aoe/aoecmd.c         |  1 +
 drivers/block/drbd/Makefile        |  3 ++
 drivers/block/drbd/drbd_bitmap.c   | 20 +++++++------
 drivers/block/drbd/drbd_int.h      | 46 ++++++++++++++----------------
 drivers/block/drbd/drbd_main.c     | 45 ++++++++++++++++++++++-------
 drivers/block/drbd/drbd_nl.c       | 13 ++++++---
 drivers/block/drbd/drbd_receiver.c | 20 +++++++------
 drivers/block/drbd/drbd_req.c      |  2 ++
 drivers/block/drbd/drbd_state.c    |  3 ++
 drivers/block/drbd/drbd_worker.c   |  6 ++--
 drivers/block/loop.c               |  4 +++
 drivers/block/mtip32xx/Makefile    |  2 ++
 drivers/block/nbd.c                |  3 ++
 drivers/block/null_blk/Makefile    |  2 ++
 drivers/block/null_blk/main.c      |  7 +++--
 drivers/block/null_blk/zoned.c     |  2 ++
 drivers/block/rbd.c                |  7 +++++
 drivers/block/rnbd/Makefile        |  2 ++
 drivers/block/rnbd/rnbd-clt.c      |  2 ++
 drivers/block/ublk_drv.c           |  6 +++-
 drivers/block/xen-blkback/Makefile |  3 ++
 drivers/block/zloop.c              |  1 +
 drivers/block/zram/Makefile        |  2 ++
 drivers/block/zram/zcomp.c         |  3 +-
 drivers/block/zram/zcomp.h         |  6 ++--
 drivers/block/zram/zram_drv.c      |  1 +
 include/linux/backing-dev.h        |  2 ++
 include/linux/blkdev.h             | 11 +++++--
 include/linux/bpf.h                |  1 +
 43 files changed, 197 insertions(+), 85 deletions(-)

