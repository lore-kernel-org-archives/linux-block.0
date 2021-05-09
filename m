Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47393C43460
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 15:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227F261186
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 15:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhEIPRM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 May 2021 11:17:12 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37561 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhEIPRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 May 2021 11:17:10 -0400
Received: by mail-io1-f69.google.com with SMTP id e18-20020a5ed5120000b029041705a6ed5cso8975484iom.4
        for <linux-block@vger.kernel.org>; Sun, 09 May 2021 08:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ptj/dJVyElDcDR4dlhXEYGbK7nkar7mLZG2Y7a4j/mk=;
        b=S4knvGqo6crkOxjSFVYpAi9aqs0yRMP+uFHCtSVi6TkwP56NmsURInVVWuqMblRhvH
         sYok++2LpVMPaS+LhVrR5qT+1iocWtY6cwIVIbcCgfBPUZ30y/F5Kgs2UIr380M2Tux6
         +aIO+tCgPF50dcV4Fw3jo1Sw+zULIl8fil+wnBMrpY+WXclnk0aBsK9s/BL2Mhtpeg5K
         lU5OvA9EqZwgs1FWzoJtpf+6SGs462zqg3GUxdfb6SDc70wB1N7DZJFl0hq5TpsILmJ/
         Mna10HcVczQAG3k0KqK/Sk6JEZNa2pIEgA2l0Wo7Y82nSx5pyha8We/F0/+dVs5gLoCS
         RZmQ==
X-Gm-Message-State: AOAM533xE6oI6FZwbnHhVcUkP8GeysMwnjWDOYXcRsVBrsMoUS4SYbaa
        dvkA0ToAmrRJwFdy3G/itXVUAx9dB6KLPRARg1pnUiZuifIb
X-Google-Smtp-Source: ABdhPJyJwGwIL1loYhchZjvnNXd4eyMCeUirhmBOuDgssB8pUDt9169y2A7L98/9mTHVSC/CagAOsT8bOf+hALkYwWJBC7G5uvBO
MIME-Version: 1.0
X-Received: by 2002:a6b:dc16:: with SMTP id s22mr14878581ioc.170.1620573367415;
 Sun, 09 May 2021 08:16:07 -0700 (PDT)
Date:   Sun, 09 May 2021 08:16:07 -0700
In-Reply-To: <0000000000009f94c1057e772431@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5b92105c1e723d5@google.com>
Subject: Re: [syzbot] WARNING in hsr_forward_skb
From:   syzbot <syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, axboe@fb.com, axboe@kernel.dk,
        davem@davemloft.net, dvyukov@google.com, edumazet@google.com,
        hch@lst.de, kuba@kernel.org, kurt@linutronix.de,
        linux-block@vger.kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, m-karicheri2@ti.com,
        ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 9d6803921a16f4d768dc41a75375629828f4d91e
Author: Kurt Kanzenbach <kurt@linutronix.de>
Date:   Tue Apr 6 07:35:09 2021 +0000

    net: hsr: Reset MAC header for Tx path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119c7fedd00000
start commit:   3af409ca net: enetc: fix destroyed phylink dereference dur..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cb23303ddb9411f
dashboard link: https://syzkaller.appspot.com/bug?extid=fdce8f2a8903f3ba0e6b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1525467ad00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114c0b12d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: hsr: Reset MAC header for Tx path

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
