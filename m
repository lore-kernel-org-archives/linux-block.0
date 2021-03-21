Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA91EC433C1
	for <linux-block@archiver.kernel.org>; Sun, 21 Mar 2021 12:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F9961946
	for <linux-block@archiver.kernel.org>; Sun, 21 Mar 2021 12:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCUMk1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:40:27 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:47614 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCUMkF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Mar 2021 08:40:05 -0400
Received: by mail-il1-f200.google.com with SMTP id x11so19210589ilu.14
        for <linux-block@vger.kernel.org>; Sun, 21 Mar 2021 05:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Du7jbAAe3dZDXGgzm0EhuVuhWQs9ocY52TW7Eb3PJSI=;
        b=VoOHG7Ez0yJB4J+qKnCmv4HG3naHxvc9zZDCyxKtkYmt6nfCnQM2OODQTHrmZT7nu0
         xJTSC3/5KMyC3RE3g2umo6etTB0qDA/WxNWVbVQepEStWKhxF8YD8mF4B6lcmZbwZL86
         s4ztvFBLnPIliTRXLI27h/y8fQOCSVo+vTyGyPBczhY6I1OI7naOSCmWOPaaLijzhuz/
         ZPF7uqpOSwyO7uj6kkaBU/FKJLY4BJuFOKvlk8uavvjIR4IBzODPnvmlGwU+xAD0XKJR
         KDrkWXgfajsbL/5RYuQkih4ntItStlLzw2NUr8GqXDBRaSAh6sdKN9B41YcYiKRfjNni
         4RuA==
X-Gm-Message-State: AOAM533ebnJzdtWIAyBWlpUlgyfCtxRl7TRzHBSXweOCyEjp//ieupyZ
        qUvlgN9P3Lpe03/Op3e/7q6skRN5HIdQhDVcDYQhG7oQoDPf
X-Google-Smtp-Source: ABdhPJwLUId8Sas9RSZ3Jj2SPQjCYzKqv5Gs8fATOIuPtXwbqn1x3RcTQQiwdqKz10rHDN98oBhipUM12tdzeJmdaeVp+nWELDAY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1351:: with SMTP id k17mr8707489ilr.204.1616330405017;
 Sun, 21 Mar 2021 05:40:05 -0700 (PDT)
Date:   Sun, 21 Mar 2021 05:40:05 -0700
In-Reply-To: <00000000000053da9405bd7d2644@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a17fb305be0b3f38@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
From:   syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit a33df75c6328bf40078b35f2040d8e54d574c357
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Jan 24 10:02:41 2021 +0000

    block: use an xarray for disk->part_tbl

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17989906d00000
start commit:   1c273e10 Merge tag 'zonefs-5.12-rc4' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14589906d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10589906d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6abda3336c698a07
dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dfe8bed00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155a117cd00000

Reported-by: syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com
Fixes: a33df75c6328 ("block: use an xarray for disk->part_tbl")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
