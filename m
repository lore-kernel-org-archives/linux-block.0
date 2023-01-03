Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D97C54EBF
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 05:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjACFWY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 00:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjACFVq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 00:21:46 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E44AE44
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 21:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672723172; x=1704259172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qjsfBZV8/cYQenaf4a1MT8cE4OdYyuK9gJVyVtAGJMQ=;
  b=K6FMRHU+qzm3ut4jUcsJq8bQsKrX4AEH96MmKx3fBw6HJH1hfMM5BZl8
   vbhtEWFcO8gAd7lv6bUFweuMIpKcPwI/wlioELkIsZ/hBfvEVuWwTNF4H
   3FqSh/eVkiGbJTKAg0N2DuKxFjFLXU1YE7GK83w3knvT9RTGLIgvpUMuQ
   v4cwt31S59Fit7EfgkI1ARui8d+esLutK6uewthq0YhkAvyM3hXNCZmrc
   81FlurJzP/6ZbaRekCwJQ3Xo/urIjRf8wcL5j4zc8VLTEb/mfrITnRLSK
   KsZkY+oj4Z4GfVB9sx+u2CmQzxMgUTfjNRbfDUCe/SUBuWOq1qAgvTzM/
   w==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="218126864"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 13:19:32 +0800
IronPort-SDR: xRRTZBW46iXkA22HL7D5yZxjEdtlTZPthodVa8wY2b72x0d6+9DF5pCuKhznBp9gt2xyOXxlj6
 9jsf0Sf5HNzPiF/qtamrLnX0BIInXE3v0YyOd/N3sI7969D+A8MHaobidXoKhrBe1I7gaV0c6a
 bJ5TtwZO9LGfODXs5/W/OfjF4k6C+XHCjPBc8ylo6EWoMi4HdELYKHrLGTRKs7bHQCD+xSYFp+
 kp0oTZ4J4KWghWy1197MPmVjn1Fv/56sSA5pe1zogyGltD2YP3h6RMhqXCvqz9B0OI9Ht/T8dU
 4fY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 20:37:30 -0800
IronPort-SDR: ee8H2kHEisOme4vnaYiNhWrAZ70ksx1vqtFBQfCTzFtzkkbctBAwcDL/9x1UWMlUAPQ5UYLB4z
 DBhkz/28eX24LcBkiywmHxhQwnSqx9j6V17QUqppfefQJA4zjb9W0iObOlaaBq4vwT+dFM3mGK
 7pBBmJLcOvoOGUwYEhLEP1n/9tM8EGz2VQn676R8A2U8H00fS1snXk91Oje8blDUN8eF6tYP7w
 kDmgJkM1jBXTm1xTk6yE+nz6vBgEkcUZ6GuAZcoFMy7rYBMq+cjcPz9RgsVu8Ntt2qYuh+ezDX
 dxo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 21:19:33 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmLdJ1YVMz1RwqL
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 21:19:32 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1672723171; x=1675315172; bh=qjsfBZV8/cYQenaf4a
        1MT8cE4OdYyuK9gJVyVtAGJMQ=; b=gxNzoNBobFmA8AcjetYDO3FgL0ug2WYlXF
        qaKZnGS8C6h28X5QYkuSkt4dNITloAzyy/4jAuFPdkkq4edG12ZBRbAOhBD/QjWZ
        XA+vlxEdMFfXYQ4h02q5t/zw0ecP6HKYftyNtVpQ84nxSCMESi2EY644tI7lINJM
        OywaN9v13rRt0Cp7pdfJPcSRwOyZNYAij1wUIDQvpYerpuYQp7ntMR9EFXzoYy0w
        eTByQNw9u5G0DrQQhQC14U4BOOlYOwI8Rlac3fuhFmB0ET8Zktz3jmzz6PCAXIaB
        I6RFYCnukDR45L+3q8k73ybupVpW8oVEjhb/dpqHcjrNL7On7+Vg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Awj8Rfdk-IRz for <linux-block@vger.kernel.org>;
        Mon,  2 Jan 2023 21:19:31 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmLdG420Dz1RvTp;
        Mon,  2 Jan 2023 21:19:30 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v7 3/7] ata: libata: Rename and cleanup ata_rwcmd_protocol()
Date:   Tue,  3 Jan 2023 14:19:20 +0900
Message-Id: <20230103051924.233796-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rename ata_rwcmd_protocol() to ata_set_rwcmd_protocol() to better
reflect the fact that this function sets a task file command and
protocol. The arguments order is also reversed and the function return
type changed to a bool to indicate if the command and protocol were set
correctly (instead of returning a completely arbitrary "-1" value.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 884ae73b11ea..6ee1cbac3ab0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -574,17 +574,18 @@ static const u8 ata_rw_cmds[] =3D {
 };
=20
 /**
- *	ata_rwcmd_protocol - set taskfile r/w commands and protocol
- *	@tf: command to examine and configure
- *	@dev: device tf belongs to
+ *	ata_set_rwcmd_protocol - set taskfile r/w command and protocol
+ *	@dev: target device for the taskfile
+ *	@tf: taskfile to examine and configure
  *
- *	Examine the device configuration and tf->flags to calculate
- *	the proper read/write commands and protocol to use.
+ *	Examine the device configuration and tf->flags to determine
+ *	the proper read/write command and protocol to use for @tf.
  *
  *	LOCKING:
  *	caller.
  */
-static int ata_rwcmd_protocol(struct ata_taskfile *tf, struct ata_device=
 *dev)
+static bool ata_set_rwcmd_protocol(struct ata_device *dev,
+				   struct ata_taskfile *tf)
 {
 	u8 cmd;
=20
@@ -607,11 +608,12 @@ static int ata_rwcmd_protocol(struct ata_taskfile *=
tf, struct ata_device *dev)
 	}
=20
 	cmd =3D ata_rw_cmds[index + fua + lba48 + write];
-	if (cmd) {
-		tf->command =3D cmd;
-		return 0;
-	}
-	return -1;
+	if (!cmd)
+		return false;
+
+	tf->command =3D cmd;
+
+	return true;
 }
=20
 /**
@@ -744,7 +746,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
 			/* request too large even for LBA48 */
 			return -ERANGE;
=20
-		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
+		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
 			return -EINVAL;
=20
 		tf->nsect =3D n_block & 0xff;
@@ -762,7 +764,7 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
 		if (!lba_28_ok(block, n_block))
 			return -ERANGE;
=20
-		if (unlikely(ata_rwcmd_protocol(tf, dev) < 0))
+		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
 			return -EINVAL;
=20
 		/* Convert LBA to CHS */
--=20
2.39.0

