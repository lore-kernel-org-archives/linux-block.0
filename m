Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AA9C4742C
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 12:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B422322240
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 12:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B07q5E3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgKMMKV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgKMMKU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 07:10:20 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707B1C0613D1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 04:10:19 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 63so4443661qva.7
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 04:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiehXoilaLcjVL9BlBQaNhTaAJDG9nqqIO0TWMbl7mA=;
        b=B07q5E3cb5/mB7Ld7CNt3Vbvde8zMncRaosaJDlZv6Vt864LjakgIYDon/9ubBonvg
         MO3dfCIP5RFXoUEuTnK7p8eV0NxSxk1WH1Oa0YEVRaifFQE/SkBLrhNubfN70NR24tVd
         D9m5jD86WUrSyzE6XiabBxQIrGVN34QmK0s6i0KeMXu+JwDjPh2iF2jRylV3bjBlmq17
         jge0XZ+wdtj6d0xSME6wxs+eY8E6end4ZX1KPOZSaD6XPoYcKtRYRbKQwwDNnOsKS4p4
         sGxcLt+g5Kc2UZNxyhcQYCU5nnMlVoyrUE4ilHTXS9cc+ImaVSEHK0wNnztoDxy4E/7H
         ihnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiehXoilaLcjVL9BlBQaNhTaAJDG9nqqIO0TWMbl7mA=;
        b=skRsU5hxK2P1ieo71tXm6AVBssUDJ5zOUjwy8Dgbun//Rn0hR/FHB60ovIluEqQskA
         9fEpU2NMiMQlBJKCMmK/CgVtPCAg/8vYppZ42AiHFYXtDWqY0C6CbpD48MXBLVNWg62q
         abcqOdTv/sHUcd9eCF36JmVrcPooLgxOMCP0Kt204lbrO4Yism0jr76T2pSuqdGgqLdu
         eNmUvywRGtzmVsH4aUSHHGUoYcruFmH7tx6pP9bdH0mcpsYpeSiOHPa89gPE6okumlpM
         Nk6L/c7QCLVDI+9glTvOG6ulsWJUP/R6cBKCk7LKIKMcIZs8ahKpg/ODIYbpzwUhOB33
         aPeg==
X-Gm-Message-State: AOAM530xR0HTAXp8r/4wQM8/IAaFKuKdwzHSobQa+PSws13RakKtIJMH
        HsSXWmUh1vV5C5/6BmZYlGd6oRVFr/2ZOwiUbwGkGA==
X-Google-Smtp-Source: ABdhPJz0bG9vUG7cborAESnk3G+Mfz2v/pDLuOMyNrvdaU6cKXA9OkAgDWAnWlxShWUS3ojvDZ7hgvRtw5w5WSbreCg=
X-Received: by 2002:a0c:e911:: with SMTP id a17mr2006226qvo.18.1605269418352;
 Fri, 13 Nov 2020 04:10:18 -0800 (PST)
MIME-Version: 1.0
References: <00000000000061316205b0e750fc@google.com> <0000000000004cb88b05b2e8d1b4@google.com>
 <CACVXFVNk9Os+2Bzht+eoeFZr=E-FCBZg2SSYx5AP_eu_-3zF3w@mail.gmail.com>
In-Reply-To: <CACVXFVNk9Os+2Bzht+eoeFZr=E-FCBZg2SSYx5AP_eu_-3zF3w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 13 Nov 2020 13:10:06 +0100
Message-ID: <CACT4Y+YrLRueFzXqNrWcy5ic-TsAJz393G+fg_4x1zfMo061oQ@mail.gmail.com>
Subject: Re: INFO: task can't die in nbd_ioctl
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     syzbot <syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nbd@other.debian.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 3, 2020 at 8:21 AM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Sat, Oct 31, 2020 at 4:01 AM syzbot
> <syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    4e78c578 Add linux-next specific files for 20201030
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=158c1798500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
> > dashboard link: https://syzkaller.appspot.com/bug?extid=69a90a5e8f6b59086b2a
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e051a8500000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bf75b8500000
>
> Not reproduce this issue by above C reproducer with the kernel config
> in hours running
> on linus tree.

Let's see how reproducible this is by syzbot:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git
4e78c578
