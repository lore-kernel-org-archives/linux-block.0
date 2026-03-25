Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255642DF707
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474661; cv=none; b=gzVLRwJlChTtW0E8FRG1MBbrVDANPioh9CrDqJJr7tBC2fErtjOFrDyy6RAknT9HyniOrNvMcfSoeT96vbpk7/RRyj3F1EezPneG8j+iEyrDSbvuVHu/f/w2xNuftNW/QsCeGKdKFZdF6D0XeQ9tpFXb1zsS8nt76NycWnFmT3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474661; c=relaxed/simple;
	bh=0SXqQJ400kOLCsvBDoNuA2aRnAhuS/aeFp+Bv9n39IM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gw1Q1ytnU+tXKhSWtVmLDrXyvCLGkEBdMHDLT5vLuqZusd6ZF4MU7wYn2d8DDwdbIZk5CIJLD9VfARVJ0F/KYYEuDp/T1rymz+NF1+R/Q/Or7Yk5tJwLWYzsxvOLcjjbD9w9ZhEfr3KsG8j4rfXRRHZWZjWNUW4GWY1gSYJPsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nID8jVcs; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nID8jVcs"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0cY1x34zlfddr;
	Wed, 25 Mar 2026 21:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1774474650; x=1777066651; bh=6rz9Pd3flg9yuvueGLKwPAsje84TQqDFMuN
	HLlTBEEY=; b=nID8jVcsSBfqy37I5anuiajHme+Nk2iY/aLloXHAurXbv4NuY01
	ymwwXBAKoCF9ot7vi7Cd6ojLC2791ohbDeSvxF02Ki4csa1URHSNPzOs6OiuvtSQ
	Tp+v4W6UZP3OoiqlVcmjja7g/uXj5yWD+T6zGGhDRfZFAJD0o1xDkG/J28da/Uut
	YzCdq3gCUyf7GKrNnaOuFohS9TBp3klv905kl++UvfSAcHw/qrdN8xjkAY9ZwEIz
	sqackEBMWmm0TV22LPtYADqdoLwws6Bm2EpEHp0cM7y/ZPORBUdTmt2mkNgo/L5t
	1j0W84qQz4sM+4jgu+dimMkCZaVcttTU2Kg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id v2JtKVbkEc1m; Wed, 25 Mar 2026 21:37:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0cS6099zlfgS0;
	Wed, 25 Mar 2026 21:37:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/5] Enable testing small DMA segment sizes
Date: Wed, 25 Mar 2026 14:37:10 -0700
Message-ID: <20260325213719.2850619-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

About one year ago support was merged for DMA segment sizes smaller than =
the
virtual memory page size. No blktests exist yet for the new codepaths rel=
ated
to small segment size support. This patch series makes it possible to tes=
t
these code paths on a system (e.g. a VM) with 4 KiB pages.

The corresponding blktest patch is available here:
https://lore.kernel.org/linux-block/20260323200751.1238583-1-bvanassche@a=
cm.org/

Please consider this patch series for the next merge window.

Changes compared to v1:
 - Addressed Damien's comment and made the null_blk kernel module paramet=
er more
   clear.
 - Added three patches to this series: one patch that fixes a source code
   comment and two patches that reduce the number of users of the
   BLK_MIN_SEGMENT_SIZE constant.

Bart Van Assche (5):
  block: Fix a source code comment
  block: Fix the max_user_sectors lower bound
  block: Remove a DMA segment boundary mask check
  block: Reduce the minimum value for the maximum DMA segment size
  null_blk: Support configuring the maximum DMA segment size

 block/blk-settings.c              | 14 ++++----------
 block/blk.h                       |  2 +-
 drivers/block/null_blk/main.c     | 13 +++++++++++++
 drivers/block/null_blk/null_blk.h |  1 +
 4 files changed, 19 insertions(+), 11 deletions(-)

