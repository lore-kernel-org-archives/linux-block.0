Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9214D2B1
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062171; cv=none; b=cyyP5WXtJrc4dyYMOW/G53gPxv3NkcNiFqw3xyDbwWV84aeGcByado6eAZBCB87IL9k9xRZS7PSS0hNiaah27lFxzk00gl6ITRIJHd2L6XNx4dD1BiZmmJvxfH5zYQGF+t3a6tzVPP/hPh5ZUu38MZIZfNSXK4/dccojcYWRJ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062171; c=relaxed/simple;
	bh=/rReCEuAMvcIKbmMv9ogQv0Z3HLmmd9oE09QV3FUlWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeTkD8IvArpByd1zhVJW42h48Hq2kLhPZ/5jVG4deJ0hdDR/SVgEtin1ptvxfGfyaU9PSY502d67Px9Q5af6qvJQ/Fqix6vd4n46DWOnbXldfpo+l3ngmYxg8VBdeB8wMcCuEMlliVViDJdvydVT3ETS7mDgQ6/5EOvZx62jjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bq/9dLZv; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bq/9dLZv"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de528effbfbso1384012276.2
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714062169; x=1714666969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4MKpUjL2KzQj6h5dKRJa50XoAW5l7/ldp0RpO3SKl4M=;
        b=bq/9dLZv+XLsn+Mt2oAST13u4T6rT4u/mW+cRkGpNfloChh+Dg+I1EhfNvAIgC4UAx
         Cw4AYlf7zPZjicBf0VIM6SFmvHj0Yrcu+tVeHZcWeirG/R/2/HRM1CBenDMjqxA4zPSH
         wHEBbamTTgXsRmzwtnwKhEuawpydJEhrJfcP9IZIxABBkm9F8nIdBle191dhamfYNVBk
         cSGslWpE2HtoHV7PCLkv2nNqyGSkYiSACmVvs2Xw63To6Rz2EpdiFDfdzCfh2+F/MI4s
         UB9DkKQJmVZRiiNOGepz1uvVT5NVXDmU8xU9yJYabGE/XcnvylnUQh0IztyJu+CP/HbP
         Ywzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062169; x=1714666969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MKpUjL2KzQj6h5dKRJa50XoAW5l7/ldp0RpO3SKl4M=;
        b=M3rXtEKU4OIrPZ2qu5vaoNxqDj2whv6kJGhpO51TdP1+OfeNzXkc1hMjqM/+/jokQ7
         iwgmb/3Pfgr7rxZ6NsegJ/jqoxssFUQHCiZV2bOOntazJOVqP8WCk1+H6fKhAz3ytuWv
         X+QNmw5v5kuS7L9tCvhrefqlDdIZhu3BRyc/1RuEvLi5/QHU61OKThD7nINlP/ey65gu
         ylklTcmZxPrpx+qmzdqVzSM2UxSmoHmEuUxSZAkr2Fg5HUibKEHPvGNrI0j2mDXcPlwi
         HSDjPgOJkOsUpaeFyyw/4opvmnPk8ByffYCiJklPmqNpz/Wbi5DTuQJFPGAEPZUVuiIo
         f1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCX3ThGtmTR9SJSED2ECTM7aAUX3IV+QnwxjFAtlhvLdLBSEsu5HW7/wG+k4xRkPRnx1D35u2FDEk3VGzZROg8ozYXJsDOiqWhYRLCY=
X-Gm-Message-State: AOJu0YztvtCpPMoyCW87dLm4RjcbTBPs44d5IERBG3YleL08vmEFwLGw
	m3FJkBDQ5VW+wk7Cs7Gw84y8npHE5UVfWGiAhBpTfk9Y/g7ksgz9yVfVVFkekfwdedBcMMZvZA4
	DAjbWZgPjKJUuHIdUrKDeOJkP1TqVIL8laiC/qtYwcahboOnp
X-Google-Smtp-Source: AGHT+IHrGBjRWx+miqjtWMw1Fv88F4iCyOHrsayI3iFSE23Qx1hC89dADnEC3+0DcmZ43uwnayrhh+t5CHgiCqzIknI=
X-Received: by 2002:a05:6902:1b89:b0:de5:4eef:1b5b with SMTP id
 ei9-20020a0569021b8900b00de54eef1b5bmr175734ybb.5.1714062168943; Thu, 25 Apr
 2024 09:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422153607.963672-1-saproj@gmail.com>
In-Reply-To: <20240422153607.963672-1-saproj@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:22:13 +0200
Message-ID: <CAPDyKFri5Zk63vnp6sMRSMfprLCo4SdVBJf-C1zgYQKWyizSJg@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: fix handling of sgm->consumed, otherwise
 WARN_ON triggers
To: Sergei Antonov <saproj@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 17:36, Sergei Antonov <saproj@gmail.com> wrote:
>
> When e.g. 8 bytes are to be read, sgm->consumed equals 8 immediately after
> sg_miter_next() call. The driver then increments it as bytes are read,
> so sgm->consumed becomes 16 and this warning triggers in sg_miter_stop():
> WARN_ON(miter->consumed > miter->length);
>
> WARNING: CPU: 0 PID: 28 at lib/scatterlist.c:925 sg_miter_stop+0x2c/0x10c
> CPU: 0 PID: 28 Comm: kworker/0:2 Tainted: G        W          6.9.0-rc5-dirty #249
> Hardware name: Generic DT based system
> Workqueue: events_freezable mmc_rescan
> Call trace:.
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x44/0x5c
>  dump_stack_lvl from __warn+0x78/0x16c
>  __warn from warn_slowpath_fmt+0xb0/0x160
>  warn_slowpath_fmt from sg_miter_stop+0x2c/0x10c
>  sg_miter_stop from moxart_request+0xb0/0x468
>  moxart_request from mmc_start_request+0x94/0xa8
>  mmc_start_request from mmc_wait_for_req+0x60/0xa8
>  mmc_wait_for_req from mmc_app_send_scr+0xf8/0x150
>  mmc_app_send_scr from mmc_sd_setup_card+0x1c/0x420
>  mmc_sd_setup_card from mmc_sd_init_card+0x12c/0x4dc
>  mmc_sd_init_card from mmc_attach_sd+0xf0/0x16c
>  mmc_attach_sd from mmc_rescan+0x1e0/0x298
>  mmc_rescan from process_scheduled_works+0x2e4/0x4ec
>  process_scheduled_works from worker_thread+0x1ec/0x24c
>  worker_thread from kthread+0xd4/0xe0
>  kthread from ret_from_fork+0x14/0x38
>
> This patch adds initial zeroing of sgm->consumed. It is then incremented
> as bytes are read or written.
>
> Signed-off-by: Sergei Antonov <saproj@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Fixes: 3ee0e7c3e67c ("mmc: moxart-mmc: Use sg_miter for PIO")

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index b88d6dec209f..9a5f75163aca 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -300,6 +300,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
>         remain = sgm->length;
>         if (remain > host->data_len)
>                 remain = host->data_len;
> +       sgm->consumed = 0;
>
>         if (data->flags & MMC_DATA_WRITE) {
>                 while (remain > 0) {
> --
> 2.40.1
>
>
