Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ABDC7EE23
	for <linux-block@archiver.kernel.org>; Sun, 11 Jun 2023 21:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjFKVSc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Jun 2023 17:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFKVSc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Jun 2023 17:18:32 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4789B1A8
        for <linux-block@vger.kernel.org>; Sun, 11 Jun 2023 14:18:30 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77ade29e1easo280201039f.1
        for <linux-block@vger.kernel.org>; Sun, 11 Jun 2023 14:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686518309; x=1689110309;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++zemBX/2RrOYOFOLtSc1QjMmPmCs+Z/n8b0jPh3c7o=;
        b=WiulE6sO2KsfAgTxr6ma3J8z2VuskwMgiAzEE3HyBF7HkWUjtuxNcbK3Dr4C5baRN/
         Bv/c6MuhWahUoo4eE0nfT1t6vAxACniJAMdzvPz1jj9IG3AUMjARogNZdQz7AK6P+PYz
         OgIEk9dfMWbuXXLJGsazTgSpdXE0sCnYgH/tsqIRZeJn/IG4Y9pcGX2FPBBIsrdo9lM4
         YgcHyvKy7vk5vtTOPZUOkcWIfcHkFw98ieTU1jyscBvMQZ4j06glpLzTj/WLSQAbNULV
         Q9Vz0H8XvvwyVYgGlF9Myc98CK1VI1IJ/akVpmrZCoCX5LZlhYUvCs3JfqO2nOxiZ1Y4
         y+dQ==
X-Gm-Message-State: AC+VfDyTw2S9UGHw4N4ZXksPkGbXwbzbKkIjap/EG6eA8OVeZVhtImfl
        NJYLT2GMB/H0MhFqJTx4f2Ke0gy0xBw+UpoAwa27AbYtjMX1
X-Google-Smtp-Source: ACHHUZ5uexlpBPtPJccaNdHhmErmovEuc0aJEQv+DulBACxbzELH3wDT/Ehuljo6vWiQkQ7yLj0tlIJ2iLEPDZLXWLeSG1iJZatu
MIME-Version: 1.0
X-Received: by 2002:a6b:fd15:0:b0:777:afc6:8da0 with SMTP id
 c21-20020a6bfd15000000b00777afc68da0mr2935869ioi.1.1686518309621; Sun, 11 Jun
 2023 14:18:29 -0700 (PDT)
Date:   Sun, 11 Jun 2023 14:18:29 -0700
In-Reply-To: <000000000000da4f6b05eb9bf593@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0951105fde12435@google.com>
Subject: Re: [syzbot] [nilfs?] general protection fault in nilfs_clear_dirty_page
From:   syzbot <syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dsterba@suse.com, hch@lst.de,
        konishi.ryusuke@gmail.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit 4a445b7b6178d88956192c0202463063f52e8667
Author: Qu Wenruo <wqu@suse.com>
Date:   Sat Aug 13 08:06:53 2022 +0000

    btrfs: don't merge pages into bio if their page offset is not contiguous

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17778475280000
start commit:   022ce8862dff Merge tag 'i2c-for-6.4-rc6' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f78475280000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f78475280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=53369d11851d8f26735c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e9d48b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d7fa63280000

Reported-by: syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com
Fixes: 4a445b7b6178 ("btrfs: don't merge pages into bio if their page offset is not contiguous")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
