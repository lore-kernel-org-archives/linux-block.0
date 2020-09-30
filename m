Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE3FC4727E
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 15:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3894D20789
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 15:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASUZZ95z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgI3PxR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgI3PxQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 11:53:16 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0603BC061755;
        Wed, 30 Sep 2020 08:53:16 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c8so2410551edv.5;
        Wed, 30 Sep 2020 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KDQZGvk0JkFdokli8ewGDoQ88Bh+KyqHPkmTFuM4sN0=;
        b=ASUZZ95zVqX6zun4WV2cHuoSaVfylBtUFd5fTB1mkLFepzB8PIBBWDCPAzkTlciPef
         YMWTvODp4Bv5Gh4ljYfw4Ohzzh6/QAdlnEm5H0bTMxW0Ce/1+MYeSPz/tlZaPIkEdkYI
         +p0UG3kM44jBQBCDkc8wvgmHpT8qZ/ijZBkqhTGYuYDiGk6c2JgLakeXfj5q34IgyH/Y
         NfGjXJEo2rU+otc359bSjHxzPdc+To+MAYco4LvusshstxwuE7hiOiJpNqjWy4gcXJrq
         CYmvr2HKgrQzRTO8wacAlTdlqmLemt93fSlXmaQepm/eakWnI0twohYoV1NlnBaD8pRz
         AxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KDQZGvk0JkFdokli8ewGDoQ88Bh+KyqHPkmTFuM4sN0=;
        b=nbilRkcibxOswu5TwQpc1+IgLfdUOyyQOkXgbTxSBRuktbltBaXi1EyUmJUPKizozC
         tsEcKy4pguFB3LGzGiUQKHwyMl7aJ7r0lx8J9lklRntGkCFf+RJqC1m5UfW+CU8TbeQ5
         ATj8U/SAf3XAhBlJ7E7YbK8cOv+sFAmilX+ZJK6nlkBultKGYNcsJf762U2TgDCUcanF
         Rfe8EfV5jvBuZK3L3sjWDwClwuJxXoSdnLeHpOY4aJKVTooCcIn3pNSlVV84m7bBUIeh
         I2ntDcW0O6BpBbqViSO+7Vw1bGKC1LEz5ecVrJN45kQmf1pCXwq8S0He12iS05/LJZj+
         PJSw==
X-Gm-Message-State: AOAM531m7FdOM1fRen7XmgjbNMXkNKkjB4rgNDk/02g06VeaAKPrdUFn
        cgFi8H6k5PYLH+yV8BcgKJiXnJmu/LltnpR2KnI=
X-Google-Smtp-Source: ABdhPJyTjUV/XRMDis5FIGkqzMizZEnCmM+iodG6+Z64Wj8n+6f8Ul3AqFpN9ekcH0mp8h7/xtQFpFdr3dVpPSCCgr0=
X-Received: by 2002:aa7:cf98:: with SMTP id z24mr3349861edx.241.1601481194525;
 Wed, 30 Sep 2020 08:53:14 -0700 (PDT)
MIME-Version: 1.0
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Date:   Wed, 30 Sep 2020 21:23:03 +0530
Message-ID: <CAKBsNOkLhK6awg91R6w3b-RD4JD-jV=uGqsX8-V7w-KDmOuF4g@mail.gmail.com>
Subject: Re: KMSAN: kernel-infoleak in scsi_cmd_ioctl
To:     syzbot+85433a479a646a064ab3@syzkaller.appspotmail.com
Cc:     axboe@kernel.dk, glider@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

#syz fix: ptrace: Prevent kernel-infoleak in ptrace_get_syscall_info()
