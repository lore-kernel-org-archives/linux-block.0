Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B1EC4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 10:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F51E22519
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 10:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgLDKQj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 05:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgLDKQj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 05:16:39 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29706C0613D1
        for <linux-block@vger.kernel.org>; Fri,  4 Dec 2020 02:15:53 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so7908463ejj.5
        for <linux-block@vger.kernel.org>; Fri, 04 Dec 2020 02:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpMAb5QJntXJGWMR5UJl49HwMF/Ul3DI1Lb876TQ/kw=;
        b=V2Sh6f2AT5wOniygLxiL12JcdUZsx2nONRusj6/VF7TSsiXsEsLFaVtIy9bbfywt93
         eSiGVaPdXp72VcYLR60zlZ4vUY1Gr0vrbQIyw6AciBdp+NQJmbIRDcNmT8oV1iKp2djR
         9Nxd2CZdZh48VH3Vvqmv7LN/zAsobdhOrBr0kR5slJEIeZ/URrVBWA00aom2ClY91WhR
         OPLTqR1Nb7CCmVXEZQaTNGJ5UNeBQjNsMzp9SYLO75uzEnQt9x9d4u4ZXI40QuhQatty
         C3kwpSC/BdUUwFSMncyqYXIABKLBBDfmPhd+WtXS6LMn/ai+lxaf6k6DQsH2fOflcmPC
         AkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpMAb5QJntXJGWMR5UJl49HwMF/Ul3DI1Lb876TQ/kw=;
        b=Vs8iYtqHu+4Ex1T7ShTbfIVulH2HC0rA1gsxbDHvzzA2HGo5pS/a72zLQLYwN0k7iY
         vlAf8PdwNg3fGIDEpfpLIqj3bQQmafVWQ6cJ41VrTFrbLobE0AwjQCA11gjNHxz9GjU0
         fdtt60BwlW1aCMeMEVU2RGOzdGiq0u+s0dzPXxx90XwimAmU0RvnMssfy5de5TLfMjz1
         nEEw750x9Np8zQGbk7a9GPmCALtScSMy+PNOQYWzsot5ex3c+13UHayiXatw33wc3knn
         evp6lyonehADNiXC0L524s/biPaozWCK6limyz+5pEOJJnv31BEBDqnz23S1TU+2/0JC
         4/Ng==
X-Gm-Message-State: AOAM533QnF6ATr8zlw/+/IpjVfz3ITeTiiiIhxAGzX0WA4b15+p9amJp
        K8LZZ6S6yEkKmqC+GSZSFpmlaTUbgeGfkYVqOnW5R03Dab8=
X-Google-Smtp-Source: ABdhPJyXxi+I3FPgc0MucGWCyclIxTrGJqYqcsvi4pqXRDCZC2fza4/lW9+nKmVvz4xNWpls4ms1qMZ/SIaOP5J/6NU=
X-Received: by 2002:a17:906:2e85:: with SMTP id o5mr6336268eji.521.1607076951676;
 Fri, 04 Dec 2020 02:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
In-Reply-To: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 4 Dec 2020 11:15:40 +0100
Message-ID: <CAMGffE=Ff1RJcYNEfceG4EQX2-1gsuP=ZDcWeOhD+pZC4CXToQ@mail.gmail.com>
Subject: Re: [PATCH for-next 0/8] update for rnbd
To:     linux-block <linux-block@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 26, 2020 at 11:47 AM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> Hi Jens,
>
> Please consider to include following changes to next merge window.

Hi Jens!

ping :)

Thanks!

>
> Bugfix:
> - fix memleak when kobject_init_and_add fails.
>
> features:
> - rnbd-clt to support mapping two devices with same name from
> different servers, and documentation
> - rnbd-srv: force_close devices from one client and documentation.
>
> misc:
> - rnbd-clt: make path parameter optional
> - rnbd-clt: dynamically alloc buffer to reduce memory footprint.
>
> Thanks!
> Jack Wang.
>
> Gioh Kim (2):
>   Documentation/ABI/rnbd-clt: fix typo in sysfs-class-rnbd-client
>   Documentation/ABI/rnbd-clt: session name is appended to the device
>     path
>
> Guoqing Jiang (2):
>   block/rnbd-clt: support mapping two devices with the same name from
>     different servers
>   block/rnbd: call kobject_put in the failure path
>
> Jack Wang (1):
>   Documentation/ABI/rnbd-srv: add document for force_close
>
> Lutz Pogrell (1):
>   block/rnbd-srv: close a mapped device from server side.
>
> Md Haris Iqbal (2):
>   block/rnbd-clt: Make path parameter optional for map_device
>   block/rnbd-clt: Dynamically alloc buffer for pathname &
>     blk_symlink_name
>
>  .../ABI/testing/sysfs-class-rnbd-client       |  8 +--
>  .../ABI/testing/sysfs-class-rnbd-server       |  8 +++
>  drivers/block/rnbd/rnbd-clt-sysfs.c           | 21 ++++--
>  drivers/block/rnbd/rnbd-clt.c                 | 33 +++++++---
>  drivers/block/rnbd/rnbd-clt.h                 |  4 +-
>  drivers/block/rnbd/rnbd-srv-sysfs.c           | 66 +++++++++++++++----
>  drivers/block/rnbd/rnbd-srv.c                 | 19 +++++-
>  drivers/block/rnbd/rnbd-srv.h                 |  4 +-
>  8 files changed, 129 insertions(+), 34 deletions(-)
>
> --
> 2.25.1
>
