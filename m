Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A215574E
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 04:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739162693; cv=none; b=a7fauDQbgnfvAVeZ0/RLjrMg5fdTQWiaFyCSWj2aCgBKnEDt/7d9XmJ3K/51BjRW2q0jmNHwbtjJyGfsBDMD7imhqL8sfEZeK0VGDiGZCBlW/40bQW7PXUROy449lUIQko/0gpbWV8dYADPugO3ABC2VPxvxoAlTLohMeXq95Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739162693; c=relaxed/simple;
	bh=vTanPSj0WJSOQJ6VK+dSr4V6tineoC/hsdguGdxz6Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Snp9r0eqy/NiJbb/AMMySiFKOf10ooP2qmJi3dIQR7HK5eoKSu2momisn7o9uMKW5//e6siZiLRFJ1m+beL8BKsLCKJCY+/ttZhsA+95J5YuRw0cXYQJD+qECLXIB6oB2mzvYH5DtkihpTnXSGbNny1MQ3yD5cjs5BBiPG3cb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XareteWg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XareteWg"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f42992f608so5871445a91.0
        for <linux-block@vger.kernel.org>; Sun, 09 Feb 2025 20:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739162691; x=1739767491; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nF3QMZZh+uHZ+XUypTIOVnYHXZf3sl/wR22/LqBDNSc=;
        b=XareteWg22SH0Jwhxaz2ViALmGAbvbFygvDRPm9MZUSIPSIcwOjCM+A0wXeZ8f9t1p
         gDampvr0OUV8RZ7ZVNLc37aceoCvw+XrI6MfGKKJKwC95v/U3yBHwlDNE9pBxXmjjSEM
         Aal+FesM1awuKFO5quF8KUzfFZ6eGR7Xs5afXKBpix19GLp4BlnhKLEYzLZ0FlG1OptU
         FTSujHq6XpN7y/vozITYu4jj+g6zjs5DApAM5/pwRhhnWhhN903cgUJIEDSWJtFoaDlv
         VANmO6yvc1FSQywTt+3oLAF0dnHZT1ST3NFIWqcUGoy9CYil5++0KG04BSveoISHbWwD
         NIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739162691; x=1739767491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nF3QMZZh+uHZ+XUypTIOVnYHXZf3sl/wR22/LqBDNSc=;
        b=auaWzRhG5xiFALgAIRAlfXYQE9bFXpLZ2nZStZhzgek2zjSAhliBoiE8mEWUjgQia3
         18X3JqZOEBghzabCCMn3uFwXZOnCrec6ujGCDABYzwJPI9HBOtll/wvfHCsOeRIxbhZJ
         jhw9/zCs0msMOIUnk58c9hbyy3BmO+T49D8jOXPZTqv7DLrl3zmeA5R1vfxfW6yERRuS
         JbzCOBTxhBxG7RfvSLknkZJw4ckYOl1tm/KRZ2NKcZ/Nawj3aU6elkn5XVZNPEyQnGfY
         OZNsBoFEWqjaONIccB+jrlCI89CXBqVZP6wUyhySDBS3qfljVoTYEJTKK2+2QyNKeQp+
         n89g==
X-Gm-Message-State: AOJu0Yzaqz+EYv5iCq21PlAUGLBiNxwImi8c8892Yz82cggJpm/vEMEY
	4nwWU0WayIh3v6ZdbkCLrmIHvyZWa9c3RD/CeMprwmCcca7jmCXIlJ2agdfYOQ==
X-Gm-Gg: ASbGncvUI5FiddWI2450ukvRAbrJwrM+P+m7mtbnZ2QQoK652NeyXPRUK8eK0W/wEmM
	03xF/1MoE7/ozUk7TzBUf2cIjdUXzDUMZZyAnFRu8M3uzUOEMz/Z6OeVXnoWltA+jUDzHvoCNcT
	X6DEAb9Wc2Cbl5QfnWqgK/m7YatoXICuDLKjCP6HB9Z/nI+ADPcMVbdvtD1TyF9ADDQby/puD8J
	8ichVGZ5fpCCPLNe/JWOaHINc0qHFcDA3IZR3xrTIbb9uX0AkEscuEdrT/M5EB92byTJFwCQRgC
	nefdiqe4Ag1zS8vGZiuDDy8tjC7W
X-Google-Smtp-Source: AGHT+IEI8FeVLv0rFukXvhLSeUcosU07zHjT/arxCxm962h4GX5fHHBVasy2JjWBqSIvNTOBRXSSKQ==
X-Received: by 2002:a17:90a:d443:b0:2ee:5111:a54b with SMTP id 98e67ed59e1d1-2fa243eb4dcmr16162251a91.31.1739162691261;
        Sun, 09 Feb 2025 20:44:51 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09b3f803sm7611469a91.32.2025.02.09.20.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 20:44:50 -0800 (PST)
Date: Mon, 10 Feb 2025 10:14:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Gaurav Kashyap <quic_gaurkash@quicinc.com>,
	linux-fscrypt@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v11 7/7] ufs: qcom: add support for wrapped keys
Message-ID: <20250210044445.vmtfhqjibonhi6j2@thinkpad>
References: <20250204060041.409950-1-ebiggers@kernel.org>
 <20250204060041.409950-8-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250204060041.409950-8-ebiggers@kernel.org>

On Mon, Feb 03, 2025 at 10:00:41PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wire up the wrapped key support for ufs-qcom by implementing the needed
> methods in struct blk_crypto_ll_ops and setting the appropriate flag in
> blk_crypto_profile::key_types_supported.
> 
> For more information about this feature and how to use it, refer to
> the sections about hardware-wrapped keys in
> Documentation/block/inline-encryption.rst and
> Documentation/filesystems/fscrypt.rst.
> 
> Based on patches by Gaurav Kashyap <quic_gaurkash@quicinc.com>.
> Reworked to use the custom crypto profile support.
> 

Instead of mentioning the contribution in description, you should use relevant
tags IMO.

> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 51 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index f34527fb02fb2..dc3eb6f29f5b2 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -132,15 +132,10 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
>  	}
>  
>  	if (IS_ERR_OR_NULL(ice))
>  		return PTR_ERR_OR_ZERO(ice);
>  
> -	if (qcom_ice_get_supported_key_type(ice) != BLK_CRYPTO_KEY_TYPE_RAW) {
> -		dev_warn(dev, "Wrapped keys not supported. Disabling inline encryption support.\n");
> -		return 0;
> -	}
> -
>  	host->ice = ice;
>  
>  	/* Initialize the blk_crypto_profile */
>  
>  	caps.reg_val = cpu_to_le32(ufshcd_readl(hba, REG_UFS_CCAP));
> @@ -150,11 +145,11 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
>  	if (err)
>  		return err;
>  
>  	profile->ll_ops = ufs_qcom_crypto_ops;
>  	profile->max_dun_bytes_supported = 8;
> -	profile->key_types_supported = BLK_CRYPTO_KEY_TYPE_RAW;
> +	profile->key_types_supported = qcom_ice_get_supported_key_type(ice);
>  	profile->dev = dev;
>  
>  	/*
>  	 * Currently this driver only supports AES-256-XTS.  All known versions
>  	 * of ICE support it, but to be safe make sure it is really declared in
> @@ -218,13 +213,57 @@ static int ufs_qcom_ice_keyslot_evict(struct blk_crypto_profile *profile,
>  	err = qcom_ice_evict_key(host->ice, slot);
>  	ufshcd_release(hba);
>  	return err;
>  }
>  
> +static int ufs_qcom_ice_derive_sw_secret(struct blk_crypto_profile *profile,
> +					 const u8 *eph_key, size_t eph_key_size,
> +					 u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
> +{
> +	struct ufs_hba *hba = ufs_hba_from_crypto_profile(profile);
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +
> +	return qcom_ice_derive_sw_secret(host->ice, eph_key, eph_key_size,
> +					 sw_secret);
> +}
> +
> +static int ufs_qcom_ice_import_key(struct blk_crypto_profile *profile,
> +				   const u8 *raw_key, size_t raw_key_size,
> +				   u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +	struct ufs_hba *hba = ufs_hba_from_crypto_profile(profile);
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +
> +	return qcom_ice_import_key(host->ice, raw_key, raw_key_size, lt_key);
> +}
> +
> +static int ufs_qcom_ice_generate_key(struct blk_crypto_profile *profile,
> +				     u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +	struct ufs_hba *hba = ufs_hba_from_crypto_profile(profile);
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +
> +	return qcom_ice_generate_key(host->ice, lt_key);
> +}
> +
> +static int ufs_qcom_ice_prepare_key(struct blk_crypto_profile *profile,
> +				    const u8 *lt_key, size_t lt_key_size,
> +				    u8 eph_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +	struct ufs_hba *hba = ufs_hba_from_crypto_profile(profile);
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +
> +	return qcom_ice_prepare_key(host->ice, lt_key, lt_key_size, eph_key);
> +}
> +
>  static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops = {
>  	.keyslot_program	= ufs_qcom_ice_keyslot_program,
>  	.keyslot_evict		= ufs_qcom_ice_keyslot_evict,
> +	.derive_sw_secret	= ufs_qcom_ice_derive_sw_secret,
> +	.import_key		= ufs_qcom_ice_import_key,
> +	.generate_key		= ufs_qcom_ice_generate_key,
> +	.prepare_key		= ufs_qcom_ice_prepare_key,
>  };
>  
>  #else
>  
>  static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்
