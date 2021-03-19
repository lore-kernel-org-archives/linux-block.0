Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D839DC433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 14:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A9864F53
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 14:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCSO4v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhCSO4h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 10:56:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C63064F18;
        Fri, 19 Mar 2021 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616165796;
        bh=LMF6VcFLzMWcvJlrobie++1BU4E1KOgfLPmAne7lKKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OGLl458+qA7HrVWVEkJBIjl2/SyMntcd5k1C5HCbg2hs9InlN7I2SGH9wJN/UArnO
         dlNyjV0AWxqr/F9OXBK8mxaeEKdFrbONTjAWDMaCVDQ7Va4s69Uhz5fg5OauZtUdWo
         Q1OgxNbnvWnRHp3AbMwTTCFfekSNmMx3NNj8G0kLaYC4pegPbIJfvKqFfw7pQ7IzY9
         yVbmIycWzkB+oDAepgQkPmFIkJUcdcf2Yn/eIplcyds5wOCXddZYzzpIsot7xhk4QR
         oi7X8GuaS3zkBlpSAbIUDYAFVSGYWwEZ3mBPY2pf+FOdZPY1xzdY2fvAXJbwX9R6GR
         AFXv0ZDlmIXuA==
Received: by mail-oi1-f172.google.com with SMTP id m13so5041647oiw.13;
        Fri, 19 Mar 2021 07:56:36 -0700 (PDT)
X-Gm-Message-State: AOAM530Jh+PcOIXPLMqKy2aZJ/3An8OwbI7ZFifT0zBZntPij8cZ75qA
        +C5aeAFe7jFP8YM4XrUcXvf6/pPgHCJPHt/qGoU=
X-Google-Smtp-Source: ABdhPJzs22NYplRNCgFniIEUfcVHb2z9VYKGx4WfHkWBTnO61TWk1PXtdP6RhG5AXzRZAFRg/1jqwU2AWebZF31Q7JI=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr1250554oie.67.1616165795957;
 Fri, 19 Mar 2021 07:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210312105530.2219008-1-lee.jones@linaro.org> <20210312105530.2219008-7-lee.jones@linaro.org>
In-Reply-To: <20210312105530.2219008-7-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 19 Mar 2021 15:56:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a234A2WmPFJxXmf-n+J7TP3A=DyDWEr657zxaML7V9UWQ@mail.gmail.com>
Message-ID: <CAK8P3a234A2WmPFJxXmf-n+J7TP3A=DyDWEr657zxaML7V9UWQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] block: drbd: drbd_main: Remove duplicate field initialisation
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 12, 2021 at 11:57 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> [P_RETRY_WRITE] is initialised more than once.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/block/drbd/drbd_main.c: In function =E2=80=98cmdname=E2=80=99:
>  drivers/block/drbd/drbd_main.c:3660:22: warning: initialized field overw=
ritten [-Woverride-init]
>  drivers/block/drbd/drbd_main.c:3660:22: note: (near initialization for =
=E2=80=98cmdnames[44]=E2=80=99)
>
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: drbd-dev@lists.linbit.com
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks correct. I had actually posted a slightly different fix last year,
but either one addresses the warning:

https://lore.kernel.org/lkml/20201026215043.3893318-1-arnd@kernel.org/

         Arnd
