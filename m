Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61684C433E2
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 06:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384612080C
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 06:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kYzk06v2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgFSG7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:59:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63738 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgFSG7g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 02:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592549977; x=1624085977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gx0Iq9e9VocHd+np5kSuBgMyah2e2tIngt017f1yHjk=;
  b=kYzk06v2cAfmMcM6mtg+jKOsbsYP9YRMgvmjeNsvuZFQCMxwszgOyDuJ
   ahrymu7wRkN2OQht6qByUz/K558g9LiN4KBurnZjtJbwm2LnoYuvJdhnV
   OaCXm1WH8rBLWemZ6got7/qUcN32jJ8fLeNqXNF2peDtAMgm1QEtge5jV
   OFQl4Vlab4jvT0Jii8R1f93/u2GQXPBYFfHIYG2BpS2RDJsQ6xMS7YYKw
   3ed8iPqGRnf4/KuR7P8Fz4FTVF+FdUdJHVON6nxNf519giV9gBO9oyR1v
   4m5eqXd3OuYyExXdCEDg0Azvtc5HxY5Fwqvnx5X31eGIL3AJrY5uw7nUS
   g==;
IronPort-SDR: LpcsiLozevh1eONnFkpA21U9Am+oZYk+ugciLcs3HVpi2Wn+szS3dQaKb1w1Yw1wPTJezC065C
 k4/I3Xgo9l7MQlNQrSOtvNXeQlpC7j/BZlp1apPcmB57NNoZU13emZAxZLCjylF2XhLeB9TcOL
 99jW18OaPB5c+PvTtuY/E4ge/G6rOdkWjoJ2vLmjrD1AAsDx8zgx6495s9xznDsl11bzDmyQ/W
 UGOi96mr1MuQaRl+Tju+3xpEAskBAwok3Im0nzm511vb8v80ElwaDGwO7abWtJbLWcjw6+Jrc+
 Hu4=
X-IronPort-AV: E=Sophos;i="5.75,254,1589212800"; 
   d="scan'208";a="144725646"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:59:37 +0800
IronPort-SDR: GUScsKxh6cT/aZWNwbAOgDcKjdegBkvYA7cN1luxF87lMsswGdR7GO3cKPxi8ypu3ThJMuTh/j
 daY2PYnSg7xVB9NAfo0Seg5M6VKAzhWCE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 23:48:47 -0700
IronPort-SDR: 4dy8/kN3qrCG6mS0UpGTc1PHUIiEhq6DN/I9DlHGP1GBNYFhF6BihxpavInPBmGrJjdTNTjYVS
 DWb+RkHuV2Og==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Jun 2020 23:59:35 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] dm: update original bio sector on Zone Append
Date:   Fri, 19 Jun 2020 15:59:04 +0900
Message-Id: <20200619065905.22228-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619065905.22228-1-johannes.thumshirn@wdc.com>
References: <20200619065905.22228-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Naohiro reported that issuing zone-append bios to a zoned block device
underneath a dm-linear device does not work as expected.

This because we forgot to reverse-map the sector the device wrote to the
original bio.

For zone-append bios, get the offset in the zone of the written sector
from the clone bio and add that to the original bio's sector position.

Reported-by: Naohiro Aota <Naohiro.Aota@wdc.com>
Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 109e81f33edb..058c34abe9d1 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1009,6 +1009,7 @@ static void clone_endio(struct bio *bio)
 	struct dm_io *io = tio->io;
 	struct mapped_device *md = tio->io->md;
 	dm_endio_fn endio = tio->ti->type->end_io;
+	struct bio *orig_bio = io->orig_bio;
 
 	if (unlikely(error == BLK_STS_TARGET) && md->type != DM_TYPE_NVME_BIO_BASED) {
 		if (bio_op(bio) == REQ_OP_DISCARD &&
@@ -1022,6 +1023,18 @@ static void clone_endio(struct bio *bio)
 			disable_write_zeroes(md);
 	}
 
+	/*
+	 * for zone-append bios get offset in zone of the written sector and add
+	 * that to the original bio sector pos.
+	 */
+	if (bio_op(orig_bio) == REQ_OP_ZONE_APPEND) {
+		sector_t written_sector = bio->bi_iter.bi_sector;
+		struct request_queue *q = orig_bio->bi_disk->queue;
+		u64 mask = (u64)blk_queue_zone_sectors(q) - 1;
+
+		orig_bio->bi_iter.bi_sector += written_sector & mask;
+	}
+
 	if (endio) {
 		int r = endio(tio->ti, bio, &error);
 		switch (r) {
-- 
2.26.2

