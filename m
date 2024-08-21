Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0798E1ACDFF
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224770; cv=none; b=CFBOqe2SJuO5BzLwubNbi/AMcpbYSz7eyTbHx+t0bRcv2ZNIgEVnek/dqTogU3sToWx1sEuZcfISfqRks4GtSvscwVR5zxvJCrfNhXj6/ftv668vM07UegirEbTo2R51UKFiAIlVdmqgzdmLNFoFxjPZsPRptJ1S7ZZ56hSb7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224770; c=relaxed/simple;
	bh=SgQa/apEnyQVxi5RGIOMYDsJA8zmcu1/aNTE/QznKio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6qubRxM5LmfIsXtDBWApsdTIMZf6swD60R00ccjmWKk9l9QBVDinaYxFLBgGrdICRGEYbVyg1whzc/m9nB1gGkCLeTH1DxmfLLbaRrAPCDcmNLeiqta5tgLoLflqjsX5dELqZF8TCjrIkOgfJcWAnKU5hBVJ2nhZRvfEF/+HFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcCh/7jo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcCh/7jo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJtm3uYD4inmsDECmrMxkvS6gTo4VXXtBuq4LxNQ/Aw=;
	b=fcCh/7jo0riPzCQUAmhkfJZJvqPI02w5NbxxpiZjE8OlP7zAbi1yHtGPIxp3I1PISwdcAZ
	u5164758EYitm+nQKkWki5s2UuqxhmRB4ez5LjxKcZgwPBEPPdl4yavuj/qn4UEkPHzWVe
	Nfz+pPu1/ASxjgrrdhNTD5+zgn+XclA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-Ctu8CAdCOg-QT07O9ealww-1; Wed, 21 Aug 2024 03:19:26 -0400
X-MC-Unique: Ctu8CAdCOg-QT07O9ealww-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1d40f49f5so711504685a.3
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 00:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224766; x=1724829566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJtm3uYD4inmsDECmrMxkvS6gTo4VXXtBuq4LxNQ/Aw=;
        b=e3IOzOkAsnDAoJgm9W6N5jqb8uNH4BnjWW2WlwFMuQtUru+X/Z8N9mUyJYstoqr9rv
         bJ3jxFNrMxk2dU9qHQBS4CwLUA0LjqzrkCS2vMakXj67dEVBfQrcl3aNfFnWn5yb1IIa
         ugaYkYeyGQnjD2b/VRxIawZtV2cL4IONzroGdQWfG7hI+/GvWUCNYhC/Tl8zZhRSY1Ev
         XU0VB66gV6aDmxce6m5KpcRZ7Pc+XayBM+E5qNaL9kIWE6u/So4a1W/TekRxVEzAngFF
         IRI0e6/uqvGOPyupA6WlU7++orH3lv75hOBOEAlppvV1U7j/Gapunn0YlCaZSaQ1t0Xx
         OUrw==
X-Forwarded-Encrypted: i=1; AJvYcCXBepJUJkczyFBlHhu1+J6ZOvW5FKGScLCdXNovvM+oyXjzzJkWVCzC87By+JPm4I1On7/CkMO8HUOBTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3o1yMVBbygiQXDSexJzSPunrhN/3jRjy2IMCr9ud6UkpQg6kz
	2XDvLX+Yhz7NV558ykSUKrVbtIZrYPdf3E83l2j0IETrxTc2j4L4NLHTaSET+aMgLWNWlXNOeah
	GnAB5kzy+yWiYbuR/TvDYAQyi4p89kDmA37nm60R6L5c3qtvW4cJjjWkZSGDR
X-Received: by 2002:a05:620a:4447:b0:7a6:6b98:8e36 with SMTP id af79cd13be357-7a6748f3e18mr161732085a.16.1724224766180;
        Wed, 21 Aug 2024 00:19:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmBWfs7G37gw0gXLs+jJ1ak3VoPRzhFXnnqGnvalRJy1Z9qU/iCGfIEx/5sYtw8Qbb8DqgNA==
X-Received: by 2002:a05:620a:4447:b0:7a6:6b98:8e36 with SMTP id af79cd13be357-7a6748f3e18mr161728685a.16.1724224765719;
        Wed, 21 Aug 2024 00:19:25 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:25 -0700 (PDT)
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
Subject: [PATCH v2 5/9] ethernet: cavium: Replace deprecated PCI functions
Date: Wed, 21 Aug 2024 09:18:38 +0200
Message-ID: <20240821071842.8591-7-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with the function pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 9fd717b9cf69..1849c62cde1d 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -239,11 +239,11 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	err = pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO, pci_name(pdev));
-	if (err)
+	clock->reg_base = pcim_iomap_region(pdev, PCI_PTP_BAR_NO, pci_name(pdev));
+	if (IS_ERR(clock->reg_base)) {
+		err = PTR_ERR(clock->reg_base);
 		goto error_free;
-
-	clock->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
+	}
 
 	spin_lock_init(&clock->spin_lock);
 
@@ -292,7 +292,7 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
-	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
+	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
 
 error_free:
 	devm_kfree(dev, clock);
-- 
2.46.0

