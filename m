Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173B1FA3746
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 02:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJaC1B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJaC07 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 22:26:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01E4B862
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667183217; x=1698719217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7TWEQQgjvLoQtW5Au9ZtMp+aKDP51r+1N5Z2PbiA6mU=;
  b=pPzixvd8XXKu6yvpqsK/74EUPeTUUmfuqu7MP+pGeATv15g7WvOWrem7
   y+N/YC0x8EwhZW9XaQGinHvlzPeuNqwRU6yDHzN2FZLmFctwHVAOWUHtf
   tsnf8V6Ez30u5fywuE1POEhNvmF2oOsREGpekalxiTg9GjTcBsOHEGeFH
   H4W3LvcwqBsLMJZD9wV0VJAgU4QahWcMUWVNz/5C0gkhYeeAH8rqve8aQ
   O/boOxSHYBaZvCHxR5frXLn2mU8xzHX4VGo86pWx24NCaJnY5K60sYbgn
   r6ndiA0wCflupYjXub0LvldthSe8tJ8EcbzsSw6Oa+ycgUQHW4tJT0ik9
   w==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="215446865"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 10:26:57 +0800
IronPort-SDR: FH2zjlI309hzqJ827JeCIFwOMHyQLDSHtScO9LPp8JyYjWm+aL5e7iGN9rQHlSNr/6gaeOdDRb
 A9xLh+RoslWC7rx6aejvvOrwvG8oI0wwe+slKbZVuu83fBnwlOMUFluw6HkDYpiBOj+tRUf1EE
 nQ2jLVD3ct1UjUAyoLwzAMXXncbEhJ2/skMoXvZPgu+FkCDSp553U7Za9tWfgGjTJMLD4C5+3b
 8TUwBUr0zroswoKV7u+qkDOrDJqiRCrVOf0SoGIAadltebef4SwSeALW5PbjRrXD7c2QYddTjQ
 1BSKImTeNvZNdGnf37J0VOI5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:46:13 -0700
IronPort-SDR: unA5p6TMzhkVvXdctUUhc/2or2PgjoA2hfhrl5gF9H8tHzg6QGnNqxPakNEG5pHlwQPLNxfI3A
 EFbzDDmyI5VSU59KuOSeSuu18kDFzu43WVx1H29j/wMdh5BVk5150vx2IGfzD3l7Zt35kRxDxt
 7/D6u5xcQXfnjtX2cBmuY2vnVnC5IfOdEuQQEWd/UXJr5AIsl2eijPCElpc5PcxT7bHStI1+Ya
 pM41gqkN96Rn0KKhgoxWrdmjExf0KF2eD0P7TlG9v24zKbgLIy4l/yYkbBwu9Lvk84aBDoQkuZ
 wSg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:26:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0xqj24RTz1Rwrq
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 19:26:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667183216; x=1669775217; bh=7TWEQQgjvLoQtW5Au9
        ZtMp+aKDP51r+1N5Z2PbiA6mU=; b=XZjm4jaxWp8gvIG8AQZhsKvBR5uDBxd4mU
        6t++o3JRcDucNfW8Y2sXmnBK3eZH3aKGQiLy4h7AhZeVfef86WNjMX5WW02GD8g3
        foV4N5GEQFPpw6zytFPvMWL5ng9XLyDBTXrFPTdl/G1BpJNUxu7lfcRS7Q8kb2eK
        Ba0CUV29pgC/r6XFJGms52L6qMns7UuN6Y3AfWbQ+jvweX//4er7t/jY2fyfQ7+d
        gQgDSorwMBsoD8MgNl6oqJfyY7oIDGvrN3eQoXtp7a5AR814QshE9sgUULbTSM8C
        up7xyQuEYIwg4J+lq/a2NLe8GxV+KC+DvW2CY8po8hn8n8jgzbMw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Th1zZPaCPQlm for <linux-block@vger.kernel.org>;
        Sun, 30 Oct 2022 19:26:56 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0xqg0HdZz1RvTp;
        Sun, 30 Oct 2022 19:26:54 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 4/7] ata: libata: cleanup fua support detection
Date:   Mon, 31 Oct 2022 11:26:39 +0900
Message-Id: <20221031022642.352794-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move the detection of a device FUA support from
ata_scsiop_mode_sense()/ata_dev_supports_fua() to device scan time in
ata_dev_configure().

The function ata_dev_config_fua() is introduced to detect if a device
supports FUA and this support is indicated using the new device flag
ATA_DFLAG_FUA.

In order to blacklist known buggy devices, the horkage flag
ATA_HORKAGE_NO_FUA is introduced. Similarly to other horkage flags, the
libata.force=3D arguments "fua" and "nofua" are also introduced to allow
a user to control this horkage flag through the "force" libata
module parameter.

The ATA_DFLAG_FUA device flag is set only and only if all the following
conditions are met:
* libata.fua module parameter is set to 1
* The device supports the WRITE DMA FUA EXT command,
* The device is not marked with the ATA_HORKAGE_NO_FUA flag, either from
  the blacklist or set by the user with libata.force=3Dnofua
* The device supports NCQ (while this is not mandated by the standards,
  this restriction is introduced to avoid problems with older non-NCQ
  devices).

Enabling or diabling libata FUA support for all devices can now also be
done using the "force=3D[no]fua" module parameter when libata.fua is set
to 1.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 .../admin-guide/kernel-parameters.txt         |  3 ++
 drivers/ata/libata-core.c                     | 30 ++++++++++++++++++-
 drivers/ata/libata-scsi.c                     | 30 ++-----------------
 include/linux/libata.h                        |  8 +++--
 4 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index a465d5242774..f9724642c703 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2786,6 +2786,9 @@
 			* [no]setxfer: Indicate if transfer speed mode setting
 			  should be skipped.
=20
+			* [no]fua: Disable or enable FUA (Force Unit Access)
+			  support for devices supporting this feature.
+
 			* dump_id: Dump IDENTIFY data.
=20
 			* disable: Disable this device.
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6ee1cbac3ab0..30adae16efff 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2422,6 +2422,28 @@ static void ata_dev_config_chs(struct ata_device *=
dev)
 			     dev->heads, dev->sectors);
 }
=20
+static void ata_dev_config_fua(struct ata_device *dev)
+{
+	/* Ignore FUA support if its use is disabled globally */
+	if (!libata_fua)
+		goto nofua;
+
+	/* Ignore devices without support for WRITE DMA FUA EXT */
+	if (!(dev->flags & ATA_DFLAG_LBA48) || !ata_id_has_fua(dev->id))
+		goto nofua;
+
+	/* Ignore known bad devices and devices that lack NCQ support */
+	if (!ata_ncq_supported(dev) || (dev->horkage & ATA_HORKAGE_NO_FUA))
+		goto nofua;
+
+	dev->flags |=3D ATA_DFLAG_FUA;
+
+	return;
+
+nofua:
+	dev->flags &=3D ~ATA_DFLAG_FUA;
+}
+
 static void ata_dev_config_devslp(struct ata_device *dev)
 {
 	u8 *sata_setting =3D dev->link->ap->sector_buf;
@@ -2510,7 +2532,8 @@ static void ata_dev_print_features(struct ata_devic=
e *dev)
 		return;
=20
 	ata_dev_info(dev,
-		     "Features:%s%s%s%s%s%s\n",
+		     "Features:%s%s%s%s%s%s%s\n",
+		     dev->flags & ATA_DFLAG_FUA ? " FUA" : "",
 		     dev->flags & ATA_DFLAG_TRUSTED ? " Trust" : "",
 		     dev->flags & ATA_DFLAG_DA ? " Dev-Attention" : "",
 		     dev->flags & ATA_DFLAG_DEVSLP ? " Dev-Sleep" : "",
@@ -2671,6 +2694,7 @@ int ata_dev_configure(struct ata_device *dev)
 			ata_dev_config_chs(dev);
 		}
=20
+		ata_dev_config_fua(dev);
 		ata_dev_config_devslp(dev);
 		ata_dev_config_sense_reporting(dev);
 		ata_dev_config_zac(dev);
@@ -4105,6 +4129,9 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
 	 */
 	{ "SATADOM-ML 3ME",		NULL,	ATA_HORKAGE_NO_LOG_DIR },
=20
+	/* Buggy FUA */
+	{ "Maxtor",		"BANC1G10",	ATA_HORKAGE_NO_FUA },
+
 	/* End Marker */
 	{ }
 };
@@ -6216,6 +6243,7 @@ static const struct ata_force_param force_tbl[] __i=
nitconst =3D {
 	force_horkage_onoff(lpm,	ATA_HORKAGE_NOLPM),
 	force_horkage_onoff(setxfer,	ATA_HORKAGE_NOSETXFER),
 	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
+	force_horkage_onoff(fua,	ATA_HORKAGE_NO_FUA),
=20
 	force_horkage_on(disable,	ATA_HORKAGE_DISABLE),
 };
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4cb914103382..69948e2a8f6d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2240,30 +2240,6 @@ static unsigned int ata_msense_rw_recovery(u8 *buf=
, bool changeable)
 	return sizeof(def_rw_recovery_mpage);
 }
=20
-/*
- * We can turn this into a real blacklist if it's needed, for now just
- * blacklist any Maxtor BANC1G10 revision firmware
- */
-static int ata_dev_supports_fua(u16 *id)
-{
-	unsigned char model[ATA_ID_PROD_LEN + 1], fw[ATA_ID_FW_REV_LEN + 1];
-
-	if (!libata_fua)
-		return 0;
-	if (!ata_id_has_fua(id))
-		return 0;
-
-	ata_id_c_string(id, model, ATA_ID_PROD, sizeof(model));
-	ata_id_c_string(id, fw, ATA_ID_FW_REV, sizeof(fw));
-
-	if (strcmp(model, "Maxtor"))
-		return 1;
-	if (strcmp(fw, "BANC1G10"))
-		return 1;
-
-	return 0; /* blacklisted */
-}
-
 /**
  *	ata_scsiop_mode_sense - Simulate MODE SENSE 6, 10 commands
  *	@args: device IDENTIFY data / SCSI command of interest.
@@ -2287,7 +2263,7 @@ static unsigned int ata_scsiop_mode_sense(struct at=
a_scsi_args *args, u8 *rbuf)
 	};
 	u8 pg, spg;
 	unsigned int ebd, page_control, six_byte;
-	u8 dpofua, bp =3D 0xff;
+	u8 dpofua =3D 0, bp =3D 0xff;
 	u16 fp;
=20
 	six_byte =3D (scsicmd[0] =3D=3D MODE_SENSE);
@@ -2350,9 +2326,7 @@ static unsigned int ata_scsiop_mode_sense(struct at=
a_scsi_args *args, u8 *rbuf)
 		goto invalid_fld;
 	}
=20
-	dpofua =3D 0;
-	if (ata_dev_supports_fua(args->id) && (dev->flags & ATA_DFLAG_LBA48) &&
-	    (!(dev->flags & ATA_DFLAG_PIO) || dev->multi_count))
+	if (dev->flags & ATA_DFLAG_FUA)
 		dpofua =3D 1 << 4;
=20
 	if (six_byte) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 58651f565b36..d30c1288504d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -91,6 +91,7 @@ enum {
 	ATA_DFLAG_AN		=3D (1 << 7), /* AN configured */
 	ATA_DFLAG_TRUSTED	=3D (1 << 8), /* device supports trusted send/recv */
 	ATA_DFLAG_DMADIR	=3D (1 << 10), /* device requires DMADIR */
+	ATA_DFLAG_FUA		=3D (1 << 11), /* device supports FUA */
 	ATA_DFLAG_CFG_MASK	=3D (1 << 12) - 1,
=20
 	ATA_DFLAG_PIO		=3D (1 << 12), /* device limited to PIO mode */
@@ -113,9 +114,9 @@ enum {
 	ATA_DFLAG_D_SENSE	=3D (1 << 29), /* Descriptor sense requested */
 	ATA_DFLAG_ZAC		=3D (1 << 30), /* ZAC device */
=20
-	ATA_DFLAG_FEATURES_MASK	=3D ATA_DFLAG_TRUSTED | ATA_DFLAG_DA | \
-				  ATA_DFLAG_DEVSLP | ATA_DFLAG_NCQ_SEND_RECV | \
-				  ATA_DFLAG_NCQ_PRIO,
+	ATA_DFLAG_FEATURES_MASK	=3D (ATA_DFLAG_TRUSTED | ATA_DFLAG_DA |	\
+				   ATA_DFLAG_DEVSLP | ATA_DFLAG_NCQ_SEND_RECV | \
+				   ATA_DFLAG_NCQ_PRIO | ATA_DFLAG_FUA),
=20
 	ATA_DEV_UNKNOWN		=3D 0,	/* unknown device */
 	ATA_DEV_ATA		=3D 1,	/* ATA device */
@@ -381,6 +382,7 @@ enum {
 	ATA_HORKAGE_NO_NCQ_ON_ATI =3D (1 << 27),	/* Disable NCQ on ATI chipset =
*/
 	ATA_HORKAGE_NO_ID_DEV_LOG =3D (1 << 28),	/* Identify device log missing=
 */
 	ATA_HORKAGE_NO_LOG_DIR	=3D (1 << 29),	/* Do not read log directory */
+	ATA_HORKAGE_NO_FUA	=3D (1 << 30),	/* Do not use FUA */
=20
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
--=20
2.38.1

