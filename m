Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9989AC43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C76206DD
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="GDSxW0v3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCFOX0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:23:26 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40944 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCFOX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 09:23:26 -0500
Received: by mail-ua1-f65.google.com with SMTP id c5so8998950uaq.7
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 06:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qANxxl4F5cUMCRHktO/ZwT6lUVBD7vqQ0Z6XlrNYP8k=;
        b=GDSxW0v3dUjrjT8jN9d+JQqFhEr6KqTluXbbh8Hgge25lQzxBkLSHgJNRjoLIo/agb
         lbyVSQHB+1vs1ozC8WuYYIrwWw0G8Kx478drbVJ7hLhuTo3jhCdM7rsw2c759H9IlXkZ
         ZSepLqCkcr2cIx1ALzhfxWqHcBn+uRVWnCFa0RRzrZdfVOZHEodUlvD1k+u1P0HrG0Fn
         fHfyWJjuf3PWNWwrEFK41RIj/U1hfoBh9+QWTAz10qU5MEaq064ZU5FDxb4BKXBk5B0J
         mYGHWAJJ5V2LZzRbiYQEoqJXzJlPIU9jm2nkXVojfGWXRf4DjI0qfJV8tuK3CLO933/W
         tlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qANxxl4F5cUMCRHktO/ZwT6lUVBD7vqQ0Z6XlrNYP8k=;
        b=lHmGD5KQRm/yKzRUMbUojW1kJmaYG0rsCmJyVJsR5rpb8vMGr01ryIMgqL0gzPaqKH
         kv+ukmmCnoPaPQEkdoA0msciMxKtMw84Bs57hG5XMfccD3QA80r+RUNMvZqKoeiQhipH
         CLTKZYo4I3bbvqkBaFHtexrovKmPMEx+TbdhtBjHJO85Rq//IYON7kPZTPzFoUdAtXhD
         8jhEss/ROp0BLMN2kJtWHTTSuDAVpkrDjzmoM4ozX9Zme2KLfFBLp8xkAK4E/Yw/Ol9Z
         w1WoW5iZDqmVq9qYQAzfhbFW+JYr0oeGhqFmgHfG8ft5lIsp2k6QpaTUjWq8T/JIc8R3
         v+qA==
X-Gm-Message-State: APjAAAV4ytZ6A6yDw9rjBFUB2mau4x/iiWyBDJCgAQLLo7TNEYIIFZb3
        vyxICh71hGs24v03fmXEkrxB7kqvjlBVjL+VduzRF/r0DF0=
X-Google-Smtp-Source: APXvYqxck8gHH+IP6WiQ5W0Ypdgtb5+fM1zlnXNBFn1c9gszZwS4yPEQTvDi59BGg0Wl3AVoErUSLAXhuodOJKuhMaA=
X-Received: by 2002:ab0:45cf:: with SMTP id u73mr240684uau.18.1551882205105;
 Wed, 06 Mar 2019 06:23:25 -0800 (PST)
MIME-Version: 1.0
References: <20190305135120.29284-1-igor.j.konopko@intel.com> <20190305135120.29284-7-igor.j.konopko@intel.com>
In-Reply-To: <20190305135120.29284-7-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 6 Mar 2019 15:23:14 +0100
Message-ID: <CANr-nt1DOptyLhdba7TMK-r=vaqt-LuKN_YY7C7ELbW9c0xeiA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] lightnvm: pblk: Set proper read stutus in bio
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 5, 2019 at 2:54 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> Currently in case of read errors, bi_status is not set properly which
> leads to returning inproper data to higher layer. This patch fix that
> by setting proper status in case of read errors
>
> Patch also removes unnecessary warn_once(), which does not make sense
> in that place, since user bio is not used for interation with drive
> and thus bi_status will not be set here.
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>  drivers/lightnvm/pblk-read.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 1f9b319..6569746 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
>         WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
>  }
>
> -static void pblk_end_user_read(struct bio *bio)
> +static void pblk_end_user_read(struct bio *bio, int error)
>  {
> -#ifdef CONFIG_NVM_PBLK_DEBUG
> -       WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
> -#endif
> +       if (error && error != NVM_RSP_WARN_HIGHECC)
> +               bio_io_error(bio);
>         bio_endio(bio);
>  }
>
> @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
>         struct pblk_g_ctx *r_ctx = nvm_rq_to_pdu(rqd);
>         struct bio *bio = (struct bio *)r_ctx->private;
>
> -       pblk_end_user_read(bio);
> +       pblk_end_user_read(bio, rqd->error);
>         __pblk_end_io_read(pblk, rqd, true);
>  }
>
> @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct nvm_rq *rqd)
>         rqd->bio = NULL;
>         rqd->nr_ppas = nr_secs;
>
> -       bio_endio(bio);
> +       pblk_end_user_read(bio, rqd->error);
>         __pblk_end_io_read(pblk, rqd, false);
>  }
>
> --
> 2.9.5
>

Looks good to me,

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
