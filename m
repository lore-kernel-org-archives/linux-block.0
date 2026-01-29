Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20D284689
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699310; cv=pass; b=QlwYIaAmbqARstTGX9Y2s5GEg9gdqZyOupROtKUBjHgcYfbEZ5zVlZKnnoKkPODZ5S7iMYvreLeqNE3tpOZVvmFusgDlsiwgFYCBEDgA2zjiqR6ze7T5ZHbbotPggYuq9QufMDjHHiigv4E1yX82o+7J8kSLy8ITKTTXaxMgGTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699310; c=relaxed/simple;
	bh=icJfGEMZ/bEneEGHfyxw3xR/IsDT8xHGAmMQsYbh2mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QH16GYjLHmr6/s2GlEYf/A2p8I2O+l2zvC++mgdznvZO4dC6qpeUFrGFGwkHYMV7yf802bhM0YK1mLXAUZuxmLqlsS3XuaJN+LfS68tr9iIp1mKIwLS6KJ3XuaobRvWzfYCGsMf5etNAX8XRtRL3kNSIt62plbm9meaq6p7o3Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FB0iOL7C; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FB0iOL7C"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b6d5bd575so1039702e87.1
        for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 07:08:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769699306; cv=none;
        d=google.com; s=arc-20240605;
        b=losc50RcNewUDaUsijYb7qXNjuNtGIeV2kWsrsEoceVHpD1HoZTbiCz4LRsN+d/+UY
         B/fwl5ajBk5QD7N0G9v7NVfkw3V1bT/L920QTrSZeEWv9iNlI/E7uGhdAF17agLZEQUu
         U29mhrcc6Mf77Vax+XgH9UkIMNJgEnmWdN14jIvD337ds1WmTcnsK27/3JROFHCklBzE
         pOLYWG9812N5uF/XqG/hGBo383NgwX7rn+fNC0TrjjLWCyAqjudLJK64xg0SQaACHmX2
         gtxgSEOVrkTAno6bL1HlQEce8LekRiGUct5lBdwZaS/fKzS7qHmImUSpNdsHw7xGCjYn
         BDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mxIu4Zy59sS+vnAzfLOcX1hJejpcL3RkLwTgRMZy0rQ=;
        fh=Vy00XvOdna1fK88eYPQb8N00260twPw74dTeUjOLd3E=;
        b=Oj87Q9ju6iLY9bILfbGAxf955DCr1DQvy2YZxmOMpif+BK4mNTbdtIJ/V7zxEKtCZj
         9lu+/vyISaKVMW6n6a32OWkNlBeDWF0CNWA8bsU1qRwKFSL69ri3z+2svsDb1d4h/HWe
         SzrNY9Cbq0Dn1jJu85Kd7+EoNN/1vy8SBUQsi7DLK9fn/MNdwvRLz+ywR3t6lqwvS+QD
         MoxUlOAOKaNmP0FcmXCv3nridFdF9iy98gx/8XLrGPGxjfxPvQfvedKF82UwmF7OymVs
         6icS39HSCcJzt2mMo20jUrMA3vF3lx1cY++CSbjVNrxRosu7Etn4hzovkbwRPQtGXEXq
         m+sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769699306; x=1770304106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mxIu4Zy59sS+vnAzfLOcX1hJejpcL3RkLwTgRMZy0rQ=;
        b=FB0iOL7CEm0YWSvSkUcNEG3Whw6FcT6GSDUTTTDVh7+MzHEYLl8CtJJdQGJEyFwbbu
         OTuYGG6QQQnLfJn49JivslxH6L/e9qY5ixNL1PL/KcIvesrK/yocl3YBlllYTWnXpwZ0
         YihQrO5MqXy3B4caBHDCVMpD3cmyVeoKrzJpUOBBlz+Cenip5CEITjZq5LAWUqnHxgD/
         seml0C+2R5wsipNa7A6hfzi8iT05VH/xWZQCFhHz/Gl7NKNiwHGZZcu5lRUbMNFjby5o
         jElaBvpvzgehXZ2N7NxkGexsXzy8RyAWqDT2Jo5o51VSIypcKolzdb2wQi3SvwtRdYwS
         eP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769699306; x=1770304106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxIu4Zy59sS+vnAzfLOcX1hJejpcL3RkLwTgRMZy0rQ=;
        b=oEKGCKejon6xBMMXm6lyymE/fYmE+qhjCw0Ag+Ioi0mcoiMTmTbWEYO/H6TTSt9yP8
         Tk/bnFr3Fi8h3hz/zrD9aM803rWQ0JTmvbfcAYIZ6uZ/ezU3YFN6ai94mPTgFrdbL4FG
         IAEg0y+RzdPIsDUTc0rS8PX4la0a0M2tlkFlVug2JLKN0XqEpuMZrphRAXqX9mUAbveH
         YJGws7iWVSfIO8HvlFX6CaBPknUDTVP2eatNoJDM9Kqmaq/OiW+csxAQQVWaYibUxRr1
         KogFEi5rIwQDhxdFJ75Z7+RxuwWaFLuf7YhmwHka05CHJlm5VRN6mKjL8h04AxTSMiLF
         BliQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkSBkUTj7auNlDE2RZyTSXutOY5lNQKwIbLg43ZtWNRIZphHTWP2FYSPZeixwnXK2sBWC0e30VFSGkeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKOCVUf+XxYFrweml+Tm77C1tU37wKUltC40UrlU4aw20fmFTv
	Wrmuv+upVZDOI+feAjsm76/PGdbIl3bpbxd3LX2Ak1xVBSeYZZJyp8TLN/2dxDGXil1mLkHiB6B
	mbNz+jCyRFdduLkTdTh3DbSLjzfCB+V/ghKfHptNsEA==
X-Gm-Gg: AZuq6aJFBrDKbCw9hl3Mj8La4M8M3pYuh1FKiCQAeTMjdJeM2XRs5fjuT9iHgv9EgYv
	edF+zEp9LrLCzQwbKA2xNQ4OkISTSufu4bUQSuxErR90EKTyJgB+WJz2qAw0dD9z0gC4qVt/94X
	KMx9yS/Fe/SQJzLZ9a0Ali7m2jCSAqavh2hegGtgDQy+uvOlO09fj67TcnFS+/eL1fZOXz5LQrV
	9QEqyQ5SaZWS91l9P6czbhVkUZrOr+vpUIWtpu4+OuJgm+M/BuKjKzaJyzTYAsEzjtInumF
X-Received: by 2002:ac2:4e08:0:b0:59d:cb35:44ab with SMTP id
 2adb3069b0e04-59e04017b54mr3697288e87.14.1769699305914; Thu, 29 Jan 2026
 07:08:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215102010.608421-1-ziniu.wang_1@nxp.com> <20251215102010.608421-3-ziniu.wang_1@nxp.com>
In-Reply-To: <20251215102010.608421-3-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Jan 2026 16:07:49 +0100
X-Gm-Features: AZwV_QicTnxYZa9_aQJZVlGxEGtVj569eS16RX-pa4PTkAgIzD_uM0U5gBRdqC8
Message-ID: <CAPDyKFp0mDkLXOCh8gDzHt4KkCreYOFk7-Hzsfb9ySy14nezXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: add quirk to optimize certain Kingston eMMC
 secure erase/trim performance
To: ziniu.wang_1@nxp.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Dec 2025 at 11:18, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> Kingston eMMC IY2964 and IB2932 takes a fixed ~2 seconds for each secure
> erase/trim operation regardless of size - that is, a single secure
> erase/trim operation of 1MB takes the same time as 1GB. With default
> calculated 3.5MB max discard size, secure erase 1GB requires ~300 separate
> operations taking ~10 minutes total.
>
> Add MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME quirk to set maximum secure
> erase size for those devices. This allows 1GB secure erase to complete
> in a single operation, reducing time from 10 minutes to just 2 seconds.
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

FYI, this looks good to me, but I am awaiting a new version of the
series due to Christoph's comment on patch1.

Kind regards
Uffe

> ---
>  drivers/mmc/core/card.h   | 5 +++++
>  drivers/mmc/core/queue.c  | 9 +++++++--
>  drivers/mmc/core/quirks.h | 9 +++++++++
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 1200951bab08..0a198a2c2616 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -305,4 +305,9 @@ static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
>         return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
>  }
>
> +static inline int mmc_card_fixed_secure_erase_trim_time(const struct mmc_card *c)
> +{
> +       return c->quirks & MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 284856c8f655..eb1053d8cae7 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -184,8 +184,13 @@ static void mmc_queue_setup_discard(struct mmc_card *card,
>                 return;
>
>         lim->max_hw_discard_sectors = max_discard;
> -       if (mmc_card_can_secure_erase_trim(card))
> -               lim->max_secure_erase_sectors = max_discard;
> +       if (mmc_card_can_secure_erase_trim(card)) {
> +               if (mmc_card_fixed_secure_erase_trim_time(card))
> +                       lim->max_secure_erase_sectors = UINT_MAX >> card->erase_shift;
> +               else
> +                       lim->max_secure_erase_sectors = max_discard;
> +       }
> +
>         if (mmc_card_can_trim(card) && card->erased_byte == 0)
>                 lim->max_write_zeroes_sectors = max_discard;
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c417ed34c057..1f7406c0ab03 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -153,6 +153,15 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> +       /*
> +        * On Some Kingston eMMCs, secure erase/trim time is independent
> +        * of erase size, fixed at approximately 2 seconds.
> +        */
> +       MMC_FIXUP("IY2964", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
> +                 MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
> +       MMC_FIXUP("IB2932", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
> +                 MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index e9e964c20e53..1882267ef201 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -329,6 +329,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
>  #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY    (1<<17) /* Disable broken SD poweroff notify support */
>  #define MMC_QUIRK_NO_UHS_DDR50_TUNING  (1<<18) /* Disable DDR50 tuning */
> +#define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME (1<<19) /* Secure erase/trim time is fixed regardless of size */
>
>         bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> --
> 2.34.1
>
