Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67809C282DD
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 21:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311E82072A
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 21:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZYLHIVwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgAGV6U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:58:20 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16218 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgAGV6U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 16:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578434300; x=1609970300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TPEEp0hQGEeofypTeSJdahJeFvY1s3Y3Ez3cPhVsO7A=;
  b=ZYLHIVwlp14vYDXTK0TFneA90JzoA/1Gz0obrT0aZkm+lH5Qms5dpg7d
   CeaBW/C0x5RE0LAdhVR3fNFLQW9JtJVKWUcWLSni3Mw2Vp/H0Z4f9xPA5
   4ooJehuzYdDUot5I8BPzjVb89Pz1TCXrQ5PwpsdqfKIU+HHgeDE3qJuEW
   XjMMM8uHrIApMyKGHnjFRM8A7o8WAmYl9DHULKEJlxpYtv/8TKc2kWPKJ
   5cpNCMuJRBOonlxD5F+5TWcX1M2zkt5SMHcev/eTrk6sgqyZD44joEul7
   JPm3tNbhUmFKx7oDK+uU4yKBQmsZ/OPCUTbLfB4/KEkVl2VoofdRoHrwk
   g==;
IronPort-SDR: RdPG2go0YRCMDExV3BVvzdBXTzKCg9LVnNYmd4uf6ShMP8jaTDhLfbUcaNiF56tUOaRbDmbLt6
 Wjf5wCd+9TNR+dzfZUPCVyAxnwOTsOc6lc2B5yrGXi9U/6r2z+pQSUmY4O46xrLRachnhUomw4
 pMzUetIYL8nZlbRYuU2oMSGf5jl7ajQaQmSdCtcQbV7aWXpduZHUXvPuXvkFGo7HyOVsHkrrdl
 NHLO7Fmalb93Ko0AL0zXSELF9DGGOT69y6XdibfuasxYaLEsYH/7GwABkka8d+RUVcAEORLI9f
 lHk=
X-IronPort-AV: E=Sophos;i="5.69,407,1571673600"; 
   d="scan'208";a="127642476"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2020 05:58:19 +0800
IronPort-SDR: tgSB5q+vLhUAFnkNTN00kW31271r4lg1VgsG/zgKpHBo0uxMb+kyVX8Zyijb9MvPsAfI2cL/ZQ
 6IKAFsleZXEe0reEKQgWcnJiPu2HFJjTPW1pvQ6jeEi4/UTEhwyDOWIVO9Rv+MB9xDL6c86ZRK
 ENa+uH8T0+dVEyWJKdsV7JQlh/AE+kffSK+4G92v/7aYxd0fit+vj+4wQx2UAccfqsrb2wxl/T
 5qpgFSV6nEFSxvles06iBuj8JMQwitzOT1qGtp2RjPcoWSztyLWxOP1dN4fLN0LBEYu82OWlza
 7bAVKqOeZJnagsFhyg8hk19B
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 13:52:09 -0800
IronPort-SDR: i5S7Q1aIHdcA5YRhkIzn6bJxMQOIXIeSvy8GdXq3Bzp5Y8pv3bz1Pgg7UOjJM+89edfYom2379
 aj6RyRKJYYSPRGVE+igftj2wahpsp5Njwbo4zA5Z05VOoUT9KIdw9NMMA9+TeYjAvvX49xtaei
 FQymK7ltnDgOJ2kmoCX0jI1e1GiyozqnFaYiqrJtdK7ZbFEUemEQ+oSTJzwSGRgb9wwfB6xYAf
 KkKlYVnain8w+cKAwC/v+tCb11FnfgCY9jREv0eshTy9qwlFE7IJ5Ui/FvbtET+TF0pJku2s/X
 XXs=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jan 2020 13:58:20 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bob Liu <bob.liu@oracle.com>
Subject: [PATCH V3] block: mark zone-mgmt bios with REQ_SYNC
Date:   Tue,  7 Jan 2020 13:58:17 -0800
Message-Id: <20200107215817.2162-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the current implementation, final zone-mgmt request is issued with
submit_bio_wait() which marks the bio REQ_SYNC. This is needed since
immediate action is expected for zone-mgmt requests as these are
blocking operations. This also bypasses the scheduler in the
blk_mq_make_request() and dispatches the request directly into the
hw ctx.

This patch marks all the chained bios REQ_SYNC so that we can have
above-mentioned behavior for non-final bios also.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
* Changes from V1 :-
1. Update commit description (Jens).
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index d00fcfd71dfe..05741c6f618b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -198,7 +198,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 			break;
 		}
 
-		bio->bi_opf = op;
+		bio->bi_opf = op | REQ_SYNC;
 		bio->bi_iter.bi_sector = sector;
 		sector += zone_sectors;
 
-- 
2.22.1

