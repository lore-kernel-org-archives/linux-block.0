Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C39189BBA
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086380; cv=none; b=XndP/qvF59dNi/0xH66oGSqeckWDwGK+V49zPkCJLHwX+KeVoAzbMlvnJf9THV/8A6ydFK9gZ0GFz1Si5BPpeCkdGkxYjl3YbC901A95Nh3iL8O2Fn6047w+eb9ZU03erH2f0Us4US5mol7izsgylQKGtui3K1CHbd0mrKv+txs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086380; c=relaxed/simple;
	bh=kdoJVoAn6TMYx4jeiXSMhz/dbakXLwqRf2j5XHX/mnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uj2ORiUU22HnsjKYiaEbPGhhHyPou60ncDney+iB/OBaxJSFIt/gB/rwSXaBWR2DLpfi06ookRU+Qr6EljsEuhZcWJ0Esed37umDhPqh2GwA6SIeQ1bE5HhsxwISGm5pS36ADsCHlHrH08AgT6KBrrtStx/ZEQQrke/qSJm9ne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6x19d6N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6x19d6N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CY9vOmK/BQyCj3xBb0Ms143MMS/6lF8CP2tePbnpXiU=;
	b=J6x19d6Nv3nssqgffnm3UOp0CjFV0EOebQdV9vhx4kgRqFmdPPwOWysn+SYxiwh28sNBGU
	6Sc1WSAIEyAdMYUd9esRI2pdP3DZO+i/nXK14nVf7g7AR98vLO4cvCZaE/iuFX1PVFfu8I
	Ulbd7RqerxEzxP7p4AhXTS+KI+F/CmE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-YEbdM__qPUy0Y2Q86a1LlA-1; Mon, 19 Aug 2024 12:52:57 -0400
X-MC-Unique: YEbdM__qPUy0Y2Q86a1LlA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3db181f240cso286815b6e.3
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 09:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086376; x=1724691176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CY9vOmK/BQyCj3xBb0Ms143MMS/6lF8CP2tePbnpXiU=;
        b=ZwptA5T8hTuBr+CmarCN7tUbIkT/buFwMsIay2hgD4rt/QJVrfG9KGMR6ZQfMV5qnf
         0AXja7nct+mLunxrDN0YVIOPVDUBbyB+hLkxSawSFWa1jrFfvDvRxgUlDm8x8IBVEHGR
         EzLWe6UyBj7r8z3LWJy8J7x1dETkNbrg3HKbg6rOqamjMmzDnoWervBKQuGOVEKy5n3c
         RxEZPzdyA1sMSuiKp32l8JIjcLme/8jvWWPbUJYaW91XmxAD64JFST7+7qrlDl56xJNd
         tWoIFYw8QITea7PEVOg8rHatr5MaBRi2VMoVPzR0B53uw8sqTR8P6ehNSDqZ438i2+9q
         vCZw==
X-Forwarded-Encrypted: i=1; AJvYcCVeCTbWt9frqksI2tgYuwbgtjZZ/0z6nIfSAuUEjzncLxpDM9viW/UhSBljFQ3u00j/oOVHXqVjZE/FFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWW5Q69AlhWU8APHutiCED8b+G5yfXBsI1VHUxbc9SHhYbQTfF
	HTMqs4BSaiei5AFCiYTcUe1EGTOyHJYQ5myVSeHQ3mwZrgke+mO57BmZK2ONR5oD+rVDgaZxWPP
	amWHUhO83Ea+YKjTVq7yiD9l5/pTWUmNd4n1I9vaSlNvfP2AcZ78VAh1eBEdu
X-Received: by 2002:a05:6870:41d4:b0:25e:c0b:82c5 with SMTP id 586e51a60fabf-2701c380dc5mr6625344fac.3.1724086376415;
        Mon, 19 Aug 2024 09:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXYRQHubDVB9l/Z5ACuWzvup4NaPaNsF9PV71SRQNM7kqNduzsiPOCl4z6zHTU6tKe3mmKcw==
X-Received: by 2002:a05:6870:41d4:b0:25e:c0b:82c5 with SMTP id 586e51a60fabf-2701c380dc5mr6625317fac.3.1724086376107;
        Mon, 19 Aug 2024 09:52:56 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:52:55 -0700 (PDT)
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
Subject: [PATCH 5/9] gpio: Replace deprecated PCI functions
Date: Mon, 19 Aug 2024 18:51:45 +0200
Message-ID: <20240819165148.58201-7-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace those functions with calls to pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpio/gpio-merrifield.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 421d7e3a6c66..274afcba31e6 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -78,24 +78,24 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	if (retval)
 		return retval;
 
-	retval = pcim_iomap_regions(pdev, BIT(1) | BIT(0), pci_name(pdev));
-	if (retval)
-		return dev_err_probe(dev, retval, "I/O memory mapping error\n");
-
-	base = pcim_iomap_table(pdev)[1];
+	base = pcim_iomap_region(pdev, 1, pci_name(pdev));
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	irq_base = readl(base + 0 * sizeof(u32));
 	gpio_base = readl(base + 1 * sizeof(u32));
 
 	/* Release the IO mapping, since we already get the info from BAR1 */
-	pcim_iounmap_regions(pdev, BIT(1));
+	pcim_iounmap_region(pdev, 1);
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
-	priv->reg_base = pcim_iomap_table(pdev)[0];
+	priv->reg_base = pcim_iomap_region(pdev, 0, pci_name(pdev));
+	if (IS_ERR(priv->reg_base))
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	priv->pin_info.pin_ranges = mrfld_gpio_ranges;
 	priv->pin_info.nranges = ARRAY_SIZE(mrfld_gpio_ranges);
-- 
2.46.0

