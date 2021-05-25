Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F99C47085
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1946141F
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 02:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhEYC1X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 22:27:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34067 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhEYC1W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 22:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621909553; x=1653445553;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GypGqk+P9NK3nH7MTJFSvTP9WqAa/tRgXSLKL6Mh68I=;
  b=QvKVq+pdc5DDkWmS78hFOS9uMW46UPNrFmlrFe7Tg1GG9dvnScyJVSOA
   cJjTzmea0jt7aBj1ai7WKpfyv0qeBOMWK4mXXY/judp5+Kg8lgbF5Bj0P
   pFiaipBKp9f3DM9+CDQO6mA4cOzTlVnL3PB+qZ98BXpcBRT1pp2Zrvs6p
   HE3fLfZ44p3KsMa9ovdVLSrRFudjNOhZMNn4Wgzvqvt8OyBAfMVbk3aPo
   Y9DRy4iLknu3kqaDxpbEFpfh5Ru8MJia4Ea4yiWVGSH1jTGsVEpnplS9Y
   QbA0tELHAVb55tXoW4yHP70lowezJwcQrD4/MsGh/zPqEt36nfBFkR7gF
   A==;
IronPort-SDR: mH6qnWzLY/nla+tR6P6GNzwr5+xrAinU6WlWuU3w8l82y2XWT+3PMQracnXmE+4l66z7l+v4FL
 smcMx0No7u1QSjsRyg/ZmAeOhsdc0xN3CKPXzjdTXilLf9I9p6d+ONtZNMBopSxoDUmYUnz0g2
 U7EHucRDqtTQ/p2CZd1tgdvvGD1MDyW8zY+BTfIfQ6bkwrtMgMFAxd3fvormLZISQj1dQcB51B
 AHQeLDR7uPMaxMz9LuH4sPmT4a1G3BvH4uC6ckesNWTKOedQTAoerpHYfuD4Mi+1QHyv5AWsMb
 gvQ=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="173981337"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 10:25:53 +0800
IronPort-SDR: qgL7KEJjN2VZe8odUsd5KUbv0Ejp649zkH/xdlBgctL+lGAEqQfO+oW+H+GSNaZhxY+RoCQyur
 bPuLkpohGsm4KxyI2GRbvXHQCsEDiwGMDliFl5ZsRW3D1qb0q2U4DnJYuktaelQaTtH1+BCzP8
 m9wb6+O/5Tfzsu1DwKYTdQxwdquuXW/u6ZL8yRds1lWA6VS4bpP9L7a4rMqP2CrtgUkTEtR6/j
 F+hFFnKdFFSWzJGi6Qr/L95/+XMEZhgzF3raeDkxkaCgsYjiOHB3G2JOAZqM+feAEqCvINCEIv
 A71I+YpJhXGCqSeSSk5M++ef
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:04:08 -0700
IronPort-SDR: oEOKXEdbvYxZSVW+jMMzY8LIseyUt/eSLLs0v9t0+4YtGgwansZMcF2C8yc6LQ48pQlwNRUk3v
 RuLluZ6B8r+AIJ1JZqgIF/zXj0cdQkwDWme2/rKhtFhOVyDOWb1quU3/C/DjrNAxxLkJWgaJsL
 2qFwWwCXJLXv4gYW8RNo84gQufmCV0KqvB3Fu9XYfodwp/joTtnZ2zVaxix3Ih0g+34yYMqNOL
 OrrNKHVzBit8oPIu2OyJ8kJkwijlNwPtqrnMi8Ks/fSbrXaHcV1ZoGnJTFI/d0lFBOG/lPOYUf
 eMc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2021 19:25:52 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 11/11] dm crypt: Fix zoned block device support
Date:   Tue, 25 May 2021 11:25:39 +0900
Message-Id: <20210525022539.119661-12-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525022539.119661-1-damien.lemoal@wdc.com>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
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

