Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BB15749E
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224750; cv=none; b=BX1i5gbdKORlyhWZ9ZAcpdalBP2lLE6HCHnR2wqXOBujIRjfK1U0d5TzHk9bkzmr1mwAIalzAaspatc+oqtHsZStKW2WblX6+Y0jz0hnKKaCsrNFUMwPwnZPDdPqv+I0YDgC1L+CUOK6obO/uOXnlwqVuB+u0zaZ1y5jzwz0YXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224750; c=relaxed/simple;
	bh=mHz+ZZWFhHEQhgF8fgLbMMsZfX1XWBKyTlte92c7V0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7ONlOqGtXGFA0XaQslBSOCTnzhUurvoM67STq6ZulF9mMdLr3PFwzuQ3/57CIDGlOUyOjn4U0Ocsh3A+SGAo427HTZXiFDLS+hzAdGYWxoXjK5ANWPw2xxLEg0hQpXui2VdXY+uKAUJQoy6EtGWIXfqc620uXbL5t+Z3qvKRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4FBG1v4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4FBG1v4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ch4IaqQVqf4n7EviAoZPVdER6FOrpbjt4F1+Z0pU5Q=;
	b=A4FBG1v4rT4nIVkYLbmVRkwX773yMrrMLJeZUTgGvg9S3z0ZHdmv2zI5jQS8VlBb5yK1iz
	2+gH3WBS+pQ3s4k7eOjzBXKbCB4F8ekzwU+RCQUKNaMhkf9IekhCzq+oqc3Vb8IaXx2ZZS
	Owo8nASkLQN34QmgvhXWrTmOsMomHR8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-q3GfTSflMyW3q_N_761aNA-1; Wed, 21 Aug 2024 03:19:05 -0400
X-MC-Unique: q3GfTSflMyW3q_N_761aNA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1d4335cceso92368885a.1
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 00:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224745; x=1724829545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ch4IaqQVqf4n7EviAoZPVdER6FOrpbjt4F1+Z0pU5Q=;
        b=MsNLwb9yzEQXnYfE0t3yxtYupm5dkR6H+TC7KLFj7Hp3bGoA+rjB0QLjchumMXsq6J
         JR0BqyUBVDqYJ+yUINBoeZfxx1NST6rrdDAqsrsZNJOIi0YST8PbVMlmpv/hPvlpo9Ty
         ONHqckhVitOhWDnWHsW3DYEdlibsiofm912wa0T489mUsEn0+QqzEzHXmJYH70t8OcbN
         JrWfEWsx8JS+zejMV6yOTLYRUYNXJ94NvK13HgMFGuBa/twDFdE0XP33GCi2Q46jVXRS
         x8pO3gSQK8/gOd4B0mMqJzGzneSbAo6CMQjzSzQD139eRa9ZhseXAIb4Z5jCKgBrF6BY
         2kHA==
X-Forwarded-Encrypted: i=1; AJvYcCUL6l0fCpqKCG7i2JbeRojWt0MK8NnTSxmV8hvmIJb+lWCq55xlc1QahpQi1WFYtor7BraJe2OAYAJNsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYiFeLM4VlFfCWEKdiyira/y0W3bnB5apwJ6Hd8V34JQdkupsx
	1pehz2apFqAaEWvaC3DAV1c0BfMlKWDv3X2YdGUiF/Fm4be1PpRKKq4P8VTq5gLMQ1Jw4nfKBdy
	QDLTG/vWeih2BaolE/cMY+QEqFR6er2Rb7DB8Thzq18lMGwmQbgoZaNb8CMwk
X-Received: by 2002:a05:620a:28d2:b0:79e:fec7:d6e9 with SMTP id af79cd13be357-7a6753141cfmr220358085a.32.1724224744793;
        Wed, 21 Aug 2024 00:19:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVEMCIqqzymRUElFBuqPlu9emFwxQQrGNHV6b0BSUinl1kKKpb11Nr3ppWIzVNMM5PBVDB+w==
X-Received: by 2002:a05:620a:28d2:b0:79e:fec7:d6e9 with SMTP id af79cd13be357-7a6753141cfmr220355985a.32.1724224744387;
        Wed, 21 Aug 2024 00:19:04 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:04 -0700 (PDT)
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
Subject: [PATCH v2 1/9] PCI: Make pcim_iounmap_region() a public function
Date: Wed, 21 Aug 2024 09:18:34 +0200
Message-ID: <20240821071842.8591-3-pstanner@redhat.com>
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

The function pcim_iounmap_regions() is problematic because it uses a
bitmask mechanism to release / iounmap multiple BARs at once. It, thus,
prevents getting rid of the problematic iomap table mechanism which was
deprecated in commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Make pcim_iounmap_region() public as the successor of
pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b97589e99fad..4dbba385e6b4 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -771,7 +771,7 @@ EXPORT_SYMBOL(pcim_iomap_region);
  * Unmap a BAR and release its region manually. Only pass BARs that were
  * previously mapped by pcim_iomap_region().
  */
-static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
+void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 {
 	struct pcim_addr_devres res_searched;
 
@@ -782,6 +782,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 	devres_release(&pdev->dev, pcim_addr_resource_release,
 			pcim_addr_resources_match, &res_searched);
 }
+EXPORT_SYMBOL(pcim_iounmap_region);
 
 /**
  * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 01b9f1a351be..9625d8a7b655 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2297,6 +2297,7 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				       const char *name);
+void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-- 
2.46.0

