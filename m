Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E157C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4C120851
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 01:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fXjQFoDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4C120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeK1MZl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:25:41 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46557 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeK1MZl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 07:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543368428; x=1574904428;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ReU84yni9xt56JfXCoVFWbAA/HHQP9CCHwaPVB+kYLk=;
  b=fXjQFoDW7wQXUqN90gnVRi3rxfKDBEiM3+Za9K7KKZukqJzijrwBHOSN
   AmZWVUa+IgGgrAbswuA9t0nR24kYliO/yQNay+EIVb0I3MOuYGlm5YiS+
   nLW/aK6Sh+rx/dHaZWfWilWmfz7Tbd91JglxIrzBb9WmyXt/u/mtJF25V
   WeUlUBMPSYIrbMMXsaOsdG1KxDOwq+yXP4M0YqfOw09KyVvgIrn01vG0E
   QEF0TsK5MNqd8AItt4CG4bpIOAIH5cxlubIv4scHz43dmSsE/x8VdyDRB
   xC4Ya4DoO4UB23abvR9xL2CE0NIGEjFxpTpADWtzWUp7700WrOd+OVThw
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,288,1539619200"; 
   d="scan'208";a="193070069"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2018 09:27:07 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 27 Nov 2018 17:08:23 -0800
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Nov 2018 17:25:53 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: update documentation
Date:   Wed, 28 Nov 2018 10:25:52 +0900
Message-Id: <20181128012552.20568-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the description of the zoned, nr_zones and chunk_sectors sysfs queue
attributes to Documentation/block/queue-sysfs.txt. The description of
the zoned and chunk_sector attributes are mostly copied from
ABI/testing/sysfs-block. While at it, also fix a typo in the description
of the io_poll_delay attribute.

nr_zones description is also added to ABI/testing/sysfs-block and
contyact email address updated for the zoned attribute.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/ABI/testing/sysfs-block | 10 ++++++++-
 Documentation/block/queue-sysfs.txt   | 29 ++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index dea212db9df3..3789b32759dd 100644
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
diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 2c1e67058fd3..a23952567008 100644
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
+or host-managed, chunk_sectors indicates the size of 512B sectors of the zones
+of the device, with the eventual exception of the last zone of the device which
+may be smaller.
+
 Jens Axboe <jens.axboe@oracle.com>, February 2009
-- 
2.19.1

