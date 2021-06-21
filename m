Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EAAC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 21:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF42610EA
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 21:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhFUVKK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230102AbhFUVKJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 17:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624309674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ugN53vPsDtDFmv0xFqPIEq2uRBg/3g5AObrFyNHFRlE=;
        b=G4sutLd7/teRMJ6wRYgldoqHo2ckhJeEx2kHCakZHkrY2fdo2Oc3nD8qOQ12NXa379+h+m
        c9S1mVUH9R3F/tyEOrYfJ0IiGwvSdUdybAyOztSl9dPzyHNqTVbuLyojutrMEM9ca2z9hj
        FbK4/NDvywEShIXxIPgM3yXc7E5YggQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-B5xYazhYPTCQdrznoPueLQ-1; Mon, 21 Jun 2021 17:07:53 -0400
X-MC-Unique: B5xYazhYPTCQdrznoPueLQ-1
Received: by mail-lf1-f71.google.com with SMTP id g11-20020ac2538b0000b029031a74fb5db6so4053818lfh.3
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 14:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugN53vPsDtDFmv0xFqPIEq2uRBg/3g5AObrFyNHFRlE=;
        b=uLvfec/lFfu92oD7RwrZC8W/kXjsXDWWnLWM0D91r6Oi33ZugkWwCAn3ymKzTd0VKn
         E7Kbn4uvEqtlDiuezEztgQgaWAssOmamh03YYiGPZnAmwZRDMiUwrqlY59pReMAl/S3w
         OEEyO6/kmrGdHkb5fcxD7WyYfnqPnm24MtRF8eUehxUBRfS0puOiubsZu2h02/79rfwZ
         I12nAc82EPsNrB8HYM4kxCST1dg36anwSB0DykWMEbW3HzOxtXm85V6SnVZKuGi/OJrI
         cOKa9zPWoGnKRat7tBVL3rrw/XkfDOzq6CG6ZPwuKmrrQdMsyp41xeLCMT6M8pFN53is
         RDdQ==
X-Gm-Message-State: AOAM5323IjnSUUTO4vPRNJh/MfS1AV4gq3I9P2uoSPQYBMhyr+3DVMbD
        xPoxoiSwv0xjY1spQNTvr98KVHCxuv3BtPxUZQlYTinEiXCfAsqcLWCD3L98aG1bddo9z+HvT76
        hgUSMBTS/sxEwWIWq7xj17d06is6rpBsY3+kPFfE=
X-Received: by 2002:a19:da11:: with SMTP id r17mr140603lfg.595.1624309671878;
        Mon, 21 Jun 2021 14:07:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwnS9Sjk5RXo+d97J0nU8aMvcrXPHsHh62vTWE/2qaAA+iVPQTDMlSYuAg2g6fSwXaAYsMbDxpM+H8CCTWaYg=
X-Received: by 2002:a19:da11:: with SMTP id r17mr140590lfg.595.1624309671718;
 Mon, 21 Jun 2021 14:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <cki.3F4F097E3B.299V5OKJ7M@redhat.com> <CA+tGwn=+1Evv=ZZmOdXSpfUTG_dPvHfDsxbmLyHWr9-XkXA1LQ@mail.gmail.com>
 <CA+tGwnn4J2=WuPEFOwmC6ph30rHXJLhjH-iWmvkKLpacmR7wdQ@mail.gmail.com> <42b91718-9d70-4e4c-2716-6259321abd64@kernel.dk>
In-Reply-To: <42b91718-9d70-4e4c-2716-6259321abd64@kernel.dk>
From:   Veronika Kabatova <vkabatov@redhat.com>
Date:   Mon, 21 Jun 2021 23:07:16 +0200
Message-ID: <CA+tGwn=8KMpRi+6M-Lcs5MjKTkPd36YL5wv84Ji2dEWLjzfDmA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E13=2E0=2Drc6_=28blo?=
        =?UTF-8?Q?ck=2C_b0740de3=29?=
To:     Jens Axboe <axboe@kernel.dk>
Cc:     CKI Project <cki-project@redhat.com>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 11:00 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 6/21/21 2:57 PM, Veronika Kabatova wrote:
> > On Mon, Jun 21, 2021 at 9:20 PM Veronika Kabatova <vkabatov@redhat.com> wrote:
> >>
> >> On Mon, Jun 21, 2021 at 9:17 PM CKI Project <cki-project@redhat.com> wrote:
> >>>
> >>>
> >>> Hello,
> >>>
> >>> We ran automated tests on a recent commit from this kernel tree:
> >>>
> >>>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >>>             Commit: b0740de3330a - Merge branch 'for-5.14/drivers-late' into for-next
> >>>
> >>> The results of these automated tests are provided below.
> >>>
> >>>     Overall result: FAILED (see details below)
> >>>              Merge: OK
> >>>            Compile: FAILED
> >>>
> >>
> >> Hi,
> >>
> >> the failure is introduced between this commit and d142f908ebab64955eb48e.
> >> Currently seeing if I can bisect it closer but maybe someone already has an
> >> idea what went wrong.
> >>
> >
> > First commit failing the compilation is 7a2b0ef2a3b83733d7.
>
> Where's the log? Adding Willy...
>

Logs and kernel configs for each arch are linked in the original email at
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/06/21/324657779


Veronika

> --
> Jens Axboe
>

