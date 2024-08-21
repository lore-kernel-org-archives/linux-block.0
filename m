Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085E19ABC6
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224786; cv=none; b=RCSBjPrHc3p7HX+OC3zOCFvs0M/S5DGc+YEnCthevq5h3EKec/wRbTXkK2hP0XuGN6YIKjlw0uv5NZuCg9V4XqEaZgpRIQkZ8DDGGGW+Z+TuY9W0ECt0zuSC6By7TwxlP9WsvZypqe6N9649FbTATFvoZe/tTZA6ZzF8pWMmoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224786; c=relaxed/simple;
	bh=zz4g00AyrOlGbCFQ8xrM/DS+BcOL9w71mmIBYnsZsuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRuWrapHAxB1ZHod2iQyRkGnjHCoess2zw/X3zcTJYuUXAOFvYG+sBqyPpt8ePAWS0nWVTzMC2D0kZUkdvQc/9xrCZOUfz4UYaNsS4tcqqy65SznMGnKuct5jfEfBSSUB1fLA9T7UUUE2wjhVYx7GCvNolBFF0Y0Rpgz6nbDz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLOl/nX/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLOl/nX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jtoMc9tojKKL8iwWeM5ToAOyUwxh+I3f+1WrHk/fN0=;
	b=NLOl/nX/ElgXyVElrf0w0feJUkRZ90e71eQH1Zh+k1joxBUY0jD1LILOXXt5jBpN7L+wFR
	TW42B6RH5OZyoqA5Vob5oa4MxLvr9eKoTPiTZZ/HB327mmifd45CaofyiuJqXW/gMUYRV4
	bR7RfKyb/Jp1b2afP62PscIOaZ6YKNE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-IR3y-h5FMEqI-RZeBwL-nw-1; Wed, 21 Aug 2024 03:19:42 -0400
X-MC-Unique: IR3y-h5FMEqI-RZeBwL-nw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1d0b29198so637701985a.2
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 00:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224782; x=1724829582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jtoMc9tojKKL8iwWeM5ToAOyUwxh+I3f+1WrHk/fN0=;
        b=Y0+sujWTe83Sl9V90NZ16OXFVb3DYXAlTOi5UkAI427deTec9l6QeGIIoUfmIACw0t
         1C0cBiZAqo1MK13eCZ9jUIG32O+/6+UMsY/SGlU0P69D4+q/nkbG3ZoGhtyTSCTqZOtP
         o4xkbctIUN+IzRHFMWK8BqX3R4Ylfof81D6ynPOAa9jghTM8UvLGNsfTbwCp7foyBMe6
         woFHMGMMWWZ2gxlii173USW6szYJVhdVZRDNGN+wahWP1RevD+hrTq7ys0mWBlqIEabn
         83V7OORTJID5/TB4+O0BneU9iN9ZE4iE3ufLYPsqExB9L2vYJrgEB1kv3EHm6Se2ZGF9
         4Agg==
X-Forwarded-Encrypted: i=1; AJvYcCUgQT2bf9iVp0iWPH5rx7eew3stjPtZSdreuHeOb+ruqQ78pj62yGv2731KJerNqv5JDto+XHRU6q2bJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgtydLTtJKv+fMaFeonZBboFxhC0d8aI1JmGju1kN10X7T9m8
	4sWE9Wk38m7ELgP+k1fJMcYLEfQP36IiH41KWfXQoCjGSGgh1q4C9KGE62fRC0QZUHOF+kWYz2R
	/gVrDiOTgmXNNCxdGdmcoMdeAY/sWQIX10Qu2f+WFYMDaSikTGohdG9nYVmBd
X-Received: by 2002:a05:620a:3953:b0:79e:e302:7392 with SMTP id af79cd13be357-7a674047d68mr175950785a.32.1724224781979;
        Wed, 21 Aug 2024 00:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEujbivdy0X82ZZM2IZtk3pa0uY+R6FAaLiHcgNfg5GEA0wo0Jm6V+lDWsOUg8+jqkxdP5bpA==
X-Received: by 2002:a05:620a:3953:b0:79e:e302:7392 with SMTP id af79cd13be357-7a674047d68mr175949285a.32.1724224781630;
        Wed, 21 Aug 2024 00:19:41 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:41 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2 8/9] vdap: solidrun: Replace deprecated PCI functions
Date: Wed, 21 Aug 2024 09:18:41 +0200
Message-ID: <20240821071842.8591-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821071842.8591-2-pstanner@redhat.com>
References: <20240821071842.8591-2-pstanner@redhat.com>
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
pci_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 53 +++++++++++--------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 4d42a05d70fc..ce336f261649 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,36 +556,25 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
-	/* We don't know which BAR will be used to communicate..
-	 * We will map every bar with len > 0.
-	 *
-	 * Later, we will discover the BAR and unmap all other BARs.
-	 */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i))
-			mask |= (1 << i);
-	}
-
-	/* No BAR can be used.. */
-	if (!mask) {
-		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
-		return -ENODEV;
-	}
+	unsigned short i;
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
 	if (!name)
 		return -ENOMEM;
 
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
-
+	/* We don't know which BAR will be used to communicate..
+	 * We will map every bar with len > 0.
+	 *
+	 * Later, we will discover the BAR and unmap all other BARs.
+	 */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
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
@@ -594,18 +583,15 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
 	char name[50];
-	int ret;
 
 	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
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
 
@@ -653,15 +639,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
 {
-	int i, mask = 0;
+	int i;
 
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

