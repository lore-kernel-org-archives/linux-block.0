Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B162F1FC1
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895009; cv=none; b=FH6fdkVzGNtfODrVTAb6JLmUFLEc1LiCvLYPohxC0VNn5YaGjSubVyJeQmr70wm/tFMK41CAUWA6Hmpfu6xUPSoIOyf4f1/QF3qTGzBxDahSIKT5HmiYurb79yn6thHKSI2iFvJXC/19ErlcKoqozbfWqzBxxGrbsAgt3ejsbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895009; c=relaxed/simple;
	bh=b4ioXWOyyt9woIuKnMQDg4tw0xbB8AWpDgnK7Ypduy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGfZkcIaccaToDsvJcAQcS9HD9ROf4PWNF/TWTchOfICFT1Swq3lxR+r/H3mMKrial9DU0y4l9IhuogQ7IzIqTWy3uNcJKF8+PEm06hjI3M4lwRM4pXXeNit7xOxwPSgpmERjKhoKGnn1AyDDDUbgZhAuj9nVHwQn8/77dP9vVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OId/3uqx; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OId/3uqx"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bSJKp3dHczm0jwL;
	Wed, 25 Jun 2025 23:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1750895005; x=1753487006; bh=HMlJoMeBrI8LEOqO1ru8RYUqqfWGcSNXGWs
	OhlqtE8s=; b=OId/3uqx5yH2K/lhgdT5G7lQTPWOgEcBbCRJZ78KTlBw21m9TQ2
	sDjILkkt4r9JXD372VwRScrXbgwxYyEBvPHnBFz8bV7OpCB8EsaU1aYxf2EK/zNz
	sELjsgqL9eCHMmY/CDFQtpDwssNuGLy4s1j6Uvyi+oqxLOZW64ggasbyFgV640rv
	0ozq0Rd1Jrl0JvdzS0Px7LPD+sn8biqBcIFzst1oHr0etORJi9VNLKREsitTOD5Z
	CVKKIePmoBHVIlHwSZQ0mmIlBn7CoyWCE/S9ZCB10nrRFev6ZR9GEYoa4xMl/y/U
	31P2sXBr6WC+vqkEtgLvBQMBrmC+Bm94cyw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MeULRjHlVufS; Wed, 25 Jun 2025 23:43:25 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bSJKh0V2yzm0pKc;
	Wed, 25 Jun 2025 23:43:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Keith Busch <kbusch@kernel.org>,
	Christop Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Fix bio splitting in the crypto fallback code
Date: Wed, 25 Jun 2025 16:42:56 -0700
Message-ID: <20250625234259.1985366-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

When using the crypto fallback code, large bios are split twice. A first
time by bio_split_to_limits() and a second time by the crypto fallback
code. Additionally, this causes bios not to be submitted in LBA error and
hence triggers write errors for zoned block devices. This patch series
fixes this by splitting bios once. Please consider this patch series for
the next merge window.

Thanks,

Bart.

Bart Van Assche (3):
  block: Split blk_crypto_fallback_split_bio_if_needed()
  block: Introduce the BLK_FEAT_CALLS_BIO_SPLIT_TO_LIMITS flag
  block: Rework splitting of encrypted bios

 block/bio.c                 |  3 +++
 block/blk-core.c            | 19 ++++++++-----
 block/blk-crypto-fallback.c | 53 ++++++++++++++++++++-----------------
 block/blk-crypto-internal.h |  7 +++++
 block/blk-crypto.c          |  3 ++-
 block/blk-merge.c           | 13 +++++++--
 block/blk-mq.c              |  3 ++-
 block/blk.h                 |  9 +++++++
 include/linux/blk_types.h   |  1 +
 include/linux/blkdev.h      |  6 ++++-
 10 files changed, 81 insertions(+), 36 deletions(-)

