Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD032481DD
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 02:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765332653; cv=none; b=C1mxz5/Uyjw9J/sv1PTgfmXyWd8voBQEnA5CDyy+spnXl81kXrYpQ9XpzfeI+s63JXYSEmA1dzcRf90Z27mgCBDaZnxTcOtU30IkpZ8cI8iuZtwVqTvadyh5qBr+mKz7k0NEYjdzQYShm1xzYHZ2NqhErU0XpMe6kZ51qUaenps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765332653; c=relaxed/simple;
	bh=8zjVElUadOzcDuOR9VRjFiKfaUjiP6pzUh9drRFIcQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBv7V/5OWbo1lpypFG1uVQDroZ8OS2UQQBI8q7FeLpRSKWwz6EeeYdN+9AE75mvqNfx7srEGgMieCDF3bLOGp1MC6sisGhY7mc7Ux1IqHEsKhD9Wk03x5azA1cF4mHnMs1jFm1SB0/9WIR3FTxpGEHp0Es7BaHtj060hySyIC8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jkjweI0w; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jkjweI0w"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765332651; x=1796868651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8zjVElUadOzcDuOR9VRjFiKfaUjiP6pzUh9drRFIcQI=;
  b=jkjweI0wVaVs7ekuies/XvwLDhOA6orxXO8/+jxbA1ZjBc39ucAlV6fA
   E8eK2LTlsuzrBQVDhYXSZ44fOc8xhNfVNwPVccW/YaCuS96BcdHGNsw5y
   +ei8JT5pqIB/Bm0P7kUPT+C/akaQbMh0/LayULtfgadmCR5dfddNaSV/r
   WEJvava7VZSfgtUOuhtxoPtCCEKYDn6Dr0rKy9DTck9c469DVywFEoafi
   UJ5QJtq2CNYjC8wKOUFWIj1Fr4fd9yCKdnwjCBRcah2TrRbwY/TR/TCbh
   wc3b2FlE/1DDuxRkE6PTal/3uJidufR4lPLhyeLk+RGWoIot98lBavuFU
   Q==;
X-CSE-ConnectionGUID: l/tSCdaqTq2tZsnPREKFDw==
X-CSE-MsgGUID: 5CpFtm2VSJOxM8+1YNkDpg==
X-IronPort-AV: E=Sophos;i="6.20,263,1758556800"; 
   d="scan'208";a="137591770"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2025 10:10:45 +0800
IronPort-SDR: 6938d6a5_tuVD3jhsLTUskK01M3VHaIxDanh039jP4UWlifAQZtU2RXv
 1jRq1HIG+X1+TGNRKu6Ffm/KF2HvsvUwdVvF2mA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2025 18:10:45 -0800
WDCIronportException: Internal
Received: from neo.dhcp.fujisawa.hgst.com (HELO neo.ad.shared) ([10.89.82.133])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2025 18:10:44 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] block: fix cached zone reports on devices with native zone append
Date: Wed, 10 Dec 2025 03:10:37 +0100
Message-ID: <20251210021037.10106-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting a btrfs file system on virtio-blk which supports native
Zone Append there has been a WARN triggering in btrfs' space management
code.

Further looking into btrfs' zoned statistics uncovered the filesystem
expecting the zones to be used, but the write pointers being 0:
 # cat /sys/fs/btrfs/8eabd2e7-3294-4f9e-9b58-7e64135c8bf4/zoned_stats
 active block-groups: 4
         reclaimable: 0
         unused: 0
         need reclaim: false
 data relocation block-group: 1342177280
 active zones:
         start: 1073741824, wp: 0 used: 0, reserved: 0, unusable: 0
         start: 1342177280, wp: 0 used: 0, reserved: 0, unusable: 0
         start: 1610612736, wp: 0 used: 16384, reserved: 0, unusable: 18446744073709535232
         start: 1879048192, wp: 0 used: 131072, reserved: 0, unusable: 18446744073709420544

Looking at the blkzone report output for the zone in question
(1610612736) the write pointer on the device moved, but the filesystem
did not see a change on the write pointer:
 # blkzone report -c 1 -o 0x300000 /dev/vda
   start: 0x000300000, len 0x080000, cap 0x080000, wptr 0x000040 reset:0 non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]

The zone write pointer is 0, because btrfs is using the cached version
of blkdev_report_zones() and as virtio-blk is supporting native zone
append, but blkdev_revalidate_zones() does not initialize the zone write
plugs in this case.

Not skipping the revalidate of sequential zones in
blkdev_revalidate_zones() callchain fixes this issue.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Note I'll also be sending a regression test to blktest for this issue.
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index dcc295721c2c..831113667679 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2096,7 +2096,7 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	 * we have a zone write plug for such zone if the device has a zone
 	 * write plug hash table.
 	 */
-	if (!queue_emulates_zone_append(disk->queue) || !disk->zone_wplugs_hash)
+	if (!disk->zone_wplugs_hash)
 		return 0;
 
 	wp_offset = disk_zone_wplug_sync_wp_offset(disk, zone);
-- 
2.52.0

