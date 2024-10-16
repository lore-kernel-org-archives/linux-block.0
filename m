Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ECD2071F6
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072172; cv=none; b=p9yDcWXy2OQeCZ3VaAirqk2CtO8rVmMjwG4Dh53CP/hn6BlOoHl/dhIvUQsJ1f1Ip7fIfvptYGGGeTZQsrGd/cjm0Qsm+Bu0RsTLstHcfKO+eX+GOCCXHPhtHn0aIcQ19XJErLVKcPZrCxCobS9KGlccy2pTyQFPWIaNAgZIIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072172; c=relaxed/simple;
	bh=IPYwte1jdHAl0RXA+w3cBwPZngFH1bdGCu0keKv5zz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4oh7K+dAVJ4kcRsNT9kKKD1Zbl1/fuaMIGpRd1bQXDUf5mDKalV1E9pJncTGnsTYi2ifJRe+ykcqxkKuKm+VZJVcxCdydtjRczpXefEbzM5UK1hXhIGlZQ/waByMoot5KAcX95j2N+lTcR8WpciDnnCeozRsqG1ywAGZNSc5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6RxSdC+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6RxSdC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729072169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYrvd5koRqIGUA/KmbRFK2qg2itve32eBCe6OW52Vvs=;
	b=e6RxSdC+igWCNHNU9N6Kl4cYIKaa/6QE76g2FwWRmGgqV9THRPa+cdqTSGUXw8boRx7swD
	V9bNz8lzoT8kwU9z5o/OVPQitG56nT6pGsc6GsYQDfXde+1c0uyLTuVXE+rNA3pXz+lAFe
	PB68VPB5KQ/qbFvM5wqwImnZX77hwWA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-lODyx03IMxmaZQaNSjYw6A-1; Wed, 16 Oct 2024 05:49:27 -0400
X-MC-Unique: lODyx03IMxmaZQaNSjYw6A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43117815577so54584735e9.0
        for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 02:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072166; x=1729676966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYrvd5koRqIGUA/KmbRFK2qg2itve32eBCe6OW52Vvs=;
        b=cPEo41T+vo8NI+BjXaz6UCXFQzYwbBLgwyBgyl/kveHZdwTLTt3Z7bQ3XcbOosKMCw
         5+JnXvBUTg1wpQ41qkToj00KoFfNt8r6L3xfnTA7NLk8H2B8I4u5Pz3UxlTnPrMBTrlV
         jDTK71Xwj+aBeGUeY7qs/nXJjwwWUHlBiFWlfo6sVli61mR1RIHIv3l/wPYbV7EA5ywo
         hnjPG1v6d7kvtikMSZX6/BGuGyXjZh6kUq3FgIhuCZLhxfn3BobiGC/N1MZoGPXLXw9H
         toxxKlejqeS9wuOByng0856h3cZDNv/2rsmJ16AqB9ONfinisKGmXViN8YGd5S3f/BEk
         UYFQ==
X-Gm-Message-State: AOJu0YzmU2vXkRBlRW0W5oRkuxmKBtfehPXM+WcRaQ6496MtEagUoXB7
	E5mEjNXqjMlJje9a0m8fXMZhjWVcY1PrLmh/sx7Vx7yjvLuO8GX+0HTsPzbUIsX+m77TeO0wta6
	dOrb2xVS0xN8KbVkA8tJCDIX86VtdrK0ejQJd5bTJhpfKafa7cCuX2vqT1YAs
X-Received: by 2002:a05:600c:19c6:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-43152a3db6amr13401205e9.0.1729072165708;
        Wed, 16 Oct 2024 02:49:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAkaJZ2lSkUiW+EXBvu4lsvkJ7W5vgIpbgoPIk0XAjxqd5XGQFT0XY1/aB9+8xJFuJprrz9Q==
X-Received: by 2002:a05:600c:19c6:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-43152a3db6amr13400915e9.0.1729072165229;
        Wed, 16 Oct 2024 02:49:25 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314b32e487sm28190235e9.25.2024.10.16.02.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:49:24 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
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
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v8 5/6] gpio: Replace deprecated PCI functions
Date: Wed, 16 Oct 2024 11:49:08 +0200
Message-ID: <20241016094911.24818-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016094911.24818-2-pstanner@redhat.com>
References: <20241016094911.24818-2-pstanner@redhat.com>
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
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-merrifield.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 421d7e3a6c66..cd20604f26de 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -78,24 +78,25 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
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
+		return dev_err_probe(dev, PTR_ERR(priv->reg_base),
+				"I/O memory mapping error\n");
 
 	priv->pin_info.pin_ranges = mrfld_gpio_ranges;
 	priv->pin_info.nranges = ARRAY_SIZE(mrfld_gpio_ranges);
-- 
2.47.0

