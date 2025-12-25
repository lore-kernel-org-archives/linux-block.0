Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D52F872
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766664570; cv=none; b=AT+56J4d2EhhWzaT/zWq9KlN97R3V5WYXx5/N4gsvr8tO3rCxAS1VYoZnhV947Kp6CQONG7EGRY9NeapOsvV7SwXKubvXSaoe64Vm+h+7fZ0HKPTPzRiswXxHC1GPFCd9NOa/oLEAvchks86DsrnngrMA3kqzERsXsh4J+I2kgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766664570; c=relaxed/simple;
	bh=g+CZH9NLS/PhGaFzlw4N+t4hI9p2PN4Z9s5GHHIzogw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UivAZaF4b9/ptZ216ZKD0PBi98LhHPkGEpU+dwjf/q/uLL0l5hrZcIiEcrSljYITOBcutY+RcSTnxtyEbDK9ZNGrgfd4pcoBUIKg1xkzy4ZHIHCd+woMUexhwJ53DH9zH5c4oiDKtse6IIqD14nimRMmSK/Yg4amZUcaDywpKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HJBavwJq; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HJBavwJq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766664568; x=1798200568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g+CZH9NLS/PhGaFzlw4N+t4hI9p2PN4Z9s5GHHIzogw=;
  b=HJBavwJqU1FrQvW7QJ2/C5sNegoHd4edNbdrOioaQCahptRilrV7vi6y
   qtuacDhr2tCRbhCZOakI8L/+hac8kwYAV+rOp0e4BUROier+NnqxqlA+F
   wDO+/OGNmaKrCXGBtNzlpRU7SNzJ4wL2Ne78xoKs+220kx0cgdZ9F1OMm
   wYfXiJjiorX4hW+O9p9XFEtOU92hdbFEFcbCaEpqXKgodgMY/qVtaVmYr
   5CxpjutezGIdzVCKRV2WhK1/QTgg61TvDU5eCBKvh994gRB1PVYoC6PdK
   5R2rzhVsQ56bX6wBYdRmiaWNjJyEX56dykk+jkEozAHsVWUTcsTsqVyzT
   g==;
X-CSE-ConnectionGUID: dczabgP8T1+/U/JcVa0HxQ==
X-CSE-MsgGUID: Q/8vWKBHRleFzzO8ZwuJ4Q==
X-IronPort-AV: E=Sophos;i="6.21,176,1763395200"; 
   d="scan'208";a="138971434"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2025 20:09:22 +0800
IronPort-SDR: 694d2972_I4/44ewsA78Acj/3hwfQhuSeslUsCNpI/jFFcq9IMoG5M5E
 V8G0l2CdtfDoMjCK7Jwp/iaZAHnE2PbjWmASXYQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Dec 2025 04:09:22 -0800
WDCIronportException: Internal
Received: from 5cg217421y.ad.shared (HELO shinmob.wdc.com) ([10.224.105.42])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Dec 2025 04:09:21 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: mcgrof@kernel.org,
	sw.prabhu6@gmail.com,
	bvanassche@acm.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v5 0/4] replace module removal with patient module removal
Date: Thu, 25 Dec 2025 21:09:15 +0900
Message-ID: <20251225120919.1575005-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series was originally authored by Luis Chamberlain [0][1]. I
reworked and post it as this v5 series.

[0] https://lore.kernel.org/all/20221220235324.1445248-2-mcgrof@kernel.org/T/#u
[1] https://lore.kernel.org/linux-block/20251126171102.3663957-1-mcgrof@kernel.org/

Original cover letter:

We now have the modprobe --wait upstream so use that if available.

The patient module remover addresses race conditions where module removal
can fail due to userspace temporarily bumping the refcount (e.g., via
blkdev_open() calls). If your version of kmod supports modprobe --wait,
we use that. Otherwise we implement our own patient module remover.

* Changes from v4
- 1st patch: moved the new functions from "common/rc" to "check"
- 1st patch: reflected comments by Bart
- 2nd patch: moved the srp/rc hunk from the 1st patch
- Added the 3rd and the 4th patches

Luis Chamberlain (2):
  check,common/*: replace module removal with patient module removal
  srp/rc: replace module removal with patient module removal

Shin'ichiro Kawasaki (2):
  check: reimplement _unload_modules() with _patient_rmmod()
  check: check reference count for modprobe --remove --wait success case

 check                      | 134 +++++++++++++++++++++++++++++++++----
 common/multipath-over-rdma |  10 +--
 common/null_blk            |   5 +-
 common/nvme                |   8 +--
 common/scsi_debug          |  12 +---
 tests/srp/rc               |  19 ++----
 6 files changed, 139 insertions(+), 49 deletions(-)

-- 
2.52.0

