Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F41C433FF
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 23:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FCA20825
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 23:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfHEX7C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Aug 2019 19:59:02 -0400
Received: from mail-ot1-f69.google.com ([209.85.210.69]:51567 "EHLO
        mail-ot1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfHEX7C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Aug 2019 19:59:02 -0400
Received: by mail-ot1-f69.google.com with SMTP id h12so47330233otn.18
        for <linux-block@vger.kernel.org>; Mon, 05 Aug 2019 16:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cCEYw1YNz6YzHWfgF679x03NeagqCuKTljhuC5ujasE=;
        b=anQkQ6CSrSbAcHcCzaPdcUYb34osMDK8xAMkzco4h08KozPT/HOfv0qLFWHwb6V3ye
         9OiIW0UFQ1ekJifnoJRxXMbn+EavIG3xPfw6xXv0osDnrKNrBJ6UwfeQOtXao2NAc2bX
         RjfpGy0OL6B4YdVmYjnYMBU1nvVB1GgbTr2RPrAYu+yyF2WI71/pvvRcJU9bOvLXwxN4
         ZUb30V0J9VRRL8AGSfpdqpFJMcO5EtNDcqag99b8KCZmNXU0nmd4o35+jx7KSVpNpM7o
         WMpMu7Qipnkp3QUkLGwe2uObodJgHnxOsN+W0D1qOFGF1chG0A3jQYjUdfrpLj55c4KK
         h9IQ==
X-Gm-Message-State: APjAAAWnR058vkn7HrHI8gpBC7XWQbEowidauhOCIJr/KK2WRBDImAAf
        nS9co3dPgi1tCbYNkt+B0nJZoamlAom8Xr7f0YGg5ZdV/Kvh
X-Google-Smtp-Source: APXvYqwnWehfXVv+cTgMbmC8JDtGgeKanwz/g7rHrVO82/VKU6rQkcOihO2EYpiU+OJoGnyjFk/K9Z7NbCjOUvfNijzTrmNmUP5+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:5:: with SMTP id z5mr1098412jao.58.1565049541088;
 Mon, 05 Aug 2019 16:59:01 -0700 (PDT)
Date:   Mon, 05 Aug 2019 16:59:01 -0700
In-Reply-To: <000000000000d0df7f058f625d13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3dd5b058f677d84@google.com>
Subject: Re: WARNING: refcount bug in blk_mq_free_request (2)
From:   syzbot <syzbot+f4316dab9d4518b755eb@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit 12f5b93145450c750f315657ef239a314811aeeb
Author: Keith Busch <keith.busch@intel.com>
Date:   Tue May 29 13:52:28 2018 +0000

     blk-mq: Remove generation seqeunce

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1263808c600000
start commit:   e21a712a Linux 5.3-rc3
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1163808c600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1663808c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
dashboard link: https://syzkaller.appspot.com/bug?extid=f4316dab9d4518b755eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117a1906600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aa11aa600000

Reported-by: syzbot+f4316dab9d4518b755eb@syzkaller.appspotmail.com
Fixes: 12f5b9314545 ("blk-mq: Remove generation seqeunce")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
