Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DC3C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 07:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E3E207BB
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 07:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="U/odPIQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgKKHgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:36:09 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14528 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgKKHgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 02:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605081008; x=1636617008;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bTq7puqpQ4s06eQATlXGBRszy/FiGDDiCj3HhpgivqU=;
  b=U/odPIQjnCtq1yb0jyyLtjlieN7WLRbk6Upo0POHX6Wyxw5TxvpgkJ6x
   51XfIjKAtGt/Ob0EA2EyC/xOGokEyDslXYH6HczrUC0gPt0yazUOHlFT0
   4wv6S42l2Su7YdexU1HgfHWIBLUmxZw28pzCVs6g5fOnqpGTPkaUa9CR5
   w6OcmUCkGMgZu1PDc0KykReMnVbmifiH4GRJsQeJCFGltNCqstiQ2Lxe8
   OQ90bx/dZsXMkzrTTtRrje0uqYB+qITkf0nCMi5QYn3+2isG7r82zuCM8
   4zm6kb9icgXxzvRZ2UUQQAEQcBP4NU2gWddWyRYNCt0YqohCcgszQuQg9
   A==;
IronPort-SDR: 9nqGXGm0jE3ozAnq3Y7mq6MVnxYYjdXM4W0blx90Wp0/ArcPVJSUWNz2WFX4yE/WRiri3in2Od
 KKw6RnDkzn5yJwI0MugbuIOshifz+35UyRISzQxb0QwhSfCt8u0rS2AWOV99fqNmU2huyWUPcf
 Cr8KolRos+IS2XupphiCld3h4vVWxbcePQ2gNDkYEei4GSf7idkTMKTfwFMR+Rkv4Wf5Ijw4rG
 nT63ckXw48Z2fWcmixPGgl5K6mbWGsFkbclSUrm+/QWgnr2hM4Ydhwl76bvySXcaZsnHGYjUTv
 qoA=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="255925479"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 15:50:07 +0800
IronPort-SDR: cauGa1H/zlTRxxRwh5hbw6oiIFkA/xVxD+uL+Y25MKU+HJWbMIwjnwn7aJbt+WqV6ZS9s0R4zx
 HqFZY1L0O1l1Gksi7GNlyKhqqnwTLgqSbXkpA+auaRuTrKgXPEZbjVNCgFOdL65zN7NbhBeBNv
 CY/KoTk8Ww0/L2wAluJMUnVW+bFDpee76L7PkqUqbTe6ECSyzHuN/lZ0J8gcKPV0YVW3goREMV
 4EYrIafMRquEismlVfpL3TUIenw2sYs7YzV904VdH0x15MA4suCyA37ZEwmTbSP8uGytS8HyvC
 VvppOu4dsGjLmWtssDmR8gcP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 23:20:54 -0800
IronPort-SDR: 3IVNaFBeg7o6MSHxA0uKiCeJkCm6O1LbbmJSUkRe11RQz8f7eACeLfo1pK9QBcztrqKGYqDTfP
 YxXQWMSQQMd6KaeEc77ZdDZbid+Q0b7k//VShIV0qlhbKb5oYYWGEMviZx/VDPg9DU87Ljv21s
 UGLGsHDPKdr5+rDM3PIbiWG/OrsYH400xgEdnEji7LYYGOh+BSzc/LGvtdaYg/3NiErOxqpx/G
 BNBf//MFBQGON4s7Sm3r9pJCN9hGjLuZZsPxGPAiQ9rQjb/0jIz3QYKH/dkhB6xFtGgwdJL7PI
 hBU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2020 23:36:07 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] block: Improve blk_revalidate_disk_zones() checks
Date:   Wed, 11 Nov 2020 16:36:06 +0900
Message-Id: <20201111073606.767757-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improves the checks on the zones of a zoned block device done in
blk_revalidate_disk_zones() by making sure that the device report_zones
method did report at least one zone and that the zones reported exactly
cover the entire disk capacity, that is, that there are no missing zones
at the end of the disk sector range.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
Changes from V1:
* Add checks on the number of zones reported
* Check the reported zone coverage only if zones are successfully
  reported
* Reword the commit message

 block/blk-zoned.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6817a673e5ce..7a68b6e4300c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -508,15 +508,29 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	noio_flag = memalloc_noio_save();
 	ret = disk->fops->report_zones(disk, 0, UINT_MAX,
 				       blk_revalidate_zone_cb, &args);
+	if (!ret) {
+		pr_warn("%s: No zones reported\n", disk->disk_name);
+		ret = -ENODEV;
+	}
 	memalloc_noio_restore(noio_flag);
 
+	/*
+	 * If zones where reported, make sure that the entire disk capacity
+	 * has been checked.
+	 */
+	if (ret > 0 && args.sector != get_capacity(disk)) {
+		pr_warn("%s: Missing zones from sector %llu\n",
+			disk->disk_name, args.sector);
+		ret = -ENODEV;
+	}
+
 	/*
 	 * Install the new bitmaps and update nr_zones only once the queue is
 	 * stopped and all I/Os are completed (i.e. a scheduler is not
 	 * referencing the bitmaps).
 	 */
 	blk_mq_freeze_queue(q);
-	if (ret >= 0) {
+	if (ret > 0) {
 		blk_queue_chunk_sectors(q, args.zone_sectors);
 		q->nr_zones = args.nr_zones;
 		swap(q->seq_zones_wlock, args.seq_zones_wlock);
-- 
2.26.2

