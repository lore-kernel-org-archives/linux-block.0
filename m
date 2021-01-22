Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C58C433DB
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 18:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EC623AAC
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 18:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbhAVSa7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbhAVSZG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 13:25:06 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95396C06174A
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:22:12 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id kg20so8525268ejc.4
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HMx5WULUEpo/GvYQe+DCnONeXIBdpeEzpvbY3sfaTEo=;
        b=DwcEicKGOYG979Ms2/RsOcxdbOz+6kqfBTvMCmL8ufwGuQ/rK5qyX7QuTJCk4wvbsO
         i9J//LKcBcsVEQ8c93Ni1iHpIwhrM20bEd+ISp8s36j4xB0AuBDW9L9frbr0XNiLwdun
         t/6c1S0CH+y4E6nlDlHafdV440DEKfHG48iCc3jvdEY51H1tpHbCVbj7bDtPYe+uv1Yh
         taOgih7Ix7utI2mosWqZIBhJTP3d8fujK/K6gDHBbIJiIkAA2IOT1xe2/3gW2npwkdrh
         GSeuU329T4e7WAYw0VgZwKfAVBzPxhTBitw+Tdk0hLrWj1+7rJF3VRw18XGyhiuv8+Cv
         dN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HMx5WULUEpo/GvYQe+DCnONeXIBdpeEzpvbY3sfaTEo=;
        b=ZCwDr2hUunjmLqm9vPpvatSJ9i821FoPwwYKct2zODPlupKzmuJ5885emnkuiKGeLP
         TKPute1H4J0iwvXWbzH+h2a0Lv/VEfT1Va99qOI30OO+Ru92PXFlWeHL85Or2DwqYR4q
         9mCUKDLoc8lZWTS8MJ3ODqh0wslXEqlsaNom3aELmeDYEVfacuScsAdFEsAYwyl8VwCk
         ekj85yVwoUfRgIATFfY1JkHK/eVBsiuPhA0z3RJWck307rumNnJ0IL0YxyIMnK+Nf54U
         Lanwmvtf9K5fiBgSuqiZ1XtAwrSpabzhRr0+t+TZEcQKCIdyMupjE3NuOqNfAWsnJxxZ
         /W2w==
X-Gm-Message-State: AOAM531og/k4Li777LnCv8/kVA4lVyabe0Z+oceggqD1LEdVOY+P6sDu
        xexBMFWne8TqnXlCDK5dWdGl3g==
X-Google-Smtp-Source: ABdhPJympufxTHr/CGIxRKqJYH6dIPcW3Ml2RciAkM8LEv9zc6ESKWuYW7wxKbZwNgkP1pWqgIEfDg==
X-Received: by 2002:a17:906:af41:: with SMTP id ly1mr110739ejb.491.1611339731290;
        Fri, 22 Jan 2021 10:22:11 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id w18sm4942368ejq.59.2021.01.22.10.22.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:22:10 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/6] block, bfq: first bath of fixes
 and improvements
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210122181948.35660-1-paolo.valente@linaro.org>
Date:   Fri, 22 Jan 2021 19:22:08 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <721F90B0-837A-4EBE-90CA-35C88C2A57D3@linaro.org>
References: <20210122181948.35660-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 22 gen 2021, alle ore 19:19, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
>=20
> about nine months ago, Jan (Kara, SUSE) reported a throughput
> regression with BFQ. That was the beginning of a fruitful dev&testing
> collaboration, which led to 18 new commits. Part are fixes, part are
> actual performance improvements.
>=20

The cover letter was not complete, sorry. Here is the missing piece:

Given the high number of commits, and the size of a few of them, I've
opted for splitting their submission into three batches. This is the
first batch.

Thanks,
Paolo

> Jia Cheng Hu (1):
>  block, bfq: set next_rq to waker_bfqq->next_rq in waker injection
>=20
> Paolo Valente (5):
>  block, bfq: use half slice_idle as a threshold to check short ttime
>  block, bfq: increase time window for waker detection
>  block, bfq: do not raise non-default weights
>  block, bfq: avoid spurious switches to soft_rt of interactive queues
>  block, bfq: do not expire a queue when it is the only busy one
>=20
> block/bfq-iosched.c | 100 +++++++++++++++++++++++++++++++-------------
> 1 file changed, 70 insertions(+), 30 deletions(-)
>=20
> --
> 2.20.1

