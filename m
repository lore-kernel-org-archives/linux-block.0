Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE1CC433E2
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 20:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF67F2087D
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 20:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgHaU3I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 16:29:08 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:35517 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgHaU3H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 16:29:07 -0400
Received: by mail-il1-f197.google.com with SMTP id p16so2928715ilp.2
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 13:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gnKsjgJ5rv+iBjKke+34Do0zneKwGI7SNQuffWwXV30=;
        b=saTxHdnXRScCcz8kXS49FAGQW/SUIGqWkyq3lHjXZ/16nPxPF36jMVEx1rLYv25OGk
         oheLhzMkCceS3hoW1l/orlYKtYSxfWeOedaXY6jvK5DIO9D0JdimkFgnFQ5FZOLBdptJ
         9deOwlofnXLcgM/k+dS6A1lcPcN2SRC8b1sPltVy8pT8MceJ2r9S4xXk6vLwwa8FCOTi
         4D6oOOp+cprDJJkspOJ1ZAC2g2nXC4x5ojfZsN3bpOB4UI8zZjBgztzNBV/ngG0+mmpK
         FZvKQUsKGAvxgHHz42PXRtIdoGIhA0RunFx8vmXUpfGESvN6HiZ/TaX7WYpf7aevtbI1
         vxmg==
X-Gm-Message-State: AOAM532R/DTfZo67PUyBjwQu6K7efD9rzrmQPjR3s0ZYQNxhJ+S65ZGf
        U/LVxSZhsdlXGiOKLahRYOJjSk7rWAdqCPreoxcMCo4+RClj
X-Google-Smtp-Source: ABdhPJwCvxBZTJEsf7HAcCNqGtxUArlv0LeJO8NfG5NM0O/U5K34R5yLEbt3NyLxslkp5VsQxwdtrntanuYjj9jwxim2j2G3q909
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b13:: with SMTP id p19mr2800611iov.30.1598905747341;
 Mon, 31 Aug 2020 13:29:07 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:29:07 -0700
In-Reply-To: <000000000000520ffc05ae2f4fee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001985dc05ae32417b@google.com>
Subject: Re: KASAN: use-after-free Read in bdev_del_partition
From:   syzbot <syzbot+6448f3c229bc52b82f69@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, jack@suse.cz,
        johannes.thumshirn@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit cddae808aeb77e5c29d22a8e0dfbdaed413f9e04
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 14 07:28:54 2020 +0000

    block: pass a hd_struct to delete_partition

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fa7656900000
start commit:   dcc5c6f0 Merge tag 'x86-urgent-2020-08-30' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14067656900000
console output: https://syzkaller.appspot.com/x/log.txt?x=10067656900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
dashboard link: https://syzkaller.appspot.com/bug?extid=6448f3c229bc52b82f69
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e2285900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f6e915900000

Reported-by: syzbot+6448f3c229bc52b82f69@syzkaller.appspotmail.com
Fixes: cddae808aeb7 ("block: pass a hd_struct to delete_partition")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
