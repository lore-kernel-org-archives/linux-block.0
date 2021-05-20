Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE48EC433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FAD4611BD
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 04:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhETEYD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 00:24:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63405 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhETEYD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 00:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621484562; x=1653020562;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=BAURSxmhtP/eUdL/GC1yQw7Mcrh5EWOqnnX0mGjtPdQ=;
  b=d2Tt1COOzOJE4LeyPk/Ce8Ax2NnAde2uayahVHF05e2v5ULEceP2Xmrw
   zaL6ft+hfezlK0U1V9ES+WlBdEk0UbUEUb+lftchK1K2vVP9DTAh+g+el
   bF2UtAV2mJeZnqIBawH2sT+H1q2vtD/sw1XrNXGLofF8QU5o+yKJKzWlD
   eKqQXOEpwtJJ9OkhIiaMSpUk78+6++shb0Jrazo6qdj/uTPZCtF2Ktm61
   qmkt48WUNbXRHpFKtLSx7pc1r3UYY28sAXnRVBY2rLnv8nrcvUQBPQpo8
   RaI/o17nSmUFlG28mksnMC8yAedNlsQfpA4Vc2bSg70vSV9p0iaP2mCZi
   Q==;
IronPort-SDR: slJhnKjnbND22Rd7rtMUZzkqRMH711+hF6y837ZphoaaODYnCTfdC4ydgYVDEwKbnR9M0FqhTV
 5W7XcYS83DNh8Jos68xVXJF4SvYZf9Bqy+q7liPpgQ3yA0OJMTBvGZ3V6LWsJUbmSmr4jfCbLk
 UrLbrlpmK1PzKW+DPvf77GzSw11rlbHkKmovvZZL7m2Q5NU2zrvrZoI8blqCbfP5xthjBqHpSY
 /4dEa/pS3CN/qRSVTAjWlxFqpdIqVDLLBnpxMHSWBaA+6KN4U1yx72xW28gLSCJOMFrOFkTUww
 lAI=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168105853"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 12:22:42 +0800
IronPort-SDR: Jaw5uw8ORAYd3tY9zXOzguLmc8G1J0kyi3h58ajGvzirG6gZejT8AtrUyaqXvbwYfZhacI4E2m
 l2SBZBsqRRczlpDNhyMtq0rlsH8WZ/P54aDxe46J+0D+PRZ1IZFf6abiFw8h1N3BUIdmY/gXt/
 bUHObUP6W0sRwWNHtHGrSQPV+wnahn7tUYn2mOifbHPFJGr5A4D198V/KLjpWwasZv47muVYIT
 NV0t0KwdQAcjxqSrcj1HFG4uYP8fh660Evp3RkHMP8kU/l6/jWorSt8qGSK4HqyEbjcjudfr+n
 BNMTpflvv7Ua5mNklsQR0hEI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 21:02:19 -0700
IronPort-SDR: uIEnt6j+SWWkCs8OnuX2F4ckxYIIbMDwF+h1O/e2ATFkGGhNDagi5H+9hnLbov9gRoM/vexk4M
 1VLze6v9TC2z5KsIFLIRgeJEgJZ4nthJn/T+LkLFh3Gp63losI3oC6aR4X0+uLK8bneewub9Mk
 O1c/VFTLphVK1QZbQRk+oUVFkJ7AHjoI5ORxCgkr7rN9mMU4rKxL70XJJKysuahRRby9XP1tM0
 Zj195sPrd9sYOwQ9p0Tn+fE6mpKDv7ygvIeptLnzXej/Hyyuk6qarV/r+xh1BLlDZweWrNZ+0o
 fkY=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 May 2021 21:22:41 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 11/11] dm crypt: Fix zoned block device support
Date:   Thu, 20 May 2021 13:22:28 +0900
Message-Id: <20210520042228.974083-12-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520042228.974083-1-damien.lemoal@wdc.com>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Zone append BIOs (REQ_OP_ZONE_APPEND) always specify the start sector
of the zone to be written instead of the actual sector location to
write. The write location is determined by the device and returned to
the host upon completion of the operation. This interface, while simple
and efficient for writing into sequential zones of a zoned block
device, is incompatible with the use of sector values to calculate a
cypher block IV. All data written in a zone end up using the same IV
values corresponding to the first sectors of the zone, but read
operation will specify any sector within the zone resulting in an IV
mismatch between encryption and decryption.

To solve this problem, report to DM core that zone append operations are
not supported. This result in the zone append operations being emulated
using regular write operations.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm-crypt.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index f410ceee51d7..50f4cbd600d5 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3280,14 +3280,28 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 	cc->start = tmpll;
 
-	/*
-	 * For zoned block devices, we need to preserve the issuer write
-	 * ordering. To do so, disable write workqueues and force inline
-	 * encryption completion.
-	 */
 	if (bdev_is_zoned(cc->dev->bdev)) {
+		/*
+		 * For zoned block devices, we need to preserve the issuer write
+		 * ordering. To do so, disable write workqueues and force inline
+		 * encryption completion.
+		 */
 		set_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);
 		set_bit(DM_CRYPT_WRITE_INLINE, &cc->flags);
+
+		/*
+		 * All zone append writes to a zone of a zoned block device will
+		 * have the same BIO sector, the start of the zone. When the
+		 * cypher IV mode uses sector values, all data targeting a
+		 * zone will be encrypted using the first sector numbers of the
+		 * zone. This will not result in write errors but will
+		 * cause most reads to fail as reads will use the sector values
+		 * for the actual data locations, resulting in IV mismatch.
+		 * To avoid this problem, ask DM core to emulate zone append
+		 * operations with regular writes.
+		 */
+		DMDEBUG("Zone append operations will be emulated");
+		ti->emulate_zone_append = true;
 	}
 
 	if (crypt_integrity_aead(cc) || cc->integrity_iv_size) {
-- 
2.31.1

