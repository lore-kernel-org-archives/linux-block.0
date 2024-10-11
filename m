Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438011D0DF0
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672903; cv=none; b=gD2gWlgXxZucZFKecWaW22AcWPCYuUQMXLNtckY74My05MXQibfqE+F0Q4qp/ljTSRFpPQwAs5ry0+zISfAMqdcSoKUNhizS1Xf+b+ulXIaHUFB4xBImo99jg9NIJiyL2yqRfnUFrJ1RQn+AKIf6QwpGLdr6rb4Fy0aBqfvZlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672903; c=relaxed/simple;
	bh=OIWWabmelC5btwN2gfeevvPbxnebFsy0zVddm/OruKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HI/Q7RaVdPUYD7Rp4cyBbv0RVcOSyrGACoh+EPNKH60pxD7++dQ3txpvrBwRrfmfQcq/HZmC9q1xzI98D2DvXpY1Vh1NSZnQdzSUj5Euv+oCc9mE2PT4yLkInhogMb3yWs++P+1sBkCzq/IRGMyKp6atEGSZnia+FTVVPOMFTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=G/takFEN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G/takFEN"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-430558cddbeso15442645e9.1
        for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672893; x=1729277693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJWiTUDuRR7vOAvQq+eZZdwnLB5y+NGdJReP7c36nPQ=;
        b=G/takFEN0BzAGP36Vm4TlsJPdHzbZLpEw8uv36p3LEMFmnd80JL1Cn11wSsunIU1sr
         IIrPLfKrcKE04uQZHJxMf1NqC+DhnrKCM7SyNw2zQDGnNF0jI1GOpZBII1rPIHLG0ARw
         MghlbCiAiBDVDT82jV20OajIn/41Cy4XLRhwlyDL0k/OLz/jnaOxRMClsxaYP/SXDOPY
         bvE94LIxHNHUkV3yf4uftqtoP51E0mzapYiBVKnG7KN0TzlHoXeRUotmyueo/vg2f+fv
         7CpStwelIHF8y4ncE/o2ojjIg248JjdmHKvpKzTwWQGtQhbzsxp2vEfdFrNdsizs6xuy
         /sJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672893; x=1729277693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJWiTUDuRR7vOAvQq+eZZdwnLB5y+NGdJReP7c36nPQ=;
        b=OWRZ+OQLmuMRPk5JI5Wvv+KRpAaXECfGyaG4sjwOR7e11MfYTORvZdjlqzjo3xaQv+
         DA+JzgLAHU4DmDVCEp3xXlryJWBakLfiEMlczeL3XQqVOkghDudXSLOCQDfqFChza1Ly
         J/xlb0ty1KcVtyRckuT5tuFIIU9mgmdZJyiVvEsg4ShUxmB8Ihdp8TeBiVTBbGOxfthJ
         i/ihaO5tBeBYS3DraDjJ3ZSUXIJQ+u9tLo/BD1t1s14Qfkx+bGmj+e5ZAMSOM/e29+0e
         7AdyKFsDyvQXXUq499bq21V/gr4WVoDnaE7UAm6F+q3oIwrfS0N9f4477qY81KIVJYYd
         QY3g==
X-Gm-Message-State: AOJu0YxJCh2Q9Ac+EUsPjfuWmV7f2Zo2jG1egAK9XfkfVOwx+T+vSF+6
	3Rua5yg0yfFOV3drwKJ93uMLVNDfUcXcUdIld7r7bE9TWO3QN56HQt+6XOyt6VE=
X-Google-Smtp-Source: AGHT+IF4oPL/69dvloN/ttCbmyTZVnb7zids2XsRUs2vvmnifEkACtdYLqCY02BzZ1634QY6/vy55A==
X-Received: by 2002:a05:600c:19d1:b0:426:63bc:f031 with SMTP id 5b1f17b1804b1-4311d88444fmr28494055e9.1.1728672893399;
        Fri, 11 Oct 2024 11:54:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:16 +0200
Subject: [PATCH v7 17/17] ufs: host: add support for generating, importing
 and preparing wrapped keys
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-17-e3f7a752059b@linaro.org>
References: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
In-Reply-To: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4227;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=7z0AVztT5cMGpKL1HOXiPwLEES90yGUwCX8SCOsuW3M=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXRh2LQ7bAQ7CKxS1EQC/uEajCQAo6Z5GLJTK
 XdDvQt2bvmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0YQAKCRARpy6gFHHX
 cmERD/9iIKvoDWCKjog0/bhMPZvD8+KwCdCudAqeJomfaC53GCIhB55GfJB9IvaqB7GITu6o1Hx
 pB5Owey9Mczn/fnrP3IBnkT+ExpEg9S0RC9B7kKDlO+0D8t1FdWgX/PPa0p3OTAugqOGEbMr+tO
 ywY3a+9yf3oNvwMlLIbiElfE5apx4PoQMJmVV0gDsM+/FfSm+1vg98FxuVm6yTBkL5Pul1toJX2
 0ToHYVD7S3IR6DVI9H/prAY3LZhhqlZQLrCempZWfJxqHsUpEihJGnWXTz0MNXnuaiu/uJBsOw+
 6+IdZp8u6u94M8jOIZRB3+ZYstukyF0mnse2DFOuOfMd09VFMSeJIPjbPxaeDhvdGR7Vjl3AfeH
 Y2n40Ca84gGNZRQH0Ug2Rov4BuUUZoD/LVBFEqOr/cgfcWK34hLQrwC53XoApnxq5nQl5aME7Ix
 i+LGaZaNxEz/WFZKcZU+jAShzzR7brXh9zYAD2eAKFJKMX6sKIgH/VlVl3r20q9d4HyHRZf1VZF
 xafLajzlgytdG5AzMClH3QVbQg6YwarQka35XEEtDzbkErocGzKHTPdOnjj594AcGvDNFOMs1pm
 YaNP7GGIBf9XLF9Pue0N/T+Rru1jQtTwt420hOPlUAFhVlbHoWbmwmfdPNgOla5U4c6iXvZSrZk
 aADVpm6/ZZMgxrQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

Extend the UFS core ops to include callbacks for generating, importing
and prepating HW wrapped keys using the lower-level block crypto
operations and implement them for QCom UFS.

Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 34 ++++++++++++++++++++++++++++++++++
 include/ufs/ufshcd.h        | 11 +++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 862e02bf8f64..180e13a44b36 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -195,10 +195,41 @@ static int ufs_qcom_ice_derive_sw_secret(struct ufs_hba *hba, const u8 wkey[],
 	return qcom_ice_derive_sw_secret(host->ice, wkey, wkey_size, sw_secret);
 }
 
+static int ufs_qcom_ice_generate_key(struct ufs_hba *hba,
+				     u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_generate_key(host->ice, lt_key);
+}
+
+static int ufs_qcom_ice_prepare_key(struct ufs_hba *hba,
+				    const u8 *lt_key, size_t lt_key_size,
+				    u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_prepare_key(host->ice, lt_key, lt_key_size,
+				    eph_key);
+}
+
+static int ufs_qcom_ice_import_key(struct ufs_hba *hba,
+				   const u8 *imp_key, size_t imp_key_size,
+				   u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	return qcom_ice_import_key(host->ice, imp_key, imp_key_size,
+				   lt_key);
+}
+
 #else
 
 #define ufs_qcom_ice_program_key NULL
 #define ufs_qcom_ice_derive_sw_secret NULL
+#define ufs_qcom_ice_generate_key NULL
+#define ufs_qcom_ice_prepare_key NULL
+#define ufs_qcom_ice_import_key NULL
 
 static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
 {
@@ -1847,6 +1878,9 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.config_scaling_param = ufs_qcom_config_scaling_param,
 	.program_key		= ufs_qcom_ice_program_key,
 	.derive_sw_secret	= ufs_qcom_ice_derive_sw_secret,
+	.generate_key		= ufs_qcom_ice_generate_key,
+	.prepare_key		= ufs_qcom_ice_prepare_key,
+	.import_key		= ufs_qcom_ice_import_key,
 	.reinit_notify		= ufs_qcom_reinit_notify,
 	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
 	.get_hba_mac		= ufs_qcom_get_hba_mac,
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index c172c1dd9209..c52acb486688 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -324,6 +324,9 @@ struct ufs_pwr_mode_info {
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
  * @derive_sw_secret: derive sw secret from a wrapped key
+ * @generate_key: generate a storage key and return longterm wrapped key
+ * @prepare_key: unwrap longterm key and return ephemeral wrapped key
+ * @import_key: import sw storage key and return longterm wrapped key
  * @fill_crypto_prdt: initialize crypto-related fields in the PRDT
  * @event_notify: called to notify important events
  * @reinit_notify: called to notify reinit of UFSHCD during max gear switch
@@ -376,6 +379,14 @@ struct ufs_hba_variant_ops {
 	int	(*derive_sw_secret)(struct ufs_hba *hba, const u8 wkey[],
 				    unsigned int wkey_size,
 				    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE]);
+	int	(*generate_key)(struct ufs_hba *hba,
+				u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+	int	(*prepare_key)(struct ufs_hba *hba,
+			       const u8 *lt_key, size_t lt_key_size,
+			       u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
+	int	(*import_key)(struct ufs_hba *hba,
+			      const u8 *imp_key, size_t imp_key_size,
+			      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE]);
 	int	(*fill_crypto_prdt)(struct ufs_hba *hba,
 				    const struct bio_crypt_ctx *crypt_ctx,
 				    void *prdt, unsigned int num_segments);

-- 
2.43.0

