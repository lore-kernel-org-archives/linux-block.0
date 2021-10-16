Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCA7C433EF
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 08:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5BD611AF
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 08:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhJPI6s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 04:58:48 -0400
Received: from condef-02.nifty.com ([202.248.20.67]:57735 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbhJPI6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 04:58:47 -0400
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-02.nifty.com with ESMTP id 19G8qcqW004323
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 17:52:38 +0900
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 19G8qQZ2028356;
        Sat, 16 Oct 2021 17:52:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 19G8qQZ2028356
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1634374346;
        bh=58deza8b/MvQFjM9wKDK2CKyqfQ4yZT6QveafG26adU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LtsTCIkIPUcvhkWpZSXnWBK2NLtvCpcjp7txYAkxiBouMohyATyRN7NZGnFV1dvKH
         Syx4rh7npZqmAPYn3MB90wMH8zX5x9eEL9P6XzI5iJpDmCOA6zAfPxwNFeX2KjJibM
         qIyk4bOKgLvWJP/p60AW3ToLdHF3wZ/fg3Ap2njyDNCpOsweNRhf5cBhwirqzs+36w
         RXkzHL9NFW9pLy++JEoH+Q3fWX/ow9NiWlWhS0Cv7QzZSEU+vj9cWQpa5dG1vLi8Ae
         moY6GbxaGyXCZ6DvAQd2V0do8VbwFEjFATCsB0XwFIqMkII8J71pcdNqeyZu8i8HMI
         upbAUgSPiXCQA==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id gn3so3324226pjb.0;
        Sat, 16 Oct 2021 01:52:26 -0700 (PDT)
X-Gm-Message-State: AOAM53007sVlv3tI/bcsT9qvvabYjDqh57g7NhrTO6OlwV3L09Vn0nvp
        cFAsgxjg40F/FMB5XFN+UlA3jBMmtBZER7nDQKk=
X-Google-Smtp-Source: ABdhPJw4RLNm4WUwuq2e1NujEZKOeDC+dPL+XOGnGPYSPpaZZBPDeAIBJMrNXFk5oEufB/kSYzrvmJEC3IV60ei4oHk=
X-Received: by 2002:a17:90b:1d06:: with SMTP id on6mr33910048pjb.119.1634374345728;
 Sat, 16 Oct 2021 01:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210927140000.866249-1-masahiroy@kernel.org>
In-Reply-To: <20210927140000.866249-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 16 Oct 2021 17:51:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-QLMk1T=PmfWurr8g2HB5=SUZZnexR9ovaFFuzC90vQ@mail.gmail.com>
Message-ID: <CAK7LNAT-QLMk1T=PmfWurr8g2HB5=SUZZnexR9ovaFFuzC90vQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/4] block: clean up Kconfig and Makefile
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On Mon, Sep 27, 2021 at 11:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> This is a resend of
> https://lore.kernel.org/linux-block/20210528184435.252924-1-masahiroy@kernel.org/#t


ping?

>
>
> Masahiro Yamada (4):
>   block: remove redundant =y from BLK_CGROUP dependency
>   block: simplify Kconfig files
>   block: move menu "Partition type" to block/partitions/Kconfig
>   block: move CONFIG_BLOCK guard to top Makefile
>
>  Makefile                 |  3 ++-
>  block/Kconfig            | 28 ++++++++++------------------
>  block/Kconfig.iosched    |  4 ----
>  block/Makefile           |  2 +-
>  block/partitions/Kconfig |  4 ++++
>  5 files changed, 17 insertions(+), 24 deletions(-)
>
> --
> 2.30.2
>


-- 
Best Regards
Masahiro Yamada
