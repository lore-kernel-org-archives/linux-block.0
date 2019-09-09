Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069C1C49ED6
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D226721920
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 12:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP8VGgpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391088AbfIIM5J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 08:57:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55348 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfIIM5I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 08:57:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id g207so13723222wmg.5;
        Mon, 09 Sep 2019 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiEmvqYHezDokAQjgi5F2Bz251GFyvgk91GEKkm7bgA=;
        b=iP8VGgpjh5evX+wubxCKl7++5k3igSiHYCGLdmun2KD+etOCUES7KuvAqQDXVKxy+h
         h+03FoIKfMknRbS7Py+Zb+6oeKNCSmXrgLubvsUprOJYoiHXmZQM55O2NBMIEYqWjS9o
         YXDoIVK+zo8KvP2Ee5z9vXnESWNrcwwXrS1L0D3QEaQJ5s35GZmtZYVfCQ9x1KKPOV33
         yeam+Qb0dMIYtutaGkl+4rqyj7wPv5YMd+69WsEUSrBQJ3o3ENMyluLcIQKiL4avQ93N
         2AsJc9LOYboUmQz+OA3LdOPvOhjqxgrw6bxAeaUPmVb8ew/B2+bYWxVLKwqybW/2Tnei
         WFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiEmvqYHezDokAQjgi5F2Bz251GFyvgk91GEKkm7bgA=;
        b=cyVmiwLKqCYGpA/GN+aePCwk7g7LrPon4YKh0IYtIbtSazeemKEiLg1R6gNO7RTYFV
         O2xB3aL3Ofdw++IUciT1c4YW8PEkJVSH26PL+fBlnzIj15CVrSfcjebHvXinlrtVkM61
         2giPZoGm4NywtD8yqnphkHZwHiojaw6Zma3NNLqHaaACW3e3z+ngeA8+PdRFYrjqwr8Q
         rIMe2UpSG//f4vvs2EXe5WcP69d9quy5IvuWyTWwjWkbfRYGd03pWlKnYJRvOV+vK5tF
         CsZJUT5Cv6/rW3mCKjOOojAXShVADjBFCXWdIypYy5y5hHZbTNAiXrsLAMiGZh1RltB9
         vsVw==
X-Gm-Message-State: APjAAAVJMeK002gsNI9/ZME/967u2bCUbZC4ymOEFGzk1x/tXuFrqKOs
        wVCHhxn3JYRoVaEnXs3EiyI=
X-Google-Smtp-Source: APXvYqwLjezjywoAPHgx7CY1NFZiNpD7zOOAE5ZJ7jcWkYO7AuQCSFbS50Vhfw2LtFbQb0kXhEmj1w==
X-Received: by 2002:a1c:4383:: with SMTP id q125mr17508299wma.122.1568033826252;
        Mon, 09 Sep 2019 05:57:06 -0700 (PDT)
Received: from localhost (p2E5BE0B8.dip0.t-ipconnect.de. [46.91.224.184])
        by smtp.gmail.com with ESMTPSA id q15sm12601630wmb.28.2019.09.09.05.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 05:57:05 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christoph Hellwig <hch@lst.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jon Hunter <jonathanh@nvidia.com>, linux-block@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 3/3] mmc: sdhci: Set DMA maximum segment size to 64 KiB
Date:   Mon,  9 Sep 2019 14:56:58 +0200
Message-Id: <20190909125658.30559-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909125658.30559-1-thierry.reding@gmail.com>
References: <20190909125658.30559-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

DMA descriptors used with SDHCI have a 16-bit field that specifies the
number of bytes to transfer per segment. A segment's size may therefore
never exceed 64 KiB.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 5 +++++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d814dc004bad..b59d063646bf 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3555,6 +3555,10 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	 */
 	host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1;
 
+	/* ADMA supports a maximum of 64 KiB per descriptor */
+	dev->dma_parms = &host->dma_params;
+	dma_set_max_seg_size(dev, SZ_64K);
+
 	return host;
 }
 
@@ -4410,6 +4414,7 @@ EXPORT_SYMBOL_GPL(sdhci_remove_host);
 
 void sdhci_free_host(struct sdhci_host *host)
 {
+	host->mmc->parent->dma_parms = NULL;
 	mmc_free_host(host->mmc);
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cf3d1ed91909..b543d31bbcdb 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -494,6 +494,7 @@ struct sdhci_host {
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
 	struct mmc_host_ops mmc_host_ops;	/* MMC host ops */
+	struct device_dma_parameters dma_params; /* DMA parameters */
 	u64 dma_mask;		/* custom DMA mask */
 
 #if IS_ENABLED(CONFIG_LEDS_CLASS)
-- 
2.23.0

