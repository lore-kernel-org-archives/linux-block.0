Return-Path: <SRS0=iG2v=ZY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C50C432C0
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 15:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CCE20833
	for <linux-block@archiver.kernel.org>; Mon,  2 Dec 2019 15:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLBPWB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:22:01 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:32866 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfLBPWB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Dec 2019 10:22:01 -0500
Received: by mail-io1-f70.google.com with SMTP id i8so4134644ioi.0
        for <linux-block@vger.kernel.org>; Mon, 02 Dec 2019 07:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yoaw0PwFg2A6gDglB5LznPWl+Lud/RfolRLMztLbYOM=;
        b=dLyzZiQE9IOVLG7TPPcNw6vs4XYbB5tKPeSgLF0v9MgVl3zruf6glwltJklkwaXNpm
         gU47D25/za76U6zTzHV8QoR3QOi5tdr+t8c5smL6u2+l9WGIrZKqhYsdXew08ZZ57eWd
         tawUN0u+4UeSVhHntnAVFf4zMt7e9ZVjWVn2dwGlwMIp3v/rwyZUVIzObf5qSfhTUzd/
         Wk2Rr5RKORdePsxHPHEUzxFxPZtHFAuhKjM61V+I8Qh7hyR91+D3XOJYplOcSc/SsPEk
         01+8dlb+KIZpLJvWwA2Hkol5Ax5iUZY4fH2qLJzkxTTpE0vgFslVUZ39H+6NnNfFEFdp
         Sbyw==
X-Gm-Message-State: APjAAAWBxmeWzQKak6ecG7h5WxpDNXECDFjWY3oegrWlijE8dEO6S3F9
        P/u034/51vN0oRu34/1zpNlHTlRa2xKa3PaKv6pjYm9Z6nb8
X-Google-Smtp-Source: APXvYqygl3XRg/RBFqVukkdgwZRNVl2uCNOuiX78gKyVxsKxIvwL0CTDPj2IidIQmxtbhRnxA50TBWTRjZbP0m4y1guFs+uD5e2O
MIME-Version: 1.0
X-Received: by 2002:a02:962c:: with SMTP id c41mr29142298jai.74.1575300120660;
 Mon, 02 Dec 2019 07:22:00 -0800 (PST)
Date:   Mon, 02 Dec 2019 07:22:00 -0800
In-Reply-To: <000000000000da160a0598b2c704@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b5b540598ba2498@google.com>
Subject: Re: general protection fault in override_creds
From:   syzbot <syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com>
To:     Anna.Schumaker@Netapp.com, Anna.Schumaker@netapp.com,
        axboe@kernel.dk, casey@schaufler-ca.com, dhowells@redhat.com,
        dvyukov@google.com, io-uring@vger.kernel.org, jannh@google.com,
        keescook@chromium.org, kstewart@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, neilb@suse.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit 181e448d8709e517c9c7b523fcd209f24eb38ca7
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Nov 25 15:52:30 2019 +0000

     io_uring: async workers should inherit the user creds

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10424ceae00000
start commit:   b94ae8ad Merge tag 'seccomp-v5.5-rc1' of git://git.kernel...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12424ceae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14424ceae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff560c3de405258c
dashboard link: https://syzkaller.appspot.com/bug?extid=5320383e16029ba057ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd682ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16290abce00000

Reported-by: syzbot+5320383e16029ba057ff@syzkaller.appspotmail.com
Fixes: 181e448d8709 ("io_uring: async workers should inherit the user  
creds")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
