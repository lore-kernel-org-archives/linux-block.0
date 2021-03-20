Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E1DC433E0
	for <linux-block@archiver.kernel.org>; Sat, 20 Mar 2021 16:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC54161934
	for <linux-block@archiver.kernel.org>; Sat, 20 Mar 2021 16:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCTQgK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Mar 2021 12:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTQfh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Mar 2021 12:35:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5925FC061574
        for <linux-block@vger.kernel.org>; Sat, 20 Mar 2021 09:35:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u9so14515505ejj.7
        for <linux-block@vger.kernel.org>; Sat, 20 Mar 2021 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=geO6mCSc3dvv1NARqozbaI1WUAau8sllKB/fxc1UDbM=;
        b=bxGQcNXeXpeOjtlbExlasnrrD4MoXwr67JE38ojVBZQDWHavj7IsdgHlypHV4KT/zm
         jbv8e4H1BKT2oJPPkbqXJYdYU54W5rdrkATCLaA82splC/ZR4IuSZap7PEktx4Tw5pEe
         SOgXyyB5CsTUyC7mMTj5Y3Ozq4vduGceHAMk11YHCyoVeAKvYLksPS+tVAyfri2XHhgN
         XWMH10oqXf+4kAX+uhaPbwt7CVNrteD3bB7pyJu1A5C9rdBAn4LR8zwSzcAM1pr2qRrQ
         MEcQ2B5xEpshRhrKFsRVNOayfq4qNi2Mf+halbudKxu846Eml+oRnXwAnW51oRepWA5j
         t4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=geO6mCSc3dvv1NARqozbaI1WUAau8sllKB/fxc1UDbM=;
        b=P/i1sMnAGMK+RogBt1XRp0n8bMTXWa/z2+4Aq7DVQEYlzMxnYgo7pc00rS6qXzg8QL
         we5FjoMGT1mpZRAlHb7SzSJ8iqQUPTKu+kJv7tLA4wjGjVwHzwhURO5OTGTJ9UgflZZm
         A8GwYwZNEwLzvevRP7zH9diUq2vNqDHjP2259GPs5V1BtAkF1aqCZTjaFABnJJR9J2ZI
         MJ3hxTfMGYT3nLHqSdWox74x45LueAy4EUWz9znzjd+jS0oVvjrOttGxM21QGVWaw6DJ
         f4FvlG4kCyFjAgvwapXlGuS1GyFvC6hjumQuWZG0DahJsyb7dNUWXTOKvO0uKenbMLNM
         7/Cg==
X-Gm-Message-State: AOAM531+bwKqkYOZDohFxY318RM9voVg45gCjdcA/NpCDQ3jXq9dPGQ2
        ANkOiyCLEtJ0Ko7578NNurxYCSjIoPGOkcsE
X-Google-Smtp-Source: ABdhPJzoCF6MXJjTZ1Ewss4fv6CRsklM39YRlzdu2kuke0QSu48Ab3TkuHoF9Zb0kmrS1es8k4pRxA==
X-Received: by 2002:a17:906:22d4:: with SMTP id q20mr10802998eja.54.1616258136055;
        Sat, 20 Mar 2021 09:35:36 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id c10sm6356126edt.64.2021.03.20.09.35.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Mar 2021 09:35:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT V2 0/6] revised version of third and
 last batch of patches
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210304174627.161-1-paolo.valente@linaro.org>
Date:   Sat, 20 Mar 2021 17:35:34 +0100
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <07F133BF-A518-49D5-96FB-E416ECF61A9A@linaro.org>
References: <20210304174627.161-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 4 mar 2021, alle ore 18:46, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
> this is the V2 for the third and last batches of patches that I
> proposed recently [1].
>=20
> I've tried to address all issues raised in [1].
>=20
> In more detail, main changes for V1 are:
> 1. I've improved code as requested in "block, bfq: merge bursts of
> newly-created queues"
> 2. I've improved comments as requested in "block, bfq: put reqs of
> waker and woken in dispatch list"
>=20

Hi Jens,
any news on this patch series?

Thanks,
Paolo

> Thanks,
> Paolo
>=20
> [1] https://www.spinics.net/lists/linux-block/msg64333.html
>=20
> Paolo Valente (6):
>  block, bfq: always inject I/O of queues blocked by wakers
>  block, bfq: put reqs of waker and woken in dispatch list
>  block, bfq: make shared queues inherit wakers
>  block, bfq: fix weight-raising resume with !low_latency
>  block, bfq: keep shared queues out of the waker mechanism
>  block, bfq: merge bursts of newly-created queues
>=20
> block/bfq-cgroup.c  |   2 +
> block/bfq-iosched.c | 399 +++++++++++++++++++++++++++++++++++++++++---
> block/bfq-iosched.h |  15 ++
> block/bfq-wf2q.c    |   8 +
> 4 files changed, 402 insertions(+), 22 deletions(-)
>=20
> --
> 2.20.1

