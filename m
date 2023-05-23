Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D02C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 09:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjEWJe7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbjEWJep (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 05:34:45 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20E11AE
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:34:31 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-76ce93a10f3so284733839f.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 02:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834471; x=1687426471;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XhonWAPAu8OTH4owMzaT0fJr80igSY+VEVOwOtFTeA=;
        b=OpgrYjuShx27Kl29gtubPFHEva24g1iRViuCRCQx84RJ4gbQkQ7eiGVZUnwSZ6ZtUM
         aq1SpMXIplP7esB4fOTC3Zb+bDaV/QhDNvgPL6vcStbklte+ahRUp1OtIq/U7fGo9VQR
         1BwTFp5GfL46d6wpoAicH/qoolRY138sLbcp9wCE5JZoQiKZwmV1HdWbtqD6EYB1zC7G
         G25NUw4nO47/PZB4sC+xROniUY713YXZpu7hWLjln24ughs/vNlE2qJxtU+7PTHoWT/5
         hUeayCATPYPDekbHIAxmBy42PM+hLY5GXWWOGbSuziCg/ZzJKfiLpHUb0mFtGsJNH3h7
         O9mQ==
X-Gm-Message-State: AC+VfDyHFdfC8l0knELI0p+sSpTmrb2KBB5+zmqynVIFN5IywgZ3vcD/
        SH5VeZQYoBvi1Ejl0d3QL/Kn2r6F4zmHqRcWHwuFUsEVxUqI
X-Google-Smtp-Source: ACHHUZ5YZD8fx0KgCTuHpDJe0wpCyOKPizAlCEPgXSRJ4L1EvfuXNi5P5YSJh8gMioCuqsedxNrAggthsCP4xsGho4gpnN+tE5a8
MIME-Version: 1.0
X-Received: by 2002:a5d:9285:0:b0:763:5a5a:90e7 with SMTP id
 s5-20020a5d9285000000b007635a5a90e7mr6621320iom.3.1684834471032; Tue, 23 May
 2023 02:34:31 -0700 (PDT)
Date:   Tue, 23 May 2023 02:34:31 -0700
In-Reply-To: <00000000000066a94205fc488445@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026bdd305fc5918a5@google.com>
Subject: Re: [syzbot] [block?] [reiserfs?] KASAN: user-memory-access Write in zram_slot_lock
From:   syzbot <syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, hch@lst.de,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        reiserfs-devel@vger.kernel.org, senozhatsky@chromium.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit 9fe95babc7420722d39a1ded379027a1e1825d3a
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 11 17:14:44 2023 +0000

    zram: remove valid_io_request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132fa586280000
start commit:   44c026a73be8 Linux 6.4-rc3
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10afa586280000
console output: https://syzkaller.appspot.com/x/log.txt?x=172fa586280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8067683055e3f5
dashboard link: https://syzkaller.appspot.com/bug?extid=b8d61a58b7c7ebd2c8e0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1223f7d9280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1245326a280000

Reported-by: syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com
Fixes: 9fe95babc742 ("zram: remove valid_io_request")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
