Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B13ED118
	for <linux-block@vger.kernel.org>; Tue,  5 May 2026 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967271; cv=none; b=h8+0JkjZ5L9bLDCZ90L6lbwg5wd4Nj0Bb4AXfzjkSrg8bqwEQuCQGLYaJpjrSabu+pwrGU4aVhM3t7O7FvKWdiUjRO0uN85phPilpfgxQ4Wrj65uNy9Sk6AMUUfj97V3m7YieKLuVBDe24kXMlO+jxazSTOm1+3zUZe1CqMHdbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967271; c=relaxed/simple;
	bh=m3VnSMM2QtOWFjvotg7TV3q/DN1mgtB9oq+ih2Z0h1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUB0HYEyP1MxpC3rYychgJXVXsmS4TduiR2ZkdPhGRKsuRLX1/r852sfyn+i7iEfspLsEf00yAfhUo72WO61nOlgwGZwCMvj7Vh1DYMQk6lZacSAsNU6y9v3yprbVpCrPSbR81aqFyxXB06PbdEeC4tmxWNNKEOyHWMOQaerCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LswpkPtP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LswpkPtP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so32640055e9.1
        for <linux-block@vger.kernel.org>; Tue, 05 May 2026 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967268; x=1778572068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63kUHHgmHe5aHRdq16aqP1LCZFlEN5uhqVLiLtPxsH8=;
        b=LswpkPtPymN7j1kirDXXa5h/c7LOiytYYE3VujZvRrkmcbOr7QB+70QvH1avjDf3Gu
         RrGm5VQ1Taq0eAiScG2Z/argb2LfewL7rXLPeY8/okN4YSRqQNXnufwANarjVM98swNu
         wvmAhhyG2ujeDE1FT6nCeixdNYdofiEq5VmrRn6rSJCcksvQ123nISDXwyThjIbpCo0I
         NQLQXpVk5eKAenHUpBXQ/FMNS+lvCuBakGBFij4EYLRE7ugp1CQJbSYlccdoFEkDN9yE
         G1zFvM9H10rsMtQyTCkkhnm3vpYX03RX4o1SD088/pFkfYgJqbS8PleyS6eC+wLqdiGX
         bhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967268; x=1778572068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=63kUHHgmHe5aHRdq16aqP1LCZFlEN5uhqVLiLtPxsH8=;
        b=hD2LPFp+TMvBrQpX37vX6EFbgueVI9EjCbShG54A0xtKoKcDFljaYqRhgylVfHDdDp
         Cr4tR163SP/g+bh/nS8mwCTM/AbBN+/ofvd0Rdde9RCwGetNMz/9W0hkyenXrmu0bPCo
         085aZVnMFCABV5U7wdQFIxcHC+CMi2n04Ojz0gUtbJSmZ1NEbsBjWEV7meV5MY0JpS+N
         3UZEiYqmDBxlThx0MO4uFOFb6qjJ55Z1gby93AsUf3As4afhSDSwT/O7JCk1mmCR/8CQ
         QDs1kqC/4g+Bv2NF3cdlGUwDH0yS73inL9tbT+jUWu10r38cAfoGMTpCZPmfiJELNNwF
         Ejdg==
X-Gm-Message-State: AOJu0YxQTrADyiUisGCPolXmz/DNl8w6MG0GQPMMGPTKPfHt42mLcxsr
	JF+mKZsborDQQ0BfUGFDtNDpk2UqTCnU7KUSPjuEmK5UxSk9BrcPNndC9wnihu+LbkCnogsToiU
	8vI5vS7Cb1Q==
X-Gm-Gg: AeBDievVdF+IzoediCH6aQ33ffIhwiAIYQLr20NaKfQrH5sePeRwOa8VlDEDCymNDu+
	gS4b8cBs4hidNzgLz4uLgOP2L4EYYyLM6emLVsD8mxEwuLsq4G1f3wkfFMHEKUGNLfJ1M3GqtuI
	kw7i5b/Q7+WonEjG7Ig4ZOruWpY52dJJJDpFkWgYNw/h1XYi1PdLVLzeizoMw6gpBJTeRfcJd+3
	Y+AYK13KhZhuYKkybGiV7EBOLgEA4Ub+3N8gzwdn9/tqpUhisjwIJFkiy2Ob86fSbUnI6LkehWm
	mHcTi+luvFhPrzDFw+txvhcjPu3zl0n0DBgcxDQLloixy50b6TV9gQv4ZL7HG0Tfqh3D6Kattpa
	IFTNbAKMFfijlpOVKkmeTwSXBq9FAuo50Z9dO41iYaJogXE2jjbQ6eIGZ3RK00tSK/EAThONh2z
	gEAUOiGKRHAIp7PbpXXmAqxByg+W7HgEx4AgUnPsVA4PeSBL0bVe7U3bacouXx1KH9WxWu7oetg
	qD5TcVfpt5ZA8kictHuVLw3ksbvvH8Kzpeu+venRnZ+Vg==
X-Received: by 2002:a05:600c:19d4:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48d1422baefmr39849435e9.2.1777967267641;
        Tue, 05 May 2026 00:47:47 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:47 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	axboe@kernel.dk,
	bvanassche@acm.org,
	hch@lst.de,
	jgg@ziepe.ca,
	leon@kernel.org,
	jinpu.wang@ionos.com,
	Md Haris Iqbal <haris.iqbal@ionos.com>,
	Jia Li <jia.li@ionos.com>
Subject: [PATCH 13/13] block/brmr: include client and server modules into kernel compilation
Date: Tue,  5 May 2026 09:46:25 +0200
Message-ID: <20260505074644.195453-14-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505074644.195453-1-haris.iqbal@ionos.com>
References: <20260505074644.195453-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the per-directory Kconfig and Makefile, and wire them into the
parent drivers/block Kconfig and Makefile so BRMR can be enabled in
a kernel build.

Three Kconfig symbols are introduced:

  CONFIG_BLK_DEV_BRMR		(silent, selected by either side)
  CONFIG_BLK_DEV_BRMR_CLIENT	(depends on INFINIBAND_RMR_CLIENT)
  CONFIG_BLK_DEV_BRMR_SERVER	(depends on INFINIBAND_RMR_SERVER)

The Makefile builds two modules: brmr-client.ko and brmr-server.ko.
The server side acts as a consumer of the RMR server-side IO store
interface (struct rmr_srv_store_ops) to back an RMR pool with a
local block device.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jia Li <jia.li@ionos.com>
---
 drivers/block/Kconfig       |  2 ++
 drivers/block/Makefile      |  1 +
 drivers/block/brmr/Kconfig  | 28 ++++++++++++++++++++++++++++
 drivers/block/brmr/Makefile | 16 ++++++++++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 drivers/block/brmr/Kconfig
 create mode 100644 drivers/block/brmr/Makefile

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 858320b6ebb7..65167fcb1357 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -353,6 +353,8 @@ config BLKDEV_UBLK_LEGACY_OPCODES
 
 source "drivers/block/rnbd/Kconfig"
 
+source "drivers/block/brmr/Kconfig"
+
 config BLK_DEV_ZONED_LOOP
 	tristate "Zoned loopback device support"
 	depends on BLK_DEV_ZONED
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 2d8096eb8cdf..4793c9b0b383 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
 
 obj-$(CONFIG_ZRAM) += zram/
 obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
+obj-$(CONFIG_BLK_DEV_BRMR)	+= brmr/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull/
diff --git a/drivers/block/brmr/Kconfig b/drivers/block/brmr/Kconfig
new file mode 100644
index 000000000000..a38d59d2c1d4
--- /dev/null
+++ b/drivers/block/brmr/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config BLK_DEV_BRMR
+	bool
+
+config BLK_DEV_BRMR_CLIENT
+	tristate "Block device over RMR (BRMR) client"
+	depends on INFINIBAND_RMR_CLIENT
+	select BLK_DEV_BRMR
+	help
+	  BRMR client is a block device driver that sits on top of the
+	  RMR ULP and exposes a standard Linux block device (/dev/brmrX)
+	  backed by an RMR pool.  Together with RMR it provides a
+	  single-hop replication and resynchronization solution for
+	  RDMA-connected storage clusters.
+
+	  If unsure, say N.
+
+config BLK_DEV_BRMR_SERVER
+	tristate "Block device over RMR (BRMR) server"
+	depends on INFINIBAND_RMR_SERVER
+	select BLK_DEV_BRMR
+	help
+	  BRMR server exports a local block device as the backing store
+	  for an RMR pool, so that BRMR clients can map it remotely
+	  over RDMA.
+
+	  If unsure, say N.
diff --git a/drivers/block/brmr/Makefile b/drivers/block/brmr/Makefile
new file mode 100644
index 000000000000..894ba2720557
--- /dev/null
+++ b/drivers/block/brmr/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ccflags-y := -I$(srctree)/drivers/infiniband/ulp/rtrs \
+	     -I$(srctree)/drivers/infiniband/ulp/rmr \
+	     -I$(srctree)/drivers/block/brmr
+
+brmr-client-y := brmr-clt.o \
+		 brmr-clt-sysfs.o \
+		 brmr-clt-reque.o \
+		 brmr-clt-stats.o
+
+brmr-server-y := brmr-srv-sysfs.o \
+		 brmr-srv.o
+
+obj-$(CONFIG_BLK_DEV_BRMR_CLIENT) += brmr-client.o
+obj-$(CONFIG_BLK_DEV_BRMR_SERVER) += brmr-server.o
-- 
2.43.0

