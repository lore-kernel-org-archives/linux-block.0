Return-Path: <SRS0=5nn9=DR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC84FC4363D
	for <linux-block@archiver.kernel.org>; Sat, 10 Oct 2020 22:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B502C2075E
	for <linux-block@archiver.kernel.org>; Sat, 10 Oct 2020 22:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390465AbgJJW5Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732033AbgJJTj0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Oct 2020 15:39:26 -0400
Received: from mail-pf1-x44d.google.com (mail-pf1-x44d.google.com [IPv6:2607:f8b0:4864:20::44d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2464CC05BD37
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2020 09:34:09 -0700 (PDT)
Received: by mail-pf1-x44d.google.com with SMTP id c21so9158186pfd.16
        for <linux-block@vger.kernel.org>; Sat, 10 Oct 2020 09:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=j31NhuPOHM2geZWaaQJv3ikYyVsGXqVbWelRycz+tD0=;
        b=TeJNxfCeLbdgAIOI+y61zz75BjTZcxa4/qtXgIqQ6lqThJOdxP65ELM1YhC/nfE3YA
         8gwvZQ8FEtIX8D97XL0DHtRKcE9jvQCTmnM2v2lS6rvjuxc+uiuU92XXBL7Skwp8Fj5Y
         B2URW2Y90cIh12vqq2rfTF4DbNdtLsuCa7j+bspoqXnbbsSZZHM4msJ6my/Y3HEGTRmY
         YONvN99WxbF72JNHNFYEK+8/ahAPTbPSeJobh9K/Dx295iJR9XvyTTz4AXZEXLkZ+Ab3
         9hvhLA5Ldt3HJ2z56yVHq5XjuTnrbaV39x8fYajri2Y0oWZgoX6law9UE/cLqIA9ANDP
         oNMw==
X-Gm-Message-State: AOAM533KHwnjAw7CdGvhpWecvi1qnV0xAO+3pkTOQtHFFuvgDnMzrFf4
        e7mO+9T8l8kyroBPs1+W5goUFu2Z7sFogByBL7EAjH6WNuPe
X-Google-Smtp-Source: ABdhPJx0qf2gnVvR85VmXRDohn+cNhIC1jhkMLDhwNno11joOtr/W5u8fdFcI6aYLOLSV77D+vz4P6E2n6OED0dp3fa5TZJ1Lnm4
MIME-Version: 1.0
X-Received: by 2002:a92:874a:: with SMTP id d10mr13835218ilm.163.1602345365166;
 Sat, 10 Oct 2020 08:56:05 -0700 (PDT)
Date:   Sat, 10 Oct 2020 08:56:05 -0700
In-Reply-To: <0000000000004a624a05b05a756d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c5e7e05b1531ab0@google.com>
Subject: Re: INFO: task hung in nbd_ioctl (3)
From:   syzbot <syzbot+fe03c50d25c0188f7487@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchristi@redhat.com,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit e9e006f5fcf2bab59149cb38a48a4817c1b538b4
Author: Mike Christie <mchristi@redhat.com>
Date:   Sun Aug 4 19:10:06 2019 +0000

    nbd: fix max number of supported devs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=171556f0500000
start commit:   fb0155a0 Merge tag 'nfs-for-5.9-3' of git://git.linux-nfs...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=149556f0500000
console output: https://syzkaller.appspot.com/x/log.txt?x=109556f0500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41b736b7ce1b3ea4
dashboard link: https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173d9b17900000

Reported-by: syzbot+fe03c50d25c0188f7487@syzkaller.appspotmail.com
Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
