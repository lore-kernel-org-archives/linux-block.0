Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ECEC433F5
	for <linux-block@archiver.kernel.org>; Wed,  8 Dec 2021 05:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhLHFHn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Dec 2021 00:07:43 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:33626 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhLHFHn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Dec 2021 00:07:43 -0500
Received: by mail-il1-f197.google.com with SMTP id w1-20020a056e021a6100b0029f42663adcso1486720ilv.0
        for <linux-block@vger.kernel.org>; Tue, 07 Dec 2021 21:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tnvEcnHI7deEWxbqkKI/fN2Wn+QIAlfc8X3oFKTEmqY=;
        b=DHEJfffB+oP7A16bEjSpkRCA0OoGimLQn9GsVwH0ngkxapqdoTLNLQeEwJlVxGhM9t
         WIKkMZIaavR3bcaPhQF4t2JJWRyZJtVGxMlE13aJyqttQPTyQryer0Y3jxHLjIvWrcun
         BRYcLdmD05qXhUibaFhLijKdGpR9feCk+aM0k0EXI2nu/w6LfkN+jcYhCGIP9OzA1g/e
         Lrk8aGVXAvenqXnv7hSAh7j7GPxzKTEyPwjB3Om6GfSPkqZMpdxT7gqY4U3QMDT/q37R
         K5itSSiRmKoYFwZEFcgPUQugnWwQhwaP1YBF9i4Ze6QSNNhMOzsWyxyWvvpinvhpe2Yi
         Bfhw==
X-Gm-Message-State: AOAM531/7U/AonHCSaidiHjuLhkuv+UAhGoB64UjYKh7kcwVsiFBWBar
        V2yL+CfBz5XA1u3/n2I4Pnl+0YR8dEjVxWIZTgqR8Dgkhank
X-Google-Smtp-Source: ABdhPJwm0RWykDAPtEx8UlrJfAiQzKFk5qK0UkARc6aPbXgU5gciPJ8DsiwY9aXoIJsshTCDAJiywzLcKqgahKGSviNBMVtm5Mh8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:: with SMTP id n12mr3885081ilk.89.1638939851818;
 Tue, 07 Dec 2021 21:04:11 -0800 (PST)
Date:   Tue, 07 Dec 2021 21:04:11 -0800
In-Reply-To: <0000000000007de81505cfea992f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad0e4105d29b6b0f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in io_submit_one
From:   syzbot <syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, bcrl@kvack.org,
        linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit 54a88eb838d37af930c9f19e1930a4fba6789cb5
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Sat Oct 23 16:21:32 2021 +0000

    block: add single bio async direct IO helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1615e2b9b00000
start commit:   04fe99a8d936 Add linux-next specific files for 20211207
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1515e2b9b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1115e2b9b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4589399873466942
dashboard link: https://syzkaller.appspot.com/bug?extid=3587cbbc6e1868796292
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17db884db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e9eabdb00000

Reported-by: syzbot+3587cbbc6e1868796292@syzkaller.appspotmail.com
Fixes: 54a88eb838d3 ("block: add single bio async direct IO helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
