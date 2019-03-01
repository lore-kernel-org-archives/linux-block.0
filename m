Return-Path: <SRS0=BuC1=RE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80003C43381
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 12:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357FE20840
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 12:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="W9a1k+7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCAMUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:20:41 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46569 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCAMUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Mar 2019 07:20:41 -0500
Received: by mail-ua1-f67.google.com with SMTP id j8so22196227uae.13
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2019 04:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKTa2MQRv+Jcyp9PY3VvhxbwtZaWR2h+gEogJTGYWRY=;
        b=W9a1k+7wnz0zaDDVDGHK1gan2CKp6ZHjTvgVv11I1zYQC+Pr+KYjjZdX9iWk/1aEau
         nAM1frla+1O3l2nvvekUsy9vsCis6t8OXo7H0YugRO9yqxr8x7LMVTLqpRAb/Ju76qp3
         pBRqowV32NCgoBP5yaIJxuPXxEZW3/+hVulY4m3qrxiMeUp+3V+uMRZ/EG+CutA+/Kho
         bWIP4EhR2ZsndcRN3JI1Zr3OLx0zc1K6MViALvXEuSAg7SlQRrojfjW99H6uaXWxQk8m
         fmis2nax++xEC4l+e1cwF3ny1CCmRJTIqgwvrxivtuv426+KYEvehRDjY5vDenqvP2Lr
         EMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKTa2MQRv+Jcyp9PY3VvhxbwtZaWR2h+gEogJTGYWRY=;
        b=HGNUst7L3YejMEsUWIdsKEJVg26Fp0U4KIZtOmiMIFQmRT+ggo8+SL/buTGlSYF9AI
         f9+W8e4srvt+7kgul9ORU+M4P6oLcWe+OMk7ngoPKPSm40qmWacYs1Dvmag50bPmdJcw
         jjchw2Qt0d0jrR/LondoYxHnss6yESkhty2vS7e2/xbzcT3tTeFmDpabbgFOzjsZpH11
         n16mnZ+Mnag4NUY9yjBBkzlfc1157ecr9a5pwwY8kSeZiq+9uBOdN8lWAYNNm7HF2egb
         ggDVhfUMzuOMEvD3TtFIBbTdvdWA1n5hABmhgL22MVybpSoRdpASDNLzJ9NamVjaNA2S
         cMNg==
X-Gm-Message-State: APjAAAX2ykjWa8cIAJeRKoyxXw8knXrezHbGHx3xM49jPc++8EsZlGHD
        jJtbgcm+wFyTGFIpoCltJng0kq26+E82ZkBAGI5qrQ==
X-Google-Smtp-Source: APXvYqzxtsXkRcwz3XFSqSMZ3FzBZPLx6twWG7Mb7QQSMZbCgqiLHkrZktweFKSmXkM0nrHgsgbavQ+wV+0Wbr0BMqo=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr2510517vsr.42.1551442838431;
 Fri, 01 Mar 2019 04:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com> <20190227171442.11853-2-igor.j.konopko@intel.com>
In-Reply-To: <20190227171442.11853-2-igor.j.konopko@intel.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 1 Mar 2019 13:20:27 +0100
Message-ID: <CANr-nt08JuvO2Fw6TyJ7m5eTjx2YQfBOHxcHgevKV=3ZqnEj5w@mail.gmail.com>
Subject: Re: [PATCH 01/13] lightnvm: pblk: Line reference fix in GC
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org, Heiner Litz <hlitz@ucsc.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 27, 2019 at 6:17 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
>
> This patch fixes the error case in GC when
> we both moves line back to closed state and
> release additional reference, what cause illegal
> transition from closed to free on pblk_line_put
> when only gc to free line state transition is
> allowed using that path.
>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>  drivers/lightnvm/pblk-gc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 2fa118c8eb71..3feadfd9418d 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -290,8 +290,11 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
>  fail_free_ws:
>         kfree(line_ws);
>
> +       /* Line goes back to closed state, so we cannot release additional
> +        * reference for line, since we do that only when we want to do
> +        * gc to free line state transition.
> +        */

Good comment.
It would be nice to document how the line recounting works in general,
as it is, non-trivial to deduce from the code.
I dug into this when supporting Heiner in his latest bugfix, and it's
on my laundry list .. but if someone else feels inclined.. :)

>         pblk_put_line_back(pblk, line);
> -       kref_put(&line->ref, pblk_line_put);
>         atomic_dec(&gc->read_inflight_gc);
>
>         pblk_err(pblk, "failed to GC line %d\n", line->id);
> --
> 2.17.1
>

Great catch!
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
