Return-Path: <SRS0=rhTN=2L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9678DC2D0D2
	for <linux-block@archiver.kernel.org>; Sat, 21 Dec 2019 08:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EA7206D3
	for <linux-block@archiver.kernel.org>; Sat, 21 Dec 2019 08:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLUInD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Dec 2019 03:43:03 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:34565 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfLUInD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Dec 2019 03:43:03 -0500
Received: by mail-il1-f199.google.com with SMTP id l13so9670844ils.1
        for <linux-block@vger.kernel.org>; Sat, 21 Dec 2019 00:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xU44G83IDVYmN3c7FdaPJTALb5/aKinaCWXRoF+LTv0=;
        b=XIYg/1OoeyoTsrkX88VaRHaArFCPUaZrNPpmz3xI+X5Bw43C3otAtewL/wfdTUe27U
         0ktqS4K+lH9YzmEBFRg7/MYIwprMUKxrJC8vQHkeNYnA2c+6ujADUaDhkVx+A+wAUTTA
         n90/JXkQszkpTGvIG3MiKv+UVm+QTTLgsOr5qAl1H+ti+pjsDCB6lrZrSNxAUj6gSFoG
         4MagZbOCvbnmUXyBDfe3vIbQ4DP6StnqGT41bHIWDspbXltR972KlHiW7rvvUR3JIgcx
         wwVm81NWONPFAPA8A+sMxO9OGWGujto3wk8V0ArytIIox7Q6Vc6fnqXwYxGx5ZmlgO0O
         lsXg==
X-Gm-Message-State: APjAAAXFe0Bx9xs8kwrWeFZOfz2RWDPxoAu+rD0rotbBfy2L7BC4K2b4
        eszG6a0qKy6fDLyI+Tpi4l/L9DA4O8acwWs7T9DmhgBMPA+r
X-Google-Smtp-Source: APXvYqyuTa0ejKszQhq4t1cDUBFdclRyWYWGgRzHUDUmQVrVTb5aXX9IU8liJ2nc0RY4emELLWHbwalTEI6xVDJ0PpVmRGT9Mtvt
MIME-Version: 1.0
X-Received: by 2002:a6b:4407:: with SMTP id r7mr11525660ioa.160.1576917781568;
 Sat, 21 Dec 2019 00:43:01 -0800 (PST)
Date:   Sat, 21 Dec 2019 00:43:01 -0800
In-Reply-To: <000000000000b09d8c059a3240be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035eda1059a32c80f@google.com>
Subject: Re: WARNING in percpu_ref_exit (2)
From:   syzbot <syzbot+8c4a14856e657b43487c@syzkaller.appspotmail.com>
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

commit cbb537634780172137459dead490d668d437ef4d
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Dec 9 18:22:50 2019 +0000

     io_uring: avoid ring quiesce for fixed file set unregister and update

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1118aac1e00000
start commit:   7ddd09fc Add linux-next specific files for 20191220
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1318aac1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1518aac1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f183b01c3088afc6
dashboard link: https://syzkaller.appspot.com/bug?extid=8c4a14856e657b43487c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b8f351e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b51925e00000

Reported-by: syzbot+8c4a14856e657b43487c@syzkaller.appspotmail.com
Fixes: cbb537634780 ("io_uring: avoid ring quiesce for fixed file set  
unregister and update")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
