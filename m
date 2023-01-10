Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51BAC63797
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 13:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjAJN1k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjAJN1V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 08:27:21 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D1F3B3
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673357240; x=1704893240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K+DjrBoMp8r4GmO2ND7jZ/tYn6dWl8LN/Wiw9iXU22w=;
  b=Y+aPc0OFCaikmLqc0nyVjiAg7K38IKvvKGpj4fgOJQ05aidBSf9ESc0v
   RHc+en4kJkuv5PWYJsAXGDp6+bOiJDloUMGBOnHjwJ+eKuatnvj3AXkJ3
   emL6gzHOyJKSPIPmdPjIEK3lrMM1OaM2tTmOMxRaBDEon5EGezmUuH0kq
   BLgfmSyBx/XLgNgeH9em+hnzL4GwmJLa6BxKaXD4ctA6KXFXZT8O9R7OQ
   Y20ltNie4ToUtKKeK9RwpfdRBqyTLeiFR5eK5PzZ1jLrfvTZ+VNM8gMAr
   b0XcyocyIw3Uo8JDfzHiE35kAPcnFpUE8jx8A8s+/wfQUEfmOGsLWCtbk
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324741509"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:27:19 +0800
IronPort-SDR: CELzG8rAedRpPEte8TVThNaqb4OrmnGKSMhXdV2ZTJacYyRBeXiNpbF1caXJXeLTlxjMCO2H1T
 32GMdFrR7MsJ+R8ZtUs2ixrkCuBQgvSGAg5zMtueCy8P41nejm6kwzJdRKGria0Iyd3E9uFt8u
 NycWsdmJz48R8OG3PIA8PcyvkDZza9PL7sg4JYqaGcB2EvvnkCT3lKM3G/EA5OujahskwiGux3
 lFfX6ezrfN/MhHIaYutmqVTxiaJp7+zrVcNvOdw/L9wr+38OGt1VDpkyRk7DxVxu9BdReY3PEw
 yTI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:39:25 -0800
IronPort-SDR: WOc7wsNBHiqrDTM4x0D/chT63zz8MF/+ye2KQ/MgpiJhjatZZyFLvNb7TKFiSDgFGTS9gABFV3
 pDiqdwbKp6X6ab9iGh43YOlZsbNPmmcMY1ya0lwuHktxWCqNXZzUhGNRwVXWIJOvyNaMkpfkCh
 aCJuEFQPGuaNEEV6nU+Jbl6o08YwkYSW+JOWBDaIaqAz2mXn6G4oHHCeRcpLx7vYJoEzitUtYW
 GRmxzA5WqVY/1e7X/2pm/KIXZ4CugggagzalQDJCqNhOggJq4LyGkezaZFyGdc+IACqu9YZVvK
 SwE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:27:20 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrs6v4LBJz1RwtC
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:27:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673357239; x=1675949240; bh=K+DjrBoMp8r4GmO2ND
        7jZ/tYn6dWl8LN/Wiw9iXU22w=; b=D2KotuHLkbPHXUp/pbMm394dfGh5LFGUMP
        94xKBgNFPOzbqXasz3zMTtds4/zESmB7M0NXYJfvy3B/fYCEc5Bt7lQCv5Ia+vTT
        5cxQ7qnUtJ5r2ikrTIkrv3g2PuPcEQqHQt6Km+W/NovVukVOnbfLN9U+g3MUb/6O
        lw2+xjGmEcsz0D3YP5lZplORmgwqrJvR1x1wPJ6RAqIIgD2AHDo6eJmrJ3c1lid/
        t0+EeeK+dYQqkeUGUg6nSdyc5ITaO6TUCtg7deIRC9j5iRNH2CvNlVjQRJFlU/yU
        jsVpvswaTlxPJfAqdal8S9J9W2SDzg2DivJwZlDboX/icWc9blpg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MHgl2rpKfZ_6 for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 05:27:19 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrs6t1GrTz1RvTp;
        Tue, 10 Jan 2023 05:27:17 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 5/6] ata: libata: Fix FUA handling in ata_build_rw_tf()
Date:   Tue, 10 Jan 2023 22:27:09 +0900
Message-Id: <20230110132710.252015-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
References: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
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

