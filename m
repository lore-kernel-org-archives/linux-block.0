Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A801D47D8
	for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784998; cv=none; b=pbcz7dQ591I0+ugmY+CI+ze+Tq0umtKcf8508p5/LnujIkYpstowWx3IYWL83tPfkc5UaYRdyUsoDBkmZSV1Lt9dOOHq9q0kLJRvr39t55KpLZkJE7bdcb6oqMK85r1ru9ypbl5+CnRv1X8ju7x9r//jryAfpVfpWujlwkquU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784998; c=relaxed/simple;
	bh=DthlLOD0XWT9pUXf24uzdmG5D5JXhN126raQjVqCgeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jU7imlMsKklYHf467GJJAhg5I0L1Gc4Wxck6bqtjlIsnzdu+DLEcOEdyLGDmmX4bopEMysoHpE8CkeQG3GeuRr9TZHnC1v32IrES9CEwDQBFhct6KWX9tlBk+tG85QLiAHVjIt1KwCA12/kT23Q4gQjWG/w6NPVQNalkkxrzfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2wAwU4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2wAwU4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wt2kRlQoJgJxTzxQjhrYYWN0zj4xz5nEsQIR91A/520=;
	b=D2wAwU4aeFZ4ic2zoJaSIJMCfzQECvk4EHUQtvnu1wsh/l+Q5e09L3/clLX87n/nOSfWFh
	PKiv7oOMH7rRmLut2DlOQt0H4yUpq2oM/CzFNS2lsT5z3DV08YoTViQ2FPzO/wiah0f/AC
	nxHeGuwn9cZO0RnwTzj9SPWO4BNvS4g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-9iRZIOurM9KXYYZ1xJ82Lg-1; Tue, 27 Aug 2024 14:56:33 -0400
X-MC-Unique: 9iRZIOurM9KXYYZ1xJ82Lg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a867bc4f3c4so928494366b.0
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 11:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784992; x=1725389792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wt2kRlQoJgJxTzxQjhrYYWN0zj4xz5nEsQIR91A/520=;
        b=Pp+9ovoSGvKRCgMjpz8jWUZpAD4VZHvQbonLKEtW0NzXiov1gRZblQTRCOMo8c721a
         WFctJE84bpCrDM/Gu6ToU4D0VCCVdxXWJiTlc9Wn2HAGplaLEU2Ftf3vBOt9ndKSpWEH
         Qaxakas+eiypsVm2Q222PFfOprGQj1oL+iUhOnj6yYotJJ3wZZjVjQ5+Hvogbi32kFSE
         AZC+CwUsFOJTrrGORscEBk6jFAVThXG7q9Jp0XjYqr+/EGcvVjTV6uwUBQPddckQtZW5
         Q4CvjygQPwZVH5jfDN6siX4XfS6/bVGaz48IxxftoXlGPGsFCJ1KG8zF+yYfluUJ8I0s
         A3fg==
X-Gm-Message-State: AOJu0YzgGApf9aqYCTZtsNXTkvozP+uVvdrXiDrVs9AWwgQcbR4+/CPd
	/RBU0NTLMnxVjz5WVlxxHibctZN5+e3eO0LZixuxrG4/iHPortiDaO4FIywzC5+Nf8Y7Flw9Irk
	MSkrqkiWjOEP0nkLQVc87peoGkdT63J5o93qESIy+qvpyGqlAeGX6IrFjBKvS
X-Received: by 2002:a17:907:7f27:b0:a80:b016:2525 with SMTP id a640c23a62f3a-a8707043b8cmr8198366b.8.1724784992000;
        Tue, 27 Aug 2024 11:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBCdBD2kW3vTynmCvtl831PHsM6tyxf6BsBh0sckStVuG33fFsI5thDuDX9Uw77VoCKbJbMA==
X-Received: by 2002:a17:907:7f27:b0:a80:b016:2525 with SMTP id a640c23a62f3a-a8707043b8cmr8196866b.8.1724784991547;
        Tue, 27 Aug 2024 11:56:31 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:31 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 7/7] vdap: solidrun: Replace deprecated PCI functions
Date: Tue, 27 Aug 2024 20:56:12 +0200
Message-ID: <20240827185616.45094-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827185616.45094-1-pstanner@redhat.com>
References: <20240827185616.45094-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

solidrun utilizes pcim_iomap_regions(), which has been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
things because it forces usage of quite a complicated bitmask mechanism.
The bitmask handling code can entirely be removed by replacing
pcim_iomap_regions() and pcim_iomap_table().

Replace pcim_iomap_regions() and pcim_iomap_table() with
pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 53 +++++++++++--------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index c8b74980dbd1..2b7ff071aab9 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,36 +556,25 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
+	unsigned short i;
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
 	 *
 	 * Later, we will discover the BAR and unmap all other BARs.
 	 */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i))
-			mask |= (1 << i);
-	}
-
-	/* No BAR can be used.. */
-	if (!mask) {
-		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
-		return -ENODEV;
-	}
-
-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
-	if (!name)
-		return -ENOMEM;
-
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (mask & (1 << i))
-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
+		if (!pci_resource_len(pdev, i))
+			continue;
+		psnet->bars[i] = pcim_iomap_region(pdev, i, name);
+		if (IS_ERR(psnet->bars[i])) {
+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
+			return PTR_ERR(psnet->bars[i]);
+		}
 	}
 
 	return 0;
@@ -594,21 +583,18 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
 	char *name;
-	int ret;
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
 	if (!name)
 		return -ENOMEM;
 
 	/* Request and map BAR */
-	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
-	if (ret) {
+	snet->bar = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);
+	if (IS_ERR(snet->bar)) {
 		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
-		return ret;
+		return PTR_ERR(snet->bar);
 	}
 
-	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
-
 	return 0;
 }
 
@@ -656,15 +642,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
 {
-	int i, mask = 0;
+	unsigned short i;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (psnet->bars[i] && i != psnet->barno)
-			mask |= (1 << i);
+			pcim_iounmap_region(pdev, i);
 	}
-
-	if (mask)
-		pcim_iounmap_regions(pdev, mask);
 }
 
 /* Read SNET config from PCI BAR */
-- 
2.46.0

