Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDA4C4332F
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 05:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiKHFz7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 00:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiKHFz4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 00:55:56 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3828713F6C
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 21:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667886955; x=1699422955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3yZJ4tehjcS9Lp4+CyZQIBgOYumFf8isDBiTp4IA14E=;
  b=kaRKQGP4FzwmFN3OJElqq3mf0TB8VK3POCie/jCt9cbDTZqsDBmnhTkE
   LERABXELZJMe5Ei3qC99D+Vf8ucPeupsTqgO/ZJUcsIjDxlf7Q5KZ9/7V
   T/C/X5rGQFeMx/ozTaT1QJOT20ur9MzatSWVAU0kCGiIo/WwdlZ/xIT0f
   By9qCP3mcsjZQeblX3FDVa6yuEBQ4zC6QiTdV3ZQoqQd2A0QTA9CnvWYv
   KyKV3tgygoc7Qslt0NAz2TnFZ19lASwncbqD7HQmMKPsQzTFOahErGrPF
   KkAnE3gIh/fg0ZEVlnzORUWbRp72P34+Z2ESnEDo002YzlZlwYKRKYO+3
   A==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="320067458"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 13:55:54 +0800
IronPort-SDR: ZVn4mfZEurbD/YSBkJS4xfHuAXMaJxfNKE/PCoK6Jq8Xf41fG9F+lYsbbfcC+Nm+uGiOW+PPtM
 2iJoE3bKg1ait178zR/zohvqP6eJq6Wbm19QTrazeBaqjzyqKlQHWUw32KQz5ctURzutWVNGgJ
 I6SHeskn07CLnZO8tCy0XNyYOTVQDNpo2Q/qTrtT/82WgbbsRImF0ZLGcbeEZqy33wBkvE09GI
 qTPMowNKTpPp4Xo/s6+GOk5K8UJMS7Nq5xgWA53gVclAVW2e52SMNVtz05yS1nwkq6P4xoXAx0
 o6g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:09:16 -0800
IronPort-SDR: /g/uSUYaDOuK8FTOrYyXO1Agsw8ghsilcy1t1vLMoOS42+qAys8hDMFALjs6pl62f0QQjmNiet
 FaldXJmhsRyd1L3w1xk9wFu+b6Nyw0IK5Dw5PCnmj6Uu39lj/JXFgRsnIxmLXxqEqLHhw86cEm
 vHhXncsuBT0+J/FHUhesmeS1XymyJ68hXdZMmB9a7bYcLaaIwPLpC8JaBZca4XCWL64HRmKPYw
 Ov7yR4w1+lgHxxMPgbnJaFDtkHIcySAxXeYla3UFG9QXaI9RF9Wj+8z5TAFZGw5jVTmNr+q9IE
 occ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:55:55 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5y563c8vz1Rwrq
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 21:55:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667886954; x=1670478955; bh=3yZJ4tehjcS9Lp4+Cy
        ZQIBgOYumFf8isDBiTp4IA14E=; b=QQ2MAL6tk5L3gNK06YKAKPOcDjAyFgTTYU
        nFXlWMENAG7Srlo4DUxm13JyEmfWSGttOVlR/j1oqpgeoacsm2IJbQ4twhaR6M/8
        UGPBIjD1h4+nuKQplYZhdiA5M4JmYIY7oXm3xHSbBWhZ+7zT+VGSSwrWPLMdJW5c
        ZnTLD8l8tADImXm2GxOQAIJh9vbUX9ocWFoGXnOAMf6r7gBwc8N+ZFMtEtPIjdb5
        D9yqE6mcpl7R+lg7rUGJSRJEe+jrdVoW8HAJ0YGsW+q9nlh9/ozngaL4s7ku+2BC
        xJuqGuO9Ybiw+IEaUyeJBAOGwf4u1nKqH0j8Mh3pKE8lcsUNmZPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6YCh6ormGw04 for <linux-block@vger.kernel.org>;
        Mon,  7 Nov 2022 21:55:54 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5y546TBXz1RvTp;
        Mon,  7 Nov 2022 21:55:52 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Date:   Tue,  8 Nov 2022 14:55:42 +0900
Message-Id: <20221108055544.1481583-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a user issues a write command with the FUA bit set for a device with
NCQ support disabled (that is, the device queue depth was set to 1), the
LBA 48 command WRITE DMA FUA EXT must be used. However,
ata_build_rw_tf() ignores this and first tests if LBA 28 can be used
based on the write command sector and number of blocks. That is, for
small FUA writes at low LBAs, ata_rwcmd_protocol() will cause the write
to fail.

Fix this by preventing the use of LBA 28 for any FUA write request.

Given that the WRITE MULTI FUA EXT command is marked as obsolete in the
ATA specification since ACS-3 (published in 2013), remove the
ATA_CMD_WRITE_MULTI_FUA_EXT command from the ata_rw_cmds array.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 30adae16efff..2b66fe529d81 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -552,7 +552,7 @@ static const u8 ata_rw_cmds[] =3D {
 	0,
 	0,
 	0,
-	ATA_CMD_WRITE_MULTI_FUA_EXT,
+	0,
 	/* pio */
 	ATA_CMD_PIO_READ,
 	ATA_CMD_PIO_WRITE,
@@ -727,7 +727,8 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
 	} else if (dev->flags & ATA_DFLAG_LBA) {
 		tf->flags |=3D ATA_TFLAG_LBA;
=20
-		if (lba_28_ok(block, n_block)) {
+		/* We need LBA48 for FUA writes */
+		if (!(tf->flags & ATA_TFLAG_FUA) && lba_28_ok(block, n_block)) {
 			/* use LBA28 */
 			tf->device |=3D (block >> 24) & 0xf;
 		} else if (lba_48_ok(block, n_block)) {
@@ -742,9 +743,10 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 b=
lock, u32 n_block,
 			tf->hob_lbah =3D (block >> 40) & 0xff;
 			tf->hob_lbam =3D (block >> 32) & 0xff;
 			tf->hob_lbal =3D (block >> 24) & 0xff;
-		} else
+		} else {
 			/* request too large even for LBA48 */
 			return -ERANGE;
+		}
=20
 		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
 			return -EINVAL;
--=20
2.38.1

