Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A2C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 16:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97EAB60F46
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 16:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbhITQTm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 12:19:42 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243474AbhITQTc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 12:19:32 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MSss2-1mJ2rl0gW6-00UKPc; Mon, 20 Sep 2021 18:18:03 +0200
Received: by mail-wr1-f48.google.com with SMTP id q26so31256991wrc.7;
        Mon, 20 Sep 2021 09:18:03 -0700 (PDT)
X-Gm-Message-State: AOAM533AZytLLLxz+az5B9RO+ZnXrokGRKfjY9VLCH8JhJtQlp/P/xRH
        qbLZ/gnWh1cU2Gg82J3wZRh6UYo6PVFMIto4Zio=
X-Google-Smtp-Source: ABdhPJyj8hFxkUX2FfsaumrjjdO0cc7SRxV3KzCjqYZ8I8x5/cEaG8V3Wj+OJvUWIWvJvZOe1uZCc9bfxWl1+/wbBFk=
X-Received: by 2002:a5d:6c6f:: with SMTP id r15mr1544050wrz.428.1632154682677;
 Mon, 20 Sep 2021 09:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210920131516.2437790-1-arnd@kernel.org>
In-Reply-To: <20210920131516.2437790-1-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Sep 2021 18:17:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Zmhg+etxdRnPdtbRS_a3e-b0VmQm3dyuTJUn_YKQrxw@mail.gmail.com>
Message-ID: <CAK8P3a0Zmhg+etxdRnPdtbRS_a3e-b0VmQm3dyuTJUn_YKQrxw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] blk-iocost stringop-overread warning workaround
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Tejun Heo <tj@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:iN3RuAXdszj+Czt9marrbVxmNIGhGTJlq9Kf/eodTcL3dh1FVp+
 JHBzeH6n3IvWSdfSHnM8FjJo3OvYmeXuv8AB5ArcRKWHZt+Wzh/nxu5P4EyZFoCx4xwhd0k
 XK9kOjlx1+m/fsREMKsHqoX6L2OU2nEaHC/7xoOOhBC8UsYoTsGSfsRO4KA9CpTTFQHu95y
 oh8FMtSQFgLLvm0ulpE8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uV1eZH4hdm4=:cq6qFO713tTPY7PevIJ8pf
 cqVS63yi09b2quPPTDQa22gnhKmNBmFTah3HuZcw0Sy2MMM6JPPMl4fuC/K4SbxJPOW2wVwHz
 L5A7XU8Osun9tdGrpL10J5oU4MBtFaTYc9Un/W3zUlobvRC17xgPtx/CXQejkUzfLAZT2xMdG
 6ACAskfYtXmz7KUKBnDdQhQ4MrXmdxNuoT/ay7fvPH8586p2F1exwPoVtAAZysJQWYYRIXqyn
 VekbEuYVOgZ14NUIJux8bT6qH9vPS8k/fuLLSO/ottraOfLZ7umGmyYlODOiYkhWS6eg0PzvL
 u5DMuJqKtoqP7nmuYB6hX1qIfruTUq43ChcNam4ut55b3d3h4cqb5QIU7S6+VTvpLGsFk3pEr
 wShL3w1/X5VKugRsXGI8ByDinvKj1vq1uUpJWuT+NvxU1eW4amy4ZIQ4A7idX74IzUI1gREn3
 NhdxFxyijG1SVKx7lCIyA+ICptqcWbP0PvqnuGc2MpniKMMvcuBYD/xFMZzbQ+iVD1heO4Ktc
 JzjWyfJjV0xbHLi/wgbww+nD3cnsJ0ukh+3gewjs9SQZf1mPIKhlMtET+fFAK+rGL9xOv+7du
 jYyXYjVfmdWyYW9giAZeTd2srpv8AIVfu1glr8tA+6fWL130B6P7guK6wAigUU6qkwLh4REYs
 GCch86qIb7KnIRvzX1bfsNqseEamfhe6lpKToouj/o8FphCsO7H0BwRwhXqfGEdtfLmZHq51o
 aZ9M29LiWG9+ZHAWgoCcDwYG8omMsXNSHbXAiAH9ZgzidpD0Z7SBJamPqwkHN3+aQ1tBJOh8Y
 zNbxxP+KNtd+VJZMzz+NcUJReymsmdNt18gS1IXAhsTga80Pl+CpSLr20BdxJ5ciIUHKMfaxW
 TgwqQCOfMFd5/u2wXmnQ==
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 3:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> In some randconfig builds with gcc-11, I get a warning from
> the fortified string helpers:
>
> In function 'memcpy',
>     inlined from 'ioc_cost_model_write' at block/blk-iocost.c:3345:2:
> include/linux/fortify-string.h:20:33: error: '__builtin_memcpy' reading 48 bytes from a region of size 0 [-Werror=stringop-overread]
>    20 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> include/linux/fortify-string.h:191:16: note: in expansion of macro '__underlying_memcpy'
>   191 |         return __underlying_memcpy(p, q, size);
>       |                ^~~~~~~~~~~~~~~~~~~
>
> I don't see anything wrong in the code itself, so I suspect it's
> gcc doing something weird again. The only way I could find to make
> this warning go away is to hide the object using the RELOC_HIDE()
> macro, but this is really ugly and I hope someone has a better
> idea.
>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Please disregard my patch for now. After looking closer, I found that I had
applied a patch that accidentally removed the

KBUILD_CFLAGS  += -fno-delete-null-pointer-checks

line from the top-level Makefile. If I put that line back, the warning
disappears.

        Arnd
