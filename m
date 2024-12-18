Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8142048
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734508163; cv=none; b=uyJ0j3NkRDGty4900wcZQ89RXPVT9aGVa/w6ey2rk03jZxMVOQQQ1MWC0PyCWGIA9z8M8TRBloLNlCVUnM0ZAfGIo9wcXVwypLjJdbd0ypUAXve54zSu/lQrLf6CuZoDrzNht5xaRdH3tp5XWtzBS2Fjq+sRXGg//p0oqRvNzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734508163; c=relaxed/simple;
	bh=cPSO+EvH4cm19aRtkWP7POCMCIPcKzDXz9O0IbU+9vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYpNGvfB+4fhnNKTWMf2feVsIJHSTLruW4rGZjyZ6pLeanJduqvwFuxO7BA0A70pRqr8ZgcKS2RSHgDQBh/zsYDGJ7cw/Rk/wfM98LU2NgWPIJrgE8pbDudNV1EOE1Bvm/kf6NT/7ltHlq9+h8DrHJFayBQ6yXujhGm52mLYbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rSaTfeiD; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rSaTfeiD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734508161; x=1766044161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cPSO+EvH4cm19aRtkWP7POCMCIPcKzDXz9O0IbU+9vo=;
  b=rSaTfeiDk3JxOPkf7MOBvR8UmK2OwO+hQ8h6CYsp9vPwGqSGxdFImbci
   o2YVLY3F0KVpTQvG5wavpCcG5P4NOxRl32gNeENgEML+eKgbX11RQZYWg
   6akiaHct3aZHtJMW27Z6a/Rzj/32t7CGjKhwMBjAukkdNo0ZmeVA085Q9
   LFS8f33jnTOau8OUdcAQQI5xlCLLfVwS8vhG5TS4rc+tyLx01dZna0C6P
   FV9ytESAtvHQQf6YrHp0PjFANJzTRzD/Rs7eVG8TL1Zc8TjIHINYbwlQs
   2HfWFc2qtvwOxVPHxJu3Gg02t4FxBAul2NsGtfLnx0ailYjj3s2KJby9L
   Q==;
X-CSE-ConnectionGUID: 27dawWd7TRqLoMR8vG08Hg==
X-CSE-MsgGUID: k9emevwGSQiwofDqQgFYyQ==
X-IronPort-AV: E=Sophos;i="6.12,244,1728921600"; 
   d="scan'208";a="35269660"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 15:49:15 +0800
IronPort-SDR: 67626fc5_zzTJh2Dju833+qoYqI1WpJh8BPhybaBvUsbfpofHlJaiXZV
 cLavyv0YQeh6b2o1ozosf5zgATyZP4GmPqtmN8w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2024 22:46:30 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Dec 2024 23:49:15 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH for-next 0/3] null_blk: improve write failure simulation
Date: Wed, 18 Dec 2024 16:49:11 +0900
Message-ID: <20241218074914.814913-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, null_blk has 'badblocks' attribute to simulate IO failures
for broken blocks. This helps checking if userland tools can handle IO
failures. However, this badblocks feature has two differences from the
IO failures on real storage devices. Firstly, when write operations fail
for the badblocks, null_blk does not write any data, while real storage
devices sometimes do partial data write. Secondly, null_blk always make
write operations fail for the specified badblocks, while real storage
devices can recover the bad blocks so that next write operations can
succeed after failure. Hence, real storage devices are required to check
if userland tools support such partial writes or bad blocks recovery.

This series improves write failure simulation by null_blk to allow
checking userland tools without real storage devices. The first and the
second patches add partial IO support. The last patch introduces
'badblocks_once' attribute to simulate bad blocks recovery.

Shin'ichiro Kawasaki (3):
  null_blk: do partial IO for bad blocks
  null_blk: move write pointers for partial writes
  null_blk: introduce badblocks_once parameter

 drivers/block/null_blk/main.c     | 68 +++++++++++++++++++++++++------
 drivers/block/null_blk/null_blk.h |  7 ++++
 drivers/block/null_blk/zoned.c    | 10 +++++
 3 files changed, 73 insertions(+), 12 deletions(-)

-- 
2.47.0

