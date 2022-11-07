Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE7CC4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 00:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKGAu3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Nov 2022 19:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKGAu2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Nov 2022 19:50:28 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FD9BF70
        for <linux-block@vger.kernel.org>; Sun,  6 Nov 2022 16:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667782227; x=1699318227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x509jXSJnwObswBV4jpE+8MByFyOsaKwegxIAG6rrnw=;
  b=i0h5vKngrskFp5pvYdHCJvyCyxmIs6WbAZwcoaNyjGfQ0ORqk6jHMHf1
   DRAI2IXYNZHrEwsThyGSmKrL36AT7STiTUqq8IlbmCF5rce6V3pBZkLeU
   Xdx7DCvvc7k1XXc5Afv/nsxJoeVIrUhJ1OwiCNhrde9j7G4VQ7UbX8f22
   /SKpRPnn25T5E+r0H2q9qAGLty+/xhvZJeGi9lJ+dxL47L0dQce3Ug7e+
   hyQECRXjMp8VBP2vNIkZtmOB6nL0LIFFZFs+w8BjoDZP17Hm94ziGmB1J
   Ze65CsVS3y7Hr7I83yhCEDAUPIiVTzz0kpn6oqGFmoXac+OeWopp+N4kO
   A==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="215958471"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 08:50:27 +0800
IronPort-SDR: sAVF9HoxfJUu+++/Ib/zYgziZ3Ca8F6EYXRWkojjakN9cr5Um+C+ONHYRMJ4I6FB1zS1qY2bvU
 W6HQL+dL42tyeCT64OWR3TlX3XGfaP/gUCK3+pOFAR99Fh8y4oIwUKBPVZRkzZ+ikMKgHM/vTI
 euQWfbsaQhoDFhEheykt7RZCcHw9NlUsJER+SfziCGQxBS8u+qXTJSvnvrpMZQ6MtHH8Au0eL5
 bO428addBrjhifcXlNG7cyUcwi7Vd04VM4/ip1BzvxqP0sgBw61RiqCDshs3mAXe8r2l+StDwg
 qJU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:09:34 -0800
IronPort-SDR: gi9yYThZyxAbXWUW3X9Hf3S8uuoK/LYIdsyQuxpyuMz/FIrykUFoExIbQ4nzEPqnH+zXbR1gxN
 e5l3QgKmZO6fGBWkgevO21KqudkG6uLlOeqJwG9j6pf5QgX8Z0w3ln6sloFuMdF2CbfGEuOh+0
 1JtPzOhAVjKKCTJ6YdkRgQpJ6qn4GtU+I7eos+yyuiqcmshKHqnCAAQkswr4Al9DPDwmcX/VVY
 SFQTIy3NW9HN0+tGAAQ9tYTGAmQJ5FCWmR/0kuh6hLepoQL4TuXMCCS0KpOQ8bUDv7xy2cYyhX
 kY4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:50:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5CM64zhMz1Rwt8
        for <linux-block@vger.kernel.org>; Sun,  6 Nov 2022 16:50:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667782226; x=1670374227; bh=x509jXSJnwObswBV4j
        pE+8MByFyOsaKwegxIAG6rrnw=; b=r3FfqeGEm+idEbtNTXbu9RtDl/jJdejw1B
        bgXIVSnhGy1sRSbhLGW+NDmb4lcK9Nyrrok8sBa1v+w7abQ0w4sceEITkn/HEose
        ilWvTAzXyVx4NqDlAQ33PixmVvej0KZ60ei1Kb4BaVeKw0iJw+RJVHoiQSWVZBgC
        wjcuMOW6Z2xEcv/bR4cwKT40Sk+jBwaYculy/Wz7umCCoUpnG19wHkFjbsn0eXlB
        W2MhTmK4RdE+ZZLSgWH2hbHwcEh/ZXY2AWdXU01Me+GAEaPPnz+L4/MVCMTV094f
        MvDTmnygj9ER37VmaLaAi/7Kw14cA4RshnskP6tOmGDOEwvgeTlw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rPgK8wDVHCzT for <linux-block@vger.kernel.org>;
        Sun,  6 Nov 2022 16:50:26 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5CM51Yg8z1RvLy;
        Sun,  6 Nov 2022 16:50:25 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 2/7] ata: libata: Introduce ata_ncq_supported()
Date:   Mon,  7 Nov 2022 09:50:16 +0900
Message-Id: <20221107005021.1327692-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
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
---
 include/linux/libata.h | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index af4953b95f76..58651f565b36 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1690,21 +1690,35 @@ extern struct ata_device *ata_dev_next(struct ata=
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
 		return 0;
-	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
-			      ATA_DFLAG_NCQ)) =3D=3D ATA_DFLAG_NCQ;
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
2.38.1

