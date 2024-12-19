Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97A224B19
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734616126; cv=none; b=f+6U/5xcFefytU+BP6dQt/ULrCj8guILrsjendHmFRyoQStO+wwW9gvk9q3Hczm+gLYElWZrTk6j4WY8oEgFEXveBdhvqOZQckIfsk7WvKPA+MDjt8Om1dIvGPlYkFJetUgEegTmkPIZydf2vrl8qDusBjQH5u4UTW749wvRn+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734616126; c=relaxed/simple;
	bh=dx8Z8zcbcEcD/p5AehdRTmFyVw4r+v5gMACGHmVdmnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CX2c3qyUmN0wa16GUWSprLqUC/klKSJz70xzGjdUaoGvuMlI9m26Vwdbjuw93LHuiD+SFhci/mZd5GsJ94GUr/K9mDcBCHq8IQuKgZLlNV5iL9A9jtOgIbtgo2EuqVnfW0I2L5U3+NXxB0JZztMQ7N7C6vOIpz7zmoQk1op+teQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y0DhZ2zG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0DhZ2zG"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f3d31808e3so6103167b3.3
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 05:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734616124; x=1735220924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mXO1JWc0dzqo7dfc1rG4WRHfe9+6B85YYjaXMsQpUk8=;
        b=y0DhZ2zGrPLufsp5oM/sv6BhZoyfMB7L+eEQCEXGWZ3Fer8puvLITpgz1CDDdwCYWd
         m3YZiBIoXqxpkbpvaofaX4jNpzOqDlyxV9CPp/xiqBKcDGz9XgSTzxCclJeImKu0CBXd
         VhWGrOP611xZjSg6ywj6lZEIzRI2PbsWlaincQ7bIUxot36FlXRCYaveC9VeZ354CUrm
         1s3jJbFAowsRWT0xgNxlPR5dUQUPP5ZzRT8x6jBLu4zxxr5qIlEW2gm6jxiaao3JOtmB
         7Dijau1IQWUEWR0kfBpIdaKJbScBTmTWEx7W5eyQUZXWodXUiTui4K2zINvl5Z1enYxO
         vsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734616124; x=1735220924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXO1JWc0dzqo7dfc1rG4WRHfe9+6B85YYjaXMsQpUk8=;
        b=sEVv0qlG4DDzCtmKdBlFOiDkt3NRVomJ7lGjBieV0QzShO0G8DjUJ4JGX9fKn+b10z
         ZkPDLRWPankAjTjWu/15fFIpNwNTTjnot7iKmdgg5cTbHqPX93y0I0HJRJHz9a+cPoNZ
         3Ppx0Bh8ICZAfhZzfiPNxidVZWXO0NkCLtD61uSTG6B0zQ/obx6q0Y8sBN9pTLk+vjjR
         S2AcTSz7/m+lEku80ngii790H97dFuklLf+9uDpWbyxLq4S9xje6fQaCkSWMchrgdyXJ
         EVWLYVlUZUq9vobdlPUB3dfksPNUFpuQq+cpNvghwRMalDjzNnHRg9/KUdJ9CHo3IuZz
         ZsZg==
X-Gm-Message-State: AOJu0YzoU4cgRkZaH0PxQLHX4GvCASeI26Ad7PxZ/rhlb4Ht456h93EI
	sesZ5dmRUwJlCQHDLVG5OCQdHiEqUfiu+0Zx+PW2/1O+aHMTHKE/Un642A36UYrExsYojJ1+AW+
	v/ggFWMqUNVND8bhzs2x/uRbmusIlgmpkO+O7rQ==
X-Gm-Gg: ASbGncuayKg2HI9QaxV/HLHjSgn+5TT+M7TBRARtmsw3jITdNTpdHjnF4ZQm+OZh83y
	upxIWD0e78Jqr7PTWTFIT478QSYG3H4a29kt4nwI=
X-Google-Smtp-Source: AGHT+IEjwcNyQmxYJWNy9sVDcxIilhG2jovJzAG4uTM2E71ZmGRx+o9hvF/TOHyKvnCLrmN7UM5vvGMWJdIs1tMfv4k=
X-Received: by 2002:a05:690c:6f83:b0:6ef:4fba:8151 with SMTP id
 00721157ae682-6f3d1e85c3emr52273637b3.19.1734616124150; Thu, 19 Dec 2024
 05:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213041958.202565-1-ebiggers@kernel.org> <20241213041958.202565-7-ebiggers@kernel.org>
In-Reply-To: <20241213041958.202565-7-ebiggers@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Dec 2024 14:48:08 +0100
Message-ID: <CAPDyKFpgM4oGv=KYyiS5qE5yznAYhMuHBm5pP6S4OVenLjecrQ@mail.gmail.com>
Subject: Re: [PATCH v10 06/15] mmc: crypto: add mmc_from_crypto_profile()
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Gaurav Kashyap <quic_gaurkash@quicinc.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Jens Axboe <axboe@kernel.dk>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 05:20, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Add a helper function that encapsulates a container_of expression.  For
> now there is just one user but soon there will be more.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-crypto.c | 5 +----
>  include/linux/mmc/host.h        | 8 ++++++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci-crypto.c b/drivers/mmc/host/cqhci-crypto.c
> index d5f4b6972f63..2951911d3f78 100644
> --- a/drivers/mmc/host/cqhci-crypto.c
> +++ b/drivers/mmc/host/cqhci-crypto.c
> @@ -23,14 +23,11 @@ static const struct cqhci_crypto_alg_entry {
>  };
>
>  static inline struct cqhci_host *
>  cqhci_host_from_crypto_profile(struct blk_crypto_profile *profile)
>  {
> -       struct mmc_host *mmc =
> -               container_of(profile, struct mmc_host, crypto_profile);
> -
> -       return mmc->cqe_private;
> +       return mmc_from_crypto_profile(profile)->cqe_private;
>  }
>
>  static int cqhci_crypto_program_key(struct cqhci_host *cq_host,
>                                     const union cqhci_crypto_cfg_entry *cfg,
>                                     int slot)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f166d6611ddb..68f09a955a90 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -588,10 +588,18 @@ static inline void *mmc_priv(struct mmc_host *host)
>  static inline struct mmc_host *mmc_from_priv(void *priv)
>  {
>         return container_of(priv, struct mmc_host, private);
>  }
>
> +#ifdef CONFIG_MMC_CRYPTO
> +static inline struct mmc_host *
> +mmc_from_crypto_profile(struct blk_crypto_profile *profile)
> +{
> +       return container_of(profile, struct mmc_host, crypto_profile);
> +}
> +#endif
> +
>  #define mmc_host_is_spi(host)  ((host)->caps & MMC_CAP_SPI)
>
>  #define mmc_dev(x)     ((x)->parent)
>  #define mmc_classdev(x)        (&(x)->class_dev)
>  #define mmc_hostname(x)        (dev_name(&(x)->class_dev))
> --
> 2.47.1
>
