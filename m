Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA78C46467
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 13:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjAJNPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbjAJNPO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:14 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204DA72896
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356511; x=1704892511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X3kzvQdGX1FhwiReGoda+divC3uvv6Zg1kXuu40s1fM=;
  b=YvkG7QDF46P/rciEezbtC/vPMavJ3sy/6j6k7KQ1iDlaEat/sPYpVV6F
   51gFwcLzXGOjetz7PTQrV8Gw7D7601nQw7RroeXGv2Apn74543Mq8mm2d
   2q2C8nuvzweLTUj+Jv5+A25s/vVrrWfBl+UM3a9fIers38bC7t5z75rpt
   eshei2U3vr4wAHveJ0o1ZKGmeKt8iJMc8GkcDp+UswqNF1AG0MFe3+nFb
   KfTpi6hbUcKI6mjXxRkLg0vnhM/Lcp64YD49RVJDCH/hqGFLzQtWO+jAw
   IHoie2XecGqF/e27ttE992scPEn/fkGvqHvz7q79tzEP4Vhch991YrXa5
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="225492651"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:15:11 +0800
IronPort-SDR: cpnQq0CYEPmqQ0qnXIwH34BDMOiFy0aWh6neEFyUoyG2C7RYjoJO0tQ7D+AOdwbd2Epul0cIKO
 gju1rKdclWqDQ1uL0hqBiFhXHo+RlbAWs6FiDcBmmnfg3WRutIwamhIRZe5xboeHqTU1xvCXZ0
 C4mfJ58v4ei6YRdbJ7bTljnPjLJuH0LhJhv8z2SocEXXeRXrEJ7HVye1AZ95WxT/BWbGTGWNOk
 KPmgdESycxvUyIGBCFo4WhZ5QLsCk8rEb42LvoIk14QgBl/qNrgspf4q975eCDbWnR/jiAFNzV
 pmc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:27:17 -0800
IronPort-SDR: 0UZY9rocEvEiI7wDqbGG4b03dFjQRf/pnkjJV0z6gIjtOCWxNxP/bU3nScveYBPzWbZPRCGcKm
 tUz0YbaGA/NeaNlZ1NECbwpvuCnjnswvQbFOTcvpYEgGVSwUqZPL4bpWCknVe85K+dvYdqajeP
 SBhsAtEOgLEJKEQvhfIhoLKe+Sz/sg+cGXRJzzMf/NlaC+DVvhH0J+Up8MZS3jBeOg0rImKsaJ
 3tuHIj9fzYv9D8jx0Nv3enXmJDLq0yu6IonpQv4ZdyOr/AJWZKm4f+YSCx+/XWtNY4/k72sVmj
 yvw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:15:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrrrv2P2fz1RwtC
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:15:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356510; x=1675948511; bh=X3kzvQdGX1FhwiReGo
        da+divC3uvv6Zg1kXuu40s1fM=; b=CYKQ1IJLchweojByCtALUDVqbmUQc6GVJS
        zUOaXKZUqXpW3BaErpyrj2o8esGWb/2Vh0Ax/hl5Xw0kyKbP227OausAW4teG94H
        gRFWayV8TmcqQ7U74F7atNFpfIdjyOKCJZTKohcKKrIE0ess/tK0LBFMgTbwSV8j
        /Ct0D1/3sYPflEMUH6JxOFF3joZnuoT2uyXOfHuzyvTHnvxn+f2i8eWkw+Fykh+N
        CeGlo4ROGI54bq+d7gCJcGdKOdZvfBppmASlhQT3PyERatE2dZbyWaKL85XAFxFG
        qui0JMgojnFP5ESevRkaDj6unvab+/ju0bYvBPOqX6204pnDMSdA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eJI_DJs1ufKy for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 05:15:10 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrrrs48Lwz1RvLy;
        Tue, 10 Jan 2023 05:15:09 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 4/6] ata: libata: cleanup fua support detection
Date:   Tue, 10 Jan 2023 22:15:01 +0900
Message-Id: <20230110131503.251712-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
References: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 ++
 drivers/ata/libata-core.c                     | 30 ++++++++++++++++++-
 drivers/ata/libata-scsi.c                     | 30 ++-----------------
 include/linux/libata.h                        |  8 +++--
 4 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..3d0f2de7dc03 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2816,6 +2816,9 @@
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
index 1c16342dda08..d25a53a873dc 100644
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
index 46109bde8a04..aa338f10cef2 100644
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
index 059ca7f2b69c..a759dfbdcc91 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -90,6 +90,7 @@ enum {
 	ATA_DFLAG_ACPI_FAILED	=3D (1 << 6), /* ACPI on devcfg has failed */
 	ATA_DFLAG_AN		=3D (1 << 7), /* AN configured */
 	ATA_DFLAG_TRUSTED	=3D (1 << 8), /* device supports trusted send/recv */
+	ATA_DFLAG_FUA		=3D (1 << 9), /* device supports FUA */
 	ATA_DFLAG_DMADIR	=3D (1 << 10), /* device requires DMADIR */
 	ATA_DFLAG_NCQ_SEND_RECV =3D (1 << 11), /* device supports NCQ SEND and =
RECV */
 	ATA_DFLAG_NCQ_PRIO	=3D (1 << 12), /* device supports NCQ priority */
@@ -112,9 +113,9 @@ enum {
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
2.39.0

