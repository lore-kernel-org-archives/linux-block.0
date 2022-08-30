Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3A2ECAAD1
	for <linux-block@archiver.kernel.org>; Tue, 30 Aug 2022 13:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiH3Nb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiH3Nb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 09:31:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A4CCD77
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:31:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id se27so14440710ejb.8
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RwN8dr8V8GBnedY64fK4fCovxdHzcABlCsbcw7WyuNY=;
        b=FEwU21Zoa75NMeTJCCPoMb5Fp7QkZIPKVRDMFuh2psnRqMglKGthaY91RMfoUvSuYu
         oEbrzmk8MVLjLuKuBSJABlC0VXDeeupqNyKMOaKh3gV2ZZy296xq5My6FWnuZBJkOo1A
         lpMTdWvzmMhFIqrEJ3BG1MuwPj8BJh+7M6g1HBzbufKddoxscxylO4Di5udW38Z4Ji0a
         kcGhyQBI580r2Pm/0Bh8+c8sS919hAc2P2PPVCue7rMDUHS3KVPqPRKceKYIv8M/WvQW
         8TzvlS018sdQj2hcJBOoTvEaAH9GYrrJaXq4puSsFsV7WG1rflLhah9Uj02ZaoCvtqwV
         z9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RwN8dr8V8GBnedY64fK4fCovxdHzcABlCsbcw7WyuNY=;
        b=rSwqvn00FJ4keCPF+/+qn0cWp22rqdVLOczLlB79r4h1qoj2bqFILtBVtfe4NSNQG/
         ZX9kB8pzmttYrxuAGkqhsT4YRHAFlYXcw7yaRvqRagqMddB3HNLl32GILjflhcCIiA2m
         2pKPa234FCRxxdu608RsTuFqwDvSEW7MOjn+Hw3fKsa6ptHLUhpK5oLq21tdDA8mihYq
         PafHzPQ3H/YYw6skP+R5sc/Bf7kKmUDs2EBgwTOokCOXBhBLeEGgntIBEgaxPaKllp1q
         dpvraX1kUiBzH2es49odE/IFVZVoIjSDNe9K50zWEK2Ojtlgi/Cw5oJuGpqTMBXr/fl8
         kCDw==
X-Gm-Message-State: ACgBeo1kdeTV4cAxrKef+VlyWzdjZCFRypM8LSCzAghBN87EjKyYdPJx
        Yxxi1PEQFfBQnYR8XB6qOcLnKU3kDZ5XlCabO/EvZw==
X-Google-Smtp-Source: AA6agR59tE/3Uw5t93XJGOHnjfrzT3tKobGZUL0azTM8EbcbXf8Oo3kjyUi14IGDXLeWgp2zPKeckusR+yVBWHQtarg=
X-Received: by 2002:a17:907:2d86:b0:741:8888:de8 with SMTP id
 gt6-20020a1709072d8600b0074188880de8mr7249813ejc.547.1661866282010; Tue, 30
 Aug 2022 06:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220830123904.26671-1-guoqing.jiang@linux.dev>
 <20220830123904.26671-3-guoqing.jiang@linux.dev> <15af8597-a81d-f1db-6d79-ab07f7b3b2e6@nvidia.com>
In-Reply-To: <15af8597-a81d-f1db-6d79-ab07f7b3b2e6@nvidia.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Tue, 30 Aug 2022 15:31:11 +0200
Message-ID: <CAJpMwyiJNboTmtNrggxzx+RfkOY20tX6WGGg-OTaZ7HVgkKOyQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rnbd-srv: make process_msg_close returns void
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 30, 2022 at 3:04 PM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 8/30/22 05:39, Guoqing Jiang wrote:
> > Change the return type to void given it always returns 0.
> >
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > ---
>
>
> Looks good.
>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

This looks good,

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

>
>
