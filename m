Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D518CC53210
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 05:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbjACFWW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 00:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbjACFVo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 00:21:44 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDC3F7F
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 21:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672723171; x=1704259171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rXA3kM1+t0Z22RbZdnHUnovsG/0E1mtbQVU8JoBc4nc=;
  b=JmAMqjoH1eQnWCtmKUW0jrJNFFGZYdVQxcCvbwdnVBGQPPJH4m63HuJl
   subc906G6zrhb/4AP/uQUEUz7mk7XQsiOnTiSzA3eZdzUhIgYSBWv3rwM
   durx5Baek38OO4rtqgbYOjuPNSl0qEAhJvwnEh9CYqQsv85d7kzqaY++e
   IOtI8oKcNLMWC/JRtr3NJ6FRRORc2oBALxBxqn7hOTjm+aqcRtJYBNl7u
   +F8DjEzXoUyulQG75YtKOJcY+olThGgUhJQkQTFIxh0Qf4h2j8InPFUE1
   hRC9R8PnPRpZxSxZLOMs3sup6NHKRIV8C/1JdcK/tsWg4HpofIQCBzPQm
   g==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="219794872"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 13:19:31 +0800
IronPort-SDR: Fz5P+nM5NrK+xvQATmMEWRjD5XghKGiehXjyL63v26oDmt5aJnZlRR/NA6MsuK+pjVVI5m83Y9
 uJBdA89pEhRiyoAYOM/GsTmZg5xel9B4Srn08kxDlcewtlwKj4slMH/3Xsz/jxNrLBYEhdjsIV
 z9sLS07Q2OmQlNA9Xe/LQsokDot22RYXG3a/X/PLAvj/r1yU6CjAWJFxjQVlP239y1ocuOv0w9
 9BWvd1xxzd8LRilKgX7fNYXUmAYaaY1GR29OG44nJeOTFXBPUCOpV2dpfA4/F1m9zDyfqA7MvS
 sCI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 20:37:29 -0800
IronPort-SDR: 60kGqnKc+9KJo5lS2nG8CjmuROeZu+8+5qDwQE5hkq12HvVXd3DBRZZ3ngaNrRZ+MozWT6I/57
 8NFPMxEUMT9+reGdJN+djxzYUEO91fvJtRNooTEzo/K9RxuV7mn/nMJ2OCpqGp/tPRmkG9h7qP
 LI1BxjQxbMGEk1pl6H6ahD8mNZH+XboZOZNl7rbyjq6cv2lLgDRhDJVfDE6VceS0/fMPrsGAyC
 dTI8NhHP3BEKf0MxsbksG0UvqytApIWmDFdrDjkba324clDlAdLC16XWA3q68GHnWHx1y1LxJc
 6ys=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 21:19:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmLdG5Nf2z1RwqL
        for <linux-block@vger.kernel.org>; Mon,  2 Jan 2023 21:19:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1672723170; x=1675315171; bh=rXA3kM1+t0Z22RbZdn
        HUnovsG/0E1mtbQVU8JoBc4nc=; b=XPRoPKq03d0+WwwpukNZDdivgne7WuxxRU
        KFMJsUn+vbb8Y8O9wPlXYpG6na8XfyN37ll0wBH1p27+6Z7dbLXQfrnXkvEZlakl
        sA4G7G8ph/pORfRDo5E+rEZe2lO+ug95FFU39/oMWz0j8+qDW/ZM30qJFqiaNxs/
        Z6/2vTmDPn8WrDZdPXBymnI9yuMSWsrFldw+MIoVKEUziCFEXyYENl2xHCdvxhj+
        +EBX4MMWB17mJjqhmpok66x/PuAKMie9yeHTvIS/AGKn1dQkB9UJE+05ykVqXG+j
        Uab7YZgkSHBFbcJsq2OG0fGOGxAHNJNvvJlV2tfjZVHvhIcXEOLQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nw7TapHxasVP for <linux-block@vger.kernel.org>;
        Mon,  2 Jan 2023 21:19:30 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmLdF0tdpz1RvLy;
        Mon,  2 Jan 2023 21:19:28 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v7 2/7] ata: libata: Introduce ata_ncq_supported()
Date:   Tue,  3 Jan 2023 14:19:19 +0900
Message-Id: <20230103051924.233796-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
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
index c9149ebe7423..650543afad32 100644
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

