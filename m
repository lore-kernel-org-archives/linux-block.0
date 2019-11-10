Return-Path: <SRS0=JPMG=ZC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6A1C43331
	for <linux-block@archiver.kernel.org>; Sun, 10 Nov 2019 11:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6DE21655
	for <linux-block@archiver.kernel.org>; Sun, 10 Nov 2019 11:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKJLtE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Nov 2019 06:49:04 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:55080 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfKJLtD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Nov 2019 06:49:03 -0500
Received: by mail-il1-f200.google.com with SMTP id t67so13678533ill.21
        for <linux-block@vger.kernel.org>; Sun, 10 Nov 2019 03:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=muS40/M+U7unS7Nwdhba7+0opY/I2Z2pZGBBgPUq8C0=;
        b=SM9W4ri+TrRAR/2Vm1zZjpKmtaAQARuKrBsSA5LnZr9TYVBPTSDMrnOcmObURfxDDm
         oCN6nh0BO9imIOLOtlMtxnBKL2g+MmztUvBxAhQ7uoOUo40Pguk6v2QABi1f14vxbZ3U
         Ls2tEhCiDMedCxb7Q25TRmnQWB8ziNcPObdYtDKuPx9at3l/mgyOYz6EBZRih+QEcBFa
         gHWTqCQ7mk4HyutCSRbyNkHdV0/9bg7Kl8phvtFQSMvJva0Z5uhg/23aL7tZhCHS1l0d
         C4qhwCYBdh0u/RtYSICsElZCHMVFhOdvSPRWjFkb54sIRPVa2yONPI5zr97/HlGnoJYy
         gq8Q==
X-Gm-Message-State: APjAAAUBxa/wnKx+InnW3fdXFgmq5sS0b6CiiL7Oas9CAcNlx1xLoNZL
        KsmEo9fmyhTC4cvtypt1Zy0C6dn29YMsf6YJR9ZIqZz138AG
X-Google-Smtp-Source: APXvYqwG7iOuXUzrPn9C7IQw34I7LSwhAIRpMFyONIfQ9Z8ZWhdhx/QqVwYg/S2UFNW58oOzV3uQTeJdrwTJ/Pza/72hGbJAuyfE
MIME-Version: 1.0
X-Received: by 2002:a92:16d4:: with SMTP id 81mr24840022ilw.198.1573386541143;
 Sun, 10 Nov 2019 03:49:01 -0800 (PST)
Date:   Sun, 10 Nov 2019 03:49:01 -0800
In-Reply-To: <0000000000003659ef0596fa4cae@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e11df90596fc9955@google.com>
Subject: Re: KASAN: invalid-free in io_sqe_files_unregister
From:   syzbot <syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit 65e19f54d29cd8559ce60cfd0d751bef7afbdc5c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Sat Oct 26 13:20:21 2019 +0000

     io_uring: support for larger fixed file sets

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154f483ce00000
start commit:   5591cf00 Add linux-next specific files for 20191108
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=174f483ce00000
console output: https://syzkaller.appspot.com/x/log.txt?x=134f483ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1036c6ef52866f9
dashboard link: https://syzkaller.appspot.com/bug?extid=3254bc44113ae1e331ee
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116bb33ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173f133ae00000

Reported-by: syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com
Fixes: 65e19f54d29c ("io_uring: support for larger fixed file sets")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
