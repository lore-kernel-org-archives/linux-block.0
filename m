Return-Path: <SRS0=Yov/=X6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A868BC3E8AB
	for <linux-block@archiver.kernel.org>; Sat,  5 Oct 2019 09:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E78222C5
	for <linux-block@archiver.kernel.org>; Sat,  5 Oct 2019 09:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfJEJTD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Oct 2019 05:19:03 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53634 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEJTD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Oct 2019 05:19:03 -0400
Received: by mail-io1-f71.google.com with SMTP id w8so17545638iol.20
        for <linux-block@vger.kernel.org>; Sat, 05 Oct 2019 02:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WHf64SvzoBNVwjzIL2+mLBT/FJ5pbE9VxiOvHeZt8EA=;
        b=WsEhDfLsc5/O2p2Jxrsdgn7fryrnzoSLv/lx4y1o7SvvSht8ydzQnxOS7aXN6yizOL
         oAq9Tz+AyQzt2uR2HAdcmJKofYSVUtfTX9njP9EDzr9cYO/8WFV4xCTV/7GTmNaXAD31
         15e+z8Y1i3XdjAOV+Pb8u+kPt1tI6/Tl4gRhMmxvyV6jQ4N4NoC+HilKgPptw1KNIJId
         GrWIjpHyo5qWIlH5TEIX8DpEks1CR0rrG5/83zLwxzQusOE/86AqvuDyPtKCcA19OQg2
         yOERrL2cZ/CshsdyXC7lATTh9ncFTIyHFre66Had36y7QgAsqxAvf/lzITSXpuf03AQo
         Aqxw==
X-Gm-Message-State: APjAAAWKuwmt1A2Nf0pUOT52CqbHqf+87F6lM7TvT/24mGi1dvTVhWXv
        1+2FSkGjegbyBXXrgVAwntt9dB7RUNZS+R8haYYNCLIREQT0
X-Google-Smtp-Source: APXvYqz4MZuBJPFuWT2av0dlIWvrlEdd3Imp6vlXh2/IyPR1aQFBmHkuBcqhjfVQvBerP46hmQ+nyu6sLc4lgE0V8zANyLh0l4Ne
MIME-Version: 1.0
X-Received: by 2002:a92:9cd6:: with SMTP id x83mr20597645ill.198.1570267140493;
 Sat, 05 Oct 2019 02:19:00 -0700 (PDT)
Date:   Sat, 05 Oct 2019 02:19:00 -0700
In-Reply-To: <0000000000000a6fc5059423a8f9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c9bac0594264f96@google.com>
Subject: Re: WARNING in __blk_mq_delay_run_hw_queue
From:   syzbot <syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org, hare@suse.com,
        keith.busch@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit ed76e329d74a4b15ac0f5fd3adbd52ec0178a134
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Oct 29 19:06:14 2018 +0000

     blk-mq: abstract out queue map

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1558f6fb600000
start commit:   b145b0eb Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1758f6fb600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1358f6fb600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ec3be9936e004f6
dashboard link: https://syzkaller.appspot.com/bug?extid=d44e1b26ce5c3e77458d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165fcefb600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162d03db600000

Reported-by: syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com
Fixes: ed76e329d74a ("blk-mq: abstract out queue map")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
