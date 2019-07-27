Return-Path: <SRS0=8nuL=VY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9EEC41514
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 10:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA9321655
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 10:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfG0KQB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Jul 2019 06:16:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54462 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbfG0KQB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Jul 2019 06:16:01 -0400
Received: by mail-io1-f71.google.com with SMTP id n8so61567632ioo.21
        for <linux-block@vger.kernel.org>; Sat, 27 Jul 2019 03:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=x2XPPyWw+kTQEvjXcX/vC5JNb6a5vMqFuiwlUWd2Kag=;
        b=NfTnGzBgaoXnNdC09WciXZI7gc02epU27QYm0vZ3eHc8wrpM6Ch45s4YewpDLlgpGa
         cVSsFofsmG7mLQDWawiu2fIzQ3dv3GGFTRfWB9tAsb5+c131EzNm+SlN04DYpNKxnX2x
         F48lCQNilcFEWBJ2hU6EF7XEf0u1U2j1xw7beSL61nZarVQanW4tl1ba0FsO8GOuc4W5
         lIezAHIY1fVe0XeKlmbMwu/g/JZhnr+DV2B2oyC39o59gh52gx4YN1/AnioO5Wre6Bza
         7Wo5EBjtiW0/K3XU9T2MwfKjGMSU5bmkPbpOf99A0/rn0+SZ9DgVQ3aHpD6+y9w84sWL
         b67w==
X-Gm-Message-State: APjAAAWubRD9jii9eNSwIG/AdZsxkHtXksKyh4bRQ/ia+/udbxJDtFNg
        +Y6UD8kWUdaoP8mnYsK5QyvcOGJPn/lL0+cdJIBVJhSLGAEy
X-Google-Smtp-Source: APXvYqyUUXRwrDhv+Q8VwK3XJ+lyMBkXhuGvc/B+mH+HMjh06Rq3S9TIzl2shA7qpymnG5hvTqwSBsZorpk8Y0tjAKx1u9bCuJWS
MIME-Version: 1.0
X-Received: by 2002:a5d:994b:: with SMTP id v11mr46002856ios.165.1564222560256;
 Sat, 27 Jul 2019 03:16:00 -0700 (PDT)
Date:   Sat, 27 Jul 2019 03:16:00 -0700
In-Reply-To: <000000000000111cbe058dc7754d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000dc874058ea6f261@google.com>
Subject: Re: memory leak in new_inode_pseudo (2)
From:   syzbot <syzbot+e682cca30bc101a4d9d9@syzkaller.appspotmail.com>
To:     axboe@fb.com, axboe@kernel.dk, catalin.marinas@arm.com,
        davem@davemloft.net, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        michaelcallahan@fb.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit a21f2a3ec62abe2e06500d6550659a0ff5624fbb
Author: Michael Callahan <michaelcallahan@fb.com>
Date:   Tue May 3 15:12:49 2016 +0000

     block: Minor blk_account_io_start usage cleanup

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13565e92600000
start commit:   be8454af Merge tag 'drm-next-2019-07-16' of git://anongit...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10d65e92600000
console output: https://syzkaller.appspot.com/x/log.txt?x=17565e92600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d23a1a7bf85c5250
dashboard link: https://syzkaller.appspot.com/bug?extid=e682cca30bc101a4d9d9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155c5800600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1738f800600000

Reported-by: syzbot+e682cca30bc101a4d9d9@syzkaller.appspotmail.com
Fixes: a21f2a3ec62a ("block: Minor blk_account_io_start usage cleanup")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
