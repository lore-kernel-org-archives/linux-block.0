Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C119C43460
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 11:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4157B61350
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 11:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbhDLLUi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbhDLLUh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 07:20:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA724C06174A
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 04:20:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sd23so10967683ejb.12
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5YvfV6E8Wx2noDcxwD+O7Hq1kDhVwR0r8Nu0UCq0ACg=;
        b=Gt34rsHWZ/A/px8rFTuSWwvvUS2D4NxnzfJeTJAfyzmlzvkVIWqBCLZbtip5ArrlJC
         HvRxhNf4ZkhUwXPlWlvwoDC1y7QI7OEF2H+9BmlRmAiHimvn819u1EzyXzq1NS+1n+DA
         98K43d0vzZPeqwij+phwk/6LB6GpAMiaoGN1w+iVxkGbOA0K1jXS1owe9K7FwOoGSK3p
         Cw/mDTux5f8rV1dKo7dvQi68hhc8qJUXyZoQ/uaahzMQ8I5cqWZy5oxBN82pYST/mgq5
         QRbzBO7GPVTBJpwTugh/DPoFr66Snfissvk5biLFpd7mBJfGxYE+9S0OaA8mCkBPkm9x
         HvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5YvfV6E8Wx2noDcxwD+O7Hq1kDhVwR0r8Nu0UCq0ACg=;
        b=HVKy485nT1i+AOuKbtKYQpCROPBRN94faNAhwUJvEYZ9H79wnVPx4lj3q/8Tnk4DZJ
         S6b+sz/uIFEOtT0drE7qprHYLm3MBrQzbrXnUq50th8JD6EpCThQ/NtlmnefbdCSwiJq
         aLRmIzPm/6Er03cpde848s7YQPIRqPZpLScpiCOX4I8RnF5SrdtkosXjDVwmUTn5vYSX
         nJ81UK1s3P9rZs0rIeSUPl+DERe2nt70BLaHCEIPZRVY69C6umkb2J1IbAFAGlXbiUCb
         frcfi08WsTqy/GTmEHKNEoaXDThQ2XaEV1EtJVSP8ytHDM77mF+L3UFYP7rdqIdbPz0w
         6IYA==
X-Gm-Message-State: AOAM530ftFUwYzSayliBWjzYXkR5UV+3xcQUMCm0AGF+qFo7q5unrtNV
        m++NzhQDFErKFLYawEo5QlPUcA5GzcOT/1ZPV+7P/Q==
X-Google-Smtp-Source: ABdhPJy7+4R9+HiXT6JKGBoZfxRJ6PWlUoocdBengEkuRthOHwy8HX9XdN5XIzRS1SIGL+VyHWMV5OZRYVa7TGAefoE=
X-Received: by 2002:a17:907:d1b:: with SMTP id gn27mr26535092ejc.227.1618226418509;
 Mon, 12 Apr 2021 04:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210412081257.2585860-1-hch@lst.de> <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
 <766257ca-4dd7-e20b-aa79-6ac3984567d4@lightnvm.io> <20210412094938.afyxzspcohw63zup@mpHalley.localdomain>
 <3bf88f25-d06d-5b95-7eff-dfb8f78bc389@lightnvm.io>
In-Reply-To: <3bf88f25-d06d-5b95-7eff-dfb8f78bc389@lightnvm.io>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Mon, 12 Apr 2021 13:20:07 +0200
Message-ID: <CANr-nt0YpZ0CuREDu613LM7yBK_qgPfwg-bNU-T=2me5GJT=Gw@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: deprecated OCSSD support and schedule it for
 removal in Linux 5.15
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 12, 2021 at 12:20 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrot=
e:
>
> On 12/04/2021 11.49, Javier Gonz=C3=A1lez wrote:
> > On 12.04.2021 11:26, Matias Bj=C3=B8rling wrote:
> >> On 12/04/2021 11.21, Matias Bj=C3=B8rling wrote:
> >>> On 12/04/2021 10.12, Christoph Hellwig wrote:
> >>>> Lightnvm was an innovative idea to expose more low-level control
> >>>> over SSDs.
> >>>> But it failed to get properly standardized and remains a
> >>>> non-standarized
> >>>> extension to NVMe that requires vendor specific quirks for a few
> >>>> now mostly
> >>>> obsolete SSD devices.  The standardized ZNS command set for NVMe
> >>>> has take
> >>>> over a lot of the approaches and allows for fully standardized
> >>>> operation.
> >>>>
> >>>> Remove the Linux code to support open channel SSDs as the few
> >>>> production
> >>>> deployments of the above mentioned SSDs are using userspace driver
> >>>> stacks
> >>>> instead of the fairly limited Linux support.
> >>>>
> >>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >>>> ---
> >>>>   drivers/lightnvm/Kconfig | 4 +++-
> >>>>   drivers/lightnvm/core.c  | 2 ++
> >>>>   2 files changed, 5 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> >>>> index 4c2ce210c1237d..04caa0f2d445c7 100644
> >>>> --- a/drivers/lightnvm/Kconfig
> >>>> +++ b/drivers/lightnvm/Kconfig
> >>>> @@ -4,7 +4,7 @@
> >>>>   #
> >>>>     menuconfig NVM
> >>>> -    bool "Open-Channel SSD target support"
> >>>> +    bool "Open-Channel SSD target support (DEPRECATED)"
> >>>>       depends on BLOCK
> >>>>       help
> >>>>         Say Y here to get to enable Open-channel SSDs.
> >>>> @@ -15,6 +15,8 @@ menuconfig NVM
> >>>>         If you say N, all options in this submenu will be skipped
> >>>> and disabled
> >>>>         only do this if you know what you are doing.
> >>>>   +      This code is deprecated and will be removed in Linux 5.15.
> >>>> +
> >>>>   if NVM
> >>>>     config NVM_PBLK
> >>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> >>>> index 28ddcaa5358b14..4394f47c81296a 100644
> >>>> --- a/drivers/lightnvm/core.c
> >>>> +++ b/drivers/lightnvm/core.c
> >>>> @@ -1174,6 +1174,8 @@ int nvm_register(struct nvm_dev *dev)
> >>>>   {
> >>>>       int ret, exp_pool_size;
> >>>>   +    pr_warn_once("lightnvm support is deprecated and will be
> >>>> removed in Linux 5.15.\n");
> >>>> +
> >>>>       if (!dev->q || !dev->ops) {
> >>>>           kref_put(&dev->ref, nvm_free);
> >>>>           return -EINVAL;
> >>>
> >>> Thanks, Christoph.
> >>>
> >>> I'll send it to Jens with today's lightnvm PR.
> >>
> >> Javier, can I add your reviewed-by?
> >>
> >
> > Yes, please.
> >
> > I'll crack a beer and cheer on it tonight. Good times :)

All those patches lost in time, like tears in rain..

Cheers to everyone involved!

Hans

> >
> > Javier
>
> Thank you.
>
