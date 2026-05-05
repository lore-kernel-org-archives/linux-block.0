Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E13ED5A3
	for <linux-block@vger.kernel.org>; Tue,  5 May 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967250; cv=none; b=V9AS9Gjn200Z1FoCYKENtVnrGrLimZDpk5E7d3/u+QbGdPNmIwOjRvKu8ZaWjvXge/1UMfL+UIYiEXSjeMBOtcBzyPxzHEQ9qMIMm/gvx0R+QDPGC1g5pJd6TvWkIoMWFmbwW/g45pFVWubcGsxAThzy7jFvk6hfneT3FHqlO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967250; c=relaxed/simple;
	bh=mnDu9233zy3NXIpowZ9sBm6kVKWZ2CvIXnLOy50e5GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFCEYO8siYctZ0EYOlvACIsU2B3Y/Ez4NhPcV5rx5EPr35Jb2v5YMlfHX903zQBsLbdoRUl1Kb9w+ftrow61xWvpf6J7kd3z8XVZJacK0Oc3SsNOofXyYCoAepTd+lm/SXunXLnChj73VpTW1BBxE+Ra20IU5sa5A519j7x/8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CDureJiZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CDureJiZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso54087905e9.1
        for <linux-block@vger.kernel.org>; Tue, 05 May 2026 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967246; x=1778572046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai8t2M95CG1qyiwdjdt8gB4lloKch9LSXoTKwvwY5cs=;
        b=CDureJiZiPWvYhH45B5ghk4cC3zpqJL69QhR6a92BPT4ukLmJp4RORnInUUsRH852p
         0mMMR2WB+2MUCO/9eUVrLFwC0rXRweLnKuYpEu2GrJj7xAV1s9m17TFaqv5EpUyK31Gc
         CYX3XNaHUswtp9mVOhuzEGa8tTDQw2Q91WFP25vODAieAwsQS7QNZ8qJEnptj5vPGcsa
         ZScUIG+UZ6Sp5yhX9zRVXhoA2+WkuSpBuUTszUX2NBAoBqyonP0PjPDJMGPjjVGQRciB
         fFsfWuECYQYjfBCeJ/WwZoF4Di1GUVBGJgg56tMigWEdbpFWvRQXgCNSR/GIw7xYV220
         gabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967246; x=1778572046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ai8t2M95CG1qyiwdjdt8gB4lloKch9LSXoTKwvwY5cs=;
        b=PNRnnjfDkT0n4sYaD1X3cxt1uxRKxEB7GDWrktknA/9eloSlo31hbMMw3PTPTSwcV+
         JMIqiQ4qtk3XNah624zY76qlT3Z9Ml7DqitE/pJywYNHv9cfKBIs/PeAhBbo3Hwwjdh3
         9mtnfmFmz+K8oEmVxJ3aNnCROzxhUd/Wskd+WMDOXiwnyrtRg5iWxH8TMKphQ41wxTvN
         Fr6s6GpL6cZOIHsQnhZTmv1xRM6sxO3BC+Dkq+I7m8Q4HzAWiqHmBPVc/d9zTbJq8oIz
         VcQ9zxel9VcOj9IIqMvgL7FmnS/srsp0d5cp+fJUM3QWSzQ3SL7Mcqa+aMFoeYFfrBaZ
         DzLQ==
X-Gm-Message-State: AOJu0YxmoriQoDMbhUdVGs0joSKMoVW5SfM8wc6t3jpaZ80tofzxLg2d
	yDwrb+bX4LjEv02+CQ6+XIph/hBmK4UIE7jOnm/i1Qqjb/r2m6ZiMKhyMnWhH5f+D6FzcjGwq2w
	UdA/snsoNVg==
X-Gm-Gg: AeBDievFZ7AW/LDN54RYPP8IBRdy3JZpJN/wDYiZCBvx0NSAH0YqcAWcOgsSCHZqXut
	tMijgsjux7GJ+zFWCScFyrXbTP6C1P5MSoyGYZyryzlamjpDWKCROKdl/PL6An0dPuLN8t4v2kh
	l3/m65xhdSDIkEc0ncQ91szrOZlAWBvpB3kc+o0+Hpm7Z/aKUJVxf1NMz6qZ835u3DkZVYBQITy
	PvYm803V5ku9W3YforZ3RXwXz9STpPbTA6fFtKWsGqOC5HRRv3xoT46Xa+ScsAve8jGWR6nHtjs
	OlbQqbA7Zp6MIm3B9cLXB28LoTmVqefVqEIIhv+AP9q96U3LUZIqQqY1rt54EJBTTWPZL7vGPwk
	cXqOAz2vEVs6C2kqKiiE9HR8mi68FnO2/eYjwJRv8fQj9M+FJXuGMSup4Vt8OZB/qP3sAHovEe8
	2Pl972qsZSo04ZOc76dqUU258ov5NrPbvn2j+ZtJVGaRdsAwnMx9NuKsZLfGj6wZojBXPFTK1uE
	30GMblcWrc2kkLbEREyDdJgP9Y0HWqZ1og/2mCZygFvLA==
X-Received: by 2002:a05:600c:8116:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48d141ceb81mr38242215e9.0.1777967245773;
        Tue, 05 May 2026 00:47:25 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:25 -0700 (PDT)
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
Subject: [PATCH 07/13] RDMA/rmr: include client and server modules into kernel compilation
Date: Tue,  5 May 2026 09:46:19 +0200
Message-ID: <20260505074644.195453-8-haris.iqbal@ionos.com>
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
parent drivers/infiniband Kconfig and drivers/infiniband/ulp Makefile
so RMR can be enabled in a kernel build.

Three Kconfig symbols are introduced:

  CONFIG_INFINIBAND_RMR		(silent, selected by either side)
  CONFIG_INFINIBAND_RMR_CLIENT	(depends on INFINIBAND_RTRS_CLIENT)
  CONFIG_INFINIBAND_RMR_SERVER	(depends on INFINIBAND_RTRS_SERVER)

The Makefile builds two modules: rmr-client.ko and rmr-server.ko,
sharing the pool, map, request and library code added earlier in
this series.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jia Li <jia.li@ionos.com>
---
 drivers/infiniband/Kconfig          |  1 +
 drivers/infiniband/ulp/Makefile     |  1 +
 drivers/infiniband/ulp/rmr/Kconfig  | 35 +++++++++++++++++++++++++++++
 drivers/infiniband/ulp/rmr/Makefile | 23 +++++++++++++++++++
 4 files changed, 60 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rmr/Kconfig
 create mode 100644 drivers/infiniband/ulp/rmr/Makefile

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index a7e3f29dc037..4b2470b5a592 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -110,5 +110,6 @@ source "drivers/infiniband/ulp/srpt/Kconfig"
 source "drivers/infiniband/ulp/iser/Kconfig"
 source "drivers/infiniband/ulp/isert/Kconfig"
 source "drivers/infiniband/ulp/rtrs/Kconfig"
+source "drivers/infiniband/ulp/rmr/Kconfig"
 
 endif # INFINIBAND
diff --git a/drivers/infiniband/ulp/Makefile b/drivers/infiniband/ulp/Makefile
index 51b0d41699b8..24c8e4b00065 100644
--- a/drivers/infiniband/ulp/Makefile
+++ b/drivers/infiniband/ulp/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_INFINIBAND_SRPT)		+= srpt/
 obj-$(CONFIG_INFINIBAND_ISER)		+= iser/
 obj-$(CONFIG_INFINIBAND_ISERT)		+= isert/
 obj-$(CONFIG_INFINIBAND_RTRS)		+= rtrs/
+obj-$(CONFIG_INFINIBAND_RMR)		+= rmr/
diff --git a/drivers/infiniband/ulp/rmr/Kconfig b/drivers/infiniband/ulp/rmr/Kconfig
new file mode 100644
index 000000000000..1d62322a02be
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/Kconfig
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config INFINIBAND_RMR
+	tristate
+	depends on INFINIBAND_ADDR_TRANS
+
+config INFINIBAND_RMR_CLIENT
+	tristate "RMR client module"
+	depends on INFINIBAND_ADDR_TRANS
+	depends on INFINIBAND_RTRS_CLIENT
+	select INFINIBAND_RMR
+	help
+	  Reliable Multicast over RTRS (RMR) client module.
+
+	  RMR is an RDMA ULP that provides active-active block-level
+	  replication on top of the RTRS transport.  It guarantees
+	  delivery of an I/O to a group of storage nodes and handles
+	  resynchronization of data between storage nodes without
+	  involving the compute client.  This option builds the client
+	  side, intended to be used by an upper-layer initiator such
+	  as BRMR.
+
+	  If unsure, say N.
+
+config INFINIBAND_RMR_SERVER
+	tristate "RMR server module"
+	depends on INFINIBAND_ADDR_TRANS
+	depends on INFINIBAND_RTRS_SERVER
+	select INFINIBAND_RMR
+	help
+	  RMR server module processing connection, IO and replication
+	  requests from RMR clients on top of RTRS.  It will pass IO
+	  requests to its consumer, e.g. BRMR_server.
+
+	  If unsure, say N.
diff --git a/drivers/infiniband/ulp/rmr/Makefile b/drivers/infiniband/ulp/rmr/Makefile
new file mode 100644
index 000000000000..c173092f4cf2
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/Makefile
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ccflags-y := -I$(srctree)/drivers/infiniband/ulp/rtrs
+
+CFLAGS_rmr-clt-trace.o = -I$(src)
+
+rmr-client-y := rmr-pool.o \
+		rmr-clt.o \
+		rmr-map-mgmt.o \
+		rmr-clt-stats.o \
+		rmr-clt-sysfs.o \
+		rmr-map.o \
+		rmr-clt-trace.o
+
+rmr-server-y := rmr-pool.o \
+		rmr-srv.o \
+		rmr-srv-md.o \
+		rmr-srv-sysfs.o \
+		rmr-req.o \
+		rmr-map.o
+
+obj-$(CONFIG_INFINIBAND_RMR_CLIENT) += rmr-client.o
+obj-$(CONFIG_INFINIBAND_RMR_SERVER) += rmr-server.o
-- 
2.43.0

