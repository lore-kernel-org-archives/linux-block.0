Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451ABC433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 10:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhLUKot (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 05:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhLUKot (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 05:44:49 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17280C06173F
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 02:44:49 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id d10so37674883ybn.0
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 02:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDtQgb9AA9xFpWuXkc+E4u23J1dpI6q3KUw8LtmkUY4=;
        b=ovRbDOO2X6hqPfiK/gjWv7YQ+244WflmjY3yZq9cJQOSgTPJydu/nbHdDw9lr8vmi/
         zxib8m2jR5z2FSANVQNHDy6k764HSw9nvKTW+XzIhN0dLh6V9zr6W/YpJMzTbXVRN6F5
         9UBFUHMLjkb7XnubVZj2qxqokO5PxSptXvirtG2wePW937F8auR/q7zq/hvxCrsx7lvo
         MpcQZVVAbABQzJ9KvzbyNev8aasfruRE9vgz9YoDUNKMlHjZPD8LwmeJSw3Kq40rx8E6
         YOiPQ/xJLQDlkTkBcdV9aL4TV33kDoXalpchSkU8OeUL6oGQl/kbT98bYCU9kG9mhAbX
         WhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDtQgb9AA9xFpWuXkc+E4u23J1dpI6q3KUw8LtmkUY4=;
        b=vWdOJBcMXK5crnR+1fX6lT7bY4Tj1u3dqC7SvMsa+upvC43LWr2+9aWRl+Jhe1WjI0
         aR3+xiqxAex064LDomI1SosR3CRuV8o/CAGxwMTkSyAA5OHm7Uv3YerYT63FgPWhy7PN
         z/TT/lxOoa3kKiSLkjGq7h27dX9zBSbiNUuztfmr2giAf52xZ/0jfkdPXj5B3Tbog4yi
         +JyaglEX0RZV8/os0IiDxmQ8Bsjnprc1J1K1lfMnaEKIzMcl0M2QegdHFbRuzbpIcicG
         x9uwZ2vIcfdkblWKHPMo+egc7sheuC4Nli/3y2csGaaPeSYfrS4yWoR19xhx2p8Pkmvn
         drng==
X-Gm-Message-State: AOAM532CHAKicTRTwkhlbx13LRkjTzgSOcCu3rxr6FuLvvJ+mP9W4X6L
        Dp1GyEMsvdCWGgq8MKYMMMm1plP+7yh9xUx6CIVHAA==
X-Google-Smtp-Source: ABdhPJxdMBSrVlyjappl/8A1n64cSvK0pWT+wsIIG/Rr1u/SqTZbJCLSpE7r7ssu9rf/kxNEj1CabHdgFByo5q4RJOE=
X-Received: by 2002:a25:af14:: with SMTP id a20mr3799875ybh.753.1640083487564;
 Tue, 21 Dec 2021 02:44:47 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c70eef05d39f42a5@google.com> <00000000000066073805d3a4f598@google.com>
In-Reply-To: <00000000000066073805d3a4f598@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 21 Dec 2021 02:44:36 -0800
Message-ID: <CANn89i++5O_4_j3KO0wAiJHkEj=1zAeAHv=s9Lub_B6=cguwXQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in set_task_ioprio
To:     syzbot <syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, changbin.du@intel.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yajun Deng <yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 21, 2021 at 1:52 AM syzbot
<syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit e4b8954074f6d0db01c8c97d338a67f9389c042f
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Dec 7 01:30:37 2021 +0000
>
>     netlink: add net device refcount tracker to struct ethnl_req_info
>

Unfortunately this commit will be in the way of many bisections.

Real bug was added in

commit 5fc11eebb4a98df5324a4de369bb5ab7f0007ff7
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Dec 9 07:31:29 2021 +0100

    block: open code create_task_io_context in set_task_ioprio

    The flow in set_task_ioprio can be simplified by simply open coding
    create_task_io_context, which removes a refcount roundtrip on the I/O
    context.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Jan Kara <jack@suse.cz>
    Link: https://lore.kernel.org/r/20211209063131.18537-10-hch@lst.de
    Signed-off-by: Jens Axboe <axboe@kernel.dk>


> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10620fcdb00000
> start commit:   07f8c60fe60f Add linux-next specific files for 20211220
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12620fcdb00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14620fcdb00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2060504830b9124a
> dashboard link: https://syzkaller.appspot.com/bug?extid=8836466a79f4175961b0
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12058fcbb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17141adbb00000
>
> Reported-by: syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com
> Fixes: e4b8954074f6 ("netlink: add net device refcount tracker to struct ethnl_req_info")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
