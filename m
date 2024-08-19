Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1202B18A95D
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086398; cv=none; b=trQ/hNLlWVts5X9rg4ZT/LQWQz/oPQOspSHExqCNQrCjpdCODTtcQI61VCqnNgynVYhjMwCLtRo3MDWQFKnqcf51W1nVBIgVgBWPZShHFhsYLGlvLXcNOoegPdVQMDz9kHMBHEwWM+NbFYFG7jgPPhXI7KkIfxQqLXfX4J46IBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086398; c=relaxed/simple;
	bh=1bt3tMc09G6s9xV0I/qYPefc2X8n9siL1P6ZGlLhoAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0gY7aYyQJpE+OKXUQVONxRokLOes58Zt1lpfvr5dYYJSAbr2WPor5wNcgwtbFOx4VLV3BiIIs8x+39ouPQiTCzFUmNAIjmfCFFFAQNMa+uIozAY+qn9EdsV0kbHQedW+uP//YATONBryot1zRfu1yH8ZN61hItdspS4lzxTRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JG0F5HYx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JG0F5HYx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abZiwvPf4gC19vxFT17Sz8slSRtUXISkEhAwbNUMlrw=;
	b=JG0F5HYxPVKDdVYMcETmD24jlaApV9rWtJhbn9m9BEnQ/UbmNAb4TFU7eo1b+SpUx+oLVW
	HxezOj1Pd8vGCzUlgVOaYNdT9bX9Agaq4a/PnQocpLYftO/nlBuKqfKTgKswUY+Jvx33bg
	10I8yQ7Iiy0ZpOxWyjKRX5lTVfoXsuM=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-LXMwdrleMjWThqU3WFKdQg-1; Mon, 19 Aug 2024 12:53:12 -0400
X-MC-Unique: LXMwdrleMjWThqU3WFKdQg-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84309d39e4bso39296241.0
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 09:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086392; x=1724691192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abZiwvPf4gC19vxFT17Sz8slSRtUXISkEhAwbNUMlrw=;
        b=sd2LRHwVDSCLcnfS4lSsCHgTjhn+sipngAbTYHV3mykBFXcMnaxv5+dItaoTK+775K
         gNDYhI9Z4U+b6YXEsPBKZhiME7aCGEoVylL4uPdQQ0Ex2ORffAPLqq5VIqvWCjwApyIt
         VUxjWyM3Iual/w9IfWYibsLW+m/JfV0O3VHMK6piNFsSIKZ8V/gFsfkyBBJamy69O7mO
         tE84/7qoAk7qgc3zLeg2qFdke7PfI9hjCjjkJU8YUQbrIX6KdhcvSvJdA6ZfemX1lOde
         1Zux52n33bdo4+hx19qLwtcQ8VLvglsc963kdTxWFTUg/YrCgyGSYWBXzb/HoJJJuR+u
         2CaA==
X-Forwarded-Encrypted: i=1; AJvYcCWcpJz8GhmlEN9IYrYtYsQdw5KoETlmkzOn0gSH69Ul60h36pZHQhIYi04ISpvKaIRknZNz4W13Rrka/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpGX4rzNsnedybrhpSCy/MMJ1/BQ+TYrmDo/v/il9xrZ2ZTESY
	tRIl8ydnDervQFc9d+exlBpIppLZKTmpEOguZnDqWZokMNtiJaPk5ll99mCb0+sAWZ4vYzX9wJA
	44PiRSPiFt2wOue6JfTKJf2cP30W3ISxU0h+u2kZMLM6baT1g14MloBTxeL9a
X-Received: by 2002:a05:6102:5127:b0:493:bb70:940 with SMTP id ada2fe7eead31-4977992674fmr7984164137.2.1724086392204;
        Mon, 19 Aug 2024 09:53:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSFSVYmUjqgNVHiq1+h9E7HGJis8qQ3DMxEZS8Skowa7KMQsueVdBGNDdQuxxSfXwtk0QtBA==
X-Received: by 2002:a05:6102:5127:b0:493:bb70:940 with SMTP id ada2fe7eead31-4977992674fmr7984139137.2.1724086391863;
        Mon, 19 Aug 2024 09:53:11 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:53:11 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: onathan Corbet <corbet@lwn.net>,
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
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
Subject: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
Date: Mon, 19 Aug 2024 18:51:48 +0200
Message-ID: <20240819165148.58201-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819165148.58201-2-pstanner@redhat.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
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
 drivers/vdpa/solidrun/snet_main.c | 47 +++++++++++--------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 99428a04068d..abf027ca35e1 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,33 +556,24 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char name[50];
-	int ret, i, mask = 0;
+	int i;
+
+	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
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
-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
+		if (pci_resource_len(pdev, i)) {
+			psnet->bars[i] = pcim_iomap_region(pdev, i, name);
+			if (IS_ERR(psnet->bars[i])) {
+				SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
+				return PTR_ERR(psnet->bars[i]);
+			}
+		}
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (mask & (1 << i))
-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
 	}
 
 	return 0;
@@ -591,18 +582,15 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
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
 
@@ -650,15 +638,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
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

