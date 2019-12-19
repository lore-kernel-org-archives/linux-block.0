Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A87BC43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 06:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB6824682
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 06:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YA6DyBPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfLSGO0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:14:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47783 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfLSGOZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 01:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576736065; x=1608272065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tzhrBoUJYUSx5xB3XnzJ4NswKblEn+E255iXADaMYdQ=;
  b=YA6DyBPCk/Vo0j77ecg54XsE8KGLmO1BTe32JyoFGfGZ9KOe0s0qqLAg
   5zss4hevzW5SCI82fBhRzDw5hKVMZvsep+ti61HVU2oB0zQmB3VW1WI9p
   rfV57OIB3o1C2tMuLaqR2lQwBsyzFeG5jZjZNF3nR7tCsSNR/LotVjjuc
   bIy4QtClq6qdcjK8MtXan1twLLkCX1bhsGW7i0i7lf1lT9mcxtHCP6PG5
   InBki5ewe4ATETC6u9xF3AUGs0uwaVusBZBqSNW8nSkpwsQwWPWIfel+0
   IBQIbu9Rf0EbP16meENd9HR4XdAzGhFl/uBs9f7Q/NGdrBx450FQWNzPT
   A==;
IronPort-SDR: t5tJ6Cas2g/Lxfcpek4GR/hImePKuUD2rUOLAnTEAd+shYP92MCEbZvd/hM+nvcmlN7wNs9c0d
 MaSIEmRXxm6NNHTjZd7o1sScltdrY+biYoIWu1gy6yNq/Yn4ZktkHwSvbddbW+Eqbd3IPxFLap
 LfshT+OJSeBDMgyjzhYc+nDxlq0O3fZxz3MZCcucLJwJerCSCbRROTrG0vG2HHHPi4zljsYCWP
 5bf0COmedaIKP13JoYUK+4nSw1XN213eaCPlu26IPnktNPdt7/j3ggpSGityqXXFNDEUww7jCF
 odI=
X-IronPort-AV: E=Sophos;i="5.69,330,1571673600"; 
   d="scan'208";a="130132707"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2019 14:14:25 +0800
IronPort-SDR: +TsMJiZX42TUBE5VOTCX86aJdl+895r7G/PG2+Y0zG+1+hF6C25DBkxYWzORdPmHXk1tPga/0/
 UH9Wpu+8ax67rppsxdT/N9k9z1ON7Xn4AppaKvgg5GG4c0y4kPRzke/VPeB9q5fjBIbzEwKZBU
 Y3zFhE4Xoy6odKwN9Y/f2eC2WTho/42lyN9Mx9aQnoJDUSPPuaEbqQxsCS5H/pHhXBQX53vT1D
 cjai+GqWDFqYgd11ndegXIMEtIrDAt/+mJ1/hqxc7uv0xa24A7/L9s6Sw9jP5alSHgH0F5Iqj3
 grtmYGxZUBD6/BQ8DgaYE1dx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 22:08:47 -0800
IronPort-SDR: W8ub+u02ixh63sIfuPMG5LEHSb6a1A/ciNHMiWF++YjHaA4BG3GHVRSruwXmLQJ55lAeSY0Ve5
 ERYx+XX5dGhjtACUd/9SS3QrgwwBYBtpBKCFiWCHRduAvknCownNSzJh4kr/2e21pS9CfDAiH4
 hDD0rQJ/69mOEBXOWHbvGqXKhj22BFxrZsMixoeeIas7JB61KAkcI/oa2y4ZEAsKD0ReG4BJLy
 8aCClvyb6i2TH0jngVGSFFjAaqiDDAD1xueenF/yn83iE3IGnJCrI+8kNOdSYMcwSkRwtoCV1W
 RVU=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Dec 2019 22:14:24 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     damien.lamoal@wdc.com, axboe@kernel.dk,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] block: mark zone-mgmt bios with REQ_SYNC
Date:   Wed, 18 Dec 2019 22:14:23 -0800
Message-Id: <20191219061423.3775-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch marks the zone-mgmt bios with REQ_SYNC flag.

Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
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

