Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71B38657C
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653799; cv=none; b=jH+yK8AuRlh3sXebJJjs1Ye2Yz7xv5UimUA35PhF8g/Zmsh/FCXXHuOHWLYoXeWQJNsami8H4VAQHuCBz9ipYO7KPGFUvGR3W8+xIhWiRDRhdjnkDjirtLZbly84QgD88LRPhkj/QoUcbn+NllnPS4W3cxPdiwqGXSRHDsdigSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653799; c=relaxed/simple;
	bh=PaNWxCzyVCN9S5cj2+MOFZdkgBSms/YclA5jFd0RD2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XF5FQQU3IWzkCo6Mx32UNU2Kb5Kq2I2bpxWiJMJSAp3W8HWzq8tAxSbUbk7g8eVCptW9SEW6x0onwkKyNcZwfsUC1k3+PGna1wNc4TANzvUrpPJKL3Uuj4mZkPbVvsfiC4T1p9JeJHIjOpfVwdyboMqa5R//k2SUOW7qQSOcgbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KSPfTAUA; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KSPfTAUA"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3D5665Mz1XM0p0;
	Wed,  4 Mar 2026 19:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653786; x=1775245787; bh=s2QjD
	Br/22MQTl+qcyuOE7u921VlRLzXVQNsCbBDgQ4=; b=KSPfTAUA72GHeMTKa6IeU
	VRmTu/ty+eWkZYHhvCuitHtD3w/D7Beqg5msdoOkOw6POF9z5eXIkQOLSiRYJLT/
	DLkaAYayCxblykocn5N6zWoBJfBcgaP1WqlRyPapnixEo4Mpf0EdHi05hgT99pV6
	0v9g/bRRoba721zIQ7X3hG4da6FAp+RQcnimOUYJZJ5iaDYKDplQKM+UVFSIXksF
	jvpb6vRgjCYsYqZMxMHKxn5AqjGJk581kBtpYsz9uI/q8blX6eR8UpfQ8Y8KljDm
	dtI2JR0QO2a0g4C8UmF7/VLcApsRAvD5+kQZYp1m/qiOG3b694Caau/vfxbv99rc
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id P_LRZjh-IkMg; Wed,  4 Mar 2026 19:49:46 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3Cp5ssXz1XM0pM;
	Wed,  4 Mar 2026 19:49:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Justin Sanders <justin@coraid.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 14/14] block: Enable lock context analysis for all block drivers
Date: Wed,  4 Mar 2026 11:48:33 -0800
Message-ID: <20260304194843.760669-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that all locking functions in block drivers have been annotated,
enable lock context analysis for all block drivers.

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
