Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC4C206070
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072166; cv=none; b=I+Y0oFgGA4dzQbq/1EPUEmLhZQ0F8Bf/PxRNPzrBp0tuwVYFid9GMulX4239WF/qssCnRuaYabr/cXSpar0uWAkmES57wunq0HoZUoEdBWPIuMl9AB/j72iERpTHg7WrLANjN+ZtxnRFKDy4kF8NKQsHcZlaWd29hOs6P9DklpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072166; c=relaxed/simple;
	bh=+7VXObVbimU6RXAVe8MLDd0WB1BZiq/LjoM6c454k1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOZ1f7plfI8M1953VxvSTZ5rDCU7xtS+T/bTrrr0+F0vKPkZwTn3tH4f/QT+VWvaRYEVjvkeJDxrzS0wniPb6ykiwRT60bo8rTrK2aLnXPe7cMu1U5wrfEaQp/96sTynrxBZVd67pak4KGUvFq2ybwMn02OkMTIyTXmY4t2WCtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFaf+rwN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFaf+rwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729072163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtS5zdbiO/gsUv0EMgDDobhsGGQ7SjCkZAyLsDHRQIY=;
	b=YFaf+rwNWRFme8Dz4/pXAxzpuAfJHzzVU+gKUbgLy8hYi99/5ASZCvswlNSQcjVAuClgSk
	FzfY+HNuuT5kOWHxLhEYsjmmeBZ+DaZW7WmC+U3xbgqfgUzpTsohchu4NzWrnIaNZDBq9E
	HnYwq3jlhK/91/eT+V7QQEU00tJaBP0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-7XhC7zDXMBSsDKrDLPEgdw-1; Wed, 16 Oct 2024 05:49:22 -0400
X-MC-Unique: 7XhC7zDXMBSsDKrDLPEgdw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d5ca192b8so374809f8f.1
        for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 02:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072161; x=1729676961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtS5zdbiO/gsUv0EMgDDobhsGGQ7SjCkZAyLsDHRQIY=;
        b=tbGfcZB3XlD5ltSiaOe3IAbEp4sW0YrVLo4LgKEoKF5VuvWgHyK56SHJHN8tOEP50J
         zb5i7CcGIWq9gAJsqvfN16U+4CMFih/w5gY8X+Wo0EUqWohSmow6UBVKLjiwqroAVgb2
         4SGfu8Z8A1YmIO47rjS3i+8mUILSc4z7aHgXwgjrID9mhhvOs3S3C3MdBDEnbFAr3vUb
         AhoK76XAco4EyWGgcW6nhmJ9/ZclVnp5S7RYLgFZpcxsYi5xGxqc+xjzXBuIfSB6VXQJ
         By0e0e3wt/RdA0uyQfCPx8+NoohZItHUdpNsZaQQ8cpPMJquq2PFRL/WxASBqLYKyIN2
         56fw==
X-Gm-Message-State: AOJu0YzDoRb5LfSSRQAANTjEtJ1wM0ri54bOY95LGzKF7Nr7WO0Zv/U6
	G577MTkhhf0BY97K8WpYdbO2BdQgpEoWiP1PzBkXrkF6eZDV5Q9JtiRy8NeSS3V7e71ACqnvd8E
	2tBUSXBB98xMfsiobYxq9Mcv7x21wrNq+msqmBDtVFn0UFyCEQPsydbc8WXHk
X-Received: by 2002:adf:f751:0:b0:37d:321e:ef0c with SMTP id ffacd0b85a97d-37d86285f99mr2815644f8f.11.1729072161040;
        Wed, 16 Oct 2024 02:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaiw/v72XpyvrLMQueXB69KM2bCaEPDc1zEe4UONM9jeIbxwKmu8+nYGsv9DDcnBz2ZvwW7g==
X-Received: by 2002:adf:f751:0:b0:37d:321e:ef0c with SMTP id ffacd0b85a97d-37d86285f99mr2815611f8f.11.1729072160611;
        Wed, 16 Oct 2024 02:49:20 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314b32e487sm28190235e9.25.2024.10.16.02.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:49:19 -0700 (PDT)
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
	linux-pci@vger.kernel.org
Subject: [PATCH v8 2/6] PCI: Deprecate pcim_iounmap_regions()
Date: Wed, 16 Oct 2024 11:49:05 +0200
Message-ID: <20241016094911.24818-4-pstanner@redhat.com>
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

pcim_ionumap_region() has recently been made a public function and does
not have the disadvantage of having to deal with the legacy iomap table,
as pcim_iounmap_regions() does.

Deprecate pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 7b12e2a3469c..a486bce18e0d 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -1016,11 +1016,14 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
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
-- 
2.47.0

