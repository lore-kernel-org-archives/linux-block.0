Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ACAFA3744
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 01:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJaBxl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 21:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJaBxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 21:53:37 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF6595B6
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 18:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667181216; x=1698717216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x509jXSJnwObswBV4jpE+8MByFyOsaKwegxIAG6rrnw=;
  b=FAInFAWQt6yxHpGTGdgaSxAP4V/UYy9BiaS7589VA814pVSyOOFiH6WJ
   CSD2tMKCVYaabOWZOKpXry+DzqoS5QVpFoCCRZonEWZUtND4/2Fms+85Y
   Z6JMmveSfVfLHz8VjQ5w2UA7HJegN5PH2iT9tcjhTKAIwBOxw/RtSj6ot
   PP0PJ39rMe6oD8lPO2Cyt6FkNvWodmHFqwaeEsH59SV93hyXTx2i+nAkd
   j2LnzLR14iHzZ++ur+2NpunbxTYUKrbYIbtUDH5VQaVYbEOEqkp+lC+CH
   +v6ToBqmf994a18QvEO6Kd444UGQP8neQBMqEF7HmqoqstIxm6WmbdVqk
   g==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="220246022"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 09:53:36 +0800
IronPort-SDR: dP7IdqQGDVsBDn/n/2k3YImuaYU9lEE89f7uahUIJ7p7S0uU2unC68psm2KhBlXIl3aJIO0/ZS
 Hh116lgFx0iK/E7BZ+CkfBrfj1W3nzTPMOJBoNkr6mIXOUUYHp6gJlw2JuGRs3yosmJ06stfUw
 lz+1YDGq6DcmSgaNuV3mwYIHchJgHda5p5EJLo8AhfO8Y/xwb0Q1Z7meLLxFyQYw3YDwBZol2M
 LGM+HcBdLrRPTeN5WCFypmjFn7tQQBZRddnrDdKxhUlN5qY1oDKY+qyEFbHEeKonGl1/094mzj
 hX7n1s1gQbdzg0vQOYE68zCy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:07:09 -0700
IronPort-SDR: 2qZgCms84YIzqEuBPmJTFXprnC4y4+kUlwzDhHXQwEIHCo6CS6sJ+FvN6YPXdw55yw28TD3gra
 HAiWYeLhmG7ZuuRfRUSX1iV1PAoxPFSS4Lmb9KnkFWwYj4AZz8Kl9IJAlr69PXLFTYBUJXVDqw
 bs8EI8b5Vqdr+ydYoUFUIwEMynetZyPUfK4yvbyCj1LaQe7PaXvn6JNVwlQB3rWaanp1Iq7NEt
 2XpNeDDTAGnr8yImOjwZORUYNZlIlO6bx4+JhA5e0+GfRqo4GnA7VefCfGQnsNGtn8WB9UYfy1
 8I8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:53:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0x5C3pLNz1RwtC
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 18:53:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667181215; x=1669773216; bh=x509jXSJnwObswBV4j
        pE+8MByFyOsaKwegxIAG6rrnw=; b=BaolBQs/9NOWktrzrrvcBCFZ9hHlqZWIl6
        OgtA9Ofm+HOrnwyBGo9JTUKxw3mQyMRqZ9GaVfcy6SMW8WuTwDeRWMEInT5mYKgP
        ung1iA1gTgUBEwEO9hiXSHaP0Dvwc6QVKOY0x5OuUkkEZ1npdnCGm9EgIYATjY9M
        I/4400FyFJUWhCG3KaFy+OF0Ul2v7iODYqePhzgXNhBOg5jNaH/AgNReQF0up2GK
        /0oPWDmO2vHZtMw6J7iwjruqXEPu164ns/5+Z88lmk33VUMGiPc83s13UeWY/je3
        CJ1zO6L7bljrLSDMFYXMZboG8EU8vgY0JGslCQhDopVuDJkMAFPA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z_Z2FMTSyBqE for <linux-block@vger.kernel.org>;
        Sun, 30 Oct 2022 18:53:35 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0x5B06QSz1RvLy;
        Sun, 30 Oct 2022 18:53:33 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 2/7] ata: libata: Introduce ata_ncq_supported()
Date:   Mon, 31 Oct 2022 10:53:24 +0900
Message-Id: <20221031015329.141954-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
References: <20221031015329.141954-1-damien.lemoal@opensource.wdc.com>
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

