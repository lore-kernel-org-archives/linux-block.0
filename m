Return-Path: <SRS0=St9l=EG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA3C388F7
	for <linux-block@archiver.kernel.org>; Sat, 31 Oct 2020 12:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030002071A
	for <linux-block@archiver.kernel.org>; Sat, 31 Oct 2020 12:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgJaMnG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 31 Oct 2020 08:43:06 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:41109 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgJaMnG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Oct 2020 08:43:06 -0400
Received: by mail-il1-f198.google.com with SMTP id s19so6627070ilb.8
        for <linux-block@vger.kernel.org>; Sat, 31 Oct 2020 05:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PLbcQV3CQNzMNiONV/iIo/BtH9u9OMn0g6YFDavSo4Y=;
        b=MV9t0YjVnoPkhvPboSJKxmZe8zRENwuq5xv16DlM9L7QgDv3V0+d3BgYv8V6pSQDId
         YCFBNsi8NL+V5rwj0ULxfJwvq7cbUz9Jotl2Gs91yvuc8ZaK//u/bOAdy8CM/5VhPKqR
         HAeLAxd92oJaZTYmDI5GQWZFxjpeEGr8yTIM6mv8BXRlkTNP3hG6KvhAGsRJepOcL8bn
         5MHLwG9sBFERITAJj2/tBlyfEr1KLT/2eZNkgR0HCltOiBVc73rkcTfngg6Qe5LypNWn
         5yyt6YXIIpu1Xn+0FPkCwFOsRNvqe3wSfAVrasErejfr/cV2GYnIwhR+yKdfv6e4kNM9
         V5kQ==
X-Gm-Message-State: AOAM532iRL80KnBA7Wt/g1JtKx7CaWrFkfbah2YiNd3RPi8Zu0qG/a9w
        t3QYTAY4khwM/LPEjzkC8zG2RFitXZeB9KDklPO8KatA/dGq
X-Google-Smtp-Source: ABdhPJwdSnQMnKqhQpqOWGJCnQ4jy4D5pDlHd07KEgNof9hw/wBkglwShyh1D3kPvEOpyeQ37a+d+sNXdO7wr2zoodVg81gSIN6U
MIME-Version: 1.0
X-Received: by 2002:a02:a813:: with SMTP id f19mr5306316jaj.2.1604148185206;
 Sat, 31 Oct 2020 05:43:05 -0700 (PDT)
Date:   Sat, 31 Oct 2020 05:43:05 -0700
In-Reply-To: <00000000000061316205b0e750fc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf140d05b2f6dae8@google.com>
Subject: Re: INFO: task can't die in nbd_ioctl
From:   syzbot <syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hdanton@sina.com, josef@toxicpanda.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchristi@redhat.com, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit e9e006f5fcf2bab59149cb38a48a4817c1b538b4
Author: Mike Christie <mchristi@redhat.com>
Date:   Sun Aug 4 19:10:06 2019 +0000

    nbd: fix max number of supported devs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154dc192500000
start commit:   4e78c578 Add linux-next specific files for 20201030
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=174dc192500000
console output: https://syzkaller.appspot.com/x/log.txt?x=134dc192500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
dashboard link: https://syzkaller.appspot.com/bug?extid=69a90a5e8f6b59086b2a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e051a8500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bf75b8500000

Reported-by: syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com
Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
