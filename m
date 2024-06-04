Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C754801
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461770; cv=none; b=PkWhVf2UpRJ2n81uvk2LQ48heY58H6aavp9LJ63j7R2d+NjOuhjSwSnDL6SyytaT89XIWaqxdKW/cQlAkiqh8IVqNd52fwhch3PgMVjAS7Si/BWUNikYoKZxCh0T4Q/cKfDEQGVds+2v7Z3oZHiPvpcWlJdkLCj8iArfk3vZ1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461770; c=relaxed/simple;
	bh=zeQo/iYSHJhiMzdVXgk2M6AYXyLP0PszcyyTEven13o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmXszyj7OSAFDpoIUr0wAzb7QU3ejYB/Ub0UPu/h9hlnQ41w7ER1NJmgYWifcftMzO9fp5RDDXfFqVB6nQipoSqsF9qoOybk7qymDPbE7UbITHibCAinsaY9A8fh5cpswvoMz/mmGgR+sPljHryP+eTodeQWJ+Dv51WStzZ+FMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=q7+WDB38; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q7+WDB38"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717461768; x=1748997768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zeQo/iYSHJhiMzdVXgk2M6AYXyLP0PszcyyTEven13o=;
  b=q7+WDB38fAnOLuPK9V1qEEs23Ydkm0Wk4Vlg+w5XKZ53Nv9ALgYtAGBs
   WbxlHCELs8x3+ai7gkUT2mHkPHGot7btoshHcvyf7UR3NIUPK7lS1IrdB
   sOzUGYVOcnvknucWx+BHMjFfsgT80nXELBszDRUHfmTCz1kZ8LBOUd+5L
   6erElqaiRZ6+tPxASlW6LIS/ADTduWWpEglYWKZfDFjSV5E+Yf1qTr77u
   KhR4sjOUQIOGdHpc5Q7eqf7wqOdaZulsz71dLf5tpHfv1qjw6E7/6vg0u
   BUv6VXPdkyKBj8zkbcRpG4qUnQ+bxBhQm/w/rLt9rSjLx7TP1SgNJSwTh
   A==;
X-CSE-ConnectionGUID: FRVlETQ6RFCsCg9f5t0lKQ==
X-CSE-MsgGUID: vDTR39EtQJmYkictb4VW0g==
X-IronPort-AV: E=Sophos;i="6.08,212,1712592000"; 
   d="scan'208";a="18908789"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2024 08:42:42 +0800
IronPort-SDR: 665e56ab_vE1EXoIhtV3vS7yKlt3iSzCZr1bXBuI0oN+R/mZ+H2KevxV
 Ht0JNPmS4Mh8tGYMy6JX25Dy6+oVEJB0mnAnoow==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2024 16:50:03 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jun 2024 17:42:42 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] README: add dependent command descriptions
Date: Tue,  4 Jun 2024 09:42:41 +0900
Message-ID: <20240604004241.218163-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though many test cases assume the availability of the systemd-udev
service and the udevadm command, this dependency is not described. Add
it to the dependency list. Also add optional dependencies to other
commands: mkfs.f2fs, mkfs.btrfs, nvme, nbd-client and nbd-server.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 README.md | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 09fbb1e..55227d9 100644
--- a/README.md
+++ b/README.md
@@ -19,12 +19,15 @@ The dependencies are minimal, but make sure you have them installed:
 - fio
 - gcc
 - make
+- systemd-udev (udevadm)
 
 Some tests require the following:
 
-- e2fsprogs and xfsprogs
+- e2fsprogs, xfsprogs, f2fs-tools and btrfs-progs
+- nvme-cli
 - multipath-tools (Debian, openSUSE, Arch Linux) or device-mapper-multipath
   (Fedora)
+- nbd-client and nbd-server (Debian) or nbd (Fedora, openSUSE, Arch Linux)
 - dmsetup (Debian) or device-mapper (Fedora, openSUSE, Arch Linux)
 - rublk (`cargo install --version=^0.1 rublk`) for ublk test
 
-- 
2.45.0

