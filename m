Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B741D7E38
	for <linux-block@vger.kernel.org>; Fri,  6 Sep 2024 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646070; cv=none; b=lKCbp94l+lIBDxgZsLq7uzoGI3wY/Vo8lHZo0fPI0pRIV/y2La4mGGn35MoOaADr83cZn0z7fP+vRmVh5zlYMqMcM5g9LbT7wscJc99vx83Y1dKkJrV/dsMMBUpy1zLlcqniSDx83kF+j4aR7tFC33Q9qqVCndF0iqBW1Sh0gR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646070; c=relaxed/simple;
	bh=+SzQWWDVMW86HWVDS60cROJ9/2CnUI2u/K5om4tgSpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GBCV6nlQF+hNkWMvyV1weGF8wQPGAx154J+3/qxNDDYB813nNiYezsDS7V6FTVx5yqprJUSAdr6G4qiAj3VKtjKDWaPQGoBme/r3g8/8o8scP+dKDVn9CIRBDcsyOPNEOxSwNXgxCa4kj1N5EMSKSj7qNzLJNG1HxryC65DIouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oxp0TMWN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oxp0TMWN"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371ba7e46easo1444319f8f.0
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2024 11:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725646064; x=1726250864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4Rp9n0BNwQ4895eIFb80hCcM78P9qUpcHMtLngVZmc=;
        b=oxp0TMWNRrwONR0HULdAYV826Oxlj4QGDwM11RGlj0RTKGR1PIKNskKnELWs0otv+U
         RYKJBf/ADwHO0hBreWARVLs14JO+lPEbXqnX3iIpaRKuCiEdWkHYIHBfFJ5C0Jrxu37D
         eDEvPSQBWs/hff1gist8Mhrx163x4MqBJDQKTvRZ3JyJC5mXpG9vV4HHgmm5etrJpNdS
         Y29jOh03sTkQfxoovAxMOyXaTop94EmMC7taN2kPuBB+D0sXFuTquGH5l1dg6M60jaO0
         mCW1BIkiKe22MNqEQtKd8/1MulVgt7PqZkW0/2Fwl4Vv7OsB8NqOHqvpH9ho/pXeto1s
         b7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646064; x=1726250864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4Rp9n0BNwQ4895eIFb80hCcM78P9qUpcHMtLngVZmc=;
        b=BJzCNUVEOozc/27QqRn5KJ7WOxmK2Lk5qGUQqduNTHHRGJQf+fHX1P161jTieQjlae
         ktWEls7RsDuwNMUuPHF2zAADvT1bK3x1MFtocRyl68+v6dwPqgEBM48G4OY9m+tzJvED
         wFqaz283ZB3wV8iR6gyzPX5quO6w5zbHmD+AU8GNYy85lrBRoqF9+HqUoHtuLlitrf00
         e4xebfgGtDw+MzXiYIWDw5S6OCiYDcwPt99LN+exwrl52tiVLFkF26CKZJenExnrG8QE
         KLcTE09c7qPkNFFOoRONzZl0C1TlKOg8U4FNo+8Vz7KUztujcx/8WdEq7/kAJSUbPTjS
         716Q==
X-Gm-Message-State: AOJu0Yx1DJjuoinoepswzYkM++nPO4dMoLKIRxpOIDtxIcczOV6YDwNR
	vHxoJxU23s5395LUhyp1oaNhv2fMLCgkTqlIYyQXaoMFVoVLI5nBTcCFWF4pzT0=
X-Google-Smtp-Source: AGHT+IH2YsDkxwkPQZjiiu6/zQYpm6i9d+U7GH+VXs5MPyeRlUy7sq6o/p2Ik86FpQoSiu2NaBEYaA==
X-Received: by 2002:a5d:60c1:0:b0:368:6f64:3072 with SMTP id ffacd0b85a97d-378895c5c4emr2286746f8f.7.1725646063377;
        Fri, 06 Sep 2024 11:07:43 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cac8543dbsm5880485e9.42.2024.09.06.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:07:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 06 Sep 2024 20:07:14 +0200
Subject: [PATCH v6 11/17] soc: qcom: ice: add support for generating,
 importing and preparing keys
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-wrapped-keys-v6-11-d59e61bc0cb4@linaro.org>
References: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
In-Reply-To: <20240906-wrapped-keys-v6-0-d59e61bc0cb4@linaro.org>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Asutosh Das <quic_asutoshd@quicinc.com>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4886;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=2lfyjj0BsRyGQ/zvpv6aD8VegLjKD1SDtsQ+KuI1v/M=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20TYENK22yvZLSPdxN1uaJiLlVnA4ApVgdQsk
 hDsjxprKB+JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttE2AAKCRARpy6gFHHX
 cljKEAC6IG/AdGK5MyYWfWqM5ZKaRmgU5LrtVRLWnyReguDrGu2oqDJ+Xk+Z8FSMpyWdBUkx1By
 xhM8thugAO2N4T2A8Q6uiUq7dWIoicSaGTw84mXVAuV31GTABr+XBgiqG3DppxszUQy43nNXnlU
 bu5yMJeTo6q1za17Bf8CCFnslrclWvGN5XDuGhG96a0JkGMWmOAlXyb+oXLQePuWfFJGqyLMapz
 U35/NUiwPA/YzG6rPVIffK9ezenDGQa5OcInlGDGUCeTmPnK2/2HN/tAYXIi5akDDaCHpRI+3rg
 oWecix9G5BQm7II4kVW3aXig4nga9mEfgPOQiwmMLiTBtVKnjwKn9bPgAKCyZmnwPQdBt+ZsFji
 ksov/Q+Y+X+dSf2Yh5LCiWrGPkmfUqLGcpkae69LO+RLvISQbDVm2X3fSoaKCCnkq8CN3WzkmqZ
 50QT72s4TD7/Dd1IvO0j49oKbIscm46k0fyoNuiPeKcHNcB035C17vDMEg7wwwungwQ0CIg7uxR
 xrXP3S/h63ijIiCeww9FzmdAJokJ7/LuWbeFOjN+mlhFxah60wWDAxgVikCH63U5kxmZKw4A/CH
 rn5rQlEVh2AYrYkuFlyxskAxgbn88jeO6cI65INpFN/wnEZZv0D3DoJDM3I7067yvcD83sjwNLW
 nmIv5IkAUt8C+rA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

With the new SCM calls that interface with TrustZone and allow us to use
the Hardware Key Manager functionality, we can now add support for
hardware wrapped keys to the Qualcomm ICE SoC driver.

Upcoming patches will connect that layer with the block layer ioctls.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/soc/qcom/ice.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/ice.h |  8 ++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 4ed64845455f..1f6d3566b9e4 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -22,6 +22,13 @@
 
 #define AES_256_XTS_KEY_SIZE			64
 
+/*
+ * Wrapped key sizes that HWKM expects and manages is different for different
+ * versions of the hardware.
+ */
+#define QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(v)	\
+	((v) == 1 ? 68 : 100)
+
 /* QCOM ICE registers */
 #define QCOM_ICE_REG_VERSION			0x0008
 #define QCOM_ICE_REG_FUSE_SETTING		0x0010
@@ -448,6 +455,77 @@ int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
 }
 EXPORT_SYMBOL_GPL(qcom_ice_derive_sw_secret);
 
+/**
+ * qcom_ice_generate_key() - Generate a wrapped key for inline encryption
+ * @lt_key: long-term wrapped key to be generated, which is
+ *          BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in size.
+ *
+ * Make a scm call into trustzone to generate a wrapped key for storage
+ * encryption using hwkm.
+ *
+ * Returns: 0 on success, -errno on failure.
+ */
+int qcom_ice_generate_key(struct qcom_ice *ice,
+			  u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	size_t wk_size = QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version);
+
+	if (!qcom_scm_generate_ice_key(lt_key, wk_size))
+		return wk_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_generate_key);
+
+/**
+ * qcom_ice_prepare_key() - Prepare a long-term wrapped key for inline encryption
+ * @lt_key: longterm wrapped key that was generated or imported.
+ * @lt_key_size: size of the longterm wrapped_key
+ * @eph_key: wrapped key returned which has been wrapped with a per-boot ephemeral key,
+ *           size of which is BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in size.
+ *
+ * Make a scm call into trustzone to prepare a wrapped key for storage
+ * encryption by rewrapping the longterm wrapped key with a per boot ephemeral
+ * key using hwkm.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_ice_prepare_key(struct qcom_ice *ice, const u8 *lt_key, size_t lt_key_size,
+			 u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	size_t wk_size = QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version);
+
+	if (!qcom_scm_prepare_ice_key(lt_key, lt_key_size, eph_key, wk_size))
+		return wk_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_prepare_key);
+
+/**
+ * qcom_ice_import_key() - Import a raw key for inline encryption
+ * @imp_key: raw key that has to be imported
+ * @imp_key_size: size of the imported key
+ * @lt_key: longterm wrapped key that is imported, which is
+ *          BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in size.
+ *
+ * Make a scm call into trustzone to import a raw key for storage encryption
+ * and generate a longterm wrapped key using hwkm.
+ *
+ * Return: 0 on success; -errno on failure.
+ */
+int qcom_ice_import_key(struct qcom_ice *ice, const u8 *imp_key, size_t imp_key_size,
+			u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	size_t wk_size = QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version);
+
+	if (!qcom_scm_import_ice_key(imp_key, imp_key_size, lt_key, wk_size))
+		return wk_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_ice_import_key);
+
 static struct qcom_ice *qcom_ice_create(struct device *dev,
 					void __iomem *base)
 {
diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
index dabe0d3a1fd0..dcf277d196ff 100644
--- a/include/soc/qcom/ice.h
+++ b/include/soc/qcom/ice.h
@@ -39,5 +39,13 @@ bool qcom_ice_hwkm_supported(struct qcom_ice *ice);
 int qcom_ice_derive_sw_secret(struct qcom_ice *ice, const u8 wkey[],
 			      unsigned int wkey_size,
 			      u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
+int qcom_ice_generate_key(struct qcom_ice *ice,
+			  u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+int qcom_ice_prepare_key(struct qcom_ice *ice,
+			 const u8 *lt_key, size_t lt_key_size,
+			 u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+int qcom_ice_import_key(struct qcom_ice *ice,
+			const u8 *imp_key, size_t imp_key_size,
+			u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
 struct qcom_ice *of_qcom_ice_get(struct device *dev);
 #endif /* __QCOM_ICE_H__ */

-- 
2.43.0

