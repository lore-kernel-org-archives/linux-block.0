Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B113264FA
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646047; cv=none; b=ty/wk/EaF6RKE5TEBUEo+PcMYNrgFZUGGCmcUkzP7w6lKKjI5gDy5yLcG+MFdKQ7DpihkN3Nmx9BhxesIrAtOswL9WI64/YY5UOWcVfnzBbwd7pd2RPHDhl5LDLcr5RG8ubru2V0fOn8M0TUaD+U/eRYy51I5hoZ4fkzw2WNpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646047; c=relaxed/simple;
	bh=u+5Vc4dJeg0pLsS+WCUWYdvS+p0QLL3I2h99PyCwNZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7Ct8Qp4z4dSgMKboNztTFh3RXB9U7ktkFsnAgvZ6JiiGyv8mmsIR9MONAdla11VCqGvfTcfV+0nCLjixkvnnl4rt2lwL4Dfl2e2UyrWzj+sGiskMUzqQT+crjaMKpdOEEuYA/rwxBD0MMbZG3UJ4kEeSIta1tHSVq/uOeSbSDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=PLJTrGl3; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="PLJTrGl3"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fjD0Y6RkDzlfl7l;
	Fri, 27 Mar 2026 21:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1774646042; x=1777238043; bh=xQVYEcgPS3cMlWGjoGb1SZoDglqm22WxX1N
	tsVJONk4=; b=PLJTrGl33uHhzmSBM4/gPP8O2syZkSltKBDwumyY95vFtAKhL7l
	N/RBlvMvYmWgdDbPKmeXrHLaHzy46zQiyIGtkP9Y/TlSvSkluOziScsnYU9HN891
	puAyrU1NBm2YLy7nQKzG2YzXuuJdlKe4ngXLrK/RaI7npkk6TYYslh9Jg1jpZges
	5lfDVKpsY1lwbi9NH2YhYBBY15KjYVJib8Mzraj4LScxHieCed3SsrgsYzkuUhFZ
	wyXOGag1QxLuBVHEL2jbJLeTElil1vkNOMjEKZB6Vxto0lETvtHUZAzDkVmzda0o
	UkPrHm6lJmbrmYEVek/FM7M3BtM9QPhEb9A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id e82kZJMgUe7o; Fri, 27 Mar 2026 21:14:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fjD0S5w4YzlgqsK;
	Fri, 27 Mar 2026 21:14:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/6] Enable testing small DMA segment sizes
Date: Fri, 27 Mar 2026 14:13:40 -0700
Message-ID: <20260327211349.2239633-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

About one year ago support was merged for DMA segment sizes smaller than
the virtual memory page size. No blktests exist yet for the new codepaths
related to small segment size support. This patch series makes it possibl=
e
to test these code paths on a system (e.g. a VM) with 4 KiB pages.

The corresponding blktest patch is available here:
https://lore.kernel.org/linux-block/20260323200751.1238583-1-bvanassche@a=
cm.org/

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v2:
 - Wrapped an overly long line and fixed the "Fixes:" tag in patch 2.
 - Restored the seg_boundary_mask check in patch 3.
 - Moved the BLK_MIN_SEGMENT_SIZE constant to a public header file in pat=
ch 4.
 - Check the max_segment_size value before passing it to the block layer =
in
   patch 5.
 - Added a sixth patch for scsi_debug to this series. Because the scsi_de=
bug
   patch uses the BLK_MIN_SEGMENT_SIZE constant, it depends on patch 3.

Changes compared to v1:
 - Addressed Damien's comment and made the null_blk kernel module paramet=
er more
   clear.
 - Added three patches to this series: one patch that fixes a source code
   comment and two patches that reduce the number of users of the
   BLK_MIN_SEGMENT_SIZE constant.

Bart Van Assche (6):
  block: Fix a source code comment
  block: Fix the max_user_sectors lower bound
  block: Fix the DMA segment boundary mask check
  block: Reduce the minimum value for the maximum DMA segment size
  null_blk: Support configuring the maximum DMA segment size
  scsi_debug: Support configuring the maximum segment size

 block/blk-settings.c              | 15 ++++++-----
 block/blk.h                       |  1 -
 drivers/block/null_blk/main.c     | 43 +++++++++++++++++++++++++++++++
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/scsi/scsi_debug.c         | 26 ++++++++++++++++++-
 include/linux/blkdev.h            |  1 +
 6 files changed, 78 insertions(+), 9 deletions(-)

