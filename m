Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6081531C2
	for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892423; cv=none; b=Zrx+UMEmYpxFJaH793LfcMYYffLhPZr+I4kl1Mpgyvc4ESu+A3hGScMUQOw4BS/J7PwvY96/CQEJX68gy/JEH/4M5xKOLvRip5/g1FLTfSw9pO6UDk2oCcN0WmAKIZ0KcFZFkn4COY90sl0CcR6aNFcr1Vx6w4ScoYIxzNBwehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892423; c=relaxed/simple;
	bh=veogpasXu8DFoes2pWWrRajzT/Tb+yGbiuMWIlqIVQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HythEZVRREERw0dhmG29/+AcBoiHpItdDvMoRrRJbjiA7ibFGNJO16L9jYR+d/gPmyUzDaS0AmztAzrM/wfRSJRJT82JCQIZWL+KYTNfr0SSY/ob26XUHgyZ16l2xoOSQRipeDWFPTu0/+6N5D3peDpo0RYq9PE7/zPp8oOVNBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aox5LklM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aox5LklM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728892420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7W6/l7rxCsNe9vQIzzAVccxaNC6ce1XTcoL6qo42AA=;
	b=aox5LklM7HLiaUbwBgn77RUkoDifh1wGUIyM8RiyFPa17+at8hQGOgQKUQ3oYhSDdwVwLS
	2RjspilbKCElTe6YPwrQ7ehp0axIQDkttyCFRoy01KcN3IZaTNPyP190615t6MFEBF9b06
	DdZVxaz8qBon6zsJOcnY00WjzmdV5NI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-SPtAjJTVNkWXmGhkTrdpqA-1; Mon, 14 Oct 2024 03:53:38 -0400
X-MC-Unique: SPtAjJTVNkWXmGhkTrdpqA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a0d8baa2cso56053766b.0
        for <linux-block@vger.kernel.org>; Mon, 14 Oct 2024 00:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892416; x=1729497216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7W6/l7rxCsNe9vQIzzAVccxaNC6ce1XTcoL6qo42AA=;
        b=Kql1XpVJsSxao1GOCSk6fSZlP6sCXnFfJx5COf36vSKmMnADqQkaDmlZjUJ4v4n0rp
         TDa4Vvdkjx9hzGKtEJTVPpcL/iUGFS45aCFtGGYLckhpfYSZlZeY60zNmCyr7bti85ry
         nqx3JuUNehg3Or5SNTmazHIhOdxNCrfUm2zq6gz49/Qg8AVSqHb8FOSr3KSvzxkvBKDx
         cUlLMzRKsshiM472ttm9KudfGI4+o2rj+wjzx8+Zt764SQaV5Z/u0366DTcRKecSRGBT
         rOn7E98W5Ko0xNHYMm1b3c0OxFJjcWC94ZDenvufB56KvNDkjbTMSrbSmMusV0qsKKl1
         HNcA==
X-Gm-Message-State: AOJu0YyFSOWdpjcxvaU5h37GrnVlaxH2ozG/qUqN1E2AqFRd8CwKyV3K
	K4hzpj48uh/VOnnTCJpXy+toag0gm/tLphEcG2FXGYZdUkc7MnWwvOeeQrwBXKQPNQqbjkIntya
	m6maqkUq5c3GiVLh3mhqcenMTYgaljtriW/9zK5rQ8s62eGZsFR+ELFZ8wrVG
X-Received: by 2002:a17:907:7ba9:b0:a99:4c71:704 with SMTP id a640c23a62f3a-a99b899df18mr956654966b.26.1728892416387;
        Mon, 14 Oct 2024 00:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcdlsL1TfE08opAxaZFL/GkS8KN4PCrsMz97DjWs5H+hxx58tt0LTAJvoIs9ET3WVAzpRpJg==
X-Received: by 2002:a17:907:7ba9:b0:a99:4c71:704 with SMTP id a640c23a62f3a-a99b899df18mr956650866b.26.1728892415932;
        Mon, 14 Oct 2024 00:53:35 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d3798001d5778cfc1aeb0b3.dip.versatel-1u1.de. [2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f86fa986sm243291666b.92.2024.10.14.00.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:53:35 -0700 (PDT)
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
	Al Viro <viro@zeniv.linux.org.uk>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v7 1/5] PCI: Deprecate pcim_iounmap_regions()
Date: Mon, 14 Oct 2024 09:53:22 +0200
Message-ID: <20241014075329.10400-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014075329.10400-1-pstanner@redhat.com>
References: <20241014075329.10400-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function pcim_iounmap_regions() is problematic because it uses a
bitmask mechanism to release / iounmap multiple BARs at once. It, thus,
prevents getting rid of the problematic iomap table mechanism which was
deprecated in commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Make pcim_iounmap_region() public as the successor of
pcim_iounmap_regions().

Mark pcim_iomap_regions() as deprecated.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 8 ++++++--
 include/linux/pci.h  | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..a486bce18e0d 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -773,7 +773,7 @@ EXPORT_SYMBOL(pcim_iomap_region);
  * Unmap a BAR and release its region manually. Only pass BARs that were
  * previously mapped by pcim_iomap_region().
  */
-static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
@@ -784,6 +784,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_iounmap_region);
 
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
@@ -1015,11 +1016,14 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 EXPORT_SYMBOL(pcim_iomap_regions_request_all);
 
 /**
- * pcim_iounmap_regions - Unmap and release PCI BARs
+ * pcim_iounmap_regions - Unmap and release PCI BARs (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to unmap and release
  *
  * Unmap and release regions specified by @mask.
+ *
+ * This function is DEPRECATED. Do not use it in new code.
+ * Use pcim_iounmap_region() instead.
  */
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..c4221aca20f9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2296,6 +2296,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
+void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
-- 
2.46.2

