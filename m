Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94350C54EBC
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 13:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbjAJNPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbjAJNPL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:11 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4B15792A
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356509; x=1704892509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NoQ954DbHhZGptKeI7CVe5HvdsPZfAJoSreUyiSqMQ=;
  b=OEvZY+1kRYVT4Iga/OifCJ5ihOd2wsvWfIBJ3YSb7kH8QYCO7M8jG87d
   O7kKObCqv+9VAVn1cSZlvwQmqS9t5O0U/RJqKWg32GlZ5gS3II/TWfmxG
   TUaMP6ciutkZl9vM8AbYhXVQkmqTa/mruHybQFohKFXqzrvSphoQDBA9Q
   +tFTdX/R7pZRNe9ab9BP6ssWD5WRMZ/9XAcnXhYJY6Oevt6e3xOun/maH
   ob4i5gOFc5WLknL70Pt0NAZuL1eDhCQEgMtySCvnrO7/y/kQiMAAB3PWb
   B+eTgqw7XkLDNY8gsURLWPd2KtinGjFwk2GZ1qXH11HuI1GmPAVTmq18k
   A==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="225492645"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:15:08 +0800
IronPort-SDR: rn6+kMugyGkGzV9i+WHrqJjaH6j6STQ4kW8Her2iBplIPBUifmLtS0JPrZqN9KDDyVK90gPReC
 IMsJoEXR/Kjde+HB91zpJrBwEMhhZIIEytJdSPA/IF0lMhTzAha6BgFGFqgBiu113v8+VAJzQi
 vEDAZNKXmlJOi9EleNoOkMy3Xlf2Xx+6WJvICj9s17bXvGFch9mMNeRnxsvkuGXn+Ylf4aQwwb
 tLQroIBPZ+HHnFRG03VUysriSEYb1pLi4T7OFUVI9lA/8x5lBEQ0GCMkyytfCIF9x35WDg3rd0
 l0Y=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:27:14 -0800
IronPort-SDR: +/UtFNt+Sr3Km/Qujb79wzVkHG+9EtR8NE0RBLcW8CJuAlGW1JSKAB5VvTcIEmZLxLp8U6jh8m
 bimY5z+PLabeRGYEuyuVWrVtg4dTOtLFiIK9akuJcOmNHqMmJX1M4zLTSadpLCtgo3FUmSkIAl
 NVgmHWb8QbxZwhEUEl0GyKBSWKu5s/M2GXlCG3yD5nQUYi8eThLw5r5M2Ik6qR5JvXcDU04J3Y
 LABSQkOiYTFToYn+BGnpYXTfRFE2QxbXIZbpADAe7EIjNsAq3/QgKtefGpGWkR5JkgQQF+kNSx
 y/w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:15:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrrrr3jYSz1Rwrq
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 05:15:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356508; x=1675948509; bh=9NoQ954DbHhZGptKeI
        7CVe5HvdsPZfAJoSreUyiSqMQ=; b=MsQDj2OdWbs87YfBm2acyAhuOFkoh4sXJR
        WhgoxjOOTYnBD4SI93hbE6uoLSi3f6xMVUu9IVZ7uTJZ9b5/ifuJ5WGMlSx19zXV
        eASoFT+AgdXgGxdODLmbXF1ttyEMoyRiUMXeTI/5TFI2DVdsNYqOrE/zY1ML/29H
        aoK42Z5xm0PwEdrP/IUVd8D/2TLPZvnueDN1bm1q6zzd04Lt4pj68cFM5RKpoB3l
        1PVtsJTcMyBmyuViMdgalHZ160C1eUgqcywQorQUPGG2kr4Q5f5KA++uHL1HzyPU
        pLZ1/zO2luXXPc8GStrHPPymkU/5irPO37AgxvQtjHQo1QN/q2WQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6p5ak6xojbVP for <linux-block@vger.kernel.org>;
        Tue, 10 Jan 2023 05:15:08 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrrrq1FrNz1RvLy;
        Tue, 10 Jan 2023 05:15:07 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 2/6] ata: libata: Introduce ata_ncq_supported()
Date:   Tue, 10 Jan 2023 22:14:59 +0900
Message-Id: <20230110131503.251712-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
References: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the inline helper function ata_ncq_supported() to test if a
device supports NCQ commands. The function ata_ncq_enabled() is also
rewritten using this new helper function.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/linux/libata.h | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3b7f5d9e2f87..059ca7f2b69c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1691,21 +1691,35 @@ extern struct ata_device *ata_dev_next(struct ata=
_device *dev,
 	     (dev) =3D ata_dev_next((dev), (link), ATA_DITER_##mode))
=20
 /**
- *	ata_ncq_enabled - Test whether NCQ is enabled
- *	@dev: ATA device to test for
+ *	ata_ncq_supported - Test whether NCQ is supported
+ *	@dev: ATA device to test
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  *
  *	RETURNS:
- *	1 if NCQ is enabled for @dev, 0 otherwise.
+ *	true if @dev supports NCQ, false otherwise.
  */
-static inline int ata_ncq_enabled(struct ata_device *dev)
+static inline bool ata_ncq_supported(struct ata_device *dev)
 {
 	if (!IS_ENABLED(CONFIG_SATA_HOST))
-		return 0;
-	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
-			      ATA_DFLAG_NCQ)) =3D=3D ATA_DFLAG_NCQ;
+		return false;
+	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ)) =3D=3D ATA_DFLAG_=
NCQ;
+}
+
+/**
+ *	ata_ncq_enabled - Test whether NCQ is enabled
+ *	@dev: ATA device to test
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	true if NCQ is enabled for @dev, false otherwise.
+ */
+static inline bool ata_ncq_enabled(struct ata_device *dev)
+{
+	return ata_ncq_supported(dev) && !(dev->flags & ATA_DFLAG_NCQ_OFF);
 }
=20
 static inline bool ata_fpdma_dsm_supported(struct ata_device *dev)
--=20
2.39.0

