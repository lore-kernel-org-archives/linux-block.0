Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40673ED5B8
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691843; cv=none; b=uaEgRWF9LD65OlpCMtGqyvP4GrDwu1++tt9l6Tj5Yp7wQ2If8kE659f4F1FBrWNYLBhPA0llcvLGtjo9gQjvOSSQo7kK7hES392N26u+qQ3sdH3K1RwmZU0FOIcXdHwJo4ijsEpDepFSoOZbxmMccbx1ezAJCEtpa0xn8MJtQUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691843; c=relaxed/simple;
	bh=U5Sn2kN67w7X1QCOSpb1W85toi61o30IrpYvA9ABpGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKPijeTCQeyZHzuTQ0VaGjhEP18ctsofqv9SO8ctlmHn/UQQCxvo66a/YIO/NNU1wWH9DZJb5FQxpNvmlAK9RBFJsOkMR7wuglZ9TZ4OBjYzq97dUl6HrNakwc1b+KdAxuljYJQmPJf3Ubp+6I/P+/8XeV4lAMy0gA5yBfYk1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=47DqlWdK; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="47DqlWdK"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR6T36ttzlh1TN;
	Mon, 16 Mar 2026 20:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773691831; x=1776283832; bh=rYMWB
	t+T2YuApN6wr2lblEPrFoJ5hsufpFss+junVNU=; b=47DqlWdK9He50tHKDhXyV
	Jo+1ggv/jCq+5/5k8ajkHxyVi4PzxAtR17RXgX/5Ar4AYWQiAlZKb05DsFkzGKC0
	nDkA9d4xw37aUFypFmQreDVQ6k5h8PZD5nRqWyV0YZ1n239G0vz2z0/0EAnsU3C+
	hSR/yeBGmS3PNDR55ufp3/09x/NXm3zFk8h0lQCtimd6l1d0n/IIz67mrjn7rfQ4
	NV3HL8/hPqRDRoGKo+du+ObVnVE1wo/KplWXoMvDsNOq3te88/koSmSAiKOHmhcC
	qpRZPfZqlhGkjDVVYcKvsBqUDNp/HxDcA1GyffPikuE/Yc+Gbqt+H1UGyLkjMgm1
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6Uw-SsU8DNb8; Mon, 16 Mar 2026 20:10:31 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR6B1lx3zlfgPY;
	Mon, 16 Mar 2026 20:10:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Justin Sanders <justin@coraid.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 12/12] block: Enable lock context analysis for all block drivers
Date: Mon, 16 Mar 2026 13:08:49 -0700
Message-ID: <20260316200901.4111651-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316200901.4111651-1-bvanassche@acm.org>
References: <20260316200901.4111651-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that all locking functions in block drivers have been annotated,
enable lock context analysis for all block drivers.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org> # zram
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/Makefile             | 2 ++
 drivers/block/aoe/Makefile         | 2 ++
 drivers/block/drbd/Makefile        | 3 +++
 drivers/block/mtip32xx/Makefile    | 2 ++
 drivers/block/null_blk/Makefile    | 2 ++
 drivers/block/rnbd/Makefile        | 2 ++
 drivers/block/xen-blkback/Makefile | 3 +++
 drivers/block/zram/Makefile        | 2 ++
 8 files changed, 18 insertions(+)

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 2d8096eb8cdf..e17f6381b798 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -6,6 +6,8 @@
 # Rewritten to use lists instead of if-statements.
 #=20
=20
+CONTEXT_ANALYSIS :=3D y
+
 # needed for trace events
 ccflags-y				+=3D -I$(src)
=20
diff --git a/drivers/block/aoe/Makefile b/drivers/block/aoe/Makefile
index b7545ce2f1b0..27bff6359a56 100644
--- a/drivers/block/aoe/Makefile
+++ b/drivers/block/aoe/Makefile
@@ -3,5 +3,7 @@
 # Makefile for ATA over Ethernet
 #
=20
+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_ATA_OVER_ETH)	+=3D aoe.o
 aoe-y :=3D aoeblk.o aoechr.o aoecmd.o aoedev.o aoemain.o aoenet.o
diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 67a8b352a1d5..8eaa83a7592b 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+CONTEXT_ANALYSIS :=3D y
+
 drbd-y :=3D drbd_buildtag.o drbd_bitmap.o drbd_proc.o
 drbd-y +=3D drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y +=3D drbd_main.o drbd_strings.o drbd_nl.o
diff --git a/drivers/block/mtip32xx/Makefile b/drivers/block/mtip32xx/Mak=
efile
index bff32b5d3c19..233961fdb41b 100644
--- a/drivers/block/mtip32xx/Makefile
+++ b/drivers/block/mtip32xx/Makefile
@@ -3,4 +3,6 @@
 # Makefile for  Block device driver for Micron PCIe SSD
 #
=20
+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX) +=3D mtip32xx.o
diff --git a/drivers/block/null_blk/Makefile b/drivers/block/null_blk/Mak=
efile
index 84c36e512ab8..282b0d51a477 100644
--- a/drivers/block/null_blk/Makefile
+++ b/drivers/block/null_blk/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
=20
+CONTEXT_ANALYSIS :=3D y
+
 # needed for trace events
 ccflags-y			+=3D -I$(src)
=20
diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
index 208e5f865497..42c2cccdb53d 100644
--- a/drivers/block/rnbd/Makefile
+++ b/drivers/block/rnbd/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
=20
+CONTEXT_ANALYSIS :=3D y
+
 ccflags-y :=3D -I$(srctree)/drivers/infiniband/ulp/rtrs
=20
 rnbd-client-y :=3D rnbd-clt.o \
diff --git a/drivers/block/xen-blkback/Makefile b/drivers/block/xen-blkba=
ck/Makefile
index b0ea5ab5b9a1..864ef423226c 100644
--- a/drivers/block/xen-blkback/Makefile
+++ b/drivers/block/xen-blkback/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_XEN_BLKDEV_BACKEND) :=3D xen-blkback.o
=20
 xen-blkback-y	:=3D blkback.o xenbus.o
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 0fdefd576691..a5663ab01653 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
+CONTEXT_ANALYSIS :=3D y
+
 zram-y	:=3D	zcomp.o zram_drv.o
=20
 zram-$(CONFIG_ZRAM_BACKEND_LZO)		+=3D backend_lzorle.o backend_lzo.o
