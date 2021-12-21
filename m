Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF347C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 09:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhLUJwJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 04:52:09 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:50929 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhLUJwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 04:52:09 -0500
Received: by mail-il1-f197.google.com with SMTP id 9-20020a056e0216c900b002acc1b44b91so6668652ilx.17
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 01:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gtMOeWgOjqpxf3UJsdLLfE47QPkTrgfO0H8YEz5DRG8=;
        b=vE8BGDKQwKof0LP5ySGY8r3fCtO2+06wTVbYCwdAy+OnsdsKqLNiULkHimwAIgDvqP
         kzqo2L6Hu63/rHnkCqjk4NVG44RdWMbj5llCaP92frRZrUex6JWbSVG7TvlJpYAhpyaw
         flkRC5E8BurrTi3Xly/pRx4j1lRKp/qtPLdgS9sqvZJiaM/Q+MunpLuJ0SRIvAuqqApB
         1sh+B5sUtBY97FEuUS47090I8tBjEOW3mCx0y0m1m2RYg/22N5ojA8LH0PqklsKlDrxU
         Ap24vMbbfu0xfaN24kw3WGYkFqjiiuyvcH+9W+5Ysbarxjo/m8KmsQ9AU5J1XIolK4Sb
         6A7g==
X-Gm-Message-State: AOAM533NG1psChidxT8mUyWcDdRWKC89UB4ViS9+Ob88LJxk1tx1Upo2
        XSHdWSECdfGcLZytfgdRCFfWdUWab6i2L/MjB69kW/DmEKp6
X-Google-Smtp-Source: ABdhPJx6QiXqNu7Hfc+O/DrzAKwtgSlzMWab3H3rNwlyXnrdxwZcfwS7rfCEn4d1tGHD0uzTYSEiyrI+miyx42y9AEkxASphiUL7
MIME-Version: 1.0
X-Received: by 2002:a6b:a10:: with SMTP id z16mr1105244ioi.204.1640080328753;
 Tue, 21 Dec 2021 01:52:08 -0800 (PST)
Date:   Tue, 21 Dec 2021 01:52:08 -0800
In-Reply-To: <000000000000c70eef05d39f42a5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066073805d3a4f598@google.com>
Subject: Re: [syzbot] general protection fault in set_task_ioprio
From:   syzbot <syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, changbin.du@intel.com,
        christian.brauner@ubuntu.com, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
        kuba@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yajun.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit e4b8954074f6d0db01c8c97d338a67f9389c042f
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Dec 7 01:30:37 2021 +0000

    netlink: add net device refcount tracker to struct ethnl_req_info

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10620fcdb00000
start commit:   07f8c60fe60f Add linux-next specific files for 20211220
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12620fcdb00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14620fcdb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2060504830b9124a
dashboard link: https://syzkaller.appspot.com/bug?extid=8836466a79f4175961b0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12058fcbb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17141adbb00000

Reported-by: syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com
Fixes: e4b8954074f6 ("netlink: add net device refcount tracker to struct ethnl_req_info")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
