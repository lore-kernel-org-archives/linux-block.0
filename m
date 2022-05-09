Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058C0C433F5
	for <linux-block@archiver.kernel.org>; Mon,  9 May 2022 21:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiEIV6G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 17:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiEIV43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 17:56:29 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6B32D3F5B
        for <linux-block@vger.kernel.org>; Mon,  9 May 2022 14:50:10 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso10708840iov.16
        for <linux-block@vger.kernel.org>; Mon, 09 May 2022 14:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=s2rmpyNyFEujAf+EJYBoIEjX5MtLaffn8+X0o9N5fgE=;
        b=lZ4ueEIoN7lzUWYapUKglBZh9XxZc9/E6txFeCg4u1UlDPnf8kjORt891eywSPIqRB
         rh1e33UUwJf0jBqtwtqpQ4ysP8ril81V/MDJrOUwT+0B93VXVDxdox4Ot0GYMHWnVxUY
         g/TYjAoOGCiNjpV2lFoZCVaolwHhVQUrPf7OMCRFLbUGiLKJxQqbcqq6xwnOvYxIy/99
         SqY3PSLc/eiPsA06b7COaU7Jqyeoeti/ypY2pjxQuOuw+4fWUu7PhEden66unaQho6UP
         vDXovtfHnzjcX6HV3JK4AXT7AnNNQPd17Nb9q1GwFzRHkUr44s0ksD5O07ioPAETcYBk
         +aSQ==
X-Gm-Message-State: AOAM531kNjtPkL00xomLRBFBfy+kbe+7LBIOdEMG/+jP40R2d381wvLf
        9vAxn5PwXecuEvITKKdic4CghiKWNj9qO63ptYW8F2mRD5d3
X-Google-Smtp-Source: ABdhPJwBVtl04Ej8XUy6iLjBCkDUNPExpqGoo3a5jGV8ypU3eIqqfYkoQPwIMtXgmETBrBFu7BHvBe/1eA2T9oXxg64g8WR0pnz3
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214b:b0:2cf:21fa:cce6 with SMTP id
 d11-20020a056e02214b00b002cf21facce6mr7280704ilv.160.1652133010262; Mon, 09
 May 2022 14:50:10 -0700 (PDT)
Date:   Mon, 09 May 2022 14:50:10 -0700
In-Reply-To: <00000000000029572505de968021@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032d06e05de9b3136@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in bio_poll
From:   syzbot <syzbot+99938118dfd9e1b0741a@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, axboe@kernel.dk,
        bpf@vger.kernel.org, daniel@iogearbox.net, hch@lst.de,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit 0f38d76646157357fcfa02f50575ea044830c494
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Oct 12 10:40:45 2021 +0000

    blk-mq: cleanup blk_mq_submit_bio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12506f7ef00000
start commit:   c5eb0a61238d Linux 5.18-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11506f7ef00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16506f7ef00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78013caa620443d6
dashboard link: https://syzkaller.appspot.com/bug?extid=99938118dfd9e1b0741a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1484cbc1f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c7026cf00000

Reported-by: syzbot+99938118dfd9e1b0741a@syzkaller.appspotmail.com
Fixes: 0f38d7664615 ("blk-mq: cleanup blk_mq_submit_bio")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
