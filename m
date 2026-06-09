Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66CF3E5EC5
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042750; cv=none; b=U70/uITAbbxfqH59rVZ8Fy7vMa3eZctTjnUhwDXV6pXVQHfMhgnj9FYSGZcr1uvjYbk/pbveqqwlZaql4cBubydKRTGp4+lN+q4SiTvhAdkl+mHXCjPhIv4U6CXUBnoCYmDjvsTrwrdxJ+sHS0g/xToJlaO1BvaY4fQUEdLNE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042750; c=relaxed/simple;
	bh=uPtQRfOZYhHSvYDUkiYXuhtGUs8Flbg4AdWQ/YIVtRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t5r3ZYPRIyKRPMTa3O0aEEln7tAX5MTo/dlTHYH6hGolrt/qtbP75DIngOXgLqDUqNt8bnQ99N2BCNu21Pep7zrqorDZv+/6s1UNXRIbQ3w8thOFu+S9fqMEyl9Dp+Z0E+qj3OvE0AlzI/7CoEQFsaoKtBoPz7ZOMXsEO7GvLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QZpGND7r; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QZpGND7r"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjdy49zKzlffvT;
	Tue,  9 Jun 2026 22:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042738; x=1783634739; bh=/KYMQ
	qBHHYPSqaf/45Wpbd0jbAJEzrANa/9yFIqIL4E=; b=QZpGND7rhoyidGvVYKYQd
	+pt2VLqNu5I0i4iwGxOqtfVw0aIeXuzqfZfEr6RQea/sLSlR5MH1R4VZNhwtubZl
	0Z/Hun4ZHtUXChqeOPtyqFVAsOu2MKJ0ps+wRb3iaXVlFNVrC51UXzVvJHEEmXw/
	aLvEnCL5tfl9BCFzbmvuZ/MmNryEVbgUJkyehvgEipmvLwk4bErExkYui0yOanPu
	eZ2fZt3YX+05KN0Zd6P0kkWiEhcykNXC2ElWZHe7eF1UePGEXGRSNzV0caOiU6Nz
	4MlJAmIFEPkfoHmXeq96PRn2iOI4vFZ4Bp94ea5brhWy24+78ICEHYZk737cR393
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hE5vAPup6PtN; Tue,  9 Jun 2026 22:05:38 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjds1hRXzlffvQ;
	Tue,  9 Jun 2026 22:05:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/27] Enable lock context analysis in drivers/block/
Date: Tue,  9 Jun 2026 15:04:47 -0700
Message-ID: <cover.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jens,

This patch series enables lock context analysis in all block drivers in t=
he
drivers/block/ directory. Please consider these patches for the next merg=
e
window.

Thanks,

Bart.

Bart Van Assche (27):
  aoe: Enable lock context analysis
  drbd: Remove "extern" from function declarations
  drbd: Retain one _get_ldev_if_state() implementation
  drbd: Remove the get_ldev_if_state() macro
  drbd: Remove the 'local' lock context
  drbd: Simplify the bitmap locking functions.
  drbd: Move two declarations
  drbd: Pass 'resource' directly to complete_conflicting_writes()
  drbd: Split drbd_nl_get_connections_dumpit()
  drbd: Make a mutex_unlock() call unconditional
  drbd: Split drbd_req_state()
  drbd: Convert drbd_req_state() to unconditional locking
  drbd: Annotate drbd_bm_{lock,unlock}()
  drbd: Enable lock context analysis
  loop: Split loop_change_fd()
  loop: Split loop_configure()
  loop: Remove the "bool global" function argument
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

 drivers/block/Makefile                 |   2 +
 drivers/block/aoe/Makefile             |   2 +
 drivers/block/aoe/aoecmd.c             |   1 +
 drivers/block/drbd/Makefile            |   3 +
 drivers/block/drbd/drbd_bitmap.c       |  43 +-
 drivers/block/drbd/drbd_config.h       |   2 +-
 drivers/block/drbd/drbd_int.h          | 594 +++++++++++++------------
 drivers/block/drbd/drbd_interval.h     |  11 +-
 drivers/block/drbd/drbd_main.c         |  41 +-
 drivers/block/drbd/drbd_nl.c           | 117 ++---
 drivers/block/drbd/drbd_receiver.c     |  27 +-
 drivers/block/drbd/drbd_req.c          |  10 +-
 drivers/block/drbd/drbd_req.h          |  24 +-
 drivers/block/drbd/drbd_state.c        |  50 ++-
 drivers/block/drbd/drbd_state.h        |  41 +-
 drivers/block/drbd/drbd_state_change.h |  32 +-
 drivers/block/drbd/drbd_worker.c       |   6 +-
 drivers/block/loop.c                   | 251 ++++++-----
 drivers/block/mtip32xx/Makefile        |   2 +
 drivers/block/nbd.c                    |   3 +
 drivers/block/null_blk/Makefile        |   2 +
 drivers/block/null_blk/main.c          |  12 +-
 drivers/block/null_blk/zoned.c         |   2 +
 drivers/block/rbd.c                    |   8 +
 drivers/block/rnbd/Makefile            |   2 +
 drivers/block/ublk_drv.c               |   6 +
 drivers/block/xen-blkback/Makefile     |   3 +
 drivers/block/zram/Makefile            |   2 +
 drivers/block/zram/zcomp.c             |   3 +-
 drivers/block/zram/zcomp.h             |   6 +-
 30 files changed, 700 insertions(+), 608 deletions(-)

