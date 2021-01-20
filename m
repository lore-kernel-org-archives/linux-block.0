Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F558C433DB
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 15:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302A923382
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 15:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbhATOuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388833AbhATO3k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 09:29:40 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF4BC061575;
        Wed, 20 Jan 2021 06:28:57 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id k4so19639935ybp.6;
        Wed, 20 Jan 2021 06:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CzqrPjifLSTHMVm2CseEp0L4soBbAOYky+LNWDRochQ=;
        b=EKMpharTDwpUWY4pVgsSQFX8dcRcclXhTfHwwR0mXQdbxFfeNd/+prfHuZ9cI05Ev/
         gPkVcOSyjizZe4t/7LEgV14+dqDQeDpQeXnDbwKjSO3zG8JtnpZ73UQErB8s0ct1V36G
         IXc++10F9qsKQh/hXjo3I5ZUTuF0bUoEPFbfAd7rdzOOqqeamQCPtntIhCIfqnONVhU/
         gly8q12RIksYTGMAF65x5yv5lUeem3QOW7nzAn3KhKPAIBblGuHJZSkJd6UC9bQmeu6K
         11D0RZu8+VEtmKFy+zIEWakOAUL6jNktciyuh63b74V4lWxTPa/fXVv+gdjJpngO7LG0
         /ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CzqrPjifLSTHMVm2CseEp0L4soBbAOYky+LNWDRochQ=;
        b=F4AvGyv/8GpxCWusctD0dcq5fIVzl0zkAFLq7BamCpjaYbzCdRT5gmhwE2HvETOc56
         bPpD+bd8Vc7y7lLK22q4eHTrVz163ApldO5JZ9iUE12Hx86M01sh6410TdyZqFc7m9EA
         /vR7lMy9At/XSKmtWDaXhIgGtZ8kwpGa3uhGod+i0Hqb0NVjVXZQ7PG1AiqW2VVNA036
         cVlbeQjjdzspLC1EeZrLmfhnmccBXh3/kRK/9MARa8x5WmZsLSAICKGSLEi7JT4HEkp9
         bQ5viSFzJclMBUCZjH/1yHU1kkorIlPD9sOOWHWET9QqGUB4m0dahc/5QHxdEmiiITFc
         ZL1w==
X-Gm-Message-State: AOAM533pli+bsJypHS2dVhUvi5CgeY45AXhF+nvKVaeQSR/VIwx2LH4i
        /5F7bHxSK/r7O5tPiR8wsHZYR83euL7I1SCvPSIHPCZHz9tDlKeH5os=
X-Google-Smtp-Source: ABdhPJyLsoNSlH3wnezZX5xFKwG8FPYcT3DetCwzzRFLGSFEENIpzEmiVIngcPvfxdycBZI/vH4XRmqtwmNy947Uv4g=
X-Received: by 2002:a25:9242:: with SMTP id e2mr12940443ybo.405.1611152936516;
 Wed, 20 Jan 2021 06:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20210119105727.95173-1-roger.pau@citrix.com>
In-Reply-To: <20210119105727.95173-1-roger.pau@citrix.com>
From:   Arthur Borsboom <arthurborsboom@gmail.com>
Date:   Wed, 20 Jan 2021 15:28:40 +0100
Message-ID: <CALUcmUnA+7bOtqg9VtaeXsrd079VKpHv+=tNX3LbhKZw7o1QTw@mail.gmail.com>
Subject: Re: [PATCH v2] xen-blkfront: allow discard-* nodes to be optional
To:     Roger Pau Monne <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Roger,

I have set up a test environment based on Linux 5.11.0-rc4.
The patch did not apply clean, so I copied/pasted the patch manually.

Without the patch the call trace (as reported) is visible in dmesg.
With the patch the call trace in dmesg is gone, but ... (there is
always a but) ...

Now the discard action returns the following.

[arthur@test-arch ~]$ sudo fstrim -v /
fstrim: /: the discard operation is not supported

It might be correct, but of course I was hoping the Xen VM guest would
pass on the discard request to the block device in the Xen VM host,
which is a disk partition.
Any suggestions?

(Resend due to the previous email being HTML instead of plain text).


On Tue, 19 Jan 2021 at 11:57, Roger Pau Monne <roger.pau@citrix.com> wrote:
>
> This is inline with the specification described in blkif.h:
>
>  * discard-granularity: should be set to the physical block size if
>    node is not present.
>  * discard-alignment, discard-secure: should be set to 0 if node not
>    present.
>
> This was detected as QEMU would only create the discard-granularity
> node but not discard-alignment, and thus the setup done in
> blkfront_setup_discard would fail.
>
> Fix blkfront_setup_discard to not fail on missing nodes, and also fix
> blkif_set_queue_limits to set the discard granularity to the physical
> block size if none is specified in xenbus.
>
> Fixes: ed30bf317c5ce ('xen-blkfront: Handle discard requests.')
> Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> ---
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: "Roger Pau Monn=C3=A9" <roger.pau@citrix.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-block@vger.kernel.org
> Cc: Arthur Borsboom <arthurborsboom@gmail.com>
> ---
> Changes since v2:
>  - Allow all discard-* nodes to be optional.
> ---
>  drivers/block/xen-blkfront.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 5265975b3fba..e1c6798889f4 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -945,7 +945,8 @@ static void blkif_set_queue_limits(struct blkfront_in=
fo *info)
>         if (info->feature_discard) {
>                 blk_queue_flag_set(QUEUE_FLAG_DISCARD, rq);
>                 blk_queue_max_discard_sectors(rq, get_capacity(gd));
> -               rq->limits.discard_granularity =3D info->discard_granular=
ity;
> +               rq->limits.discard_granularity =3D info->discard_granular=
ity ?:
> +                                                info->physical_sector_si=
ze;
>                 rq->limits.discard_alignment =3D info->discard_alignment;
>                 if (info->feature_secdiscard)
>                         blk_queue_flag_set(QUEUE_FLAG_SECERASE, rq);
> @@ -2179,19 +2180,12 @@ static void blkfront_closing(struct blkfront_info=
 *info)
>
>  static void blkfront_setup_discard(struct blkfront_info *info)
>  {
> -       int err;
> -       unsigned int discard_granularity;
> -       unsigned int discard_alignment;
> -
>         info->feature_discard =3D 1;
> -       err =3D xenbus_gather(XBT_NIL, info->xbdev->otherend,
> -               "discard-granularity", "%u", &discard_granularity,
> -               "discard-alignment", "%u", &discard_alignment,
> -               NULL);
> -       if (!err) {
> -               info->discard_granularity =3D discard_granularity;
> -               info->discard_alignment =3D discard_alignment;
> -       }
> +       info->discard_granularity =3D xenbus_read_unsigned(info->xbdev->o=
therend,
> +                                                        "discard-granula=
rity",
> +                                                        0);
> +       info->discard_alignment =3D xenbus_read_unsigned(info->xbdev->oth=
erend,
> +                                                      "discard-alignment=
", 0);
>         info->feature_secdiscard =3D
>                 !!xenbus_read_unsigned(info->xbdev->otherend, "discard-se=
cure",
>                                        0);
> --
> 2.29.2
>


--=20
Arthur Borsboom
