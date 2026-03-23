Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620E3E023F
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297763; cv=none; b=mXRbSq52ELNqVZbvcrjG8Q1SAaoEwjcMyaR78hw6GFuoj7AqVC63rMpv4XQA2vidgWP2yLrTC9MRYF468OgEBBtKB36Z9Pv+7ELrxKL+/qfPms5MTASfD8w8AtEYwg9o+K4SQKBj/tbmd6Kred+MGKXeXk8aWStNvxISAMmUY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297763; c=relaxed/simple;
	bh=EilbCy0V7BXkfHkvve+NOPDZterpc1ZVNxlfpXM16XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpl7m/9UjFuESHKEnzb9DObPOogoKHL7y4cVX07IaorLjWGohgQQ0EbC6PKp0rdviU08jJrUFqcUQENliEVjlXfhJee/Lo2syp8VcFc4XJlkBLK3zS/HqCNIhskAt2DGB/h7jpX/MXPhD1X2f17NSttjlzZvHBd8qVNq/9MUcLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Zn5QNMVF; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Zn5QNMVF"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fflBm3H1hzlfgRx;
	Mon, 23 Mar 2026 20:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1774297758; x=1776889759; bh=grws0aUhj0Wq/LGj1+bA/8M1EjmEHgRh5+Y
	rpvQUibc=; b=Zn5QNMVF77w2xS8jV5RWL8GvLajKILEDM6avUhKLkqfsVKPmNMa
	cgYuf7+5ZIWTonUwXDedRi6tcE0SdvS+veOoEtHQpFCYAlzr+SqMYR51QMZrTSI2
	egJUyU/nI0SdPnZhu5+sHO5+RHAyql6jadgH2MZYz8mx+cTvDP5A6QjKLTFLKHYb
	KEnOenDUt4Sym2iEZSCLmxNo2GsgP3t60K2AGrJ/cHDgCg/lEsAxtr1SJC6/9eU/
	FlmU0zfZ1yOWHG6NdoTtF6KuQRAxpBc8A7gPHQtfYQeIHS7dfaVEpXIDT2EYP84m
	4JGoxDNn25wkfVtFBLx1lbO14nCixa+93eg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jVedBVg5tWaC; Mon, 23 Mar 2026 20:29:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fflBh6xknzlfl5n;
	Mon, 23 Mar 2026 20:29:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] Enable testing small DMA segment sizes
Date: Mon, 23 Mar 2026 13:29:00 -0700
Message-ID: <20260323202904.1248169-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
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

Thanks,

Bart.

Bart Van Assche (2):
  block: Reduce BLK_MIN_SEGMENT_SIZE
  null_blk: Support configuring the maximum segment size

 block/blk.h                       |  2 +-
 drivers/block/null_blk/main.c     | 13 +++++++++++++
 drivers/block/null_blk/null_blk.h |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

