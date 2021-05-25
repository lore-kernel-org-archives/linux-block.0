Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4D0C4707F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4117C6142E
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 21:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhEYV0t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 17:26:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36450 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbhEYV0r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 17:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621977917; x=1653513917;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=bFcRaggZ9tBN12RVTPVwAzImTsSc/VkMzkTVeX3Uo8g=;
  b=HyayAsfXi2EJ+XHR5ykqc/SdLHwKSW3xM645Ah5RW+Z9kJCRGgvFjykW
   gseSApcjol8/HQhDd/nxmLRS0FjYVs9N+taVSV9OKMDALeXNUzFoQ3gK5
   platCEo2MOtoIE7GtLoJ3n8rookhql2yE7D0J9VrPUg8l5U+s+uhpTw8D
   i0VOBqDL4UwWdTdX5QfKndaM2g/fT5uTgMzqZBCeLPQIrqKUurtSUSc2v
   lGBnK0Gs0hZp5slSoK4Nv5YVuSkZMWNp6ARaxNns6EnIJEDBpRnZMDi7h
   74lbF+QhCnwtFsZ0VRgeMtqbwUf1aXuPCemGggXCZRXWk00G5bYmx0tG8
   w==;
IronPort-SDR: 0j8o+QnfmfuARJ3/B1gTKcwDjmkfdLlAqz5IBV/yiq2NrYJdZOL6KN3P6UU6mwcYnW7JyDnJJ7
 aKbaBVOIBKeY7rQXl/96Pc18Qz4BueDAhl9wjk2h9OC3+KnyETCCZy/zzSygnFehsG8+qEwXX8
 fZzbx3xDqTVp8LsR0d1ofhY7RZBkQK05PLxvxqDzKmYdMPE/FkRZgP+tmJSszHD6Tk1goD6ffR
 cjAi6Z1EiZScstKrhOz41XHNnGCIKYefvceGFy8/4LME1AjpMoH8C8wGdMOWMVug/COaenhwBp
 IsM=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; 
   d="scan'208";a="168717550"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 05:25:17 +0800
IronPort-SDR: 1QfQARWClb/cmw6YSKcfDEQ5e4eOMQ25ohk6kmiLsdw/WCiIv5dAcXrz/l0CRabD2qrv9mEvWK
 e9v+RBTSaO8e0qq6dumBMH726z6+dqCy9wr3O9XhIKd32X9y6EB40MwaWxG4jTmNUCfdVGUuoQ
 aY/SFKE8qR3UJ8D2S5jWfVhIPMuGynGbQsWUOcjIYGH92uwPn2VL1+3YZy62XUgPrr7L6Nijp+
 PTXk007YQORBbZRzgDZH1HUFNPUO54ifDShZ/nYzARohE+r3SJxP0IYMsOCaZvZrNxsYszvbUV
 BP3ICFCO3Hy0g2triUJMrH1p
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 14:04:44 -0700
IronPort-SDR: FNmk77p8RaJkKJ4Lf3DM2Ud9DNupkU6U5O1zROkYxyKxSGhxq4OJunGO10+o4L6MuRYtE2H1Fm
 po1vbCpBIFroKqFEYU3NDhTff2xyL58bH+mLvyJ5deJuKcgsD6BBAh8lLqygUWRQlH8k/Cu6yl
 FafTPsK47Kcw2TinMkQH+7J/7/yP8tQe69m71KK4x49inIVgLiBsngobFb6vHGIIibRq+0dC78
 ey/iqrz7U2rHkRpxzRP+MaA9lgOO/OAGdLY3rFFte99MK8UsGuQtYi5VZJKkQdR0wOtAoPsExe
 IUU=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 May 2021 14:25:17 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 11/11] dm crypt: Fix zoned block device support
Date:   Wed, 26 May 2021 06:25:01 +0900
Message-Id: <20210525212501.226888-12-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525212501.226888-1-damien.lemoal@wdc.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
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

