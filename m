Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95445C54EBC
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 13:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbjAJNPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbjAJNPK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:10 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B08043A02
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356508; x=1704892508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R873OM2Ku7NzjIV4vPevY+ELpWrUMJedKCQYFLdggVk=;
  b=iUM0zcCN/Pn6SeTlePtBptQ5VsIIjzGVfUrhQzZFOenmvVXHIodoUo6H
   1eFj6INo6/Dxg62+onuUAMqSmEwab4cVoBDo1kzM33mPhJLuTlpFKZr+i
   EPMhg8CyV5WVflTEcZURuoarge1G9ydvQJufPerrmlf52/Qhc0QtJiCnO
   i1XrMtd3PzxnR3B5HUaqeKLr/BHKj7VaMYckRg0qZvKmSX2LzVkVYjEqT
   MYdJ+U9cX/m1SQ4CoX+oDoon1w4z9441QIDWL68cumFmotSdI/JiOE4U1
   kJhzd8HTCXqJJKfpC2P6nXp9INS7KjuwjcHz/tTgIFl8ge3nMFLig+5dY
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="332448515"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:15:07 +0800
IronPort-SDR: YKXRPA1wWnjUnc+nugxCm3feEO7N9y+X5oYCAq7PUayXnWfINMxm9uwdsC1+Mzh8nMp00X6xlv
 Sohy93gYaqh8y5LoqHcvn6IvaaM17KFNGqbThpsa2j3u7RWZyc+WIurv5cJ1vEO58O6qHkFmEU
 AqCQBLprqJYF44S9kCIbhv3DAkD0lphbyj0Es8ukbbNiA1TBfL1RcX/844QpDIf1VtuhLJaMPA
 6TW0M1N6rflDd7tWOQ5kJxt+88k8TwwQG0jKqnB05qWDUZgjDwH9TNGwPESUts6fwy0280hXsK
 G84=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:27:13 -0800
IronPort-SDR: dVOrbNBMzuljmrC0GRv+d1GU+5Aer/3ruIpvjyqmAtDK8l+Cbm+BhyscOqWfA+tDhOq+vugM33
 HKMZJIiVA9q74eup62/SMpL0B/NbpZy0GKD/AtA20CJEo52QbqJSCQYToPvminnVM7+KX5TLnP
 c3DeLdZzu9cd5EobZnYxKv7QNCt24Dthsfdbdo1E6bg4WkpXKtqsUnWrQ6O5M/rWBquy0rQZBB
 psEKqJyaLulvVg9zvH0Mc+5J3Q0h7mpmDiW7WXE7bZMGX7jTwCON8IO3oI0n4KZ8PnqHiP3QnR
 vXM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:15:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrrrq2hTwz1Rwt8
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:15:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356506; x=1675948507; bh=R873OM2Ku7NzjIV4vP
        evY+ELpWrUMJedKCQYFLdggVk=; b=fRYATrjqhGCPOlTpKcTI1UA+B88729kzk/
        KqQLV9weSPXsWm/3E+o0aXWKaQsduikm9fKn6slVbRWe59FhA4osdyCJwBO9DJpU
        sCc7gbfGVAYnhpaBNYbN+/+FtDspSmt4hxtXx9GXE6dzieavy0Qy2JebFY9ZYlQk
        cC474WHVoEPkdc3vvXUP6i6LcILDWTLWrQild3LYQaNZzy60CsaTGgNHpmPkuaAZ
        2jQw+7zJqwgRSHfXfT7wBEG+l6JgUuyhaS0GfcroaaGLJZtZhHWkGjUv9yPY8xSr
        Hk/RB8c5XcZdLAEmhm3BYwgB/Xa7WNvS1Z50GCfeSoQdGcyWdovw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5juotUv_9ULq for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 05:15:06 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrrrp0FYNz1RvTp;
        Tue, 10 Jan 2023 05:15:05 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 1/6] block: add a sanity check for non-write flush/fua bios
Date:   Tue, 10 Jan 2023 22:14:58 +0900
Message-Id: <20230110131503.251712-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
References: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>

Check that the PREFUSH and FUA flags are only set on write bios,
given that the flush state machine expects that.

[Damien] The check is also extended to REQ_OP_ZONE_APPEND operations as
these are data write operations used by btrfs and zonefs and may also
have the REQ_FUA bit set.

Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/blk-core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9321767470dc..c644aac498ef 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -744,12 +744,16 @@ void submit_bio_noacct(struct bio *bio)
 	 * Filter flush bio's early so that bio based drivers without flush
 	 * support don't have to worry about them.
 	 */
-	if (op_is_flush(bio->bi_opf) &&
-	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
-		bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
-		if (!bio_sectors(bio)) {
-			status =3D BLK_STS_OK;
+	if (op_is_flush(bio->bi_opf)) {
+		if (WARN_ON_ONCE(bio_op(bio) !=3D REQ_OP_WRITE &&
+				 bio_op(bio) !=3D REQ_OP_ZONE_APPEND))
 			goto end_io;
+		if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
+			bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
+			if (!bio_sectors(bio)) {
+				status =3D BLK_STS_OK;
+				goto end_io;
+			}
 		}
 	}
=20
--=20
2.39.0

