Return-Path: <SRS0=ez2/=VO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE7EC7618F
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 01:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262D520818
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 01:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XT+TAHJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfGQBvw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 21:51:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26739 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfGQBvw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 21:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563328312; x=1594864312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wdPsIShi+j2gklkYJvrdms/7xjwVBe53oFU2znZWh6Q=;
  b=XT+TAHJ9D3iKAODhyKEWjlzomtEcWgAQiiI58OROhVr2G0NiwX1IDNuX
   USVEZ7CI4rHuHymn0shJIDyPnDSkixyxcEHhggMyXGxoFN7kwNH/e3Dis
   nPVyij//6LIRFyZgieYZoKTTZU6jYhycnBAJdvmFEommH9as/+Tt3mIo1
   Qb+WjwIMqFj11Q6NS/EJY2dG77rWOCPqdSlQhFwqC4gwA4tUTDgNeTm0f
   OJvNNChyoyr6JfcZqtlXQ3AhEGqC3eDAn5SOUpZREHP3ElUDGMl05X8hC
   MAZp4tJfX4uU2MPvTK3NhraSrn08cFeJWAfoO+hDWuoBQQeKlOOZuGpdU
   A==;
IronPort-SDR: Z7IY6RusZ/PhYdnWvMsP2PQbLiePDeV/1IZfvwtA1Xk1KSi6K4Dkrdx7KN0OxmBV4aqgrLTkH/
 dtpqZ1XYiqavsMcJjoufdf0l08WiJ0cXUBF98z6dsP333n7hso7d5RsrK8VFt+rZjyT0ce3G8r
 tFT+IybrLaun4bXgVs5JxS7Ap1lW7DSaMlR6nOrkZvWvRpd0OpYiE5igaW3P2We5M4Wovl7Cpn
 EW9q97kYx0Ss7WY2haInyi5xXODusjybh4ItqcIXHweQmjExOpwx6ENQHlYLn7dBoLaqWNOibp
 df8=
X-IronPort-AV: E=Sophos;i="5.64,272,1559491200"; 
   d="scan'208";a="114363295"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2019 09:51:51 +0800
IronPort-SDR: epNbV8ZHz3/FTNc/7Y4XwIsNJGW6BMPD/5S6YfUPLK6sTQbKfx+aP1ieIlgD2Z+m2+zSR0UjZ6
 IeUPyRbVBiYQGcOBbLrowhIouxYQJ3f7HwmhkVZP5yH2pIN8+cnyOqxzWFyrylWeM92xYrOPK9
 F+gt+SloimGSpaL0ChH777y+xTCdL2skaj8WDPvRfSpgHXmL+BuP3W5HKAFMGibtsi5LLC0L/a
 uXfZ40SXrZQD2IlU6iL2/q8a4fuwfxHqZUwDiU2kI2ByjeIYFGQcTIiMG8ZXdFSGHXuknI6E9l
 kEAnLXlUoowoxzd6VT0TuqrX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 16 Jul 2019 18:50:23 -0700
IronPort-SDR: 3IcATmr5KkVnLT/YNZKNMogCJg95pYs3EShTSsNh0j1vSk1fvQGrf8eNh9se5yvL4fdP6NIPHM
 AWEaO5etqVHu8w2UjIIYwxjPg7ZDXv6tddKCQ6NmJjaIt1X5ytsvjsvwLwgodNmZcj50XW66bR
 NuEJpvZ+B2as+dzR1NZW7ALYwHxaLCyNY1XNAs8C4k/TpetaLLVCEEfnTYG3s5SauaDwdYKji0
 PXuAMJM8FxqT++AG/ibB+qE8a00KL0vts26jxrUTse/qxSpdxvqUBKso8/e9w/kPddr4j1yD6x
 yOc=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Jul 2019 18:51:51 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2] scsi: sd_zbc: Fix compilation warning
Date:   Wed, 17 Jul 2019 10:51:49 +0900
Message-Id: <20190717015149.23028-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kbuild test robot gets the following compilation warning using gcc 7.4
cross compilation for c6x (GCC_VERSION=7.4.0 make.cross ARCH=c6x).

   In file included from include/asm-generic/bug.h:18:0,
                    from arch/c6x/include/asm/bug.h:12,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/current.h:5,
                    from ./arch/c6x/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers//scsi/sd_zbc.c:11:
   drivers//scsi/sd_zbc.c: In function 'sd_zbc_read_zones':
>> include/linux/kernel.h:62:48: warning: 'zone_blocks' may be used
   uninitialized in this function [-Wmaybe-uninitialized]
    #define __round_mask(x, y) ((__typeof__(x))((y)-1))
                                                   ^
   drivers//scsi/sd_zbc.c:464:6: note: 'zone_blocks' was declared here
     u32 zone_blocks;
         ^~~~~~~~~~~

This is a false-positive report. The variable zone_blocks is always
initialized in sd_zbc_check_zones() before use. It is not initialized
only and only if sd_zbc_check_zones() fails.
Avoid this warning by initializing the zone_blocks variable to 0.

Fixes: 5f832a395859 ("scsi: sd_zbc: Fix sd_zbc_check_zones() error checks")
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/scsi/sd_zbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index db16c19e05c4..5d6ff3931632 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -461,7 +461,7 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 {
 	struct gendisk *disk = sdkp->disk;
 	unsigned int nr_zones;
-	u32 zone_blocks;
+	u32 zone_blocks = 0;
 	int ret;
 
 	if (!sd_is_zoned(sdkp))
-- 
2.21.0

