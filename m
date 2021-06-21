Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53615C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7586128C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 19:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFUTXw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230061AbhFUTXw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 15:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624303297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WaS3AKoDpdpjjvORaM52plgHZ+Tp2sa/oPeUlnYFgo=;
        b=H5Xjcu8OvhB4bzTN/k3OnWEBjM0zQ76VsmiibILTVPR5gu3rj1NRv0EJpUOCCrns1EQWtJ
        AOGhr+XOX0fYEfIbu9yDuMYMvBF+An2fZJ/yU7eIT/mBZF9mmugIQfvtSnQFEnfV1hC1Xi
        EjV7OAcmDB0CD4vUYLXJKgFri2YM0u4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-UgHr-BRUOOODxx1pulbdLQ-1; Mon, 21 Jun 2021 15:21:36 -0400
X-MC-Unique: UgHr-BRUOOODxx1pulbdLQ-1
Received: by mail-lj1-f199.google.com with SMTP id m11-20020a2e580b0000b0290152246e1297so9551686ljb.13
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 12:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WaS3AKoDpdpjjvORaM52plgHZ+Tp2sa/oPeUlnYFgo=;
        b=NVTg7vKmTaV96XGq0A31GR8CzGqZt5RW+fSVkqMDmWUNf3E5XlAuYSlWkNgFMRDaML
         pbngoqosmEqtBztU7z2BvExbfn0eLkMG4BE+yA8ZSWqE1F4FLeRk9DfT9sOXXbMaVWzi
         BLWvraSJwrRzvRWBshSg6xuKfuhJtNDo4YSBpDDGxqrEG/fe/A2z2vruH9g1G8B54LkW
         369DiY0t+1dTjLznOji8CXYidhVUuZ7UFduGa/OCS9ZcqCe33CcaiJMYhzW2MH4pT4fj
         BbhGq0PPxY4QrITpqroFzMly4/OBeWl3ET2aKa4ntjhM/Y11bEE9azBx0fHtlHmbO8My
         +o1g==
X-Gm-Message-State: AOAM531HOLg50tbdsSGeYkRx8cWjhUbDjxJECs9SBymiffJnO9AUqFIl
        I5qKhScAzfm4M7Ir84ZvJOMCRaADHksBRwf+EhgNIxCVDyqL5i+ZWXRy7/advaYYpajLlVVJQFI
        yoVhshpQCY+j+CIJLL90D18ovk/VcOh7oxbCUuEU=
X-Received: by 2002:a05:6512:3054:: with SMTP id b20mr15005799lfb.375.1624303294496;
        Mon, 21 Jun 2021 12:21:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh9pSBqbX5AT9XeSxwgLuuNU/QKdqrn7kz5HOMPJI8chtenPkYZfjhaMo0r/NynkPmmNIuZkVRPy/xYKaT7Fc=
X-Received: by 2002:a05:6512:3054:: with SMTP id b20mr15005793lfb.375.1624303294288;
 Mon, 21 Jun 2021 12:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <cki.3F4F097E3B.299V5OKJ7M@redhat.com>
In-Reply-To: <cki.3F4F097E3B.299V5OKJ7M@redhat.com>
From:   Veronika Kabatova <vkabatov@redhat.com>
Date:   Mon, 21 Jun 2021 21:20:57 +0200
Message-ID: <CA+tGwn=+1Evv=ZZmOdXSpfUTG_dPvHfDsxbmLyHWr9-XkXA1LQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E13=2E0=2Drc6_=28blo?=
        =?UTF-8?Q?ck=2C_b0740de3=29?=
To:     CKI Project <cki-project@redhat.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 9:17 PM CKI Project <cki-project@redhat.com> wrote:
>
>
> Hello,
>
> We ran automated tests on a recent commit from this kernel tree:
>
>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>             Commit: b0740de3330a - Merge branch 'for-5.14/drivers-late' into for-next
>
> The results of these automated tests are provided below.
>
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: FAILED
>

Hi,

the failure is introduced between this commit and d142f908ebab64955eb48e.
Currently seeing if I can bisect it closer but maybe someone already has an
idea what went wrong.

Veronika

> All kernel binaries, config files, and logs are available for download here:
>
>   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/06/21/324657779
>
> We attempted to compile the kernel for multiple architectures, but the compile
> failed on one or more architectures:
>
>            aarch64: FAILED (see build-aarch64.log.xz attachment)
>            ppc64le: FAILED (see build-ppc64le.log.xz attachment)
>              s390x: FAILED (see build-s390x.log.xz attachment)
>             x86_64: FAILED (see build-x86_64.log.xz attachment)
>
> We hope that these logs can help you find the problem quickly. For the full
> detail on our testing procedures, please scroll to the bottom of this message.
>
> Please reply to this email if you have any questions about the tests that we
> ran or if you have any suggestions on how to make future tests more effective.
>
>         ,-.   ,-.
>        ( C ) ( K )  Continuous
>         `-',-.`-'   Kernel
>           ( I )     Integration
>            `-'
> ______________________________________________________________________________
>
> Compile testing
> ---------------
>
> We compiled the kernel for 4 architectures:
>
>     aarch64:
>       make options: make -j24 INSTALL_MOD_STRIP=1 targz-pkg
>
>     ppc64le:
>       make options: make -j24 INSTALL_MOD_STRIP=1 targz-pkg
>
>     s390x:
>       make options: make -j24 INSTALL_MOD_STRIP=1 targz-pkg
>
>     x86_64:
>       make options: make -j24 INSTALL_MOD_STRIP=1 targz-pkg
>
>

