Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641F4C43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 06:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3543F214AF
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 06:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfCLG1B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:27:01 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:53595 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfCLG1B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 02:27:01 -0400
Received: by mail-it1-f200.google.com with SMTP id 190so1316353itv.3
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2019 23:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ywp1yr5NnGi3gAPkFDTZ9W5K0r3DGxfghSypk/TOnZ8=;
        b=gNdNp1Llh09k/3DOVO0+CFX/XsW7ovvCEVoMsG+Rp0yRVxx2rnob1gyhX0s+mic8Kz
         Ht4Kk4ur7LnekDDmMTWAd3fc7rsMfBTl91mERx2WxppEZO+YIur3sMfEmOBdUZRkcn4N
         64OMnn5+WCse5U0sJjQTFB7rLnWOWJryA7fjiiFGqNTLjMsOLgxhe4ahgznPmZMQ0MLq
         PrmYdFp25wo9XNvpptHTauz3zZjwC8JP3Ubi9ZGik9EYP+qnX7Z1hO7WG9LdkU09mBal
         +G2rfBUFsvnFxqfpiAFNHMQEgzDwfqd5eb4F+5xyc3gwEtcV2wNo9AMuvT3W7AslFYmy
         Pw6g==
X-Gm-Message-State: APjAAAUGB0oY4Nzf8doLQwKxymZfytk/5tk63ySdlI2SziInfXDCaXIq
        5QnS+5HMVQr0q/cd0Q8NP/P2LVw6XqF5OqdmG/r0U5kxawOP
X-Google-Smtp-Source: APXvYqyqnkNtZ9vMHj9cj+NvQPPBfdeZw1DZ/+aZApYlG/KRyhIbbGma3DNsFbSEqJbENYokpZPcQ/+II8D8ckAgMk2Jqbtz7+6F
MIME-Version: 1.0
X-Received: by 2002:a5d:8141:: with SMTP id f1mr1557637ioo.9.1552372020484;
 Mon, 11 Mar 2019 23:27:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 23:27:00 -0700
In-Reply-To: <0000000000001b1a1d057e776c92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7206e0583dfc6b3@google.com>
Subject: Re: WARNING in hsr_addr_subst_dest
From:   syzbot <syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, axboe@fb.com, axboe@kernel.dk,
        davem@davemloft.net, hch@lst.de, linux-block@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri May 26 11:53:19 2017 +0000

     blk-mq: merge bio into sw queue before plugging

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1681996f200000
start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1581996f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1181996f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
dashboard link: https://syzkaller.appspot.com/bug?extid=b92e4f1472a54e1c7dec
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107db700c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12304827400000

Reported-by: syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com
Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
