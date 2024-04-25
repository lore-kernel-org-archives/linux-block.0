Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65112AACA
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046566; cv=none; b=MSY41Wsk2qyOTLzcLmjorYj2aKmfybjEsb7fxAKU6sxlAn5/4ztUHuyW/ygkgUUzGpYmNXZAg89iA2xJj3DCF2I2+3lkpV2ysvXAUvdZ38r9xXblXnoxljQIk+SNrvuZLKM+DSTshuxoqmpUq4n64IP1PZQUDknjwyTQYwPeci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046566; c=relaxed/simple;
	bh=Dm+etqH2De1+a/qCsHpPLTfPwO4HwLD6Ve94rrn0grg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDq0nLXqnhJRIfE+DWPl9z2+XD72YmhNTZVAnyzntqj8J3mGJpHFbgO58pLZd/O5Rb9T/5uLar8WY1NBf34rmmYioJ2MmknMGIvTPb4Nti6li+qmokRAyWRC3KntXeI47ZJKS1wCtRMibPeNdrvdL4yHBNfTDmadIyPcQNn/vus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FSDgAxo0; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FSDgAxo0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714046564; x=1745582564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dm+etqH2De1+a/qCsHpPLTfPwO4HwLD6Ve94rrn0grg=;
  b=FSDgAxo0SxX8J1J5EW6JpYvOjP2X+7cejyt8DH1JbrHybB1u0mqwNVSG
   HDKGS+axjmYHj4MMrclQMgYa95A48J6URy0Uv8wRHzKUrfMD0QixgFF3v
   UXmf+mZ6O5RIXyMIi4gif1rDw4z7Xk9dRar6zzpoEB1LfTTJl2u7vIo7l
   MJ9p5dLmZutRzsyoTFZGqfzky2Q9LsbsqFvtIsIBjF/dnHHNXCHDe3hvn
   Hl0ADjqE6+CVIWt+3qhtO2bnmWNjloHSbfVajSGpSWLiBeqEWfYpEBvMl
   6MJ54PQojUiuPpK6THFbgNxFI40m8K+wqRAOMeFMSrejCqh6zZFtj5mLl
   Q==;
X-CSE-ConnectionGUID: A9gbarl6TmOLYt9zAUnbPw==
X-CSE-MsgGUID: yqaYvFvqRy2xN+ndEVPSwA==
X-IronPort-AV: E=Sophos;i="6.07,229,1708358400"; 
   d="scan'208";a="15578165"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2024 20:02:42 +0800
IronPort-SDR: 726cNnIcCQMK5onC6WKRS1U0wMjkEb7ORUoVQq80DNhAJ7DygiGfR/0RtqEb0dDMOOKB5Ica/8
 lrbWXhg9afgCB87gjAl6BLTo/oSWaM+HS89y5wjyrP7vjKRjzrybJG8nplyBYC5HX809MEErV6
 vL0R6l3E/d+Ej80rjtUpZQBL3jx+zHtnrMQ0ciyaOm9cfbyfTBsMhGV/Xj+3uAKbQdVpyNqcEo
 f6Jdlv6gbDW39bkFNxiUdX373cvFyykMsoOGsM4bbEvHTvVIjhFpHMlIDrVjKDOcosAQJpKNhT
 Vk4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2024 04:05:10 -0700
IronPort-SDR: FVTVMydzSXZ2GFoC5YVwjhAOIlIn7Cm6sHb8N7HejNEhG1WcFKbnVGhynh+Pwhb6GDAg3A2seV
 5qpoMXISeScYeBtcoLfRnies1YfJSRLJwoAGNKrGZddp476QaSWt2WnYmFkxQhXhBw9ieJurzD
 nOvvnxqQPGjGNilTGQXcByffj4wuV7mbUbosUTt7vCo4RqQa6I3E2F7pCI4WU9c5zCPMvRWNr1
 xfZw3iQRzLvLkBGGYnyHA+fI5ntWXQM0WHL4m+VO3xsPXW1CXSbcr//a5HLcCSnOh1HaDuugbp
 5uY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2024 05:02:43 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Changhui Zhong <czhong@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] block: check if zone_wplugs_hash exists in queue_zone_wplugs_show
Date: Thu, 25 Apr 2024 05:02:39 -0700
Message-ID: <e5fec079dfca448cc21c425cfa5d7b291f5faa67.1714046443.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changhui reported a kernel crash when running this simple shell
reproducer:
 # cd /sys/kernel/debug/block && find  . -type f   -exec grep -aH . {} \;

The above results in a NULL pointer dereference if a device does not have
a zone_wplugs_hash allocated.

To fix this, return early if we don't have a zone_wplugs_hash.

Reported-by: Changhui Zhong <czhong@redhat.com>
Fixes: a98b05b02f0f ("block: Replace zone_wlock debugfs entry with zone_wplugs entry")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3a796420f240..bad68277c0b2 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1774,6 +1774,9 @@ int queue_zone_wplugs_show(void *data, struct seq_file *m)
 	unsigned int zwp_bio_list_size, i;
 	unsigned long flags;
 
+	if (!disk->zone_wplugs_hash)
+		return 0;
+
 	rcu_read_lock();
 	for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++) {
 		hlist_for_each_entry_rcu(zwplug,
-- 
2.43.0

