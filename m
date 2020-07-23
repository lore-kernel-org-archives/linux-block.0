Return-Path: <SRS0=kKib=BC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2E8C433EC
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 08:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA4B2086A
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 08:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="G/YuI1fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGWIRf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgGWIRe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jul 2020 04:17:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88858C0619DC
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2020 01:17:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so4356926wmh.2
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2020 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcragK8oLRiU5tMGVrSQP//UjTzh3N+LO7S1Gkj4gso=;
        b=G/YuI1fbq/fdF6OL8QRLb+QLQa4eZdt6FjanfxYaelRd6zNYwoixJlCfZGvhZ7O6Zi
         TzXeemSlKUiSFqUv9hcDgk68rw2tGwtME527qLu9dXpqDmTea4DRZjJTfsfmeE4GkiZc
         74C0s6szrr+bVaM9wHIYFfeJv515oE68P0Qtu5/XSFY4Z0cEOZxYxWDGHJMqT55+NKi5
         8JkK0lwMtE6vNdtBjQtmJGLfrO16Rmy+QhOdmI8nRLvwbVl0xAPYL6HoCWr+GSUDAkpR
         CfdV7wx7kPnSlT1zurLB58pfIFwEBodrIQT0K8z8zTlHCbwWcGao1c2Ag4S0OUqZF9he
         O39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcragK8oLRiU5tMGVrSQP//UjTzh3N+LO7S1Gkj4gso=;
        b=TbdICH92gKBezj37DL7GgbX6+AvjiAFLu4/8rckpqYl5PQPsT4qfUrE9/Nq3579+GF
         sSSTApDXO21moK8eZ4yR9U6naZjdA9J+gNsZ4reI/P+BPbaQRDm1ImrHKHv/J+MBqJ97
         Hra9M3A2EoeovpXHeutZumyIk0qdoEs6XGBXwvEpzINxAvJjPd0Xu0yKJ34dK4ZGpOhe
         gZHZlq1+mQ+DObwNCtMZvZfbpImdeTREuY0tmwNPtnkhYSGiGpiWnXUN1B1f/ItB7L0L
         eAcoE6R9AonIFX07CKFqmpoO26NI/FVf7ObsAOW2PUZIS5prqvtMc1mItegFUmbtxv/K
         ZGdQ==
X-Gm-Message-State: AOAM533k9cMaiwW1mcQdDZIIrYVyEk2ZD7/+sphu0yd0U6WbnkrhSqMz
        B85NCTv3Z54f0Pk/H1JyUkBzKzYWNtzhFYhfhR4a
X-Google-Smtp-Source: ABdhPJwnrrDYcltcXNEL69nN8gSZM3zGxRmih/MXwlttPxKqR2Oy9Y0+Q1ZHM2XGbe1R3vgj7ObLEACbkW10IpunP2E=
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr2880002wmh.166.1595492252188;
 Thu, 23 Jul 2020 01:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200722102653.19224-1-guoqing.jiang@cloud.ionos.com> <20200722102653.19224-3-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200722102653.19224-3-guoqing.jiang@cloud.ionos.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 23 Jul 2020 10:17:21 +0200
Message-ID: <CAHg0HuwmOymx_2MHArvmv3-cT3zqO=8Ndmxtm9ovr8HtQZsG-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] rnbd: no need to set bi_end_io in rnbd_bio_map_kern
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 22, 2020 at 12:27 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Since we always set bi_end_io after call rnbd_bio_map_kern, so the
> setting in rnbd_bio_map_kern is redundant.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Thanks!
Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>

> ---
>  drivers/block/rnbd/rnbd-srv-dev.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
> index 49c62b506c9b..b241a099aeae 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.c
> +++ b/drivers/block/rnbd/rnbd-srv-dev.c
> @@ -99,6 +99,5 @@ struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
>                 offset = 0;
>         }
>
> -       bio->bi_end_io = bio_put;
>         return bio;
>  }
> --
> 2.17.1
>
