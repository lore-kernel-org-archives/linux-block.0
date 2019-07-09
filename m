Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9B9C606B0
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 07:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AE8216FD
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 07:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ib085wxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfGIHxv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:53:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29405 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGIHxv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 03:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562658830; x=1594194830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GEpDGO7B4cizWFJYjPAAOuCnY/DjHb3t7H54QMgV9hs=;
  b=Ib085wxIxPDL52JE+QdnK2AprY+3cgqja3t6U0IYf1aKPdkTS/QHFI8N
   bN50/4GzNcSM125JJMxJ0F1b9YG3RK73jtn1gOrgcbUST6iw5/o961KfL
   qqupqXgHukG4DI6q2Qvio67jiRE6Z4+PpveXKGkdD8PnZDbqIDgMsKypR
   0bamtHG3+uiLglqyzdKlirCR/qRkIi0EKdfKgvnv+lgeExYL+RijBQf1X
   PKvbvBasqFivgQf4Xds45XJ/b8Lx8QfU0EuJkuQI+9Y9T0S4sc+YP0aPW
   +2Abt0nctnXKx4Bv8YypSUXmb4YcyOWmKpUZRhgI+q0r7zn2eAscuPsAU
   w==;
IronPort-SDR: QChiiTas5kzCriLQGZx04NhMjc9ne2jkG/FpcYk7UG6jm8n/KAfKgFzK8UFa/ZN1gE0HiDW+oX
 5/b9kTnKGWc5kJHmDkqSOhrD25c6RIF3CSAsLiCZaXFeRAalxF8NaS2Y0bD1OdIYTKy3tNvXg6
 Bx2r2InJMjI69dbGvVzIQG/mmA3iBw9pJDvkS1Z3Da7BsJ5XkHOcMgC6ga+euakD8z8YMnSkEi
 boZi54oTAwP/t3V/pMqzzLGjgC4ZKCy7sn/s22A6S8OoN0AtIIWxkod2Dx/uWVQQMXcJthAqPL
 m7k=
X-IronPort-AV: E=Sophos;i="5.63,469,1557158400"; 
   d="scan'208";a="113697532"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2019 15:53:50 +0800
IronPort-SDR: voLanYdYkEw3niYycbkjeIRS97gya2OeAHKnGXLu6TzTszyr82cYjIZ5dxEYkG0Tl+vCS9YjEx
 /PZ/451JwGCtHfcdawx8x+vCaDhDCoQP+bRVSvKXgL5k8vIpfX0nJewf6AXTPT+pYforA7RKV3
 8jP2uZCisguseejftrtIiHq8IaFfQeh0eoYlUCi0uT5t7N1L9adh5scI1d34VNlvcY7EbhGtNC
 bDBZhWT5I3RRQ9MznAgJx9xRjOTUgClSm4b9jOWybs1MwQn61/xQHkm1qruQd/g1X0ZccAzXa5
 CDouYj8AFeSTWLSjPWDQ6Ym0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 09 Jul 2019 00:52:37 -0700
IronPort-SDR: hSBr1oX4TB2c7DHZ69bzIOiug2qt1Uje6ObUzLJ4RFVNH4kPtWl4tG3PkfkHKwvqIude2LHBgH
 4TAOSkYz07tJ1dRRFS9xtM2cuRCUwrdYhTB103nVOoK4a4zLTexSRkYlyngZP6oQ2k6L76d5W4
 8bJUY8Z2v0WQi+Ls3uuphE6HFiBgAp2pigr6ylQVQcW07T9dShnBTZTgZ/0TdENfKUO26z3rMz
 vScL2jfhG38wU3s9lARs1/YrlOnlsirzWSCH5PoaB6n2l4ofrUihJs6FQa18dAzHXl0brdgscx
 cR0=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2019 00:53:49 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: [PATCH] block: Fix potential overflow in blk_report_zones()
Date:   Tue,  9 Jul 2019 16:53:48 +0900
Message-Id: <20190709075348.24823-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For large values of the number of zones reported, the sector increment
calculated with "blk_queue_zone_sectors(q) * n" can overflow the
unsigned int type used. Fix this with a cast to sector_t type.

Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 79ad269b545d..231b7e1b6d22 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -134,7 +134,7 @@ static int blk_report_zones(struct gendisk *disk, sector_t sector,
 			return ret;
 		if (!n)
 			break;
-		sector += blk_queue_zone_sectors(q) * n;
+		sector += (sector_t)blk_queue_zone_sectors(q) * n;
 		z += n;
 	}
 
-- 
2.21.0

