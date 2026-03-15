Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B54A377EAB
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595523; cv=none; b=BBr2tWisUf80ymxKDKrxcOZkgjcuiTz8cR2Gm1Vpd16kUbOXAUdVs0aEOe+iqUGSQ9/BZQNrCb63fq53h65DfjpShq0aBzZYeIOc7DF7nAQO14m956FtxnJDfJFTNvCf+JW9Oc2jVo5XtHhF552FX4Qa48sEe2rEJi7XGMD/SL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595523; c=relaxed/simple;
	bh=X32PXM6CIYzypQR5TwfD7Jn/cbq77OlrCWR99DHxUpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAg8e2vDF/iI/kKxoEQF/cG7dF7kS3+oP/OmXgqLAAQn90emwEHrpmh4WVsvoVSxk6ArBUdks+yVg3rkBNZ0uIttVmeVgCgySw2r7MHOOnxf/sEX2EonJTbSnuuxbeMvIyo6DyQtRMdddPLhbgendMAQuEU3Bu6zzE6WzdFSzv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVn/lJIS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVn/lJIS"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso33067335e9.3
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 10:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595520; x=1774200320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubQ1v6PBsq99cAcF2yrnS1WsB85d1f/acmJVUU/lg1s=;
        b=OVn/lJISE6nIYTVJ/aLvnPsBrPeMZbwCysxgFTAiV7KsOpGZZ1N+8CoWT4pza/yvHz
         pCvfPpuYfn/UsJcvGHOItAspz4fKEDIx1Xg2rj9HJBExqWW09yEZ5qDxTKIQ0HnVEaws
         eWd1/riC2qzHSgIfO6qIGErNFVTRVW2pUAi7neTLkK5+mXIBLO8Yq7xQc1Jf9Y4hMvGf
         FK2yq+acgLUukcvmtR2Ona064ozquy6IygiZgrPaxegHnU4343kpPQUjoVoj2GGokC45
         bBjH11U305OTpOgSay8gv+wp73nEd5biFLR/nwFUHL8oivBCysLyAz6eM8lDI77pJHIA
         F9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595520; x=1774200320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubQ1v6PBsq99cAcF2yrnS1WsB85d1f/acmJVUU/lg1s=;
        b=AvJZ39XyJwd5AJ21U25HzkNRwVAGek+CjIjMZx2hxPy4B4fIBog8R8+1PG88khxEbe
         +jXOCADiZkPwc8fAsgcWFa7m97vREKkhR1zCCFaLX0sEbJhLyy3v+FLoGvC51nOmpiBb
         etPgjLdzRsUgCIn84UNO/Sbdt3oae88V0JBsHpEBVPh+hnszqoPvWvsrAqg2dHrBROGN
         jpgL7okJxoMuqVOkAh70QNajvYNGmUvfVKJ9bz7CM/0KTnRgvHzBoJNE6S29n2yQGBIe
         UJbFeHxfxopNXjnWePjvn8uqkkrKXC5YOD15+0PPRLpqbXraIoKIa0yxXO1CM1PL/EbD
         rp7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkPPWaAn4b29BGuhuHJZuACLbgPz6mXkoWg5oIGw3XyiGHnbYxhzLU5UKASuz0FMfuRHTVOotbJopA7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEuVXUSgbgQiPn9+odU5wv81qeIbjmtlozGv5VPnkbQ7HqxSfa
	FsDMN0F5OaXGvR5ID1b8Zs471HPiKQ6AZvw7Jnso/vMx8UmiBa+3sGuy
X-Gm-Gg: ATEYQzzvk/IxSA5eQ5+kTFTd6eCKncCYqIzWtpPzltuaMrgrriZ6FfedhVv433PG6Bj
	6b31t5euZIFlV0yw5XA679TmqYcdXIeTaYAkt69b/1uH5uUTitybDHy29487MqhSllg7e81fY54
	FBnSITo51ia2BDXUB4GXchMlA2BIr67yQjf7jCvbzwTiz/nA/GF0gxryFiGZ5uZ3IZX0F34s5K5
	8PTPfSggikEUhww1sO6AnghtG/Dc2/dIUnI9ngJyjVPIM9GYzP5ue5yAttnLdkv+OLekzwZAzTo
	2tWl75Opbe0U+xJv7E66HBkPjW7sCrWCK+il46eoPemTfMS+XsOqXNgqlj4bWYx3eR5lzHa1cjB
	VDXh83jTia9gD08fcKbXrbmuq6NQdTDw4/QZniPdBTL01s8S1uOT4AAgrFAUEFO2z6mib61E6Sw
	Os7mAZfpajZcwGEs2dPLsJM4PnNe1gpbr0/IzefAGSc2eSDg==
X-Received: by 2002:a05:600c:4592:b0:485:3dfc:57a with SMTP id 5b1f17b1804b1-4855671044fmr171605205e9.32.1773595519800;
        Sun, 15 Mar 2026 10:25:19 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73easm457168325e9.3.2026.03.15.10.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:25:19 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>,
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: consolidate imx25/35 data and add Kingston CID
Date: Sun, 15 Mar 2026 18:25:07 +0100
Message-ID: <20260315172507.270480-4-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315172507.270480-1-adriangarciacasado42@gmail.com>
References: <20260315172507.270480-1-adriangarciacasado42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate esdhc_imx25 and esdhc_imx35 soc data into a single shared
struct since they share the same flags. This reduces redundancy. Also
add the CID_MANFID_KINGSTON definition to quirks.h for centralized
management.

Signed-off-by: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
---
 drivers/mmc/core/quirks.h          |  4 ++++
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c..d736bb4be 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -15,6 +15,10 @@
 
 #include "card.h"
 
+#ifndef CID_MANFID_KINGSTON
+#define CID_MANFID_KINGSTON	0x70
+#endif
+
 static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 	/*
 	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a7a5df673..9cfa26722 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -256,11 +256,7 @@ struct esdhc_soc_data {
 	u32 quirks;
 };
 
-static const struct esdhc_soc_data esdhc_imx25_data = {
-	.flags = ESDHC_FLAG_ERR004536,
-};
-
-static const struct esdhc_soc_data esdhc_imx35_data = {
+static const struct esdhc_soc_data esdhc_imx25_35_data = {
 	.flags = ESDHC_FLAG_ERR004536,
 };
 
@@ -391,8 +387,8 @@ struct pltfm_imx_data {
 };
 
 static const struct of_device_id imx_esdhc_dt_ids[] = {
-	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_data, },
-	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
+	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_35_data, },
+	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx25_35_data, },
 	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
 	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
 	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
@@ -414,7 +410,7 @@ MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
 
 static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
 {
-	return data->socdata == &esdhc_imx25_data;
+	return data->socdata == &esdhc_imx25_35_data;
 }
 
 static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
-- 
2.47.3

