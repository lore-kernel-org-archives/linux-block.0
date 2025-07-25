Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0552BE65D
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431012; cv=none; b=EadhJkK/Q8J78KjvCaiFHYoHvddDXlAu/HHtqLNeCp1titMr2aKJlEHP5Ct8jJT37BPJquI34RY0H6PZ+4auI8dETwNUGgL6gKiB59XJBs5kQYQP9+TSpNnyYJsX/YqtM+GUVqUYHa2hje9UmudGkvLe7uLQsC/qPJIWdw79njs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431012; c=relaxed/simple;
	bh=w2HMzhVqQf4yfasGaTYxhpukXi/pg1pzj1D7pLUqFAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYU5RWNgBM1K52NrvjAX9XYV0op9ukpPfS/jEEcDmmABCGuOC8EBEW+QC8ztyCvO0xYkJ9j9n/ABxGWBl+qzbKO4TohVxxZzmAy12Wcn929zwcPsSOo6dEhJkMmdE6/Ipd7JM0Ns/gMpv3KJzjjPxmxFIfXqLSBFT/Ws2Teeg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T5c/giv3; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T5c/giv3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753431010; x=1784967010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w2HMzhVqQf4yfasGaTYxhpukXi/pg1pzj1D7pLUqFAU=;
  b=T5c/giv3B1/Q+jiVE1k+klv/DfsBcBlRDHBdeD/Pijx80uPGQHoRRv//
   FLXcHh5RLrRqEXRSM8l7r6bEC+NlMzEG6tCe+O7/UC4Dz6gthXhB6PCu4
   lD9dOR9syqIPwZhQj8nnzkq9lm8+FvTdlcouklPqmnXO4nbC2Gw4lXDIo
   9LNsTDS2p504LXdaJwijPj4qXgFklcWpAvSWFWP75fJKZotDppcHERMYc
   qytUl0RvQ3Si2tv+6JgAhAf7d7QB1fo1ZVd5DCTlc1cg730oN3f7xdVcm
   NrWqea0LB+ufyvre+YSSCAN8oDgbC/6B4cISLColy7zIoOQwGgUqs5A6n
   g==;
X-CSE-ConnectionGUID: i8p34F/OSjeOtoAlWF4gJQ==
X-CSE-MsgGUID: Jl2QQC55SGKTUgbhxYROgQ==
X-IronPort-AV: E=Sophos;i="6.16,338,1744041600"; 
   d="scan'208";a="98694735"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2025 16:09:03 +0800
IronPort-SDR: vCOsz7KeHdsFVy2eK7wl10Hgjb4+nhp17qtSDZd5fWf5+Pq3fFAX26z/rt2ubF5Nq5s1akpQT7
 SSiMSwYxx6Et1tzJ0JsIZQ//NdzpZIjJ5QEoN755FWRISZrFMo27mTzkO4yNuENc52FKomw1S5
 E3xymYoJDiqBFCrMWOaYJl9ZkxGYfMhzr2IhBrmw2/Gqis/04d79lh1GKiHdpzRdkbKvUfxgtu
 HjHtSxiobNPYvY/oCBaE9erl0+jxytW8RuJzA4eVaKsu39fMF4CKLxysZW+NaFk4dz8uQSnzIu
 Ss0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2025 00:05:21 -0700
WDCIronportException: Internal
Received: from wdap-nbqxrzw6z4.ad.shared (HELO shinmob.wdc.com) ([10.224.163.174])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jul 2025 01:08:57 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] zbd/005: remove offset option of blkzone reset command
Date: Fri, 25 Jul 2025 17:08:56 +0900
Message-ID: <20250725080856.232478-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case zbd/005 performs sequential writes to all sequential
write required zone on the test target zoned block device. To prepare
the device for this operation, the test invokes the blkzone reset
command. However, it takes very long time to complete.

The root cause of the long reset time is the offset option of the
blkzone reset command. This option specifies the first sequential write
required zone. When the offset options is provided, the kernel processes
the reset operation zone by zone. As a result, a separated zone reset
command is issued to each sequential write required zone, significantly
increasing the overall time.

To reduce the execution time of the blkzone reset command, remove the
offset option. Without this option, the kernel can perform a single zone
reset operation that resets all sequential write required zones.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/005 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/zbd/005 b/tests/zbd/005
index 4aa1ab5..790d24e 100755
--- a/tests/zbd/005
+++ b/tests/zbd/005
@@ -46,7 +46,7 @@ test_device() {
 		zbdmode=("--zonemode=zbd" "--max_open_zones=${moaz}")
 	fi
 
-	blkzone reset -o "${ZONE_STARTS[zone_idx]}" "${TEST_DEV}"
+	blkzone reset "${TEST_DEV}"
 
 	_test_dev_set_scheduler deadline
 
-- 
2.50.1

