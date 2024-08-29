Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80DB1B372E
	for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941141; cv=none; b=GeV7+bEUPhlS+IVrW+3WUdxe9rzDtPIDDMWX9pWLvPIMXy3dm40Mbw0xB9fekZsM01oev54lO07gdbezI1qJYfSlwSqXA0uB9kyWVf0vLvGRhUcPClMz3JQdjonY8gMGVGKb7zQoMckEvFMPUHIlDGuNuCs+ZxYizEpE78Ocvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941141; c=relaxed/simple;
	bh=nzy04PgDjxRp4clOpzx7ZwAQtwC8BOnrH0UdBVVoGHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyPuWUzBNtRHCI0J147eycmfZpPlk2bdjtzB4zry1Ju9UBOeByiYpZAizWhIlwXbg+pHj25TWDx6NArEyOk6Qa9GUX4odjjYnZi4AOF52dvIQyd5sXJIMJWbJ4U1ZtqLAbNEQkvHfxE/r/1dWj2yZ67Wknej6WVI9esCXWpg+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHqXJlCy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHqXJlCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osuRWDMAcWp5GKuvb2jQp7XxiFBFhqIKDkkqm4u4oTc=;
	b=hHqXJlCyefRSB6A/pWndTmSav3cyag1eyII4HnxdPdSArTOd9pU9FsEisIdYS6bP7FFRNm
	vu4WNKvPh1P595C9UzBWaOJ2/EIY8ewzjz6w511RsRFjNaGbbpIsYOjsykZJO8b/zUVNj7
	sGsd7+5wpPvgtysfv62/8rwzA7EbsZs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-lPQBkMj3MzalpVUqaUDa2A-1; Thu, 29 Aug 2024 10:18:57 -0400
X-MC-Unique: lPQBkMj3MzalpVUqaUDa2A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3718eb22836so448132f8f.3
        for <linux-block@vger.kernel.org>; Thu, 29 Aug 2024 07:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941136; x=1725545936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osuRWDMAcWp5GKuvb2jQp7XxiFBFhqIKDkkqm4u4oTc=;
        b=Qa6+J4EyXlz6FEawy5IkDY5xgfTIviVh3HwfYya1lyyyv3YanlwRfr4L3nn8CiY61i
         Z1niTybGy4IqzTSwwaveoh9H4H6hgq1OEcFZDyz26kf2nOFj9+ks7jwIr7Ww/dugwl56
         QMAxgfZarqxwEk9jgBLWknauIpat0Z4UAUTqGsMw3iXBf2ZzxpStvjJO5KDyEU9oahk7
         HSAz/JitqSmZcjxaBTGIz5zAl/VXUeudBccxHvZRWi4rPQoHZLBXfv3VYq3FjKMXyGL3
         HVwxnlHtZcKKIjgoSIcwn+7AqIZG9q48TV4yu5VYsdsj5C8qRQv2ho760/PN9zt4tJE/
         KXvA==
X-Gm-Message-State: AOJu0YyR4Lif3Ic+mPKsK53ormvM6DhECYkXY0pLLOTatk5EYewi7w+7
	jyG9J0huiqWPcYB14pasf9/yckoPe8geJ+1buTRwVkNMNGqodLc+LFe8gFHb+NlfET+LWoWxXl8
	tmqUrQutvzyWmSm8QQ2TjUrVCgxqESPZqPoFQ4rsenRzI+nyvmX7bVMpcrKK/
X-Received: by 2002:adf:f24c:0:b0:371:8e8b:39d4 with SMTP id ffacd0b85a97d-3749b5503f3mr2024882f8f.28.1724941136560;
        Thu, 29 Aug 2024 07:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYRK3DCkIWLqUxz0XY2NMNmO7BWhVLf+DW2Gbx1uLqQ4PTQOElvgJY4ok5jVfTKZaAWaobsQ==
X-Received: by 2002:adf:f24c:0:b0:371:8e8b:39d4 with SMTP id ffacd0b85a97d-3749b5503f3mr2024838f8f.28.1724941136092;
        Thu, 29 Aug 2024 07:18:56 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:55 -0700 (PDT)
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
Subject: [PATCH v5 5/7] ethernet: cavium: Replace deprecated PCI functions
Date: Thu, 29 Aug 2024 16:16:24 +0200
Message-ID: <20240829141844.39064-6-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Furthermore, the driver contains an unneeded call to
pcim_iounmap_regions() in its probe() function's error unwind path.

Replace the deprecated PCI functions with pcim_iomap_region().

Remove the unnecessary call to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 9fd717b9cf69..984f0dd7b62e 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -239,12 +239,11 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	err = pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO, pci_name(pdev));
+	clock->reg_base = pcim_iomap_region(pdev, PCI_PTP_BAR_NO, pci_name(pdev));
+	err = PTR_ERR_OR_ZERO(clock->reg_base);
 	if (err)
 		goto error_free;
 
-	clock->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
-
 	spin_lock_init(&clock->spin_lock);
 
 	cc = &clock->cycle_counter;
@@ -292,7 +291,7 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
-	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
+	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
 
 error_free:
 	devm_kfree(dev, clock);
-- 
2.46.0

