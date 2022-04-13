Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2EDC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 12:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiDMMh6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 08:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiDMMh5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 08:37:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B04434B7
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 05:35:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u15so3597725ejf.11
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dU3h4dYcQmE5EoKwpi5mLpwTqeoQbyvKFbA+oLFITo=;
        b=BkB4OAwd22ccX2nhr5BlEvRletKtRAHK4pFuiPXMJoAM6sFNGJTPHqzQBB2Ygi2MBs
         4ENWd61z6Gii0L3GxoeryyvW47IvkZDfzkJnOgi/2OukuO3lcEybahCJ5Pe1KU5oOZn3
         CNpzPLNCj2RQNempf1J2QNcH10e732q4FiI6HofK8+BGggtlW9CQhvHGbefvcGE/V2pd
         o8geeAaA65XxawnZQKjYZu9FSAxpsr23PNA1pfKDUfznpBwT8e92X/zN/N1AgvW18907
         QfDxIJf7mSRjRe+iJuh2ZtDwnQvE8pG+GPEEOaFZ7yH2BGGXZYUihjb7AgjM4GztkLKy
         tKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dU3h4dYcQmE5EoKwpi5mLpwTqeoQbyvKFbA+oLFITo=;
        b=e3zwK0IpMhOfdVtEOz9HXKfXsxZHWzukKuzxnFQuRxvwY4+qqzDPAviwL2N96nbGDh
         yKWaK62BABZ0/gXO0EfNo68tf1zOq7OuTsCJsjpJwAW7JKiFlAA9CKjgLDKec2oPeoE1
         /vXB2xvmBY9iA3uLad1OkSP7QZ/sJa2TNcE476066mfvqwRps9SXuS4X5hW6v9c95buk
         Ox7gQx5AkNUI8GMkCvYeqq7iZDE4pE1NE3tkPhn8Tzmk2svKMhbrORIwSxi1dLpUsyzP
         rsXnrFh1A/JOtMgl3sW87qyhi1u1DFl61BOaBIeDjDzP7GWVcUr4ghsF8tcXTvVpnCOu
         kx5A==
X-Gm-Message-State: AOAM531JGFf5jeq5oBd/zjc5qUvi4VZRF/Hrh+GPtI6/QgwcIau08Hch
        kEOVdZi6tJQpZpL+tA+1jVzk1/qZDmYcTkIY4LlOkpfG1IA=
X-Google-Smtp-Source: ABdhPJyRCXCDKmB70kgsABOPTnMPnJWxHEF0Y8GVl/3o73LwFYXA4x4EVUeSEIa3h5tWS7ZnWHJjONn5AW39qQ3b5Ek=
X-Received: by 2002:a17:907:3daa:b0:6e8:969d:564d with SMTP id
 he42-20020a1709073daa00b006e8969d564dmr11614057ejc.735.1649853334452; Wed, 13
 Apr 2022 05:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220413121315.63684-1-jinpu.wang@ionos.com> <f3757d4b-fc2a-b0e2-4117-d7a7fb3f0f53@I-love.SAKURA.ne.jp>
In-Reply-To: <f3757d4b-fc2a-b0e2-4117-d7a7fb3f0f53@I-love.SAKURA.ne.jp>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 13 Apr 2022 14:35:23 +0200
Message-ID: <CAMGffEk-9FeG38Ja6hFOMVp_R3ut4kvvcFhVg32Fv2PCxfQwpA@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd-clt: Avoid flush_workqueue(system_long_wq) usage
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@infradead.org,
        sagi@grimberg.me, bvanassche@acm.org, haris.iqbal@ionos.com,
        Santosh Kumar Pradhan <santosh.pradhan@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 2:26 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Thanks for a patch.
>
> On 2022/04/13 21:13, Jack Wang wrote:
> > @@ -1792,6 +1793,13 @@ static int __init rnbd_client_init(void)
> >                      err);
> >               unregister_blkdev(rnbd_client_major, "rnbd");
>
> I think you want
>
>                 return err;
>
> here so that alloc_workqueue() won't be called when
> rnbd_clt_create_sysfs_files() returned an error.
right, I just fixed it, and sent new version.
>
> >       }
> > +     rnbd_clt_wq = alloc_workqueue("rnbd_clt_wq", 0, 0);
> > +     if (!rnbd_clt_wq) {
> > +             pr_err("Failed to load module, alloc_workqueue failed.\n");
> > +             rnbd_clt_destroy_sysfs_files();
> > +             unregister_blkdev(rnbd_client_major, "rnbd");
> > +             err = -ENOMEM;
> > +     }
> >
> >       return err;
> >  }
