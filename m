Return-Path: <SRS0=AIK+=3W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A439C3524A
	for <linux-block@archiver.kernel.org>; Sun,  2 Feb 2020 07:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409DA206E6
	for <linux-block@archiver.kernel.org>; Sun,  2 Feb 2020 07:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgBBHFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Feb 2020 02:05:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:56284 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgBBHFC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Feb 2020 02:05:02 -0500
Received: by mail-io1-f70.google.com with SMTP id z21so7189157iob.22
        for <linux-block@vger.kernel.org>; Sat, 01 Feb 2020 23:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Fqcj080fpjW3YleUBFYycrIBXVF2KLfVb8A0MJTatPs=;
        b=oxLdzbz0WfJYRBIzeE5U3t5elxJ5MJ8YtAkni1gbvayVhA9XviprlEXVq9vH9uCtpX
         7jTxmBfIbZo9pUjIsYyO9VSUrJOaKJsN354rzwtZEUg7IzQTMaVCWHBj6EofXyqzg4PB
         N0NER2YczMlHMOOCt2frqh5J+waQqcLiBLJwFcgg9rzo/3q+Or2S9VWUcywAN9ZpCDkR
         nPBOcZY/C5v/P8Q6YOUaFJ5zdPe9xNVjVJF0Lw0oT56DfY+PcVGYte5QzINc3ehMkjhu
         QN4h4e/dyLxttZ1ZRPL2d5qi3vqDQqAQ+rAEg10ZtfvcmqLjFyLTKDpT0P9qgpIiKltw
         bNFg==
X-Gm-Message-State: APjAAAWJr6wqPm7vVeuQzT1IXQcZ7LYjEkx9lrDtJsGdf24ouHpu2ywL
        e/YcefTKag4wJ15N4ZPwhT91yA86rkS7J7fSeozcnRlCdp0J
X-Google-Smtp-Source: APXvYqxfBgVwZ/hal5pak54Hcteg+t0Fij/8KIMoja/+eLHlPRn9E4SfA6mh3Gdu3ROVJtSS+LFRs6S4yHL4Rd9kab/BnsMwYdze
MIME-Version: 1.0
X-Received: by 2002:a5e:8e4c:: with SMTP id r12mr14311646ioo.119.1580627101442;
 Sat, 01 Feb 2020 23:05:01 -0800 (PST)
Date:   Sat, 01 Feb 2020 23:05:01 -0800
In-Reply-To: <0000000000001a1ef1059b1a27c7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e76ba6059d926c08@google.com>
Subject: Re: INFO: task hung in __generic_file_fsync (2)
From:   syzbot <syzbot+44c32606d8669fb0d45c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, dave@stgolabs.net,
        hch@lst.de, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ming.lei@redhat.com, osandov@fb.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 85a8ce62c2eabe28b9d76ca4eecf37922402df93
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Dec 27 23:05:48 2019 +0000

    block: add bio_truncate to fix guard_bio_eod

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ebe101e00000
start commit:   bf8d1cd4 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=44c32606d8669fb0d45c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137e2615e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11306971e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: block: add bio_truncate to fix guard_bio_eod

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
