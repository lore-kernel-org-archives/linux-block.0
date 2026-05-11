Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D185426ECF
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517077; cv=none; b=jXDIsown/enVjXs9U8NJUDMShAC6AqBqsTojrwb1evi88ZYc1P6ui1V4ePkw+oHjEL4N+FMegRgRRsX5lqbZrjg0CB8qY29NmlRIlk/cSrNasJRTfo13g7+2rgp/9X+TFlv2GAG0IuzbxE3K6q8uR0xS6wBgInRtPP9EmH2rKXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517077; c=relaxed/simple;
	bh=2R5gR/hie3mD3L/dsPaAEchXIuIO+bVWOLaX/i9UClY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tko5OHFTOTKzuTIYi9+5hSz4VVsi6QnG0HboK/eQJlQ/qCpx2zj89ZpWBewLXISXkw17We75QGV5y7ETgfTT/d5tuwKZJom8pTKrRZcCsHqDtVuLqMcSzHRxTWlhSfp+13cXfRtzxWbCZ/AOOzHtNylszhc7mjDlfpqDK/jfxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kSvJ+NlS; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kSvJ+NlS"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlbR4sbmzlfgQH;
	Mon, 11 May 2026 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1778517071; x=1781109072; bh=Keeec/pdoEDXg+cyqYs1HnIHMv2Tlygg3up
	U7kH/988=; b=kSvJ+NlSdn8p33zxbfjDMh9estNgKc6fdmcI3Ur+MQIZyZbpocC
	Gao3hIpaHvtS7nb9/dbSwisFqFxi/na2ZNqGTcSiXXsaNJ4tZvUxlhdo2SCDzX3N
	IB7HXfZ80XBGRM1YojsSJh2YXjnzBquF+Grr/wO1ByWQXrynSdSHI11ruY+8Sj9I
	JU1RVlAUn513W6zPdWQv+MlIJ002jXpp6mDjvayaeIXu7375a2GN+xAe7XY/md5k
	Z1yww3ssOsiEdirFdmxJv5MfT6bMymQsdj70hapIH1UtK8LCa/PuyUbk4mT7n6MT
	Sz3nZvyEAukaQ3IXlA4veiZEYI30VkCQHnw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IW7kvMor3g2M; Mon, 11 May 2026 16:31:11 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlbK6gJzzlfdvj;
	Mon, 11 May 2026 16:31:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 00/12] Enable lock context analysis
Date: Mon, 11 May 2026 09:30:42 -0700
Message-ID: <20260511163100.1887263-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
context analysis for the block layer core.

Please consider this patch series for the next merge window.

Thanks,

Bart.

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

Bart Van Assche (12):
  block: Annotate the queue limits functions
  block/bdev: Annotate the blk_holder_ops callback functions
  block/cgroup: Split blkg_conf_prep()
  block/cgroup: Split blkg_conf_exit()
  block/cgroup: Improve lock context annotations
  block/cgroup: Inline blkg_conf_{open,close}_bdev_frozen()
  block/crypto: Annotate the crypto functions
  block/blk-iocost: Add lock context annotations
  block/blk-mq-debugfs: Improve lock context annotations
  block/kyber: Make the lock context annotations compatible with Clang
  block/mq-deadline: Make the lock context annotations compatible with
    Clang
  block: Enable lock context analysis

 block/Makefile             |  2 +
 block/bfq-cgroup.c         | 11 ++++-
 block/blk-cgroup.c         | 98 ++++++++++----------------------------
 block/blk-cgroup.h         | 13 +++--
 block/blk-crypto-profile.c |  2 +
 block/blk-iocost.c         | 96 +++++++++++++++++++++++--------------
 block/blk-iolatency.c      | 19 ++++----
 block/blk-mq-debugfs.c     | 12 ++---
 block/blk-throttle.c       | 34 +++++++------
 block/blk.h                |  4 ++
 block/kyber-iosched.c      |  7 ++-
 block/mq-deadline.c        | 12 +++--
 include/linux/blkdev.h     | 21 +++++---
 13 files changed, 173 insertions(+), 158 deletions(-)

