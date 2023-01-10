Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E536C67871
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 13:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbjAJNPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbjAJNPP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:15 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAA244C6B
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356513; x=1704892513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K+DjrBoMp8r4GmO2ND7jZ/tYn6dWl8LN/Wiw9iXU22w=;
  b=cFUEdVD19WWFLvSpN+ZdWIinv2bKpGmcf1EgrYdGg4mJEFhJBnypaR2E
   1CxpdoKhWjKOPPnfTUDpqtFdmW4aabNvRuamHbiy8uCVu74FrOQEYup+H
   ye1/WrIQjbrGlpIj5Q4hS1iODdXO3EAfGK4rdBNVbeIqiK1OTlX59JBTN
   bMR3snwi1x6LG3rBdpKXTqKJR3mYbr0BtsPpeOkadoZ8YW5kTyq97mZfq
   8BDs3h3SjmicfuIvGdvqD4jBUtnCeojiOw3rHh2NvoLqt8RnTxbKfPOsy
   DcNsNF53gaZA11JSNSpINTRanMdCXq7jTqt4+Fojn+E/JALOhrdAMv+U6
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324740900"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:15:12 +0800
IronPort-SDR: EYktQLdZ7q+UrQNyZrlamWkEab5HSEOkbsPjAve8/OIDZ/+ArtELv2sCOvzv3g9mf7zzFCw5Ci
 Y+zgAqtZ6/fI00KJDF0j4apy5ZSgPu6g1eyKBgPlWuVZ2WVxQHZls7y5VMnU6ZBftpdR/CFKRW
 sJCjp8duek6r5SsUi4y17tNbDir2Yaoucb1mDnScfZrZzVR5g/KR4U1P/n5GXSxLk9Fgq7Ce4z
 thi3IatBpPg6d54Qz9gB5C4ewTAUpNx8720svdPErYk2zjj9B7QteSOQMEB6XYbgUgXlTS3VLW
 N2c=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:27:17 -0800
IronPort-SDR: izoYCNyJh8qg3qFZ8aXsb8qOYJ9/vL53h3dlDb0v0rWnhfaJOG89q2hC3unhNKp2W6H+agJJbB
 cwl53fe1yL5gwy9rSTxbOdUYagJFyTTGmd22h82BwA8a62UXMLFa2brknkuKMVjmaywZM/G2fK
 gOh5BLrjQ1kMvYO+uEz+VITEYtli9j9gJIQLTfoa7an7PwkYQmvsbhLlCuo3ICyPH3O2U5a6cR
 dQzYzo7aXaCaN4+9Q1Bvro2yosm8fLfek3dOXPHwS5OPMmfWTblBLSl4X9xx0GCApR/jZ5n9pk
 6/k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:15:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrrrw193Cz1Rwt8
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:15:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356511; x=1675948512; bh=K+DjrBoMp8r4GmO2ND
        7jZ/tYn6dWl8LN/Wiw9iXU22w=; b=VS/YA3zsPC6bO1OTx1gumSfe9r2u3EDVh/
        I6HmKPuODGnKnIvxq1YWaeNmZ4Cj5KCFIRmpBr2p5kJDHpospZOXjFJ11tX3yqpl
        +gUOO+o/isvEv9UuJFk1BOoGKGemhVCrQVK2QLF7MATrhVeGyQB8N0Lq1eS95s+/
        +IBb9OTM4MuE3zyd1oBKBsc3xx/7bivwv6v9SPLWM/R2vScp2bUMDdZyS9j9gaID
        OuEdlCYoev6TEgevNcb0tWKw3r6aW/TATI0bVU2Wn/icFhRIIDMpyc7Ml8XGuGqj
        FhQPb8FOQl0X122D07LhgUShlCNgKzF97etBSFIYBB9xqk8UY9Sw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cOdhXTyWZiZf for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 05:15:11 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrrrt50pbz1RvTr;
        Tue, 10 Jan 2023 05:15:10 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 5/6] ata: libata: Fix FUA handling in ata_build_rw_tf()
Date:   Tue, 10 Jan 2023 22:15:02 +0900
Message-Id: <20230110131503.251712-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
References: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d25a53a873dc..ac88376f095a 100644
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
2.39.0

