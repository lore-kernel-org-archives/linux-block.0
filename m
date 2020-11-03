Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E71C2D0A3
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 07:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90FF21556
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 07:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/e9geNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgKCHVw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 02:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCHVw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Nov 2020 02:21:52 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6BAC0617A6;
        Mon,  2 Nov 2020 23:21:51 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id s89so13953929ybi.12;
        Mon, 02 Nov 2020 23:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebOQ9Je52Ez30DqwtDrcVUKFemUvVML69F1lmPNTVIw=;
        b=I/e9geNV9tzU8CIkTqKuEmOIsZYCWKKGd+WCtCpSgPxrxlQw4E6++PFFS8LYwGktEq
         FCcFyHXaEbuuxayyqd4kgEdAcUc/X+wdXHQ6mpnVTTXfkf0Qu7Ko4p2XkuGSMsqRcYWX
         0WT1z7eI28uc/Y2LP8IyBvvq3eH92GMeFfGCt1S+PBNr5aoBh6/DH/e7l8m2Tj7P9u+M
         MSEv9l+EPUdUWY5b1IVtBML9fXje1Yr95BVaFWX1B9skdNjICVy3zaetSgLrGG+B3r5X
         PAaysuWe09a5Rc7C+8j59/aI8zq3lV7LpgMV/4GkoZgh51emuVF3HRr7a6TP0tWug9yo
         WPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebOQ9Je52Ez30DqwtDrcVUKFemUvVML69F1lmPNTVIw=;
        b=FODtFeVpsgY0mKl1BLF+DP6ptTcMuhchBdVgml6sAk3plBgGlR1YfslvSCTmJgItFp
         Dq+VQg4QW16WkcNjj7VJEuQXMvXhY4Qdv8NjYAkrc86zrIp8IEhKHkICg8fUT3yqK1LB
         MRtwItCP1alq9VMu1F6zf2mes2XmfxKYbV8rXQAFWy23wfLgqE72v0ZyGf6bIgnqgqH2
         198SXCQfG8HNVIWyqU1bG+fAR95SeWGh6NNT4rVa9RvUKPhsY4E7Q5V+fc5EB0dVhQer
         G7MdBPfmpK/PG7e5rs5sp2/litG4u78WTC6MmpYVe81q612oWwPvn/O6F4xG3ix6018m
         sS4A==
X-Gm-Message-State: AOAM533l7CS/GgCKmD8jozTBp2+Fs5+kpvQLOWM06FIaz66b2wAxwCAk
        k7Mn76uXo0RvouMW5/yo9jKapb8tpFlfxXbGNNY=
X-Google-Smtp-Source: ABdhPJzFEfGhyvQoxfMBw2GldYklK5VyOgWqObaAubmsY18xxv3SgrXeZt50AZbkDYLWVmrCbfDK0EgQo8aM14ondg8=
X-Received: by 2002:a25:2d01:: with SMTP id t1mr28378049ybt.50.1604388111314;
 Mon, 02 Nov 2020 23:21:51 -0800 (PST)
MIME-Version: 1.0
References: <00000000000061316205b0e750fc@google.com> <0000000000004cb88b05b2e8d1b4@google.com>
In-Reply-To: <0000000000004cb88b05b2e8d1b4@google.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 3 Nov 2020 15:21:40 +0800
Message-ID: <CACVXFVNk9Os+2Bzht+eoeFZr=E-FCBZg2SSYx5AP_eu_-3zF3w@mail.gmail.com>
Subject: Re: INFO: task can't die in nbd_ioctl
To:     syzbot <syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 31, 2020 at 4:01 AM syzbot
<syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    4e78c578 Add linux-next specific files for 20201030
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=158c1798500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
> dashboard link: https://syzkaller.appspot.com/bug?extid=69a90a5e8f6b59086b2a
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e051a8500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bf75b8500000

Not reproduce this issue by above C reproducer with the kernel config
in hours running
on linus tree.

Thanks,
Ming Lei
