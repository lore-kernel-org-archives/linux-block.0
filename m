Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF0D1B1429
	for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941136; cv=none; b=e9d8AqCep6FKgdTdlXOeKIevNzKjkjcePNstbIPiSo4MFpP9tRVE7maZU/Mn/nfQkzaTaSK0DZNI5jBimQ4Mn7qcP3RymeDv0S60SbA20L0d5wvU/VJ28Ro5et3mmLzM+IlWLZWni6lo3JRPKinw/DiKgJz82XOGaYJgcAr9oXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941136; c=relaxed/simple;
	bh=V4KRcC8BfWc5Sti/Fdc73KUa8QY4uocvnp5UyVnLmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/MNs1ZU+MaxUnugpENQIPiTgdkmTuy6BPASjPPwr1EDhEjkiJpmDBUYLLwrYsnswWU7ZKSaP0loEOdSUWhKCdhmUs15EBjX/nJ39tmInOml78mE9hPZ3INhcsgq8qhtU1usdaG+cb3X1R6CAklY7zutC6BOLbeK7knWe5z6yRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EL38qi4c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EL38qi4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
	b=EL38qi4cB3+4SU5JW/ydGVgTvO/anUFhfijY29tDBkoHifNcruZlRGcmW4iYtUS2ZqOF8z
	z/uVqCl9UrFhsp+I+O541cH7chFy9Al8X07LfLTkZksZW7WiGTTT3uUES8HMv57yOkaz7l
	opRmYXjMFetGoRkV72vka1gvVm5xc+8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-Zycxx9zQPPGHgWwq_gSEjw-1; Thu, 29 Aug 2024 10:18:53 -0400
X-MC-Unique: Zycxx9zQPPGHgWwq_gSEjw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3718c0b4905so564789f8f.2
        for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 07:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941132; x=1725545932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
        b=bWDzbFs3m+ZvlFbrraWb62D1axX1De6iTVUqo4kcPDcJNUm1aF1zK3AJtWSKAjl7NU
         dhDZTDGF0aLBxmwmHWkbwFFLeHbi3iFXWdtCa8fkJGwuQCPLAYhv3jM4FJiQXe+psnuh
         894H5ix913Ut8ZsB+62jDzte/lZOYXEEyeYQv8g8qiEKu5WhOGqKfHIX2r4VHNX6qUiM
         eXQTlVFYyIR1ME7fEmAbRj7tufNfbu5j9GldM+0Scu1HbNyIvKFMKPT7a96M9WZ29BMx
         R/p8aldP3WKdGkeiq1O0qJZCEyJZl42Eu+yiWUi6o095kNCTgEZAQfR8l75rMjMJ7WCg
         yFpg==
X-Gm-Message-State: AOJu0YwmBRCvSn1ItUJ82QX4CSXpufhq8ZKt5xtodDDyJGo7UisbgKGV
	Fp9oxW0pVVN8v+WuJpfkEiAP8+t0ZhGd+iafXaRNu5ifc4P7TGyxz3FRHnwRL5MDCTGxV5CURtw
	ftmoeRF4n/o2lN7h4As0CkiR3qeMnK9dTQB2HVF7A4e433nK0WpYekToXJ0xU
X-Received: by 2002:a05:6000:4d0:b0:371:890c:9b5c with SMTP id ffacd0b85a97d-3749b58e35fmr2067681f8f.62.1724941132036;
        Thu, 29 Aug 2024 07:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExu3DQrPfL2Xn0gAB2fCj8JJI6EtuIM+NkPB8RfQMu0+YrU4TAxvDtIU5CsDAlbEI3/d8Pow==
X-Received: by 2002:a05:6000:4d0:b0:371:890c:9b5c with SMTP id ffacd0b85a97d-3749b58e35fmr2067629f8f.62.1724941131450;
        Thu, 29 Aug 2024 07:18:51 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:50 -0700 (PDT)
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
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v5 2/7] fpga/dfl-pci.c: Replace deprecated PCI functions
Date: Thu, 29 Aug 2024 16:16:21 +0200
Message-ID: <20240829141844.39064-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829141844.39064-1-pstanner@redhat.com>
References: <20240829141844.39064-1-pstanner@redhat.com>
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

Port dfl-pci.c to the successor, pcim_iomap_region().

Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl-pci.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 80cac3a5f976..602807d6afcc 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -39,14 +39,6 @@ struct cci_drvdata {
 	struct dfl_fpga_cdev *cdev;	/* container device */
 };
 
-static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
-{
-	if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
-		return NULL;
-
-	return pcim_iomap_table(pcidev)[0];
-}
-
 static int cci_pci_alloc_irq(struct pci_dev *pcidev)
 {
 	int ret, nvec = pci_msix_vec_count(pcidev);
@@ -235,9 +227,9 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	u64 v;
 
 	/* start to find Device Feature List from Bar 0 */
-	base = cci_pci_ioremap_bar0(pcidev);
-	if (!base)
-		return -ENOMEM;
+	base = pcim_iomap_region(pcidev, 0, DRV_NAME);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	/*
 	 * PF device has FME and Ports/AFUs, and VF device only has one
@@ -296,7 +288,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	}
 
 	/* release I/O mappings for next step enumeration */
-	pcim_iounmap_regions(pcidev, BIT(0));
+	pcim_iounmap_region(pcidev, 0);
 
 	return ret;
 }
-- 
2.46.0

