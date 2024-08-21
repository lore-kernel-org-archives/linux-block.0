Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0A1A7AC7
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224759; cv=none; b=hX2nahyB8L09bBplK1g5j8raRH/KuFKANvRpKesXpXEzZucW1FNALMaocwSnthGbbDV8be0dpw3cxkWB0NpJSQnhlfDA1365dbA4kArnnHrvZu9rDQ77k+/llP+W88TFdpNCc18KzKWf1arzcsHfQQQqmAFMqPQzGDnpXlaFe64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224759; c=relaxed/simple;
	bh=X1zz/TunuR2PG93iDywgu0fR0ZIioix5D5qvFJsuS9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbQfVn6eypC8T2C3npcp8l9HGKLjv9woSYZiOwba8bjoQUea2JT5SQISZYewIq2pQUh9O+yyFdSMTS/J8Jv6G1JDB0yQl4EuZuQzuswo1rdWe5Kk4AeOLbdAy/KatGxYMlcjYB5xe9aISlUUNh+9Ws+tn3Gwby28NMQATza8qp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XkSy2Bnz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkSy2Bnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLI8bZjR6OdWE6SPmBhjzuWJVjW15O9K3MBwEhWkwDY=;
	b=XkSy2BnziZJXpVkMxTN9FO94Ab7wAE3C+LYUdlXuYrcziRRk2765K1tHNy7SsK0MJFmTtT
	IRx1FGi18hPKPLmnX+kNMqVlk3BKoM49d6P6QWvRb/x0LwtVYWbCv6qB3uirzP8san+Mcf
	GUM3Qrc2wyW+XVl0CIHCKozS31SIL2U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-Z1Xto38WOxOTGrG-cWEUhQ-1; Wed, 21 Aug 2024 03:19:16 -0400
X-MC-Unique: Z1Xto38WOxOTGrG-cWEUhQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a34e9c8945so657226785a.2
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 00:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224755; x=1724829555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLI8bZjR6OdWE6SPmBhjzuWJVjW15O9K3MBwEhWkwDY=;
        b=cwxzkmjjnm5y2RZ0MIYSLVuIdVTa85qrlNoy8c2gA7Af9AMFFt7aNJsuxYA1pXZHJC
         PvAFy3ySLqxR/jQarEDwZwmwQoEwmVc4/ehqyBUt/w3RQDk8DvoZp9vB2NaPNPVhOZI0
         w2eIwaE/Cs+fRYLQNhm6XHDt6nEqR0RPxgW8Q7vQwbL+oWY9uReikeUydfyJiJZpqAmm
         RlGRE34tb9UObJ6uga3Aa0WF7HesgSoA44yg34Rl6AmUXLiNihXRXO0kuMyJGKydlmeB
         Xx9SjrfYdOzIvZxjKJ2mWrzTTmZRNokhIq8MaKHtU0ONFbP7iu5pxjp212kuOuaht6KH
         r8CA==
X-Forwarded-Encrypted: i=1; AJvYcCVC6wDcynM46CHajfiVqjsGPjWYCsF2RWvJq1A26Qo3F9Q0xu2CfMSE84gQfPicFLXax1Rg6turAks6yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrukj/26jo2a1buv6TfbQIw1kPizT4hoiZKImZ9xRL+18zvIJq
	UkujLUFv+tVTh6Rpy26rptIWZ1N4+8ztmIH8NGYAVcxJlgpWdm8xdvyPaitQzmEFmBYTX6hD082
	X6JHMWCCH15+S5jBlOJbJqMxva184urmy8+47LgAqLyWxW7aTpZu61TpEQvFS
X-Received: by 2002:a05:620a:1906:b0:79e:f8b7:5c73 with SMTP id af79cd13be357-7a6740c5e31mr226529085a.55.1724224755568;
        Wed, 21 Aug 2024 00:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtpkoHy3cS2PdzwF01k905nXUdsELS2xvQjiGeTjNuWZ60d5TFnGqma74hup77Ia1MJryw5Q==
X-Received: by 2002:a05:620a:1906:b0:79e:f8b7:5c73 with SMTP id af79cd13be357-7a6740c5e31mr226522685a.55.1724224755041;
        Wed, 21 Aug 2024 00:19:15 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:14 -0700 (PDT)
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
Subject: [PATCH v2 3/9] block: mtip32xx: Replace deprecated PCI functions
Date: Wed, 21 Aug 2024 09:18:36 +0200
Message-ID: <20240821071842.8591-5-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

In mtip32xx, these functions can easily be replaced by their respective
successors, pcim_request_region() and pcim_iomap(). Moreover, the
driver's calls to pcim_iounmap_regions() in probe()'s error path and in
remove() are not necessary. Cleanup can be performed by PCI devres
automatically.

Replace pcim_iomap_regions() and pcim_iomap_table().

Remove the calls to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c6ef0546ffc9..fcd5806621c7 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2716,7 +2716,9 @@ static int mtip_hw_init(struct driver_data *dd)
 	int rv;
 	unsigned long timeout, timetaken;
 
-	dd->mmio = pcim_iomap_table(dd->pdev)[MTIP_ABAR];
+	dd->mmio = pcim_iomap(dd->pdev, MTIP_ABAR, 0);
+	if (!dd->mmio)
+		return -ENOMEM;
 
 	mtip_detect_product(dd);
 	if (dd->product_type == MTIP_PRODUCT_UNKNOWN) {
@@ -3726,9 +3728,9 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Map BAR5 to memory. */
-	rv = pcim_iomap_regions(pdev, 1 << MTIP_ABAR, MTIP_DRV_NAME);
+	rv = pcim_request_region(pdev, MTIP_ABAR, MTIP_DRV_NAME);
 	if (rv < 0) {
-		dev_err(&pdev->dev, "Unable to map regions\n");
+		dev_err(&pdev->dev, "Unable to request regions\n");
 		goto iomap_err;
 	}
 
@@ -3849,8 +3851,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		drop_cpu(dd->work[2].cpu_binding);
 	}
 setmask_err:
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
-
 iomap_err:
 	kfree(dd);
 	pci_set_drvdata(pdev, NULL);
@@ -3925,7 +3925,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	pci_disable_msi(pdev);
 
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 	pci_set_drvdata(pdev, NULL);
 
 	put_disk(dd->disk);
-- 
2.46.0

