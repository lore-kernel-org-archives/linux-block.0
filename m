Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D46BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 15:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1E860F38
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 15:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbhKPPpD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:45:03 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:42716 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbhKPPoN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 10:44:13 -0500
Received: by mail-io1-f71.google.com with SMTP id n25-20020a056602341900b005e7a312f86dso12390560ioz.9
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 07:41:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yEoiAOZNXI+7ziHDgUkTx2Lv3WSs9sv/eVLYHQ4c5qs=;
        b=pFair8I7G48S6Vfvt+LNW50rtKHDB1xZe8MfRlB3Gn624VFzA5+0iEpejysz5D8cxu
         g8Z5jSIgEuK9XDGun2VgNYNpCmFhXqT8sJkUQvuAoFvLmGA1EUIMkiuRWeI/Sv7Zwlhg
         uBUS7KulC/0RoEQ94hyWjA4aHb/qnyAuuMPj5m9x6KLqP//TSlSZVsmqznZP3AxY8ThH
         rZbxlDOPxwhXPa8ddOxWMwag35dnXVTSRjlhil1SgPZYt3H+VKBgv2PndAzGcv6Uyzkz
         s6UIFyuBZ13DsWTpI4TKwIsBawxzyravt4WtkAmrbKUPVBocvsq28cgKSn+tfwutvXwT
         SP9A==
X-Gm-Message-State: AOAM531OIlkuOvzTGyJ9cTZ1cod8Mt+tO0AwUYsrvc1RyMAFjD4KEU54
        2A62bCTkalDLw2Irm84bJDkzP+LAkaMTMyBPYmHjO1Eyg3Di
X-Google-Smtp-Source: ABdhPJz2QvP079zeX/CSMbBjUQ4yB0Z21xR5DrHse56nG8ecxlTTNjG5d/4SrtAzw+M2+watkTiawRFrq6/9vJ1WSz68jkvpCbf8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr5243399ilv.102.1637077275827;
 Tue, 16 Nov 2021 07:41:15 -0800 (PST)
Date:   Tue, 16 Nov 2021 07:41:15 -0800
In-Reply-To: <00000000000009a2c505bbcaed68@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ee63e05d0e9c172@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in __hrtimer_run_queues
From:   syzbot <syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, fweisbec@gmail.com, hch@lst.de, hdanton@sina.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, paulmck@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b60876296847e6cd7f1da4b8b7f0f31399d59aa1
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Oct 15 21:03:52 2021 +0000

    block: improve layout of struct request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137f2d01b00000
start commit:   f40ddce88593 Linux 5.11
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e53d04227c52a0df
dashboard link: https://syzkaller.appspot.com/bug?extid=de9526ade17c659d8336
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a81012d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1282b6d2d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: improve layout of struct request

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
