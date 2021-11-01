Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E1C433F5
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 13:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCF160E52
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 13:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhKANSo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 09:18:44 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50965 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhKANSo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 09:18:44 -0400
Received: by mail-io1-f71.google.com with SMTP id u20-20020a5ec014000000b005df4924e18dso12510378iol.17
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 06:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gt2XnhzY8fDS+SgeNfM/Uab1dWqIkAJn0jd2H/ERAws=;
        b=EEkpgc6+cJi2l4j89RMy4wKVMA9woAi+/lpwjvokov/XtC7FIuWbmEvl1xyW7GlDPS
         Igf8w5nXgIvk2bXd9nYZqvsjSXRT7dMaVXO0wlYic0ecaELKb+xfIAtnJ/MxlkFQ6Q05
         38A7OXbH4vRqHCjMp9j6INQQ0wk/VCrslx7qxNLp76j4WKtThn6tqCne2HegatM9gN5V
         tkuiODOvev0Uove/ifJiRGhkfRvEASVRXvKUfwlCvptceA8G2pvVXHt0GHWBu6Jr/m1j
         AIq6XVbOyFCzf+xNl3zS+AxOBcAfHy0myXfxmzoqKxJXrb6+dx9tMDzLlyQVC87YqAgj
         8cJg==
X-Gm-Message-State: AOAM533En/Wque5LRjAIx4NOXJtzSMhHoie7Q7uhXVBU3705+bYmLaXv
        wPjX13n800e0m2vOR5RuK/1jhuSGBVjC+t1R29pVO4rlIyx9
X-Google-Smtp-Source: ABdhPJygvpMoysiFZMBOQUyz3LUgeuSlsCMSsz+vxGrqQK4ulKv05XNBG1CFhA4ZkcGq4EQP7/OZF4WQgXd+fDJsPHikb/WL5tKV
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2a:: with SMTP id m10mr6772343ilh.192.1635772570980;
 Mon, 01 Nov 2021 06:16:10 -0700 (PDT)
Date:   Mon, 01 Nov 2021 06:16:10 -0700
In-Reply-To: <f3de46fd-2159-6843-d2da-9a7a6a46b6c9@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006d69c05cfb9fb2c@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in __blk_mq_alloc_requests
From:   syzbot <syzbot+cd20829ac44b92bf6ed0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cd20829ac44b92bf6ed0@syzkaller.appspotmail.com

Tested on:

commit:         d1c2a961 Merge branch 'for-5.16/block' into for-next
git tree:       git://git.kernel.dk/linux-block for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=bfca9240a79435af
dashboard link: https://syzkaller.appspot.com/bug?extid=cd20829ac44b92bf6ed0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
