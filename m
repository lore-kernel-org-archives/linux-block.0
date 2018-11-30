Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7608C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 05:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D8220868
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 05:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pmUu4daF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D8220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeK3Qod (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 11:44:33 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4801 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeK3Qod (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 11:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543556188; x=1575092188;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OAzUSBv86tyuxPjxcEqksvLGS03F8SjUFAMa4LsvQpE=;
  b=pmUu4daFZeUBD3obipel/TZzsIgUtdtHdXNCMGMfyyp2a8qAGBzZ0WIw
   3j+GVintnhlPp6g94b+jDh3nKZD2dBPx/LY4/FmG1IcayOYpOzSXeiBeF
   K/tW+FsqyN7XqahTiuFmhpJHoq+o9OcxaNtrB/p7/DFJeFgFySNq+quAI
   R1pB9qDVGDX/7YOKpzvMSudfvwlx7ToANcYMuWBXfk8QaRh6CkLmXwVB7
   xgUVafmrM6B5vfGI4aPfOzih5tLHx3Wz3D0SI/KrWzunfXhhIZADE2f9L
   v1DTZh0Jk9lt0YaelopLotGfNH57Pcv50QnaLNMLObpsvKNM8uFOnYqiT
   A==;
X-IronPort-AV: E=Sophos;i="5.56,297,1539619200"; 
   d="scan'208";a="97208997"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2018 13:36:27 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 Nov 2018 21:19:23 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2018 21:36:25 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] block: update documentation
Date:   Fri, 30 Nov 2018 14:36:24 +0900
Message-Id: <20181130053624.1910-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the description of the zoned, nr_zones and chunk_sectors sysfs queue
attributes to Documentation/block/queue-sysfs.txt. The description of
the zoned and chunk_sector attributes are mostly copied from
ABI/testing/sysfs-block (added a typo fix). While at it, also fix a
typo in the description of the io_poll_delay attribute.

nr_zones description is also added to ABI/testing/sysfs-block and
contact email address updated for the zoned attribute.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/ABI/testing/sysfs-block | 12 +++++++++--
 Documentation/block/queue-sysfs.txt   | 29 ++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index dea212db9df3..7710d4022b19 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -244,7 +244,7 @@ Description:
 
 What:		/sys/block/<disk>/queue/zoned
 Date:		September 2016
-Contact:	Damien Le Moal <damien.lemoal@hgst.com>
+Contact:	Damien Le Moal <damien.lemoal@wdc.com>
 Description:
 		zoned indicates if the device is a zoned block device
 		and the zone model of the device if it is indeed zoned.
@@ -259,6 +259,14 @@ Description:
 		zone commands, they will be treated as regular block
 		devices and zoned will report "none".
 
+What:		/sys/block/<disk>/queue/nr_zones
+Date:		November 2018
+Contact:	Damien Le Moal <damien.lemoal@wdc.com>
+Description:
+		nr_zones indicates the total number of zones of a zoned block
+		device ("host-aware" or "host-managed" zone model). For regular
+		block devices, the value is always 0.
+
 What:		/sys/block/<disk>/queue/chunk_sectors
 Date:		September 2016
 Contact:	Hannes Reinecke <hare@suse.com>
@@ -268,6 +276,6 @@ Description:
 		indicates the size in 512B sectors of the RAID volume
 		stripe segment. For a zoned block device, either
 		host-aware or host-managed, chunk_sectors indicates the
-		size of 512B sectors of the zones of the device, with
+		size in 512B sectors of the zones of the device, with
 		the eventual exception of the last zone of the device
 		which may be smaller.
diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 2c1e67058fd3..39e286d7afc9 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -64,7 +64,7 @@ guess, the kernel will put the process issuing IO to sleep for an amount
 of time, before entering a classic poll loop. This mode might be a
 little slower than pure classic polling, but it will be more efficient.
 If set to a value larger than 0, the kernel will put the process issuing
-IO to sleep for this amont of microseconds before entering classic
+IO to sleep for this amount of microseconds before entering classic
 polling.
 
 iostats (RW)
@@ -194,4 +194,31 @@ blk-throttle makes decision based on the samplings. Lower time means cgroups
 have more smooth throughput, but higher CPU overhead. This exists only when
 CONFIG_BLK_DEV_THROTTLING_LOW is enabled.
 
+zoned (RO)
+----------
+This indicates if the device is a zoned block device and the zone model of the
+device if it is indeed zoned. The possible values indicated by zoned are
+"none" for regular block devices and "host-aware" or "host-managed" for zoned
+block devices. The characteristics of host-aware and host-managed zoned block
+devices are described in the ZBC (Zoned Block Commands) and ZAC
+(Zoned Device ATA Command Set) standards. These standards also define the
+"drive-managed" zone model. However, since drive-managed zoned block devices
+do not support zone commands, they will be treated as regular block devices
+and zoned will report "none".
+
+nr_zones (RO)
+-------------
+For zoned block devices (zoned attribute indicating "host-managed" or
+"host-aware"), this indicates the total number of zones of the device.
+This is always 0 for regular block devices.
+
+chunk_sectors (RO)
+------------------
+This has different meaning depending on the type of the block device.
+For a RAID device (dm-raid), chunk_sectors indicates the size in 512B sectors
+of the RAID volume stripe segment. For a zoned block device, either host-aware
+or host-managed, chunk_sectors indicates the size in 512B sectors of the zones
+of the device, with the eventual exception of the last zone of the device which
+may be smaller.
+
 Jens Axboe <jens.axboe@oracle.com>, February 2009
-- 
2.19.2

