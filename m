Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3339EC432C0
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 12:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126462071C
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 12:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfKVMFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:05:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:49430 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfKVMFC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 07:05:02 -0500
Received: by mail-il1-f200.google.com with SMTP id c2so5824879ilj.16
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2019 04:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YLtxj7xu9S4VYhhCDjrKcqKxwz52D1HAufjzm9xRIYA=;
        b=riaX675GP04d+T1YtSczzB8ix97MjG0fIsEBCblgVCLWIjm8RGWr1g6+UfY8mu3IWs
         zaqb2S8W2F6WekkJIinWkSIViiyCxKsCfho1zIX6jCPPTQCKyJ7WzLXPCzyf9pAyvghQ
         8A345m5vaftssQFnN2pqTQnqQOHEVY9nb6DCRF573dseIVcEE4T+Y5pmPhQs2JDkQqUS
         2nBx9fBRxRgwsXLjw6Jb/0Kp/sqmGcdU0U1FrsSkwsLZIJcwb+W3Fua+iI3E6qKmadRU
         8NU8N+M2QbTH6G2eJf44TgyGmEXtR+TQY9GuVojdQXrheINfFALPpooBHMttD0E3zIV5
         MZGg==
X-Gm-Message-State: APjAAAWTYLbNEBgvv7PRZrVD8je9aaT211aASWVL6BcaDT3jii6rd8UL
        hNxlHh0B1E6VE9WDnWYNNTxTobvZNYup2v74jQRP5agGIznn
X-Google-Smtp-Source: APXvYqzLSG5K9/8Rx46f0Q7HCZBo+1m9CabrzYoO3tOKdNNWpyseOGbFZvHTqgXspUcWOic9CVWOfqzNf3RNV0WV/vMYgC+7iua+
MIME-Version: 1.0
X-Received: by 2002:a6b:b9d5:: with SMTP id j204mr12060233iof.129.1574424301340;
 Fri, 22 Nov 2019 04:05:01 -0800 (PST)
Date:   Fri, 22 Nov 2019 04:05:01 -0800
In-Reply-To: <0000000000003c4e6d0572f85eb2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000350fb80597ee3931@google.com>
Subject: Re: WARNING in generic_make_request_checks
From:   syzbot <syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com>
To:     00moses.alexander00@gmail.com, axboe@kernel.dk, bvanassche@acm.org,
        hare@suse.com, hch@lst.de, idryomov@gmail.com,
        joseph.qi@linux.alibaba.com, jthumshirn@suse.de,
        keescook@chromium.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        sagi@grimberg.me, snitzer@redhat.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org, wgh@torlan.ru, zkabelac@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit a32e236eb93e62a0f692e79b7c3c9636689559b9
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Aug 3 19:22:09 2018 +0000

     Partially revert "block: fail op_is_write() requests to read-only  
partitions"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119503d2e00000
start commit:   60f5a217 Merge tag 'usercopy-fix-v4.18-rc8' of git://git.k..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=139503d2e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=159503d2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=21cfe1f803e0e158acf1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b87bfc400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117ccc8c400000

Reported-by: syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com
Fixes: a32e236eb93e ("Partially revert "block: fail op_is_write() requests  
to read-only partitions"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
