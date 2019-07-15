Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57510C7618A
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 05:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C78120C01
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 05:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XTxJjDZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfGOFig (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:38:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37497 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfGOFig (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 01:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563169115; x=1594705115;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v+bSBg6jjIAj4+AXOXVxZAQGqn3jMajngF3sUFLboa4=;
  b=XTxJjDZf2zRpGms183oaJIGeQv7gJ4nW4SrPOQzQmt4gusmpef1Pzejk
   e+RijdevFI/n8fkn0IDxcGlWOO4DKEY3rX/OfB+YQbwiwrlKkgp4qfFde
   629kMchJVnUufO+kfwJc06p4K7p4KTz9bfsW5PxekxgCM9XsZpiZFbK9T
   KWKlzfRRCz6kfZhwqwX+oTjCErnOjyTW4FFto6FqlbRSRgczgNjx9ZqDC
   GLk/d1auMAtpIbDnk+IBRDpl4O5ofGX4RSr43IyI/CRRLfXBHqyky/taR
   cHVgAdQe8gFO0n8WGqKTpwBoTzDbCvIc8V0SnyJ99pb9AeLNuZvSChaNp
   g==;
IronPort-SDR: Xj9rxWAf4q8cvHXfPR6HhEXQcdehbJeXRjWWRZG9dFKB2A/19gVfbCkfFZdOpHi/OLz4LOlCMD
 G446NMLxDzyW3m3rjEifrZq2etEzaI9V+Z39PMI933bWmCXQXm6Fnv8I/vHw8ogmxDyJevet1M
 5PwoarbJ6zx3v6TlwpDNjAJo5Sk7Jy8PFV/I8EKLIJokNELAGpfj4AVN2zY28AHmBRGB1J8KRs
 MhywbkINte7FN3/oiXnfu54e0Et4etT3Q4M2zhhC4x7GVzm2CWIJYoH/4TK4P/9Hfyk4YrlhVa
 hF8=
X-IronPort-AV: E=Sophos;i="5.63,493,1557158400"; 
   d="scan'208";a="219467783"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2019 13:38:35 +0800
IronPort-SDR: VCb40TSfXw4SkHY+9sok5FMij9qh/COwXXhwJwDHYoq46mMSa5Ti1oJRsvpdroswnjqqAEuZyQ
 B0Aow9+ePinANFwZ6IvuJzXSUEwf76NDAYSdzKZvWFDVrPZtebFWIcgrD2qOpdf0EtBI6JznQF
 jtRtMN5kz4UdYmL929vQynRyDMlPzTuiSl9BLM8kTewl0f0F+CwoWRiIMG4feUmT1gcCFRs97I
 487zr4YeDl5PpMM7FxZ6cPVe7Yk1UIFT57foqZ3POcVXchusWRSO6ck7EaIV6VFZXLsKLqNm6d
 9dLifxVEETD2Zpr7Vo/pkOTP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 14 Jul 2019 22:37:10 -0700
IronPort-SDR: y+vpzPHJZp/IHdGFEGtQjRhb5l7KwOBuEKFB3udkb+zhATdyWNCqohOX8KoR3+IefvpWUDE+dT
 WLiu2aV7WYzWfu3dALvzsn+AHDFD3cTyGkE+4wRGKDKFT792UIKRYQtGDY8ZlJ6qidHQ6i2ngJ
 hr9SHCHFVDBqebxIZfinf0A4QID0f1rV1a0T+qCPjnsZ9FX2G/wKyfPSz24qFEjHb9ZFOWSeiL
 dDTQBQwMFufHbEHORFv7BlutHZFVyyvXlL+M6clsx/LUwYA1pHneQqyN2oE/V2TFo6KskO4pIl
 iO4=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Jul 2019 22:38:35 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] scsi: sd_zbc: Fix compilation warning
Date:   Mon, 15 Jul 2019 14:38:33 +0900
Message-Id: <20190715053833.5973-1-damien.lemoal@wdc.com>
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

Fix this by initializing the zone_blocks variable to 0.

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

