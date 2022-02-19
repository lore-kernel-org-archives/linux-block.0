Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCAFC433F5
	for <linux-block@archiver.kernel.org>; Sat, 19 Feb 2022 03:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbiBSDct (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Feb 2022 22:32:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiBSDcs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Feb 2022 22:32:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE10D1B7624
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 19:32:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E4B462075
        for <linux-block@vger.kernel.org>; Sat, 19 Feb 2022 03:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A65AC340EF
        for <linux-block@vger.kernel.org>; Sat, 19 Feb 2022 03:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645241549;
        bh=dr6RiblauHb7AyJYXabmITvaPdrndByhXm3PAifETd4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e9dU2amkojYJUxWjqpaqsT0UZaX9l9Xqmf9OtMbydSnvfbY57Cj/kVAWiNC9kMtwR
         hObbCNSQ1Yv3bPCUOdzSFwVRJuVCxBz8GUZd31vvEiCVJx1Sskvr2dZJmFmugiC8px
         uAfTiQFKBCd13KxH8ns/TJx7eZ9XVyBIRHVl02cPWphtnSGereY3aPbX/J6cndMbFC
         JF92wMpXcOMIax2IT1116ipSw6om5kcPKmSqD7/0T4l5m9gfAZsDe8t7nDp/SxZHji
         quqqsrjACnKWxZYWQD5s0pphRNbE29XttSeaAmQP+zvq3Y3WAjAvXZnnfBYiDIcCmy
         hVjKUomEDPZ3Q==
Received: by mail-yb1-f171.google.com with SMTP id w63so1918474ybe.10
        for <linux-block@vger.kernel.org>; Fri, 18 Feb 2022 19:32:29 -0800 (PST)
X-Gm-Message-State: AOAM530hxfmAYKZi+BTQNWbFhEmMYCts6Jr+akYooyK5jxfWn0oFR71C
        cw3+fid3OCG5ezuZ5wtVy+eQn9TmkoPV1VoX0Aw=
X-Google-Smtp-Source: ABdhPJzCBR9nHGbDK8UY4UCXlvhCw+mNjig8CfHtks3BUT4dASQyyYP1dTBQ7imh5ntVEvzQ5kl2Ilb+azuKR494cG8=
X-Received: by 2002:a25:e747:0:b0:623:efe8:62d5 with SMTP id
 e68-20020a25e747000000b00623efe862d5mr10583561ybh.256.1645241548766; Fri, 18
 Feb 2022 19:32:28 -0800 (PST)
MIME-Version: 1.0
References: <YhBfsIqCNsi7D/st@bombadil.infradead.org>
In-Reply-To: <YhBfsIqCNsi7D/st@bombadil.infradead.org>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 18 Feb 2022 19:32:17 -0800
X-Gmail-Original-Message-ID: <CAB=NE6UB-qE2SW-2nsB0vUfQ+aMpeUB4yUqjfp_5VE2RQhMMFQ@mail.gmail.com>
Message-ID: <CAB=NE6UB-qE2SW-2nsB0vUfQ+aMpeUB4yUqjfp_5VE2RQhMMFQ@mail.gmail.com>
Subject: Re: block loopback driver possible regression since next-20220211
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Pankaj Raghav <pankydev8@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 18, 2022 at 7:10 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> I noticed that since next-20220211 losetup fails at something stupid
> simple:
>
> losetup $LOOPDEV $DISK

I can bisect through linux-next, next-20220201 works. I'll let you
know what I find.

 Luis
