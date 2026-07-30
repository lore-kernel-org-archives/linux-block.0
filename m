Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0113AB28E
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441543; cv=none; b=LKje3As3hSyZomqQHlIUlY3YSvRNwOgXGisSiguCna7ne0o46klarFqjcpsC2OBdLFVnmCuyeFCMuBYl3GVy1Mf3Bn3kutqHmfvna58APm4HVR7UB4pg0dpT7NKQQiIPVI04TEGGU9gTCwDLYEoKGh9hyn6gHzqYzL9H/R6VX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441543; c=relaxed/simple;
	bh=vOFdi7KtXiwN0aUl52TQJDI4e3HB2WkIe72/EDnyiA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PIbaxygY7xr1yOe5kP4DCYwZWBgciBexeel5jfrW6sYCKfVn1rm4uHLt/0itSNXrUG7BX/WkeuIje2AvLZzZK8D2zhgV+5w2nvhqcIpaSO5oKWKvCTOmen6sGxBGQzRIPDCS1UssoRfK0NPFOhA+4nFPVvLfAXdpvvjVUeZ5vgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=V5eiHbDn; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="V5eiHbDn"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hB0QF1zXpzlfpLs;
	Thu, 30 Jul 2026 19:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1785441537; x=1788033538; bh=w9/sb
	f1Q+EeVvJdQGT9P601gqmtmY6VagmX+aalGhDM=; b=V5eiHbDnwWEr1yVWCb6oM
	HeAtyVAYf4vD4wyioYDOAGo8hhytkmF47O8GE1CXZHXrBbWVUL8wMDB4C09MysPc
	YZ2FsWESnWbHegoMeilfqrL3SVLYmpjUNRKSZ9O7w/YSA/OdKE8Ycpd+5Iy6GEA7
	dilCoKXxGMzfPoLvLHgblA5x99m6jiJ845p8pOHoS7WsXYmL2bcIl65NWE8iEFU7
	rMGl6hhf/ZoZR5LObGGEGZ0ikYrPr/giF6JRPFvJbRi3eA0kS7HKTTI/KkUSOZaH
	3NzREJDOZXw4PCuWWjfpAhe0Ogg9RgmeQO2PxuWv8dTlIX4hGkThLXNigQDZFJ+j
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QDySi5CueqFe; Thu, 30 Jul 2026 19:58:57 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hB0Q71Qfgzlfvps;
	Thu, 30 Jul 2026 19:58:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 00/12] Enable lock context analysis in drivers/block/
Date: Thu, 30 Jul 2026 12:58:23 -0700
Message-ID: <cover.1785440858.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
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
drivers/block/ directory except DRBD. Please consider these patches for t=
he
next merge window.

Thank you,

Bart.

Changes compared to v1:
 - Moved the DRBD changes into a separate patch series.
 - Combined two patches for the loop driver into a single patch.
 - Also for the loop driver, added a __must_hold() annotation to
   __loop_change_fd() and __loop_configure(). Added a __guarded_by()
   annotation to loop_index_idr.
 - Added a __guarded_by() annotation to nbd_index_idr.
 - Introduced the null_zone locking "class" in the null_blk driver.
 - Fixed the rbd patch description.
 - Added a __cond_acquires() annotation to a new function in the ublk dri=
ver.

Bart Van Assche (12):
  aoe: Enable lock context analysis
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

 drivers/block/Makefile             |   2 +
 drivers/block/aoe/Makefile         |   2 +
 drivers/block/aoe/aoecmd.c         |   1 +
 drivers/block/loop.c               | 256 ++++++++++++++++-------------
 drivers/block/mtip32xx/Makefile    |   2 +
 drivers/block/nbd.c                |  11 +-
 drivers/block/null_blk/Makefile    |   2 +
 drivers/block/null_blk/main.c      |   4 +
 drivers/block/null_blk/zoned.c     | 120 ++++++--------
 drivers/block/rbd.c                |   8 +
 drivers/block/rnbd/Makefile        |   2 +
 drivers/block/ublk_drv.c           |   7 +
 drivers/block/xen-blkback/Makefile |   3 +
 drivers/block/zram/Makefile        |   2 +
 drivers/block/zram/zcomp.c         |   3 +-
 drivers/block/zram/zcomp.h         |   6 +-
 16 files changed, 245 insertions(+), 186 deletions(-)

