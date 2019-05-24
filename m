Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77495C282DD
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 01:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D90C2177E
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 01:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0zpMuds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbfEXB65 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 May 2019 21:58:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36156 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387741AbfEXB65 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 May 2019 21:58:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id s17so8255262wru.3
        for <linux-block@vger.kernel.org>; Thu, 23 May 2019 18:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3oDLwoclKDir+Uf3rm7VnvEeh9KXyN3CG5w+zfmiXQ=;
        b=R0zpMudstZW5mQuJ3tLXFAWH2hHu/WNspiMMPGYKHyztN2l2K5i/NambZNiF531XIx
         KqA9GDfn3F2gd3DiDTA6qhfhNCwgMG3oU8xyONzyzBmYscfHlTPTiJiFJJsLlglrKeN9
         0gRtf4WSYtN39w75AX5tDcxdfRHJpG0JcwfE8t0z3qRbwHnrrZsSJmEPZsGtdVOOTye7
         uabKgqseY6tTj2zPeexbF0Gjiyh4WF9vmv43RVtMf1PIB5kGVeUI62g2EF9oL1T/TkRK
         dtnwM/3TShiE9plEHT1SPGNQGTDRryW90Zqt2flDOB4KZgbzYyzfHCLIaImrypgkUsdV
         34+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3oDLwoclKDir+Uf3rm7VnvEeh9KXyN3CG5w+zfmiXQ=;
        b=ZIi3ML45NGrfi5xKA4P4H4uQrgSfNPkYahm3vuEc0nnvV8GeR3TTahx87qNmZDexSi
         ckFH+esYPs9DGLqzZn4RVGEvql7/KBc4gEXOk7yzqwukdXd67Xm7cvevBEsUzWFkbXKf
         Ft9Zfyxx88Wz+WaNWcagZ+6oPeqWZigLGusnm7RQRvR3tHZTXANe9q36lDXB83oPxYPq
         ZkM1AcKIXzmhJTnC95Pme0CZ4uFiKtMol6QQzve56UwgrlKvOfsGre6TBMh0HWScY01m
         RtDIRCRm8/3/NXP0t6JuuCZCVXRry81y48PXnDThDJMuWkcc3Csn1Wg5IEkDZ0OhIppD
         sx6g==
X-Gm-Message-State: APjAAAUD5TYzN9Z7lfPSr8pnI6QPhL6c6TPlVdTM8lqtvPY2Zh5Hz1B8
        jDiyXnM1l+iLjQ/OIYh3pPDP2rTPyD+61roZRQY=
X-Google-Smtp-Source: APXvYqz3/cn9wlQHUbWfiFzt/peWgLSDdX+MqBnXTepxw8gPZClNkuOvm0b5qwXODdVPDMbgk1wkfGEu60ty+eTZ6hE=
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr265795wrq.115.1558663135199;
 Thu, 23 May 2019 18:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190523214939.30277-1-jpittman@redhat.com>
In-Reply-To: <20190523214939.30277-1-jpittman@redhat.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 24 May 2019 09:58:43 +0800
Message-ID: <CACVXFVNr_-A2u=8=Uni4K7HgfEBc2g1JAFfW98TY2tZKzcH9+g@mail.gmail.com>
Subject: Re: [PATCH] block: print offending values when cloned rq limits are exceeded
To:     John Pittman <jpittman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        David Jeffery <djeffery@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 24, 2019 at 5:50 AM John Pittman <jpittman@redhat.com> wrote:
>
> While troubleshooting issues where cloned request limits have been
> exceeded, it is often beneficial to know the actual values that
> have been breached.  Print these values, assisting in ease of
> identification of root cause of the breach.
>
> Signed-off-by: John Pittman <jpittman@redhat.com>
> ---
>  block/blk-core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 419d600e6637..af62150bb1ba 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1199,7 +1199,9 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
>                                       struct request *rq)
>  {
>         if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
> -               printk(KERN_ERR "%s: over max size limit.\n", __func__);
> +               printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
> +                       __func__, blk_rq_sectors(rq),
> +                       blk_queue_get_max_sectors(q, req_op(rq)));
>                 return -EIO;
>         }
>
> @@ -1211,7 +1213,8 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
>          */
>         blk_recalc_rq_segments(rq);
>         if (rq->nr_phys_segments > queue_max_segments(q)) {
> -               printk(KERN_ERR "%s: over max segments limit.\n", __func__);
> +               printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
> +                       __func__, rq->nr_phys_segments, queue_max_segments(q));
>                 return -EIO;
>         }

Reviewed-by: Ming Lei <ming.lei@redhat.com>

BTW, do you still see such kind of warning since v5.1? If yes, could
you share something
more?

Thanks,
Ming Lei
