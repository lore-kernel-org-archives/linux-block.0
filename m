Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB5EC43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BA720675
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 14:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="Th3Pmr97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfCFOUY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:20:24 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37194 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCFOUY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 09:20:24 -0500
Received: by mail-ua1-f65.google.com with SMTP id x1so8993473uaj.4
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19qtKejtx9kuONywn2RzdAPzuRlkEq79+b0g1VL7knA=;
        b=Th3Pmr97L+AAJa/GBZ9iIRybG2zM9TQ0SQdXWgMC7AGyB4Grv8nHcZmN3fWLXjDEeV
         9EPys1Hd8I+8qCqcmOQZKpqs/45uNYBHUWGP6HyJCxRcZIJNpkgwOrUI4FHPlRN4Jgal
         Kcj/t6X1FGgVXWns0BrElyAR02oC11VZPlo7csdDaS2DNMVS1ZAM1v5IaZfUMu2T+tpw
         rkd/RFDVq+S2xL6iZWTWP0IlIZWfQxhGdRM9sXWe75BWWyUqXI3+tQWiefH8U1hqHAfp
         x1iCPBHnbVR3oY8GqoyoBSrAsaqn1lwjikL8v0lvBPO5FLCFrJLuqzW3OHoqqQBpw3sM
         KsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19qtKejtx9kuONywn2RzdAPzuRlkEq79+b0g1VL7knA=;
        b=itPQQi4WGh2ZugkXjBRa4mwJdIwOFK3hKPBa0MNFVmD9dWOTCr1w8dSTjTGm36XV8r
         iYklcVz6TkLte7qCUdNO/5HjHjfIqU+M9mFkk5YUw+UcG7BKZi/b1ILO1YBqU4zMMfj9
         KExIdTNq0a8/f0AaRIECXWzgcFn7D+MuYSgYS5q9b08JzY6jhn2Lap78GVqvWUyjoO14
         axvJ/gxzOBJXaOZ4KOZjawzPe1QjXL4m0QSSesvtZDDT8gKpdg693Y8ctGkterq2q3kQ
         3HdeDFzk4h5/JusJksEnK3jtuOCqRyLTDQXrIXLyEmrqo4ZOZl2BHDWZADVSMvcL3r1b
         OPug==
X-Gm-Message-State: APjAAAXypvBBoXW7JNzee2fAZ2APP3sovdZNVmWz4OR3ZxOlRrXJIPtP
        cQR2w0wUIeQ4dguN8sDj9z0pE5W73OKeDfAD9FIOtA==
X-Google-Smtp-Source: APXvYqyQ8gkjaA3WCaYUVPJqBciRgTaJZ7/NdMs3Qi3xID/R/PEja+yopblHGEANj+dlY3BYzWlYQIjxfmFIHFi17vY=
X-Received: by 2002:ab0:45cf:: with SMTP id u73mr233117uau.18.1551882023484;
 Wed, 06 Mar 2019 06:20:23 -0800 (PST)
MIME-Version: 1.0
References: <20190305135120.29284-1-igor.j.konopko@intel.com> <20190305135120.29284-5-igor.j.konopko@intel.com>
In-Reply-To: <20190305135120.29284-5-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Wed, 6 Mar 2019 15:20:12 +0100
Message-ID: <CANr-nt2u1-ntsma3KKp56reds9d1LnKfHjgA5BRJTwtyQ2y74g@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] lightnvm: pblk: Ensure that erase is chunk aligned
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

Looks good,

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

On Tue, Mar 5, 2019 at 2:54 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> In current pblk implementation of erase command there is a chance
> that the sector bits are set to some random values for erase PPA.
> This is unexpected situation, since erase shall be always chunk
> aligned based on OCSSD 2.0 specification. This patch fixes that issue.
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>  drivers/lightnvm/pblk-map.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 7fbc99b..5408e32 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -162,6 +162,7 @@ int pblk_map_erase_rq(struct pblk *pblk, struct nvm_rq *rqd,
>
>                         *erase_ppa = ppa_list[i];
>                         erase_ppa->a.blk = e_line->id;
> +                       erase_ppa->a.reserved = 0;
>
>                         spin_unlock(&e_line->lock);
>
> --
> 2.9.5
>
