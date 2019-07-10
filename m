Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ACFC73C6E
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1849220844
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 04:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DOogmVBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfGJExN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 00:53:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31080 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfGJExM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 00:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562734391; x=1594270391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J9A2mZKc8m8TPsZq/6PX/LDmXgRam2hTzN3MSAAoRAk=;
  b=DOogmVBbgAL5bvMPN8K3210Tlv74kRvCUrfwN6moLo7gc3CcvxLT8+1K
   GhDh+X7mQY/nANoczN5fjhvqgeidce9Gz4UL+dPw3yaG8dd8fbPxNrAVV
   hLnsR2BZf1j7lt7+BuYFnNdNT7h3LEl/GIg98vbFHmQZ/4VALk4EzTO1e
   e3fK6jKwm7RYoDfeX13KHf02yto4OtskTqpGolSenmNHgXKY5YBYV5dYt
   l295DRdPi1hIDDqa+klIGYFEwkWTi7/sLKEU3PwX9gzL+aeCUzDzic1iK
   61xeV1tHO8iFuJP9kzPap8Flbt8vWMEwK0SIjZd7tHZ7o9qtm5K6ZVAzs
   A==;
IronPort-SDR: bBiN8w1i+az9yWFlIl99RMZY7aqleTz2AryvccxkL5t8cMIaldim98ZZAk2nbvTJD67tguUCv+
 r6BJafLD+RRdOnmuLeGXLN5sOBoKT1zruSLTe8z/9OJ5wrcOYzmc5fvU35qM7u3IiVwUrB1s8w
 iJFlkryPJCO2SOMaoU+IHP32VnaQh6hIn9OpbrnJiO0wPgRgjW3wilYSg7nqjmd0o4eB+00yUD
 gNP/ugD0N31rIdAneh8Q+GG0+wahYtobo+WaRwE2+Zi3mw4so7C2zL7bBRxrfeDimVhp+mrGGk
 0Vs=
X-IronPort-AV: E=Sophos;i="5.63,473,1557158400"; 
   d="scan'208";a="219039962"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2019 12:53:11 +0800
IronPort-SDR: Fxp8ThtXwBwy9cA6QEknndTbFqUXz6ELt+MxhXkdlHhkBH0JNDeQd35s83zB5H/l4/8/nKlAHF
 DWzvlW9i2MMqrfbRmmgXQ+tWF43/6dhg+3q9uTOFgI0WmZkndw4rNDsNvD0YxAdEPai6+LNx9T
 odX7h/+gANp2fJJsj8dx47/iR1FX6HzUg/msRr7nOkXknMFaqWY9CyzRAtplVelcZeqgkKFJhD
 Kv0NEQINDir6JSJHDM/shG3diZp9tklA1DJkv6/uvXzZ7ytBMDVy493dD5rHWlqG09hslQZXyC
 bQ2OHFI/HuWObfJxo1uxJ1S0
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 09 Jul 2019 21:51:57 -0700
IronPort-SDR: BrTKhci4sDUE741Gj/HOO9THgD3+jku47dVcAtmtWixPOFlOdOq1itt1F0+VR7z8VaIObgnjPs
 tJgwLmxLy0q07uMXY4qGOqFlm/GKoWlF6G4yyy/jIYKqZk3OK8xEPdHZLKlvp6c8+FdB3w04YX
 z9LqdLCNr5cpWpe4OZdnMiTL9NbdrtUWa0S448eKouPfe/ZU7jqu/UtlK01bc/WDfiz/vAD15v
 K4Lg7dePzT2YnY/T0tv2j8Cyki4ptnUvsOkvUmyEiqLkx5/MqY5BIkDWxo3MaRueOCZQAWTY3S
 Sdg=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2019 21:53:11 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: [PATCH V2] block: Fix potential overflow in blk_report_zones()
Date:   Wed, 10 Jul 2019 13:53:10 +0900
Message-Id: <20190710045310.12397-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For large values of the number of zones reported and/or large zone
sizes, the sector increment calculated with

blk_queue_zone_sectors(q) * n

in blk_report_zones() loop can overflow the unsigned int type used for
the calculation as both "n" and blk_queue_zone_sectors() value are
unsigned int. E.g. for a device with 256 MB zones (524288 sectors),
overflow happens with 8192 or more zones reported.

Changing the return type of blk_queue_zone_sectors() to sector_t, fixes
this problem and avoids overflow problem for all other callers of this
helper too. The same change is also applied to the bdev_zone_sectors()
helper.

Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-zoned.c      | 2 +-
 include/linux/blkdev.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 79ad269b545d..6c503824ba3f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
 static inline unsigned int __blkdev_nr_zones(struct request_queue *q,
 					     sector_t nr_sectors)
 {
-	unsigned long zone_sectors = blk_queue_zone_sectors(q);
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
 
 	return (nr_sectors + zone_sectors - 1) >> ilog2(zone_sectors);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5ace0bb77213..760668ed555a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -686,7 +686,7 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 	}
 }
 
-static inline unsigned int blk_queue_zone_sectors(struct request_queue *q)
+static inline sector_t blk_queue_zone_sectors(struct request_queue *q)
 {
 	return blk_queue_is_zoned(q) ? q->limits.chunk_sectors : 0;
 }
@@ -1434,7 +1434,7 @@ static inline bool bdev_is_zoned(struct block_device *bdev)
 	return false;
 }
 
-static inline unsigned int bdev_zone_sectors(struct block_device *bdev)
+static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-- 
2.21.0

