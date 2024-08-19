Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14318950C
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086377; cv=none; b=CNcUezd0yLeKNanqvLJ57D+XwnDQLVL8cLJYPvDa3wT/qQt1nnZHEQt2Yl3Sq1sTJZFa+yrj+dZLf7AC9Qec4KzgMbnzg7YTA7ODbSpJHjIqd9bUh6OjJA2dJXG+zFvbJAvcbOAfZB6OiTcLB/xb99CE6rkB3j2qd3AoihonYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086377; c=relaxed/simple;
	bh=4wYDH1u7rI7foUd8ddC2jHC2VfD945Yix3xLtlXZQbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vve2DZCPs+JU3fGRXwvEaPKV/oUaIaWfsPzhBrsfikSj7Rg2kjBFBRtDqIATTyfMOnne/HUDwXrIgwhEX3g7T3qgyljWRz7NQKFzkNm/qCX68C9LwasN4e7sKFn+c1SlTy1kkl2nNMbzUZyoxXjzjukeLFet0ntMQEzwZOUFcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVHzWm+7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVHzWm+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvDTGRlH2pE5xUmthqP2K8NKj/VvlYnHCpyCpsJBmcw=;
	b=UVHzWm+7YtPSs7KzoxaUNyiZUCNrM49UBRlJTLNE+YBviYpRg0wSmc5Na2Hm7VBzW2QrIX
	0YWpXSW8/utNhY4gmkrnwR9N2U1QAXPuGXfEHggtGg1czBQTGHo84xwllV4gZTru74+nkC
	+L4wwyLKDkbdfex8kgzAk3fIVJVmDnM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463--eL2h86GPAqb_Tn_qne8Hg-1; Mon, 19 Aug 2024 12:52:51 -0400
X-MC-Unique: -eL2h86GPAqb_Tn_qne8Hg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4502562fc7eso3229641cf.0
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 09:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086371; x=1724691171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvDTGRlH2pE5xUmthqP2K8NKj/VvlYnHCpyCpsJBmcw=;
        b=EqLCbiB4FS69mMEmDZdgI6SWmJb6auEXFzoqwkUBt+oYmJzjhrfGyZbKk14mwQ2w0Y
         Ilp68sVhO6oUM2Ven/1we40ew2AOP1mpvCq5Aqse7u73P2VJQWpJ6Ep59CKNFxxtODkF
         RHQl6NKOl3g+5AvD8e8eP4rjkRAaldQeyXNmkZp+eTikcsnaKlumXjIVsoXxPdhTzZEB
         mJYZl3UvJvd+th9L5GCf0GRShX9jxr0maLoGCfYA7f2Kxo2gasjx+vG5i/eyRoRg1h9j
         OF9ccujZEzBggWa4ciDPPa/8senG2dJGapl8/+ivx9fDGo9SDTN+hIdRX7Hmtjd10uEU
         U7Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWTl1J7aKfMprpabJavwUaEa6ErMGaDSv7J64v8USFcQNOmrAxsQRVQdC5uDLv6osBuMPJ9+IRiNw9nhPm/+mxuExMp/U3yuEkUF+I=
X-Gm-Message-State: AOJu0Yz6cD50wdgokiCK6vTcWEJGhsi6gmkbMopT3rIZUo+GndcmuPSC
	P3AXxh6NjZ+HmKPNO04SZJX4AeQur0XsuCMGJZ4ddWqUUVbQVJeeZYpAIgO2wHQT2QkRrkXtjFF
	AEJfhIPcNsvKkfEz4GhWJCvL3i+o/ir7ztp5SemEBMtR2iv6743uxhfC0YLAk
X-Received: by 2002:a05:620a:2916:b0:7a1:ec82:5fb8 with SMTP id af79cd13be357-7a50693aa1amr850725885a.3.1724086371336;
        Mon, 19 Aug 2024 09:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZa/FD9N9XMYe6vZgYz+o23a4NN1SRn7d1y7DUQ2BvFX9aygcJIaTQ2PovPIikQclvdS1AXw==
X-Received: by 2002:a05:620a:2916:b0:7a1:ec82:5fb8 with SMTP id af79cd13be357-7a50693aa1amr850720485a.3.1724086370809;
        Mon, 19 Aug 2024 09:52:50 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:52:50 -0700 (PDT)
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
Subject: [PATCH 4/9] block: mtip32xx: Replace deprecated PCI functions
Date: Mon, 19 Aug 2024 18:51:44 +0200
Message-ID: <20240819165148.58201-6-pstanner@redhat.com>
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

In mtip32xx, these functions can easily be replaced by their respective
successors, pcim_request_region() and pcim_iomap(). Moreover, the
driver's call to pcim_iounmap_regions() is not necessary, because it's
invoked in the remove() function. Cleanup can, hence, be performed by
PCI devres automatically.

Replace pcim_iomap_regions() and pcim_iomap_table().

Remove the call to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c6ef0546ffc9..c7da6090954e 100644
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
+	rv = pcim_request_region(pdev, 1, MTIP_DRV_NAME);
 	if (rv < 0) {
-		dev_err(&pdev->dev, "Unable to map regions\n");
+		dev_err(&pdev->dev, "Unable to request regions\n");
 		goto iomap_err;
 	}
 
@@ -3849,7 +3851,7 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		drop_cpu(dd->work[2].cpu_binding);
 	}
 setmask_err:
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
+	pcim_release_region(pdev, MTIP_ABAR);
 
 iomap_err:
 	kfree(dd);
@@ -3925,7 +3927,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	pci_disable_msi(pdev);
 
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 	pci_set_drvdata(pdev, NULL);
 
 	put_disk(dd->disk);
-- 
2.46.0

