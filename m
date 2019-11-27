Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E794C43215
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25642071E
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 07:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfK0HpB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:45:01 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:48371 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfK0HpB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 02:45:01 -0500
Received: by mail-io1-f72.google.com with SMTP id e15so12446367ioh.15
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 23:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YRVZo6hNi7keHgsRUhwNxFT/wNgVW78g53M8zInUS00=;
        b=F6MBS94J1o7kn+B8DX/yRA7vn7+K8cI1tVBJYS06pP2KI/RFIE7yz5S8L1SVgq+e6x
         WkHwL32Z2CHtfpCYmG2CwgtJZO4JjhAb6+6BLfZtKwotSVZBU1Pwpc65V0JAO0NqRR8a
         Xfr0Itgc6QKT7QkxtV/lTdXksc2TsO/1zeWaS7DXuy8CNWYbur0fbLQ2XVn4v8jx21JY
         FoCl8w0M6zghX2yoyN4/z7lIS6pFyKl54UrOzARzBnelJQ5krY1XEm0QRQFtVNRcHiUE
         aK8RdnMh9W1svoIrO20hB6jqlbSxSlLt3Ssvgt1fcVdTeoLFMcGvbSlI3o3yCl0LIF/e
         +pyw==
X-Gm-Message-State: APjAAAW/V8H0mWUXXHMXwJst3eATLi1ulnkli/jbblDmqgq3h1T2HfZn
        iQoAbfg2JEAMdDxLMFm8MMna0XluVOJ0yBuVcwtQaNIwnJtM
X-Google-Smtp-Source: APXvYqxYJS0yXjGWxfF4TAH6sMJkenvzlZJMjdc+2mWHUf8AMRtwUGVMsZ9Z0a//OKYOxpMLZNeVK3k1A+KtoOXLOoIuGb6zNLcu
MIME-Version: 1.0
X-Received: by 2002:a92:50c:: with SMTP id q12mr43328163ile.234.1574840700355;
 Tue, 26 Nov 2019 23:45:00 -0800 (PST)
Date:   Tue, 26 Nov 2019 23:45:00 -0800
In-Reply-To: <201911262053.C6317530@keescook>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085ce5905984f2c8b@google.com>
Subject: Re: WARNING in generic_make_request_checks
From:   syzbot <syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com>
To:     00moses.alexander00@gmail.com, axboe@kernel.dk, bvanassche@acm.org,
        hare@suse.com, hch@lst.de, idryomov@gmail.com,
        joseph.qi@linux.alibaba.com, jthumshirn@suse.de,
        keescook@chromium.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        sagi@grimberg.me, snitzer@redhat.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org, wgh@torlan.ru, zkabelac@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com

Tested on:

commit:         8b2ded1c block: don't warn when doing fsync on read-only d..
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d727e10a28207217
dashboard link: https://syzkaller.appspot.com/bug?extid=21cfe1f803e0e158acf1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
