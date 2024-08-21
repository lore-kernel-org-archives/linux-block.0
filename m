Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F52192D89
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224782; cv=none; b=t/At6blI9Layd/H0OF6iHB0d+SywH+vImfXXhmrh5qKHs6Ub4laUq2KdW94ag8TvfcRBnua1hUy1UJesMxmuUrWR/cxsM8NbfRSA0fQt7tjPY7N9QuPoPFlsExwxOL5yZiAzuY6hfCRw0fFToWxF3Ab9v3wf92n4buFWF7mkx0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224782; c=relaxed/simple;
	bh=Z/uFtZxMenV3NzQdDiVoUzUWJpKJL91lmHSWEqlwU88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fewjPlANvYGEKgZ+XnKE6aFwDwE6diMXg/B7f/yFK4i75CLJvF7wZRgZGyZ37CRetAblAZRS7qJns/OReJ/ApmYhMWggX6GwcqBKe7rB8DDlLPfArgku+TO+fpBdhnhsPK8V6MVOtpmztAEWIxCx1907Ybft3uIUSPtEl7c42yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOX/GWOL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOX/GWOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqXkRiyUxqSbliwQmHVEASu4D/RYGtBd8mGoyCxVF1o=;
	b=dOX/GWOLOMKpUTwLweBt7mlevj7EY1Z3vnSFS7jo0iKI1xua283E0yUFv5gBIS5BSYZxvI
	FWceMEXLqnBs18qPwiLXGC1rq09He03WzeNJRdoaxy54HEYXktLK66mED4YxrTSeTlD6S6
	xEZ1jYjeRMUFXFuscJ6b7k/zKwhh970=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-s9QxYTLyPzeMNegPcpbW2g-1; Wed, 21 Aug 2024 03:19:37 -0400
X-MC-Unique: s9QxYTLyPzeMNegPcpbW2g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a1dab8a2eeso775445985a.1
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 00:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224777; x=1724829577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqXkRiyUxqSbliwQmHVEASu4D/RYGtBd8mGoyCxVF1o=;
        b=Dp35YtEfY59/iPxKjK5fbWyaLOawnzPEHtwfyTYXaZj1AU/7n+Crkul9cgRCiO+vip
         nsDR+RBAs5LyXzi6Fcv4O5ofco9tsZn/Gp9WTsaGzBgwsHwWmtJRna0Zmw35tRSHoJGC
         2WRXDIjNG018R/GlvXL42klcU0+WNig0mVrJ15yjw08zjULhqnmuT3kN6SvP92JM3gdI
         OglfR7xmxQe+SzvUyfHXEobavx87e9fB+oVnRlMyzvHsRKvnwJdm5EDLOzxPiQXG1Zkm
         vyLH7n+ryPsglEvYad47mNYROfHyHALUrsuoqGial0agkdh+YK5AokhqlR2G6MAQHagp
         LRHg==
X-Forwarded-Encrypted: i=1; AJvYcCWfBaYyR1UlAqlmnw3VINQq6fUZArNnKHxlXVZMMlfEsABunaBcn3G5udb05fO2ai++PuRyU8PcPgUQ3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+lRJnqWbMFVYAURJKQEQLg8e/jTkOKsXcrwNo7BfaLfFZli2K
	N4X4MyLL9F4youS9ERMADGFEsDLa2ckoZhvpCIvGh9lnbwVp3Ahl+mX0aeF/55jZJpPs8u2/qt2
	IiZ1VWlUm8yglf31V8eMQpP4K5g2JYEl60pFgN8dmapOXIAsmsxmwtq4IfLZ8
X-Received: by 2002:a05:620a:4723:b0:795:5672:9298 with SMTP id af79cd13be357-7a674057cddmr157582585a.41.1724224776883;
        Wed, 21 Aug 2024 00:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzvsJUVRLWmc58Q7QaiuvVDQhxagsdXHOmahNlcC4bwy6acZdi9NrIfC29BkE+CkLUyoCrrg==
X-Received: by 2002:a05:620a:4723:b0:795:5672:9298 with SMTP id af79cd13be357-7a674057cddmr157580485a.41.1724224776363;
        Wed, 21 Aug 2024 00:19:36 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:36 -0700 (PDT)
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
	virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 7/9] vdpa: solidrun: Fix potential UB bug with devres
Date: Wed, 21 Aug 2024 09:18:40 +0200
Message-ID: <20240821071842.8591-9-pstanner@redhat.com>
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

In psnet_open_pf_bar() a string later passed to pcim_iomap_regions() is
placed on the stack. Neither pcim_iomap_regions() nor the functions it
calls copy that string.

Should the string later ever be used, this, consequently, causes
undefined behavior since the stack frame will by then have disappeared.

Fix the bug by allocating the string on the heap through
devm_kasprintf().

Cc: stable@vger.kernel.org	# v6.3
Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 99428a04068d..4d42a05d70fc 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
-	char name[50];
+	char *name;
 	int ret, i, mask = 0;
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
@@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 		return -ENODEV;
 	}
 
-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	ret = pcim_iomap_regions(pdev, mask, name);
 	if (ret) {
 		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-- 
2.46.0

