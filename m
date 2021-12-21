Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03795C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 05:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhLUFVI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 00:21:08 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:52071 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhLUFVH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 00:21:07 -0500
Received: by mail-io1-f72.google.com with SMTP id s199-20020a6b2cd0000000b005ed3e776ad0so8477468ios.18
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 21:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pAkGYvpJnzLica1LfFPS5fVVW20iI4ebrlJU4TBRC1w=;
        b=SDJy0+rVPL8zgzeERJo23VUgF0zslWktnxTHL5KAZtDXdNrHpn/leBUMMNYsVvtMe2
         Zr6swjKZ0q6dG3XH6keetEsJ7lKmdFRxW/QoleHsqI3S0HtGXuiZqMegYjM0iY6RzF7K
         pu70gNbiT8R7u58swu4e+QPA/gpzYHvtDTtDrIozCZy7czfinzGkQ/WXlIaJ86uKu0oR
         0TZVXHSvv4WJ9F5DZWF5dg6ErEALrQE74MjzJUdPczRn2Kk00PrfCF/Dnj6YSDEoEPVV
         HFKyFrBJHzQThwYzFl9/PKCB9TKPV9b6zNq2W9VBPmWG6lkm+6A3sOIX4EIl/nC2Up3c
         pLug==
X-Gm-Message-State: AOAM530p55YtTM9mu0Q2c+pM6qZO/vkjo853K0YeOWSdlVGQpbfMe2by
        1KxiP2R+DJtVUTaAzI25zLE47KmXSWc8ApfUh2a+X8ltbUaR
X-Google-Smtp-Source: ABdhPJzS3GVIK0iN6UAGQUIYIE7VHAjysuGY/+j4c2ZHySOCtT0bggn2d6ZgGUznxMwY4oZx0iqBl07uUkLjNeNC4zm/b04G1ZFQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr694808ilu.191.1640064067391;
 Mon, 20 Dec 2021 21:21:07 -0800 (PST)
Date:   Mon, 20 Dec 2021 21:21:07 -0800
In-Reply-To: <7ded6b2a-1f95-73a2-c074-2841dd5aaf96@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025571305d3a12cdd@google.com>
Subject: Re: [syzbot] general protection fault in set_task_ioprio
From:   syzbot <syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com

Tested on:

commit:         e1ad6d38 Merge branch 'for-5.17/block' into for-next
git tree:       git://git.kernel.dk/linux-block for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=f22078a087d573ce
dashboard link: https://syzkaller.appspot.com/bug?extid=8836466a79f4175961b0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
