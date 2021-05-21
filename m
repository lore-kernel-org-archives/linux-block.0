Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3A2C433ED
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531256108C
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 03:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbhEUDC7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 23:02:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25389 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbhEUDC7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 23:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621566097; x=1653102097;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GypGqk+P9NK3nH7MTJFSvTP9WqAa/tRgXSLKL6Mh68I=;
  b=pQSA/CdMdfHIQScOjykahusY9csSmKS/XskHLMn1JoGYiGVWz6/7Jd5P
   1iRK7uqZe+KA+eNVu1PZFzNi9KrvJXY9jo/ZaLIQEXm4UhFZCozKeJwO2
   6izUsMYfld1AvPHcB9GgbpcBCO0hUoGGIbLJRRM2tDS7Y21cJU0o98VAu
   d8XsUrF4GtUHtNy3iBwONrsp+h31ZIWgchLCZ+bDT9nsjIhKWWiaA26Oj
   2al9TU7x7NWgZWnxI6HjnDdj06M7MPe/AQd1O3qoX7ffjaUeUgyWrCkRA
   OwMjn1j2UMxQrXLpYGJfAotn3ofDtOfDuSdIWmRwjI2nD29ESmjFXGIdl
   w==;
IronPort-SDR: EYyESBhykEsE/s5gaJwKkExZhgDnzNXpbZQVF8TzOcU2N0Ua37NFfiydN/62A+ZZXiokgUmVot
 mJGSpWrNeYcBYKWJD1HRbnBOdvfWoLqOlJEV1PW8qeI1gR3SAe1pcm8APeLGgNDqfc/wuEyKMD
 QvbtoDlZeJqDpQTFgJ/R/Qm8lauhrml4FQEVWeXslJfnzkHkssV1wxzNj2k0b7RIzezeTlbEOI
 K5dUqdZHvajOaFXmANUJnzhuBkzVyo0e5fPBpoHweqeizDTIl3IAR76vhAB5lJa31U/Jh52udi
 QQ8=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168943921"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 11:01:37 +0800
IronPort-SDR: 4SI7H2n2jZZeAGkcAdqK5SdlYBBd7wZ5IOfaK2NAXbzqGkD6d1I/Uz3Db4aR2/P4hsnL/sBmdV
 HhQ+9su6sO759RZlcByVkmFfocnpo6OC5dEsxWKGyDKbI5KIotzO9Vm5NakAZ1OSdzTINIZo0b
 co1ZtHoGAK06xFxSfI39hGIBmM8I96Lirikm4EnbHExJpX90EwbZnVwnfosYhmCh749nCMiEa3
 U+1lTvGCWSW51y2RuNU3MXusGU8u8h47KbD1kzKzR+Afc0mxiwElXTmLUQaQ7rEazy8xKN4yb1
 6vfejEoY+JY9jEO4GOrd24+C
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:41:13 -0700
IronPort-SDR: Zn2PPmc/iCohYVwADqN/1taYAjbCyo5RH1HgFYMvsiahQov8RWWTIKcCbOwB4ANUohJhTysDXW
 YPi/MxU7ElIUYU4IyK9OAb62hxbGbefiXAGBqcNn4lr/E6Oaxw7lzGUeTbptAcVYwe2ViEsac+
 JNlDJsrTe7OAtcxNheVUFIVQdwldEnaRHanIquiY8xCJO1UpztxVQ+KbL4d5hpbPImm5ElOn27
 5ocHdDWDy8BU32hnNS5OCre9z3wYMvll+jmvaKXknL4OqNej1ql1gSI5CfQ/N1qM2fzb2otzJH
 d5Q=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 20:01:36 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 11/11] dm crypt: Fix zoned block device support
Date:   Fri, 21 May 2021 12:01:19 +0900
Message-Id: <20210521030119.1209035-12-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521030119.1209035-1-damien.lemoal@wdc.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
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

