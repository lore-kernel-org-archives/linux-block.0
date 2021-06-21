Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B573C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332D66108E
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFUVAt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230052AbhFUVAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 17:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624309113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y/K3lILiULD0z/ulUasjkaj92UZACfZBuA3cNYmBFVQ=;
        b=SppY0vkKY12WC+PwCMksG+17uS0gNS5FEV5bXYmoDo/JsTo2e6VOluqlX0pRtc2RUuqBtC
        JZY0HRyg7BlW6wx12Txif1YLB0YJESlu4EbZ2iYF2wAnGtFoRzhvSlMxpYRjLzP59n5+m7
        RwgfRzp1hZvAMepl8PU+IxwF2IS3GwY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-sVB_iSM9MQi8dx778F1kiA-1; Mon, 21 Jun 2021 16:58:32 -0400
X-MC-Unique: sVB_iSM9MQi8dx778F1kiA-1
Received: by mail-lj1-f199.google.com with SMTP id j10-20020a2e800a0000b029015f88d3e725so9655695ljg.6
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 13:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/K3lILiULD0z/ulUasjkaj92UZACfZBuA3cNYmBFVQ=;
        b=W5VEUhYt25TuBtTu+4Je+v92Pk/5t0Z+aZb+BJviWEUW8rCDUrN+/KXGdgXQSYZLXG
         a//wqsc+DxljbH0WWtcmdCGCMg6p5SIYc/FVfAKco9e+ok15oKygPy5sF/S3hBeiggIo
         0veTiT809Ao3HNhJVAm7ipYAi2a989yuls0faT2TPgZo8HNG7lLjOxbHeUude51j5l4C
         dIOVUREtPSCDnNXwrB1gUgS+Lsott28bK2V0MnkhW11nGd80P9wpkGwXckuxZu9nA2/h
         9eKBEJ0e9iCBe+AbM2G0GA5uObFlVapu8iN1JlqbmF0tyutXTiKcNR6I+Nw5fHhOM9Tb
         M8cQ==
X-Gm-Message-State: AOAM530uy9hYsbsmmv+y9u+7D7ZmH6qa0cWaKPEA91JbEHHd2AWoLL3G
        QkyyuXHC3W73REYXsiICqI3pHbed3S201YNTwbPkMreuZ0AY+1NMDE3b9fJKtqEuEe0avgCk24s
        CZKNwPzN0LBevU3qygcu0z5Co2v3pqsOQlZ4kn0E=
X-Received: by 2002:a05:6512:3b21:: with SMTP id f33mr126097lfv.185.1624309110770;
        Mon, 21 Jun 2021 13:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvqQkggqNp51HuqyP3lyovoynELw5xLm9mWZbtiEyrKWiuiY0KH9nQeob/PtsDsUFFY0EuZVokhlwtzLvqsQQ=
X-Received: by 2002:a05:6512:3b21:: with SMTP id f33mr126087lfv.185.1624309110600;
 Mon, 21 Jun 2021 13:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <cki.3F4F097E3B.299V5OKJ7M@redhat.com> <CA+tGwn=+1Evv=ZZmOdXSpfUTG_dPvHfDsxbmLyHWr9-XkXA1LQ@mail.gmail.com>
In-Reply-To: <CA+tGwn=+1Evv=ZZmOdXSpfUTG_dPvHfDsxbmLyHWr9-XkXA1LQ@mail.gmail.com>
From:   Veronika Kabatova <vkabatov@redhat.com>
Date:   Mon, 21 Jun 2021 22:57:54 +0200
Message-ID: <CA+tGwnn4J2=WuPEFOwmC6ph30rHXJLhjH-iWmvkKLpacmR7wdQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E13=2E0=2Drc6_=28blo?=
        =?UTF-8?Q?ck=2C_b0740de3=29?=
To:     CKI Project <cki-project@redhat.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 9:20 PM Veronika Kabatova <vkabatov@redhat.com> wrote:
>
> On Mon, Jun 21, 2021 at 9:17 PM CKI Project <cki-project@redhat.com> wrote:
> >
> >
> > Hello,
> >
> > We ran automated tests on a recent commit from this kernel tree:
> >
> >        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >             Commit: b0740de3330a - Merge branch 'for-5.14/drivers-late' into for-next
> >
> > The results of these automated tests are provided below.
> >
> >     Overall result: FAILED (see details below)
> >              Merge: OK
> >            Compile: FAILED
> >
>
> Hi,
>
> the failure is introduced between this commit and d142f908ebab64955eb48e.
> Currently seeing if I can bisect it closer but maybe someone already has an
> idea what went wrong.
>

First commit failing the compilation is 7a2b0ef2a3b83733d7.

Veronika

> Veronika
>
> > All kernel binaries, config files, and logs are available for download here:
> >
> >   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/06/21/324657779
> >
> > We attempted to compile the kernel for multiple architectures, but the compile
> > failed on one or more architectures:
> >
> >            aarch64: FAILED (see build-aarch64.log.xz attachment)
> >            ppc64le: FAILED (see build-ppc64le.log.xz attachment)
> >              s390x: FAILED (see build-s390x.log.xz attachment)
> >             x86_64: FAILED (see build-x86_64.log.xz attachment)
> >
> > We hope that these logs can help you find the problem quickly. For the full
> > detail on our testing procedures, please scroll to the bottom of this message.
> >
> > Please reply to this email if you have any questions about the tests that we
> > ran or if you have any suggestions on how to make future tests more effective.
> >
> >         ,-.   ,-.
> >        ( C ) ( K )  Continuous
> >         `-',-.`-'   Kernel
> >           ( I )     Integration
> >            `-'
> > ______________________________________________________________________________
> >
> > Compile testing
> > ---------------
> >
> > We compiled the kernel for 4 architectures:
> >
> >     aarch64:
> >       make options: make -j24 INSTALL_MOD_STRIP=1 targz-pkg
> >
> >     ppc64le:
> >       make options: make -j24 INSTALL_MOD_STRIP=1 targz-pkg
> >
> >     s390x:
> >       make options: make -j24 INSTALL_MOD_STRIP=1 targz-pkg
> >
> >     x86_64:
> >       make options: make -j24 INSTALL_MOD_STRIP=1 targz-pkg
> >
> >

