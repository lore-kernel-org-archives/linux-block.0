Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8B7C636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 20:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBPU53 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 15:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBPU52 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 15:57:28 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045A44CCBA
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 12:57:27 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id w3so3586288qts.7
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 12:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzSraNHal0QwWiBz7ixtga3AF0evBVtXKNCBRPNfcU8=;
        b=yHWKrh6L+A/LEv4avnrpHYYZs5jM1YaEXQ9aIE0ePDSmBY9JkccH/5q8CoKzEwYvQ4
         t4UWOqDrSjGXYimbH30ZC4ZSMAQAcHs9d57hAVBa8eK1gpxez0aGCkEysePxOqC8hs86
         TPulnCIDnA4jrYZL0UNdKHQu9YBxlTKqvWtMelhmESbfKQteC7p8odDmMwr0jGVfrPXQ
         2jDH+D5xEiNgZZaH+wHDPaVYJ9uZxWMXlLi8YmG0sutKDz6xAEXxt5A6wV5qWRz/q0tP
         H3RTdeFpystzohjR+zxqQz+grwn63oPH3r7NhIRsFbUmMySkXubLbpYRVaPfJj21G4DI
         flUg==
X-Gm-Message-State: AO0yUKXmtrpvlNwAwXb9cgsPZTfRiRU+v/2L6QCMlalwzXSuWnb46UL2
        9EPN8AQrB8SB/cThTZbrhvZF5g9OGobXmg==
X-Google-Smtp-Source: AK7set99SqIBuKkYxmikXi1RG0NBViBcSUtJ47i+FMetYV7dI0cYkkCsgjicGwRgTiogX2Y4XRrIqQ==
X-Received: by 2002:ac8:5f88:0:b0:3b8:6b23:4fc2 with SMTP id j8-20020ac85f88000000b003b86b234fc2mr10941490qta.15.1676581045796;
        Thu, 16 Feb 2023 12:57:25 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id m5-20020a375805000000b006fa22f0494bsm1836526qkb.117.2023.02.16.12.57.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 12:57:25 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id i137so3726401ybg.4
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 12:57:25 -0800 (PST)
X-Received: by 2002:a5b:e:0:b0:951:12c7:5836 with SMTP id a14-20020a5b000e000000b0095112c75836mr344539ybp.163.1676581044900;
 Thu, 16 Feb 2023 12:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20230210010612.28729-1-luca.boccassi@gmail.com>
In-Reply-To: <20230210010612.28729-1-luca.boccassi@gmail.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Thu, 16 Feb 2023 20:57:13 +0000
X-Gmail-Original-Message-ID: <CAMw=ZnQUOLXiQf195tufdMo-8UCw=QgqFwewkSTDzSaKidYF2w@mail.gmail.com>
Message-ID: <CAMw=ZnQUOLXiQf195tufdMo-8UCw=QgqFwewkSTDzSaKidYF2w@mail.gmail.com>
Subject: Re: [PATCH] sed-opal: add support flag for SUM in status ioctl
To:     linux-block@vger.kernel.org
Cc:     jonathan.derrick@linux.dev, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 10 Feb 2023 at 01:06, <luca.boccassi@gmail.com> wrote:
>
> From: Luca Boccassi <bluca@debian.org>
>
> Not every OPAL drive supports SUM (Single User Mode), so report this
> information to userspace via the get-status ioctl so that we can adjust
> the formatting options accordingly.
> Tested on a kingston drive (which supports it) and a samsung one
> (which does not).
>
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
>  block/sed-opal.c              | 2 ++
>  include/uapi/linux/sed-opal.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/block/sed-opal.c b/block/sed-opal.c
> index 463873f61e01..c320093c14f1 100644
> --- a/block/sed-opal.c
> +++ b/block/sed-opal.c
> @@ -487,6 +487,8 @@ static int opal_discovery0_end(struct opal_dev *dev)
>                         break;
>                 case FC_SINGLEUSER:
>                         single_user = check_sum(body->features);
> +                       if (single_user)
> +                               dev->flags |= OPAL_FL_SUM_SUPPORTED;
>                         break;
>                 case FC_GEOMETRY:
>                         check_geometry(dev, body);
> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index 1fed3c9294fc..d7a1524023db 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -144,6 +144,7 @@ struct opal_read_write_table {
>  #define OPAL_FL_LOCKED                 0x00000008
>  #define OPAL_FL_MBR_ENABLED            0x00000010
>  #define OPAL_FL_MBR_DONE               0x00000020
> +#define OPAL_FL_SUM_SUPPORTED          0x00000040
>
>  struct opal_status {
>         __u32 flags;

Hi,

Any chance for a quick review, please? Would have loved to have this
for the 6.3 merge window, it's a super simple change.
Thanks!

Kind regards,
Luca Boccassi
