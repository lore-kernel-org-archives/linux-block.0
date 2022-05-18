Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16269C433EF
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 12:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiERMDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 08:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbiERMDV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 08:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3C1C51332
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 05:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652875398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QXuzzet92SbtqRuzz00+sjnF/sjZKVtGRrKvRCDQAJI=;
        b=NRhz37p+HW8FXabVotom98xdtZbDrzuriFcuwqOv2Nhi4MDxxTfWW2YJ2ww1lQFItKpC92
        eHUkCLetk3YO9fLqLtwz5j4Eh7ER7gfxX3JpNk+uipTUEigl3QvOS7WJEWUWJVwHtoS0Ie
        ZZQfm7KfLQgEPQmsh9flhCUAcROj598=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-7-tSXt_eO6CeR0PH_nsiCA-1; Wed, 18 May 2022 08:03:17 -0400
X-MC-Unique: 7-tSXt_eO6CeR0PH_nsiCA-1
Received: by mail-pj1-f71.google.com with SMTP id m6-20020a17090a730600b001d9041534e4so933864pjk.7
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 05:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXuzzet92SbtqRuzz00+sjnF/sjZKVtGRrKvRCDQAJI=;
        b=ULG3vLnzUlhES2IPL1hDOANcvOlsuqkuGtcuNWRutvhyp7NtxmFYjs324fi251Cz6P
         cB+RElUeLEyf5er4mcUSt1Ka/PUdTs/2rkh7pSMF/ZxqD3GZvwUVZD9eN1lgvIxePJ2K
         l4D4hjfuJ/EVc0QbRMs8KsGLpmmIMb6e1V04AGncqwxIXG9EUPIS+Ro094QKS7XEwT9K
         UesydzCxrdADS+dOAWPnyQL4NUcHpAGHDHSJLZT5VZ3xPrl+tZCqFzdkxVXQ4pXvnNiW
         pQNvrepZ8WIUnmG2p7UkoTq+YkRCL7KpoXfKZ2ZVo3XET7hwJ9X53BScSGitoX72GQ0g
         ZaFQ==
X-Gm-Message-State: AOAM5322OBVOZ57U7wNrWQuIrjPNbayr7QRFN/iP4499UKXgFHh5Gq18
        +H/PwhPh21JYV3VouGAWmx1ImufKuQVxOr95J0oglpwnX/Rld4003suMlwOmjzaplDkFqX/NTxf
        Iiq0R2oYj8+gpO1zRovevnPF3CCSRROiLdoIOGiA=
X-Received: by 2002:a63:68c6:0:b0:380:3fbc:dfb6 with SMTP id d189-20020a6368c6000000b003803fbcdfb6mr23558292pgc.326.1652875396475;
        Wed, 18 May 2022 05:03:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfHjJ7wOc7EfzoDw9bz9TZPPeqDCyi/9W2OTJ/0vStXrGncq07B+IOFJmoSAHUllEg6FQfXCkwecUQS45sisE=
X-Received: by 2002:a63:68c6:0:b0:380:3fbc:dfb6 with SMTP id
 d189-20020a6368c6000000b003803fbcdfb6mr23558282pgc.326.1652875396187; Wed, 18
 May 2022 05:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220518034443.46803-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220518034443.46803-1-yangx.jy@fujitsu.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 18 May 2022 20:03:04 +0800
Message-ID: <CAHj4cs9istDHj28KRDCFoE0Y_Hqui4=Fg3em+5YfnNN+byhnFQ@mail.gmail.com>
Subject: Re: [PATCH blktests] nvmeof-mp/001: Set expected count properly
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     osandov@fb.com, Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I also met this failure during my previous testing, thanks.

Reviewed-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, May 18, 2022 at 11:44 AM Xiao Yang <yangx.jy@fujitsu.com> wrote:
>
> The number of block devices will increase according
> to the number of RDMA-capable NICs.
> For example, nvmeof-mp/001 with two RDMA-capable NICs
> got the following error:
> -------------------------------------
>     Configured NVMe target driver
>     -count_devices(): 1 <> 1
>     +count_devices(): 2 <> 1
>     Passed
> -------------------------------------
>
> Set expected count properly by calculating the number
> of RDMA-capable NICs.
>
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  tests/nvmeof-mp/001     | 7 +++++--
>  tests/nvmeof-mp/001.out | 1 -
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tests/nvmeof-mp/001 b/tests/nvmeof-mp/001
> index f3e6394..82cb298 100755
> --- a/tests/nvmeof-mp/001
> +++ b/tests/nvmeof-mp/001
> @@ -18,7 +18,11 @@ count_devices() {
>  }
>
>  wait_for_devices() {
> -       local expected=1 i devices
> +       local expected=0 i devices
> +
> +       for i in $(rdma_network_interfaces); do
> +               ((expected++))
> +       done
>
>         use_blk_mq y || return $?
>         for ((i=0;i<100;i++)); do
> @@ -27,7 +31,6 @@ wait_for_devices() {
>                 sleep .1
>         done
>         echo "count_devices(): $devices <> $expected" >>"$FULL"
> -       echo "count_devices(): $devices <> $expected"
>         [ "$devices" -ge $expected ]
>  }
>
> diff --git a/tests/nvmeof-mp/001.out b/tests/nvmeof-mp/001.out
> index 2ce8d17..a7d4cb9 100644
> --- a/tests/nvmeof-mp/001.out
> +++ b/tests/nvmeof-mp/001.out
> @@ -1,3 +1,2 @@
>  Configured NVMe target driver
> -count_devices(): 1 <> 1
>  Passed
> --
> 2.34.1
>
>
>


-- 
Best Regards,
  Yi Zhang

