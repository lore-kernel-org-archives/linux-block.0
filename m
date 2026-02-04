Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E521CF7D5
	for <linux-block@vger.kernel.org>; Wed,  4 Feb 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215481; cv=pass; b=aqRob5qtGkFrl6k4itmRtiPiW7B+rc1XfKdtwnNypk+q8YiQEs8v4zWRoIvJd36ekuJpbLZnJ8t/Z6KEksLsSKKfjxl5ExmKm28ySxnynP3pYv6edmuUwii0Bdm9fb3GsiGHxPMTNq8wymybAGBhUfhiDdOoDAg5H68oDJkqro8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215481; c=relaxed/simple;
	bh=VeU1M/+PLjDRdSdinp+x/60VrhCRA3f0z0U08KL3du0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMW9OlhgTej5hhWMxKw7k+0vASNZj4OWn31o/IZIICCVtKIRx/YP6m4dm6au2eh9c/aD384rDFh8pQNIm0E+Q4a590tkldDSu0cxHnjwB0J0ANpcDvzsdaCBp97TaPxe4JuXKkwE3DuiYSJNDrKpYF7KOHh2ScMxKiZipYvhMzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cVGIRotZ; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVGIRotZ"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-649dbff9727so1159322d50.3
        for <linux-block@vger.kernel.org>; Wed, 04 Feb 2026 06:31:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215480; cv=none;
        d=google.com; s=arc-20240605;
        b=TaFCrdePkkEyLIcs3flLgh+IsON4qA23NK2ITGwVN1C8bUssg6bB870ji1lwq9AdDA
         S17ock9FnPluZs2JVBDXlSUPV14JPvRJosSnEyot5Hp3EWGSZMzLu+HCePJI+MfVJgH/
         9i4FSi1/OGB0XZ1uLqFSjIvXCwEmUQxIaEni0jv/frQdvZB1DRjr8N5ywYe4T+WeXRg+
         fXpJAdYRY/QNrgdJ0PT58arBrH/DZVxNCIktzhgocUuN5dCwY1HnMHceMrVqqkBaq82z
         S9Etle6W4NqmSlKAIplwzKkyzlJTY3ml6M3bSCiBZoOxiysq6RysBAxWXyt/Famxx5VJ
         wZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dI+cml2Ore4hIHpIJvCr+cPhA0RJkwTrbCvVMmSJFk8=;
        fh=CtqKfInXfN04wsF7PFVIzxaWNNmTNlagD7A1VCj0LI8=;
        b=Qi+ydJZY3cDYnRgzaCBjwkvcsIescY9jYsbvR/QyHmAnTtdx5SW05cdCogqL1B9aEm
         z/jMR4briP2k+jeqZCioTcsroexz/GXdgfM77JDUx6dicX98bVGOuqARpDOD3b98TZpW
         qeUnQq4K3kUUkMy/GQ6U5bIXIGEh9Dbe9Mviv34rWCkKmoM6UEVDVgO/YiwdrNHOBKVx
         JI/ZoVkMfXg36sFTksuLVUtM+3dHL63+RWKVXwJ0wWbH6vrftfYMVhf7Ne4mKhLSZpsc
         mpy2RueoAXMZgDp0Pn5DwcjZPsfdJJrBqP2WuJ57HFfOsr8U2PuyLZy05GzHmXB98JoG
         TTMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770215480; x=1770820280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dI+cml2Ore4hIHpIJvCr+cPhA0RJkwTrbCvVMmSJFk8=;
        b=cVGIRotZeWoXwteae1+pUw0PuU1R3gckrsrRbUmOHUs336JjKKecQj030iJTPuCKOz
         8mo813apBO0a1SadlbMFURGvxLIy7EwBQsK91/V64xx+hkZJRpk1YDBz5QkxDr4PEEJQ
         BaE9eBsZzrZbiq/RCnxe293Hw1jNXYW8eMmASyID8JcWIRTfCgfBju70TOFMvPx3/o1y
         rZmmcRnOV01pPAa/mIobR8RVsU/Do/nN80Qgs+OZpgZR2mBTDBYsLCn6V7a4EGDM+Rph
         xaiTAyVATTAho13twlb97EsTOwD67nXw3/NsqoTA3Lj+Csd7oHNgdQUgbSa6dxUl8w7z
         cjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770215480; x=1770820280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI+cml2Ore4hIHpIJvCr+cPhA0RJkwTrbCvVMmSJFk8=;
        b=NuhHww7L9NdiUJQ1xu92v8KOEwj5wXyEoPHabotNJsV/We5AVWtNTB/FUrcwDnpHsx
         pUlxzob9q3xYRMZvJq1lS+jgNsPoXiOnSj5g08iIlovCT1MV0AYmI/Et/aFb0ISorg1y
         2FF+7f9UbqYposMICZSIm2UJ6jGVOyvdDrS/WocIfdAy8541TpEDicD8km/8oO7+HJoE
         SkRvvPVT+jJkbLiFANJ+g/MvKi5XWXIfVqpmX7106MwX/z03+8SsNmwPsMF2rwiBGUGo
         +DoN/OOiDHYkz/Z+uK00/H0zwIRebj0ZoFmhr1qRBeDjJiUfyYRA8WQGVoPzPrqKdbGo
         3ucg==
X-Forwarded-Encrypted: i=1; AJvYcCVkjcGULe+CDUat+Qw2l4Rcve2IaCdpr+NikQAgKJspZ4wzvvu15xl/YJD7tJ2mXJw41S6RNPA+aQLZig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LIhaeeBn7/tFE/rBBHnc9DknPcMoYMe2gh7KXhsFwAFUY3VS
	xcveSB2ZYmmA3az8h+c22/dsquaThU1TP7Oebri2oP+BIzBNS8oLm2vlJR147xBGAsYFun63Skw
	Xq55UvfZ+qjiDe7nykndboT6floAnMu/rtWeEWC9kUV9OmU6nKIpD3h4=
X-Gm-Gg: AZuq6aItT22kO2ISYL1QBBGurvV3YsBwQ05/jY+VUbJeOLQBW94l54uT6eT91Ebc8fh
	v+7rukG18/boolvZXAIEpxBv6L8v4lKQyxS/t27J1u+hvAH8a2aY+m/MrxFJB9LvCgKzpzyIcNt
	zsz2wMcAyzEOp9CrQR+tdVYvI82zXWnILHWc5pYR/MbVn54xRH23+Cx8m5A4tWexYvsLh2DDIAL
	bB+blzw8DwLEW5U+aFmZs6wXS1RRwPDpu78//OewxFtYYsgYgGEHtWdTwkW2kPdy1r/SXlV45aS
	toZjDxc=
X-Received: by 2002:a05:690e:11ce:b0:649:64d4:8127 with SMTP id
 956f58d0204a3-649db33311emr2635192d50.4.1770215479555; Wed, 04 Feb 2026
 06:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204034003.2961402-1-ziniu.wang_1@nxp.com> <20260204034003.2961402-3-ziniu.wang_1@nxp.com>
In-Reply-To: <20260204034003.2961402-3-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 15:30:41 +0100
X-Gm-Features: AZwV_QgI7Imdfxcsknmh62CBzZI03NFl9MPDU-nwW2BMZCSmMmoB66KvDFFoZiw
Message-ID: <CAPDyKFr1UhsDakJaP-W39=n-DhM4F0KTWTaEwXZRmLpnKa+y=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mmc: add quirk to optimize certain Kingston eMMC
 secure erase/trim performance
To: ziniu.wang_1@nxp.com
Cc: axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Feb 2026 at 04:38, <ziniu.wang_1@nxp.com> wrote:
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

Even if the optimized performance requires patch1, I decided to apply
$subject patch as is for next as it doesn't make anything worse as a
standalone patch. I also added a stable-tag to it.

Patch1, is better merged via Jens' block tee.

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
> index a9619dd45270..a7c364d0030a 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -311,4 +311,9 @@ static inline int mmc_card_broken_mdt(const struct mmc_card *c)
>         return c->quirks & MMC_QUIRK_BROKEN_MDT;
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
> index f5e8a0f6d11b..6f727b4a60a5 100644
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
> index 4722dd7e46ce..9dc4750296af 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -330,6 +330,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY    (1<<17) /* Disable broken SD poweroff notify support */
>  #define MMC_QUIRK_NO_UHS_DDR50_TUNING  (1<<18) /* Disable DDR50 tuning */
>  #define MMC_QUIRK_BROKEN_MDT    (1<<19) /* Wrong manufacturing year */
> +#define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME (1<<20) /* Secure erase/trim time is fixed regardless of size */
>
>         bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> --
> 2.34.1
>
