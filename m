Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F65C433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 12:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CD260FBF
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 12:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbhIFMgs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 08:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbhIFMgs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Sep 2021 08:36:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8858C061757
        for <linux-block@vger.kernel.org>; Mon,  6 Sep 2021 05:35:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id jg16so13266317ejc.1
        for <linux-block@vger.kernel.org>; Mon, 06 Sep 2021 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xypxOlLpIj1kGaPZeLVMc46scojUqvHHVmiRLDEQQR8=;
        b=TL6ZLMNGxgMHqhSbKACJWG4qgO0pISGZjT4JY7BFUYc/LatqxrxQpwN+gwdbM1XDsP
         xpBb0U2eP8wW9LADy2lHUFT/75fMKfjuqvMyBddfFM1xTtbVHNtw/fkk5gaRIfzWxUUy
         QdTYsduN+uwL8CXX7zlayO+MTXqottOhFkv4nbTroeFhU75RmvUMsGXCMKZvM+N8o3Bf
         lQ7P+DQmVasNhKW+dE0+4VyrifzkXnAcGGUgZDWWk4d+4bG79BkdhL6tHCMB4OXivB5o
         8ga4NUcbLasdXv2/JVZsHoZEBCG4C5HGBZwc803IM3EukNOouLdCm9hRb1HQ0BX5OAh9
         b0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xypxOlLpIj1kGaPZeLVMc46scojUqvHHVmiRLDEQQR8=;
        b=a1L5KAIqCW7Wqt0fd/1yeb5G9Fns1uZ8a6qwnqjp6pDcTd2TdWU92bxYWqa2cKoSSH
         8B/ozW8LbEE7WLy/Pe9pChQcqtAAj2FPnxZ+CepRSEkhYHBzZ6C0KvsSUJenfEZ5idn+
         6ucX3VtuT3iXPAyenpG4gad27Zo++kGRLE7xBdR7TJyhwLWQ9QomHi6npOWiLS2Fcz7R
         +4LnpSGrlpgSBlCGNVW84eLT7HEx3QiJeDPG1SdFgt7eMA9FQnhpgqJu8VQc3P7io1BP
         xr6VX6npi8t2ySW8qLBuxtJS8vUv4R6jBmc4IYJwDvP6h0ASv2nIaO4XgoPzEo+kpF6T
         gSvw==
X-Gm-Message-State: AOAM531QYQ0OkYEXQlcLWMm7VdiuQ69t/WjQcTjgzBbQw8ywiv6mNGhZ
        iSoUv3zJVSZyGSOzVAOVBfnC0t/N8MkVb/sYOZ0pB3KZMCq50Q==
X-Google-Smtp-Source: ABdhPJx3hPH1VLkxO8Io/KzIZ1VugtEWn5DfCMkNUKAyG5KjbPB8MecAtLLMHCMKfPT+VSVkB0Iyuu0sNY1+YmKFz6E=
X-Received: by 2002:a17:906:318b:: with SMTP id 11mr13586711ejy.493.1630931742051;
 Mon, 06 Sep 2021 05:35:42 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 6 Sep 2021 18:05:30 +0530
Message-ID: <CA+G9fYvA-ctLRz=fimVs9oYPN+s5gtFc32dQVxinkOLyed0DUg@mail.gmail.com>
Subject: block/mq-deadline.c:274:12: error: 'dd_queued' defined but not used [-Werror=unused-function]
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Following build warnings/ errors noticed while building linux mainline
master branch
with gcc-11 for arm architecture with clps711x_defconfig config file.

block/mq-deadline.c:274:12: error: 'dd_queued' defined but not used
[-Werror=unused-function]
  274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
      |            ^~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [/builds/linux/scripts/Makefile.build:277:
block/mq-deadline.o] Error 1
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/builds/linux/Makefile:1872: block] Error 2
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:219: __sub-make] Error 2
make: Target '__all' not remade because of errors.

Build config:
https://builds.tuxbuild.com/1xjZuKPY0IygLQHFkTFMY9TPQh4/config

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git_describe: v5.14-9687-g27151f177827
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
    git_sha: 27151f177827d478508e756c7657273261aaf8a9
    git_short_log: 27151f177827 (\Merge tag
'perf-tools-for-v5.15-2021-09-04' of
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux\)
    kconfig: [
        clps711x_defconfig
    ]
    kernel_version: 5.14.0
    target_arch: arm
    toolchain: gcc-11

steps to reproduce:
https://builds.tuxbuild.com/1xjZuKPY0IygLQHFkTFMY9TPQh4/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
