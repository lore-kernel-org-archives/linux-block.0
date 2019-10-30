Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B3CA9EAF
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 07:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AFF2087E
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 07:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfJ3HoB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 03:44:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47854 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJ3HoB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 03:44:01 -0400
Received: by mail-io1-f70.google.com with SMTP id r84so1196859ior.14
        for <linux-block@vger.kernel.org>; Wed, 30 Oct 2019 00:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dxnBOmtjfHc78Shusa2+2C/dwRTd+Y9TDOU+bAXew3I=;
        b=W58CuVXAbfveYfImYx4xkU6qlzoj8XNX3GmLCp80zNAuH11g3whFximRh9XbX3MiOz
         e6QllhVB3nmR4lAzGFRTK+5mC0QSeRi1k4kfivGizQtMhOOIsqr4Q+i5Zgd0W7FpojCe
         +61NfVmLzZ4LJqno7/sB/eZqttP0GaBeEVLaLc+Z9I83WRnvoz//Ay+/UvPzP/BlM0z2
         ll5HfxvYNCsN0LZxMK7PqOUSpXQOd+3O4irm0x/8f/HQm3H3+LpmsftXGPVnK+z18QgA
         86khvLZ+E7w+LFmLtJ+A3CpT1zfYPLZyOirofWRNSZO5ppandBdOcRTop7pNXvN7rv5C
         ANgQ==
X-Gm-Message-State: APjAAAVHmBxiSBU1e7bkI4iIJNqLnyp29c63nGYpHhSFO9zjCl8Ttuz0
        JzAYn59lpk39jF5MtISRSXDg9OEtL9vSEFbDa4xKwSyUmo7u
X-Google-Smtp-Source: APXvYqzGVHBXNanN7A1gB3Pu8U6dJQ1xC84jP6Pgwkt0UEP1XoERs3CsFZrP1t2i7TE5nit9eB6qSkADskBzJ+BxPwORRiMLm+9o
MIME-Version: 1.0
X-Received: by 2002:a92:99ca:: with SMTP id t71mr16932987ilk.61.1572421440730;
 Wed, 30 Oct 2019 00:44:00 -0700 (PDT)
Date:   Wed, 30 Oct 2019 00:44:00 -0700
In-Reply-To: <000000000000c6fb2a05961a0dd8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069801e05961be5fb@google.com>
Subject: Re: BUG: unable to handle kernel paging request in io_wq_cancel_all
From:   syzbot <syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk,
        dan.j.williams@intel.com, dhowells@redhat.com,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        joel@joelfernandes.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, mingo@redhat.com,
        patrick.bellasi@arm.com, rgb@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        yamada.masahiro@socionext.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit ef0524d3654628ead811f328af0a4a2953a8310f
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Oct 24 13:25:42 2019 +0000

     io_uring: replace workqueue usage with io-wq

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16acf5d0e00000
start commit:   c57cf383 Add linux-next specific files for 20191029
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15acf5d0e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11acf5d0e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
dashboard link: https://syzkaller.appspot.com/bug?extid=221cc24572a2fed23b6b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168671d4e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140f4898e00000

Reported-by: syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com
Fixes: ef0524d36546 ("io_uring: replace workqueue usage with io-wq")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
