Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B54C2D0EE
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 01:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0F820774
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 01:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgC0B2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 21:28:05 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:53317 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgC0B2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 21:28:04 -0400
Received: by mail-il1-f198.google.com with SMTP id z19so7287692ils.20
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2020 18:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fpOoO95ghuCLLCEIiKHNf1Vn4Rzo9M55/w0gJcRUpiM=;
        b=VaiJ6SrFkavSYRop+aVt7gZMFEzWkuuCw8th107oCEp/aOfeBHV0aCA1CAokWh+NP+
         vHDPf2F94jsIkK/w+VBHt+GG8WaOBp5duxbdq9+sUOxmlxUisgIGmt4HOzL0+Y+EVT4u
         C4Jx3wRhQl7mNuKX/XnV4AzBobFMKExeboOj67pDbym6KInCIbJjf2IETj/Qu+L331K2
         ewfE2JrBkZsaTB1AqbU6EyosfIlKKPlEd0u5CIHEkTbzVXnm/jEF6k/3ofvl8vbwAjoc
         /J7dDHoQDrIuLG/H1r1PZm4QZNpPdnlXXMVsFBdV2M5HNnvqZIdVkPDJ8COIoaHBewdj
         1SAg==
X-Gm-Message-State: ANhLgQ2Ru/z8zC5MoN0mO4kyXLbtxIJkrVjaDRimzUmz9cVbgdjo0XRD
        FY5w/vtWlZQQMS+WbdKKVwmA5caqt/txN91YLGQsXongX834
X-Google-Smtp-Source: ADFU+vvuj9CdqnaKA39zoipe43VtYnqnycnu6XYDRVQ3pQdtkCj1GJ/YWcoFF34sHC9pd58juZJvz3MqwN724aP7IdgdRuetL7J1
MIME-Version: 1.0
X-Received: by 2002:a92:9107:: with SMTP id t7mr11623063ild.140.1585272483961;
 Thu, 26 Mar 2020 18:28:03 -0700 (PDT)
Date:   Thu, 26 Mar 2020 18:28:03 -0700
In-Reply-To: <00000000000047770d05a1c70ecb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004760b805a1cc03fc@google.com>
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
From:   syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>
To:     a@unstable.cc, axboe@kernel.dk, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, dongli.zhang@oracle.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit 768134d4f48109b90f4248feecbeeb7d684e410c
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Nov 11 03:30:53 2019 +0000

    io_uring: don't do flush cancel under inflight_lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14233ef5e00000
start commit:   1b649e0b Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16233ef5e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12233ef5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
dashboard link: https://syzkaller.appspot.com/bug?extid=313d95e8a7a49263f88d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13850447e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119a26f5e00000

Reported-by: syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com
Fixes: 768134d4f481 ("io_uring: don't do flush cancel under inflight_lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
