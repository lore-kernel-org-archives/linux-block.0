Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611B202F8D
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904813; cv=none; b=RJDeDZikChS/n8VbtCPuIFhxN/bFXy8H52RjC0yyyCgjWvWSH3+jiz9317Pl5JuozwXXuu7zLN00QZbr5DshDKsqYULme2YaDAlWqxbiCeAvtiaRJDS5ADVr5sOVIjkWtyMOYRLKAwujtqHfNOLreUwkgfOJY/fCcD4mBRNXzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904813; c=relaxed/simple;
	bh=VnePaPHmlv7i/nnnyChjq6x43YKF5Ar7+3PST2zxv8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V78faF7n4An0RhJBrPTDeWZDRJYedbl1CqZY66dxrtMD32Xh/PeV4VO6ih5H50iQtAzUHHIG6TrXMCCB9qmDuBNxidGOMBD7et5K2zFccXccTXgIM2r1U4479z3w1+l16TTAAp5BFTn5AL/jAhra0buTrBzcDHK0VecBfgFOw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhPh6hAm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhPh6hAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730904809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zhNdkFjEuaL+ue96DDquelqda/uA2K1QZKXu3ul/egA=;
	b=DhPh6hAmrleixfpy7mNdCk8NyaFSI72k7QQprGLmjPK6ckRFvKn8SBhfUwkPd4kJoanuxY
	cWTFNvGnmr+3xfMv6GEB365sUAUH9peHrBZcsEcAPVQuIOJZmcnEsZwMTSHLfqYfYYzqc9
	1qh6yzNTDoirxyceDnFNNE3nqaV3mwU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-7ve69LrVM1qrvvgg2ZNzWA-1; Wed, 06 Nov 2024 09:53:28 -0500
X-MC-Unique: 7ve69LrVM1qrvvgg2ZNzWA-1
X-Mimecast-MFC-AGG-ID: 7ve69LrVM1qrvvgg2ZNzWA
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7092f2d50ceso5282432a34.2
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 06:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904808; x=1731509608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhNdkFjEuaL+ue96DDquelqda/uA2K1QZKXu3ul/egA=;
        b=Tq6zd4dchOtBvlYb8vc1SopBz+s8CCtG1HRVGRkbftrq/VxqGYDaSP96J1xrcQiS90
         emxP9EXAbMGO+GalCeBd6LpmL2t9BcTqEhN/9fxnZx6WYYoIj5S5wUDhyma6XMcma0Kk
         JtXXSsqAkOKtTKaGZmKNIZaeCPdUAfdp83zvtcIbM8liXNoIRPkRg1/BRpo3lL+itUy1
         uDcrh/vbgHobRscue38DcFnWrQX0genWxqF6YAhROhDXaPcAHGWSC2Bq457SN7nXO5QP
         V0pJbXsCO3PIiq1+wlnwqn0tTQsBbG/1T+Ax2eAXJ3xjeT7Jnra2EKE2nOzDl/gAXlOO
         dO4g==
X-Gm-Message-State: AOJu0YzlHIjK+X9YdM0gjXdTE7qWVfGzMhFY9f4tAi2xCYFMNjAa3kr2
	DL7BumMnkZSHGi02eox5jRpkojpEncFeJEk1IAt2BS/2naCzJcb9GgiBgmV0/dBbGZ8O4wtZKsl
	WgTnsAHaevRV4pR4o7CFuSssZ10UwJ1cxksj7SJs/93CcmesepUge+Ddvn+p8
X-Received: by 2002:a05:6830:350a:b0:710:f879:a15a with SMTP id 46e09a7af769-719ca25bec7mr20442523a34.27.1730904808168;
        Wed, 06 Nov 2024 06:53:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsq51w47iT662Km72nLQPeQu8djAs8QboqY5C1WT4nq+oW7/h0uMI2jzD2Ad6z5rq3DVB1ng==
X-Received: by 2002:a05:6830:350a:b0:710:f879:a15a with SMTP id 46e09a7af769-719ca25bec7mr20442500a34.27.1730904807836;
        Wed, 06 Nov 2024 06:53:27 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc69cf6sm2910192a34.26.2024.11.06.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 06:53:27 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Li Zetao <lizetao1@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtip32xx: Replace deprecated PCI functions
Date: Wed,  6 Nov 2024 15:52:50 +0100
Message-ID: <20241106145249.108996-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_request_regions() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()") and commit d140f80f60358 ("PCI:
Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()"),
respectively.

Replace these functions with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 223faa9d5ffd..43701b7b10a7 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2701,7 +2701,12 @@ static int mtip_hw_init(struct driver_data *dd)
 	int rv;
 	unsigned long timeout, timetaken;
 
-	dd->mmio = pcim_iomap_table(dd->pdev)[MTIP_ABAR];
+	dd->mmio = pcim_iomap_region(dd->pdev, MTIP_ABAR, MTIP_DRV_NAME);
+	if (IS_ERR(dd->mmio)) {
+		dev_err(&dd->pdev->dev, "Unable to request / ioremap PCI region\n");
+		return PTR_ERR(dd->mmio);
+	}
+
 
 	mtip_detect_product(dd);
 	if (dd->product_type == MTIP_PRODUCT_UNKNOWN) {
@@ -3710,13 +3715,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		goto iomap_err;
 	}
 
-	/* Map BAR5 to memory. */
-	rv = pcim_iomap_regions(pdev, 1 << MTIP_ABAR, MTIP_DRV_NAME);
-	if (rv < 0) {
-		dev_err(&pdev->dev, "Unable to map regions\n");
-		goto iomap_err;
-	}
-
 	rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rv) {
 		dev_warn(&pdev->dev, "64-bit DMA enable failed\n");
-- 
2.47.0

