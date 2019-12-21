Return-Path: <SRS0=rhTN=2L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4C0C2D0C3
	for <linux-block@archiver.kernel.org>; Sat, 21 Dec 2019 17:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F13D2072B
	for <linux-block@archiver.kernel.org>; Sat, 21 Dec 2019 17:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfLURtG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Dec 2019 12:49:06 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:33635 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfLURtD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Dec 2019 12:49:03 -0500
Received: by mail-io1-f69.google.com with SMTP id i8so8422244ioi.0
        for <linux-block@vger.kernel.org>; Sat, 21 Dec 2019 09:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GshsWrdoEPyx2vd7d7UXajSCgogocC5OTxKPrWDtn2k=;
        b=ggcYXeqLzaSJSFvzBtLN1ozX4WrT4QBB0mPP5wtE/N9t7jrxCPECQPmU9nWasCtWcx
         oo8Ou1OcfQFZJM2U1mbIET5Jk03MLrMRfxbSUlhdQWt3NyAZnhi9RbbtmdsdpXSiWf9X
         TbpAdrEQY8nN60STFvGjVvtKUGqR+ALEK/f/T1ud3xwegYzWjkZhJZfkLqF9SHC73WGH
         nPTbUrdwazggd+zxrRadCStpT3zpVFS2yGo2qADCsKxihYbiXDCgcLIpDM/Rfo8fq5Ik
         GSjK/NCp1D1t9xW7uqRo1CGmWlh0jU3X+xGmczGXWeGG7CZnjvGfVhC0QKQT4Ma1JjRu
         WGwg==
X-Gm-Message-State: APjAAAXmZWk1pS0wiSbYMRjqdUmm9JOgnXXSYMeIHge1Mm5g5Sfm4gEy
        nUid3FNLRRWgl0seMJLVxpyX5b5RslR3cpg6BdTgkdLLDQYh
X-Google-Smtp-Source: APXvYqyCKPkUw/hvhEZzXqoyo1tTaKHhSZzOInzWI8gOHUFYW5HjZUeSJEoBRod5KvA94zqYvimn+I2NEHvJijo6waweNFndE35n
MIME-Version: 1.0
X-Received: by 2002:a92:d809:: with SMTP id y9mr18895833ilm.261.1576950541498;
 Sat, 21 Dec 2019 09:49:01 -0800 (PST)
Date:   Sat, 21 Dec 2019 09:49:01 -0800
In-Reply-To: <00000000000031376f059a31f9fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dac3b1059a3a684b@google.com>
Subject: Re: WARNING: ODEBUG bug in io_sqe_files_unregister
From:   syzbot <syzbot+6bf913476056cb0f8d13@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit cbb537634780172137459dead490d668d437ef4d
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Dec 9 18:22:50 2019 +0000

     io_uring: avoid ring quiesce for fixed file set unregister and update

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10eadc56e00000
start commit:   7ddd09fc Add linux-next specific files for 20191220
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12eadc56e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14eadc56e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f183b01c3088afc6
dashboard link: https://syzkaller.appspot.com/bug?extid=6bf913476056cb0f8d13
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15653c3ee00000

Reported-by: syzbot+6bf913476056cb0f8d13@syzkaller.appspotmail.com
Fixes: cbb537634780 ("io_uring: avoid ring quiesce for fixed file set  
unregister and update")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
