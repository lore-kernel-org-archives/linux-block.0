Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA48DC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02A422D6D
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 06:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jFUDCj/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfHUGMH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:12:07 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46795 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfHUGMG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 02:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566367926; x=1597903926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pkSKnUyLKuEm0+rCqbuqfjLUYzLq6qcBdWjO6y3X84E=;
  b=jFUDCj/Rz+nAOe3Ayc6FsHFjYAFgZOfN9KpoHbmJV03XuyKDUMeOO+PZ
   Hv1QKlFCl/ZpYaNlJSuclPjf49IdYPFC7kdjlF0tWg2QdX9T8KiA73ZyN
   oWajwfjiG36hw/8rur+bDlkOYCKtqX5Q1ZQYF9qWFYbXPOx6OdRYGqzg8
   DIbubt7Vxo2zaQV1kJ7ovRGjIP8hVra9wwh09/Jj04k2rgs/P+N1Kc1LA
   1dznHKc+zE44yvCo1brlwhD1KZibj89xtXwHx6eFLD98qvXWt1g1/Ohqv
   xPkWULkc2h6x+hD+lYM02HQzKEfiGm2K/iaIFbw0FjGQsDehAVsk5EDH0
   w==;
IronPort-SDR: mjBtJvuuzUuYBgAIU7TJIq6ETHzP3oc/t3aH3AFzSOGujvBEAPaA7oAohoLeGm8UektYySyeyO
 i6TZBBesrCElRPW6HxsY11RZSmZ99K8beEGJ9DpvyZtMrOPh9ZW1Mc1ZTsA5MFMpDhWK7Bls0h
 fqjqFv2GhXQBsrxCMR/6L2FXLcQCLct97CxNpjtBUewmkLwmoArisIHAKOJA28KJ9idFfSS4k4
 KKScgEwmEcIKSOedC8/wdfOKbrDvOo5GYl9dzYIzZ/y0GrAwL1gvVNFNlKAYG7w26zvM7x58m1
 qcw=
X-IronPort-AV: E=Sophos;i="5.64,411,1559491200"; 
   d="scan'208";a="222880644"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 14:12:06 +0800
IronPort-SDR: /Zcqaap36ZdqO8XxRP2AIjRdXD3tPaScUtMwfeVsffobbMcbw33N47TYzaUOcod3awtfrho66o
 DJu1xXtOaq+TsjAV2IBImCm/sZdsH5hne4GhFtwqzfHcidPC48X9iMAbwFX1XEaKnn1N4PWFf/
 tNNh5sWQOKJh+SptcUNMCGMPDF2ix+rJjlIA/lfSC2HK4WX8KJn53qr/F/mQoVYKn9U+r3+Tki
 DpiWG+2LcNuoTAhC1ly+Wbjo+CU3CTgqy0+/O8HHLETk41FVnAqhipGcBDhC1pIpAoSpG6JXvW
 C2y5EbV3Sa57prflK43JHD5R
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 23:09:27 -0700
IronPort-SDR: gaol3yHL7M2d3mOEXfON3s8nndUFoilpi34YuaQm+Ll0LgtzBij5CyNwLnotQAGppOSBM+h+yX
 x9uGiHlRU/zxkgO3/AHcmvvSp40ySjFid8rhYiXX6BjxRmvkRi/oLoUBvagwblfylUKjrHPDTD
 GnVsgv5C+Nh1fnp0fbLE6RUMY7fzyHYgRJ3TdgTN3jHB2tcl3aw6G6E6prT3hWJnsAd5QTwmL7
 SDbja4wkhcs3fSSf6S/RsSg1QMam3JmlJPnqL7hqpcNLyrAkRb+l1M1I15N1se3hgJb7swuBVO
 Jok=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Aug 2019 23:12:06 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 1/3] block: set ioprio for zone-reset bio
Date:   Tue, 20 Aug 2019 23:11:54 -0700
Message-Id: <20190821061156.3127-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190821061156.3127-1-chaitanya.kulkarni@wdc.com>
References: <20190821061156.3127-1-chaitanya.kulkarni@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set the current process's iopriority to the bio for REQ_OP_ZONE_RESET
and REQ_OP_ZONE_RESET_ALL.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4bc5f260248a..741759b5e302 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -214,6 +214,7 @@ static int __blkdev_reset_all_zones(struct block_device *bdev, gfp_t gfp_mask)
 	/* across the zones operations, don't need any sectors */
 	bio_set_dev(bio, bdev);
 	bio_set_op_attrs(bio, REQ_OP_ZONE_RESET_ALL, 0);
+	bio_set_prio(bio, get_current_ioprio());
 
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
@@ -290,6 +291,7 @@ int blkdev_reset_zones(struct block_device *bdev,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, REQ_OP_ZONE_RESET, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		sector += zone_sectors;
 
-- 
2.17.0

