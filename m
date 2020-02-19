Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91E8C34055
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A811524671
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fc8JBt6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBSQ1L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:27:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39628 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgBSQ1K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:27:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so1318149wme.4
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 08:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3RfLpkSg4BBxrjUvuH+ZfTwcMR2+u85t8Ne4yuoFM8=;
        b=Fc8JBt6PKQoguEIQYGlBcLTuJrHOI1g5A3hAJnfPRDXX0oNPpUqqxo9Vw/LMVsjgVT
         RH/u/2vlOwq5OlOuy4h9DPOMRzWbwzo2SILUG38tGFyPpJBOCPiAl5ZgPu33mnkQn/RE
         RTr1De5zOA/Fy1vZchUb5xFScRQ8T5XzfSj857wzsSp6/ogkPZ7ymNGWMopWXOYvBWMg
         eTVptxnfZy9vmxiSddnWVsnfCI+iPaSMBWErZJ1ODEje2ZkB6pfASnFmRds6m40QxpNr
         exO7FjnkT0klGMaxaYKzcGn+85Wpa5fG81pM6HvjkeSpMx7NhT1pcqoxQOqldtQW58y7
         NLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3RfLpkSg4BBxrjUvuH+ZfTwcMR2+u85t8Ne4yuoFM8=;
        b=gYoxXn3sRXqTJMrcTXIAulv/A5pRvCsYKDC5bf+gYcGU3aCUtoNT4zwaVKtIGO4CM7
         XeXu5wHTary/qGzCpSEmRMWunJh88cmyA9JiY7SZq7CCA0TCQOfjN7yCMiGk2CXSDWNf
         y41p3ie+h/KQecH9WqM5uhPd+zkLmqqyurAjuyVn5mLnIqUW/4s0s43PmRmzX/3s9Tqg
         6eMRxNLBq4641MLpFPVy+KIB+fR5JP3ke9YGlpYvkSsHXosPSudC9aaKqMuHwdLdRX1R
         yW1TU+UlpLHMsGIoPOpKbFmIKmHCqvl+KJqEJ41rzi/qW68mk8ORVnxio1fhARpseWR4
         vUQg==
X-Gm-Message-State: APjAAAU/QKVcFPgTsGl1yDuXYqIzZ6CY5wAlaHOH9fbzLIgKijXItxVS
        gbfBNrlWJ5oHt5yu6wSOoTfssCeap003iIvOKRzZBg==
X-Google-Smtp-Source: APXvYqx87ZO7cTx5X06jrxGPHRxLE/Le84+kAcqdqUSEz7XmLbhDYZDF35GHnLRFh2odpwgzCR71z1Tn0S8112EnqUk=
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr10927444wmj.1.1582129628720;
 Wed, 19 Feb 2020 08:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20200219162339.16192-1-digetx@gmail.com>
In-Reply-To: <20200219162339.16192-1-digetx@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 19 Feb 2020 17:26:57 +0100
Message-ID: <CAKv+Gu9vOh5vmHTGLYA9nszQfGq-yMRPvyYUhSzwcYJD+ZYKHA@mail.gmail.com>
Subject: Re: [PATCH v1] partitions/efi: Add 'gpt_sector' kernel cmdline parameter
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>,
        Colin Cross <ccross@android.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 19 Feb 2020 at 17:25, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> The gpt_sector=<sector> causes the GPT partition search to look at the
> specified sector for a valid GPT header if the GPT is not found at the
> beginning or the end of block device.
>
> In particular this is needed for NVIDIA Tegra consumer-grade Android
> devices in order to make them usable with the upstream kernel because
> these devices use a proprietary / closed-source partition table format
> for the EMMC and it's impossible to change the partition's format. Luckily
> there is a GPT table in addition to the proprietary table, which is placed
> in uncommon location of the EMMC storage and bootloader passes the
> location to kernel using "gpt gpt_sector=<sector>" cmdline parameters.
>
> This patch is based on the original work done by Colin Cross for the
> downstream Android kernel.
>
> Cc: Colin Cross <ccross@android.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Which block device is this parameter applied to?

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>  block/partitions/efi.c                          | 15 +++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 50138e6826a1..ee4781daa379 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1382,6 +1382,11 @@
>                         primary GPT is corrupted, it enables the backup/alternate
>                         GPT to be used instead.
>
> +       gpt_sector      [EFI] Forces GPT partition search to look at the
> +                       specified sector for a valid GPT header if the GPT is
> +                       not found at the beginning or the end of the block
> +                       device.
> +
>         grcan.enable0=  [HW] Configuration of physical interface 0. Determines
>                         the "Enable 0" bit of the configuration register.
>                         Format: 0 | 1
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index db2fef7dfc47..0c8926d76d7a 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -103,6 +103,17 @@ force_gpt_fn(char *str)
>  }
>  __setup("gpt", force_gpt_fn);
>
> +/* This allows a kernel command line option 'gpt_sector=<sector>' to
> + * enable GPT header lookup at a non-standard location.
> + */
> +static u64 force_gpt_sector;
> +static int __init
> +force_gpt_sector_fn(char *str)
> +{
> +       WARN_ON(kstrtoull(str, 10, &force_gpt_sector) < 0);
> +       return 1;
> +}
> +__setup("gpt_sector=", force_gpt_sector_fn);
>
>  /**
>   * efi_crc32() - EFI version of crc32 function
> @@ -621,6 +632,10 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>          if (!good_agpt && force_gpt)
>                  good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>
> +       if (!good_agpt && force_gpt && force_gpt_sector)
> +               good_agpt = is_gpt_valid(state, force_gpt_sector,
> +                                        &agpt, &aptes);
> +
>          /* The obviously unsuccessful case */
>          if (!good_pgpt && !good_agpt)
>                  goto fail;
> --
> 2.24.0
>
