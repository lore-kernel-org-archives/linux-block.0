Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415AA2DE6EB
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488742; cv=none; b=pCq+re5QniF+Z4VTAmKhUQ/xNlLUkgbMz0OWqy+okQ6jCYibGmWguENiRKes0U4bTnmTKDHARWycIbzDDMix0VZEKoMzO+w8adRz0Y2K6e5XP4VXH9cKD7Am+jH2cBKrELgVyBYC37b+2KYSCPs8epe1mLaGQ/n+Y2m4+zXnnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488742; c=relaxed/simple;
	bh=Og//7ozAyV5bq3glmROJ70+wgb3eq9p4UrOq6nDrKoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=td9j1NlXaDMqXns3cq6pPCNZkjXAwYhj7P8EUHNdKrVtO5sHkv6aHrl/WkxtB1oukRzx1OVKhLbSVVq+9fLSUvlJexP8m2uRwWAKvpwT8xHkjSIaaPutVe69gMLa0oAK+8X9pFFGygtQRBZmZBC6PKRPOfxs+rdO96rFejNze0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=f7gWjW9V; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="f7gWjW9V"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXWvl16Gfzm0XC1;
	Wed,  2 Jul 2025 20:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1751488737; x=1754080738; bh=1MCDAPQCwgK61H2bfuAKCeKuvD71kvzm3XJ
	UhpklJeo=; b=f7gWjW9V/R28Ipkohq0witwhihjoZtFUJsUz9EkeM1a3mQ0D1Xl
	FF9mxf3u97CBot5w74+VNKR8ZaFOw3dFmKYj0MOOb2ISZa12SF06TRKHCg1v95jo
	vCEQH7pBNlENf2qJ8Pmf6PaoVdlEWDN+i1HJcyKfxWJX68wpNmDwvC81drt2F9EL
	/6JoWGQ4DDCgE7yV6s6BbxI8YP2wRh+0a/yu+wLPOmDl8ZQ62rJsxZ6wzOfokVxR
	cQkXIzn4xq8VfjBt0XjkJ+hLS3Vbm6h8yz+xwovplvgxrOMQ85E8/3KG0Of+73MA
	EQjam7Gk74YMLAEHxZMUrCPaGH0pwYiN51A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xHW7a4EPsQTn; Wed,  2 Jul 2025 20:38:57 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXWvf4plpzm0dhj;
	Wed,  2 Jul 2025 20:38:53 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/8] Simplify the code modifying queue attributes
Date: Wed,  2 Jul 2025 13:38:35 -0700
Message-ID: <20250702203845.3844510-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

The blk_mq_quiesce_queue() / blk_mq_unquiesce_queue() calls on frozen req=
uest
queues cause confusion and also make the code more verbose than necessary=
.
Hence this patch series that removes these quiesce / unquiesce calls. Thi=
s
patch series should have no performance impact on the hot path and should=
 not
modify the behavior of the block layer.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (8):
  block: Introduce QUEUE_FLAG_FROZEN
  block: Do not run frozen queues
  block: Remove the quiesce/unquiesce calls on frozen queues
  aoe: Remove the quiesce/unquiesce calls on frozen queues
  ataflop: Remove the quiesce/unquiesce calls on frozen queues
  sunvdc: Remove the quiesce/unquiesce calls on frozen queues
  swim3: Remove the quiesce/unquiesce calls on frozen queues
  mtd_blkdevs: Remove the quiesce/unquiesce calls on frozen queues

 block/blk-core.c           |  1 +
 block/blk-iocost.c         |  8 --------
 block/blk-mq.c             | 21 +++++++++------------
 block/blk-sysfs.c          | 13 +++++--------
 block/blk-throttle.c       |  2 --
 block/elevator.c           |  8 ++------
 drivers/block/aoe/aoedev.c |  5 +----
 drivers/block/ataflop.c    |  2 --
 drivers/block/sunvdc.c     |  5 +----
 drivers/block/swim3.c      |  2 --
 drivers/mtd/mtd_blkdevs.c  |  4 +---
 include/linux/blkdev.h     |  2 ++
 12 files changed, 22 insertions(+), 51 deletions(-)

