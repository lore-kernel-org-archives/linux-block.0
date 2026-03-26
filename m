Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A65E208D0
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528478; cv=pass; b=h8bKSafW2OyWcO/9UPvWrwmJvmFtLoz6MGqdfi90/82GxRxyjpWe50ggpbkC1GeNVN6tpURkjfTmt9u50OrT2ueULKiWf9xbmK5Gn59ELfYqVHzuVbLIryyQsgbUt1ovWBYiDep36HEgFal/TRBbwwh5wIshQ+au1bGJ41h/KAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528478; c=relaxed/simple;
	bh=vKbutdKkB7cYgg8PtWY4GjrFMft+n09kmPg3iA2nEv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMpGGNqHJOPlzgfmLceHnNIEX1SZE1Cxp6S2g9pnIQhJhjA0qa5z4ZaH+7fqw96iOJcuoVeavnjNvUBiV36Od4l3gtToNqyWulPh9QjlnHHDLbJyyQGwhEhJs2hFQqCDDPxGbuYRpEUrAeNUULLyfF61oMCUu74R8+Py5xl0eTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JL7Oa7vc; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JL7Oa7vc"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a13a06fc85so1216135e87.1
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 05:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528475; cv=none;
        d=google.com; s=arc-20240605;
        b=R9t+H0vJiw/x6Wx1DUbjJWhlnHVBfOfmI1JynAg/MSAzg5f+h5d3/M1jv2g1fJN0hI
         +3XdeFsG14S0dk/WE2BJtCcjPUCtnHNSA+/m6nFtcoN+t8fLCbPZZciPaiuLgwrhpKls
         mcLb+9BRCuUVwIlN8rVVEQvVNzxzNebBWc17YIHiZTKtIOL0YDPCvltk/fgzN+nLR5Qj
         IT8LmaOpiOSeZj3bsL4pwrqy6joJEgB0GCTkjXtTaWnzp7w9j2X2IofZB6qXXyfQS4Uz
         onLc6n624MK1VPHZUX7b7nre/UR75z0PbraCKVYFlTXJj6GQQOkRIH6FwbQ8ChsB5/aj
         qiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DKfBZ3nUfK2TfojoC1M4yQGHYMzoN7cQZr4Vt9bR1fc=;
        fh=kpsCP3A2Ro2crUO94Vf6N5/zslVsbjHGGUGabL2Tjog=;
        b=HDjf3jit7eq99BlcUJSpH4HsmDIwuIqodDJcCZ+V27FYF6bv+1JHzS2Czij9f+zvLN
         FQGaqxhK5gOsqbL4xiS2ErU+xTzWYwb93AmvUsWu8+TSD+qIAUn/8h4sCU3l3JnySIM/
         n9gHDoJikiO3K47LqpbHPDGkPAHTOjk02QUNZ2bCgU8r1gS4ChuSqszRKYeKV6ir4mDy
         75/i2WC20cC+zfkffJjhOsK0r+hyB+2zr81JSpmwqOePLA+a6SfLkp+Kk9ZDtJOcCQwl
         tV2osFlDevPpptOE91W21AEp9Hha6kcHtNBnapE0gtJGVCXMPeuJVXbQDde2oI7z7wW6
         yq7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774528475; x=1775133275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DKfBZ3nUfK2TfojoC1M4yQGHYMzoN7cQZr4Vt9bR1fc=;
        b=JL7Oa7vc0gQP3LaU9EmY7l/Sc3kiXzVV2l4mvNsVkgnVDbpk6z3rcFSzBF+p6PLsaK
         xIqZlN/lFJO7ucuknZRX6IPGOVvrIS4sw27tR6yQ3o6EkNlbAE3NNC3davrhEXrHDF/K
         D/IGxuhh7kk0SEGtzkRneSgc6WGxXt+FkySAtdsdtZNysDglGBmg/7PVXKcReIu9pt/d
         e6dLSCw88Ct9Bjr2rRc0o+SAf2YLlfa6EzL1nTRXgLWVoqx0cnxuZugvr/kmqe9315rc
         jBpk4uJDAzLKDSvC3ps55265Y/EY7/3IYdyEJAuNmWRogs59r5VwtTPRAqipBit+zJcm
         xKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528475; x=1775133275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKfBZ3nUfK2TfojoC1M4yQGHYMzoN7cQZr4Vt9bR1fc=;
        b=BJJI8G8I82Q85eGB/0dBMSNukGFPzrZvIuE7HjbrBlDchCrJrjNKUw2FzXsXkl3fjw
         i4FMNPm+BD3E4utHcmsi8rotircRCeM0K2qv1095EBi16sa3Ic4Hw07Ppom4Vj/UQram
         akWcKFWmh+jK+ZnnRqZwdOwNHAFFV9J3KIhZkdo2RS91Dr9RKS32Uy7kpW85+Yu367mM
         WrlGx4ex4ZFSTLijy3oi4I9e9e3ktLIBzMXLZLJsOqln91kUg6uNjXaQ/ihsH9Y+mOHQ
         CqFSnEUcGPwel1/TkjgHTOBF+XHF/s1Z8uh5S/QsR0pxRXQHUVoR/TEe8i1RPEL3yFBv
         ullA==
X-Gm-Message-State: AOJu0YznAvSF/4V07gRhBbZsB8jtuH4fbt49JZ/gFP8LMwPNumVoKijL
	OULLiN1P+/klUw3SwK2sGW70IdjQuiEX7ToCnWq1c2gIHRNjMkhEplCdhwmRt6nfOMfvTCtoNir
	fxH72kaDJcDo6HGwPRUQEiOP4ikP6JdK8+DiZJ+Wojg==
X-Gm-Gg: ATEYQzxRKsxXA/DmTsvJ3SUxlPV7jeq83XJ0p0yI+R2tWgSS/QiJcP9dReY4lcQ5vqK
	G36PH34rZKaKtqcEJpW/ninA06FXyhDVgVlViu09w3j3Urq+rjKxX49+P9y1mMlt9opQHE5nsGh
	h9avALwywUS0dfC8gPS1kfZOdcN0C4BKEGuzszzsYZsgamw/TZnqJdVAZXQKnCSzHx3bnrFFiUT
	YRAyx9+R5p5nt4M/Ncotz/ieiM3C4h89lf2cBeW1SHQqJ6CQnhpCR7NXr8KjnSl+pjHWpCDFUxW
	5zzN6eM=
X-Received: by 2002:a05:6512:3ca1:b0:5a2:8636:6150 with SMTP id
 2adb3069b0e04-5a29b977f5cmr3510136e87.10.1774528474999; Thu, 26 Mar 2026
 05:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324143448.2631888-1-b-liu@ti.com> <20260325134947.2799552-1-b-liu@ti.com>
In-Reply-To: <20260325134947.2799552-1-b-liu@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Mar 2026 13:33:58 +0100
X-Gm-Features: AQROBzDsSu0isFOTp7LFpErPbIIJz9mwTZMH7T_NJkSfkIxfgjxejHieQax_j2k
Message-ID: <CAPDyKFq42GDC6V4WZpax_tFM69JPafB9_UOAsfkJN1ZxAP7LeQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, axboe@kernel.dk, 
	shawn.lin@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 14:49, Bin Liu <b-liu@ti.com> wrote:
>
> Due to errata i2493[0], multi-block write would still fail in retries.
>
> With i2493, the MMC interface has the potential of write failures when
> issuing multi-block writes operating in HS200 mode with excessive IO
> supply noise.
>
> While the errata provides guidance in hardware design and layout to
> minimize the IO supply noise, in theory the write failure cannot be
> resolved in hardware. The software solution to ensure the data integrity
> is to add minimum 5us delay between block writes. Single-block write is
> the practical way to introduce the delay.
>
> This patch reuses recovery_mode flag, and switches to single-block
> write in retry when multi-block write fails. It covers both CQE and
> non-CQE cases.
>
> [0] https://www.ti.com/lit/pdf/sprz582
> Cc: stable@vger.kernel.org
> Signed-off-by: Bin Liu <b-liu@ti.com>

Applied for next and by adding a suggested-by tag from Jens, thanks!

Please consider sending a patch on top, that decreases the data size
of struct mmc_queue_req.

Kind regards
Uffe



> ---
> v3: move the flag to struct mmc_queue_req to reduce the scope
>     cc stable@
>
> v2: add errata details in the commit message.
>
> link to v2:
>     https://lore.kernel.org/linux-mmc/20260310160408.3976760-1-b-liu@ti.com/T/#mb201075c9c466a78b58dbb0bf1f39139f0928591
>
> link to v1:
>     https://lore.kernel.org/linux-mmc/20260310160408.3976760-1-b-liu@ti.com/T/#u
>
>  drivers/mmc/core/block.c | 12 ++++++++++--
>  drivers/mmc/core/queue.h |  3 +++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 05ee76cb0a08..db8c99c73a61 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>                     rq_data_dir(req) == WRITE &&
>                     (md->flags & MMC_BLK_REL_WR);
>
> +       if (mqrq->flags & MQRQ_XFER_SINGLE_BLOCK)
> +               recovery_mode = 1;
> +
>         memset(brq, 0, sizeof(struct mmc_blk_request));
>
>         mmc_crypto_prepare_req(mqrq);
> @@ -1540,10 +1543,13 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
>                 err = 0;
>
>         if (err) {
> -               if (mqrq->retries++ < MMC_CQE_RETRIES)
> +               if (mqrq->retries++ < MMC_CQE_RETRIES) {
> +                       if (rq_data_dir(req) == WRITE)
> +                               mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
>                         blk_mq_requeue_request(req, true);
> -               else
> +               } else {
>                         blk_mq_end_request(req, BLK_STS_IOERR);
> +               }
>         } else if (mrq->data) {
>                 if (blk_update_request(req, BLK_STS_OK, mrq->data->bytes_xfered))
>                         blk_mq_requeue_request(req, true);
> @@ -2085,6 +2091,8 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
>         } else if (!blk_rq_bytes(req)) {
>                 __blk_mq_end_request(req, BLK_STS_IOERR);
>         } else if (mqrq->retries++ < MMC_MAX_RETRIES) {
> +               if (rq_data_dir(req) == WRITE)
> +                       mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
>                 blk_mq_requeue_request(req, true);
>         } else {
>                 if (mmc_card_removed(mq->card))
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 1498840a4ea0..c254e6580afd 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -61,6 +61,8 @@ enum mmc_drv_op {
>         MMC_DRV_OP_GET_EXT_CSD,
>  };
>
> +#define        MQRQ_XFER_SINGLE_BLOCK          BIT(0)
> +
>  struct mmc_queue_req {
>         struct mmc_blk_request  brq;
>         struct scatterlist      *sg;
> @@ -69,6 +71,7 @@ struct mmc_queue_req {
>         void                    *drv_op_data;
>         unsigned int            ioc_count;
>         int                     retries;
> +       u32                     flags;
>  };
>
>  struct mmc_queue {
> --
> 2.34.1
>
