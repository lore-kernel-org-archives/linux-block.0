Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DF9EB64DA
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 22:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjGGWcc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGGWcb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 18:32:31 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64932127
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 15:32:29 -0700 (PDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-55bf5cd4e75so3183800a12.2
        for <linux-block@vger.kernel.org>; Fri, 07 Jul 2023 15:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688769149; x=1691361149;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JrBZCM2sZbAEtmzMwiNkMKBUDefOdEVG2GINkQd/o2I=;
        b=F4IN/9LdtE1YbybpDgl4FXyLbft9k/WcpR5bn9HOZs4Q3wfBb61AxHzj9omiM0LrrY
         9Ys7HGFvnmVsAEBijZaR5mphTc/P+yCBVrvGbxmMsc7zZg+yxRrskWIe/aJEkhAlHIWL
         Nzz+/SXwpGSDOVhzC+vCNnbhYnC/2r7LH7ndvkAJaztLWG2YoT0M4rlmVYzndSMW72gm
         KS7XW+CVaXJPozANrsKGWu9nAy3w8kV0n3b6dvrjD3alXYcBt9QlekVhsPFIQ32MBtce
         KY1CBy4fZuavsZIuuL/t6d2PbM1xvZNmulLrmbSQtZsdLTd44hksvvFHe/SHkIIC3SAi
         dQ5Q==
X-Gm-Message-State: ABy/qLaDxxKWwq6kNd02u164a/Jf+chJV9WozJYmoTjmbxwwHC6oVexT
        MlWXpnPSWJelBzqt4Y/s1c2QmHTbdltF03ePt6ZHsc74/ePJ
X-Google-Smtp-Source: APBJJlHIN2tTYXymcCUfXVwsV+PDUVJ2fikgqRYkjrV4CjneUIezMffsOm9xPaios13wH8u6jIYhec5vLxheC5G5bAqo82SGxkqg
MIME-Version: 1.0
X-Received: by 2002:a63:4b10:0:b0:557:7f87:e5fb with SMTP id
 y16-20020a634b10000000b005577f87e5fbmr4278933pga.8.1688769149292; Fri, 07 Jul
 2023 15:32:29 -0700 (PDT)
Date:   Fri, 07 Jul 2023 15:32:29 -0700
In-Reply-To: <000000000000ae0f7b05d77b27b5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040576405ffed3547@google.com>
Subject: Re: [syzbot] [block?] [trace?] WARNING in blk_register_tracepoints
From:   syzbot <syzbot+c54ded83396afee31eb1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, mingo@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit fcaa174a9c995cf0af3967e55644a1543ea07e36
Author: Yu Kuai <yukuai3@huawei.com>
Date:   Wed Jun 21 16:01:11 2023 +0000

    scsi/sg: don't grab scsi host module reference

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13470f02a80000
start commit:   c8451c141e07 Merge tag 'acpi-6.2-rc2' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2651619a26b4d687
dashboard link: https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1655b82a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ef7348480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: scsi/sg: don't grab scsi host module reference

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
