Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010F6C433F5
	for <linux-block@archiver.kernel.org>; Thu,  3 Feb 2022 21:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353933AbiBCVGK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:06:10 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:52057 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347691AbiBCVGJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Feb 2022 16:06:09 -0500
Received: by mail-io1-f72.google.com with SMTP id h1-20020a056602008100b0061152382337so2798928iob.18
        for <linux-block@vger.kernel.org>; Thu, 03 Feb 2022 13:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uBmyzhLL0AacmJiOO0ygo8pOFo4TfHCiGIA5EQdvXeE=;
        b=ex3+scQmn51BUBTkf4gf0f0Uw942rlPnCKI1F7TM4M/cTCuNgHXmDW83tUV9lLhqJW
         7osnbMX8EfrMBMeHdJlE7iC4MkQGisoBCAAXC1tQhy6babUwxrHqF3PRU6cyPc4vEAkA
         Www3rY4WoUkZJ/t73oRCwk5hGKIr3BMv1/CXdqBcB2GhLCR1yQF5AkhgA7jRy6BuD+Oe
         EXLENWueMMxfNidI1HmEeSlVDOhUg5IlUWs++WlO/dPJIVsFXyqdW1sYDc2rVNtan3bd
         6Nd2J09av+UZ0wYysKdGEjlk82ZNCVfb2TSqqwfYdjVACYNnmJWfvc8rvjWejVmOmbAT
         aKJg==
X-Gm-Message-State: AOAM531lKgahdnSviZ63QWHNtPrV2J2p7Yo1p6g+cQkVtPJF+qMGmP+h
        cHqIAgfRmXwSfGOK7b+g/Gsij5klwNb4jhQAwrBUrLeTLBOa
X-Google-Smtp-Source: ABdhPJz7/ZbgejMhaE9OEyjG/6HURwiA2GryVh/9fg+CbYb99M8adUZngW39faXgneuMNTyLw+8Sk7QFCH8alyCPJh/ctQrEX+6V
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3295:: with SMTP id f21mr16186925jav.193.1643922369206;
 Thu, 03 Feb 2022 13:06:09 -0800 (PST)
Date:   Thu, 03 Feb 2022 13:06:09 -0800
In-Reply-To: <0000000000008c32e305d6d8e802@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dade8505d72380c9@google.com>
Subject: Re: [syzbot] general protection fault in submit_bio_checks
From:   syzbot <syzbot+2b3f18414c37b42dcc94@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, axboe@kernel.dk,
        bpf@vger.kernel.org, daniel@iogearbox.net, hch@lst.de,
        john.fastabend@gmail.com, kafai@fb.com, kch@nvidia.com,
        kpsingh@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit a7c50c940477bae89fb2b4f51bd969a2d95d7512
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jan 24 09:11:07 2022 +0000

    block: pass a block_device and opf to bio_reset

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b4f1cc700000
start commit:   2d3d8c7643a5 Add linux-next specific files for 20220203
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b4f1cc700000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b4f1cc700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27a9abf2c11167c7
dashboard link: https://syzkaller.appspot.com/bug?extid=2b3f18414c37b42dcc94
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14635480700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10eb2d14700000

Reported-by: syzbot+2b3f18414c37b42dcc94@syzkaller.appspotmail.com
Fixes: a7c50c940477 ("block: pass a block_device and opf to bio_reset")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
