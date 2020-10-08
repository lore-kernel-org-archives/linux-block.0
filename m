Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972FDC4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 03:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3563920714
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 03:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbgJHDiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 23:38:11 -0400
Received: from mail-io1-f77.google.com ([209.85.166.77]:42442 "EHLO
        mail-io1-f77.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgJHDiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 23:38:11 -0400
Received: by mail-io1-f77.google.com with SMTP id k14so2888430ioj.9
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2020 20:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4IhbBH7ECghcPFerwikAMQpqWj6YlBpaCR+/1lLbfIE=;
        b=KiaVXSZx7j7tIYN/7fTf96o8kyP/5NbbCI9mnDGxsni4bISB1Nm5+Q+J6f/1TiZQ1c
         6+fgM6oLnkcKmCG8ZUTz/LveZuTQV317naiM/KFOU6D3eNlg6huzrChhq3ipUs2Q2EF0
         75e7VjIEN42mjAFHPJSGNjKJ2DVBfBZc00aEFfgSkBeiIPWP+4N8CF7D1BuAa8ppZaz+
         v9qROsFkF161Y15Vtwpano1SlXibNA3xgdHmOvf9n86jDHx9T/szvw3/ThjAOlL2Hh0h
         3WoNvJUdf7XedM0LhcSxwyvGfwKSbQywUzGiBXvSzrtw4jgbMFhJWCX2CMF9LM0oDLo2
         X12w==
X-Gm-Message-State: AOAM533RmUOU99N2fDGAeLc9tWDge9uV3ke83U4IWB8740FGtQrvGOic
        rsNGrwZGcHz4gE6iJ5llmobdFmpFqI4NKL35pNoQGcBtenKQ
X-Google-Smtp-Source: ABdhPJynKSURyz8krzVv92HNweDLHB/5PqX1t0MirYXocBnDSftoIzE01f7AZnfI+TcgJdlhKPHkNqcCx/gg/MZ7dJ+aWSiS2SjA
MIME-Version: 1.0
X-Received: by 2002:a6b:f30a:: with SMTP id m10mr2888088ioh.164.1602128289047;
 Wed, 07 Oct 2020 20:38:09 -0700 (PDT)
Date:   Wed, 07 Oct 2020 20:38:09 -0700
In-Reply-To: <0000000000009323e705ae870d48@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dab1205b1208fe6@google.com>
Subject: Re: KASAN: use-after-free Read in delete_partition
From:   syzbot <syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com>
To:     anant.thazhemadam@gmail.com, axboe@kernel.dk,
        bgolaszewski@baylibre.com, dan.j.williams@intel.com,
        dragonjetli@gmail.com, gregkh@linuxfoundation.org, hch@lst.de,
        hl1998@protonmail.com, jack@suse.cz, jean-philippe@linaro.org,
        johannes.thumshirn@wdc.com, jroedel@suse.de,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        saravanak@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 08fc1ab6d748ab1a690fd483f41e2938984ce353
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Sep 1 09:59:41 2020 +0000

    block: fix locking in bdev_del_partition

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1259b1e7900000
start commit:   f75aef39 Linux 5.9-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=b8639c8dcb5ec4483d4f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c43c79900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173dfa1e900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: fix locking in bdev_del_partition

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
