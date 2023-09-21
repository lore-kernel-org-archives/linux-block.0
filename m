Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335BFE7D0A4
	for <linux-block@archiver.kernel.org>; Thu, 21 Sep 2023 18:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjIUSRt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Sep 2023 14:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjIUSRd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2023 14:17:33 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B50385D18
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2023 11:16:25 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1dc160e3aadso1684767fac.3
        for <linux-block@vger.kernel.org>; Thu, 21 Sep 2023 11:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320123; x=1695924923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q3qFJHo3XVshohtuwZiN/FL0niZyPiXxa7GA+BqUwY=;
        b=fVPaV2hiFvxUIiEmwzokoUOXEGG0iYlToAcV20vB9iArs9oaLPmeITuTDS2u/Eock4
         un7ig9xzDlLeLiT9w63VLeHuU5N4Re/wROPkwcwU9QTrrV1aB1qGcs3T6KhJp4mY+sHQ
         7UmC5MqjrWkW2huU0vs+AqzRhRfUHgpxTB28w7AFR3rC5vmoSqKs2JsRf+G3hntQrawt
         wScG1jxEBWSi4x3orlqwqJQkMlOz8GoFJbtENo0Nj5q744AHwFhj8kbbYa2cm0FDZOzK
         TZIJWCcHdsNEhrjh9OqCerBawww1BSj+TIRZldFJsIO0y60+twVctnt6ZgIifXQv72I9
         AG7g==
X-Gm-Message-State: AOJu0Yy+QgZiN4qd2fWNTRj1guvfQzT934lP2JjgALDbRI4TjkzO0Fey
        d28Xir/JOYct1nCiUjvPZJcuQNPClcYHj9Pi30rr4sFIwUk1
X-Google-Smtp-Source: AGHT+IHHPQ+f83WOGBx5Q3jkh5OIGbhQpryoZz5a7eZICtLdsOv/3A7TNMHxgGgwmTb+a5OxHenITAsJd3MG+L4ZYu+uSSaU8Nmx
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a8b2:b0:1c5:e4a5:6990 with SMTP id
 eb50-20020a056870a8b200b001c5e4a56990mr2450683oab.5.1695320123192; Thu, 21
 Sep 2023 11:15:23 -0700 (PDT)
Date:   Thu, 21 Sep 2023 11:15:23 -0700
In-Reply-To: <000000000000172fc905f8a19ab5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b93c240605e27901@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_commit_transaction (2)
From:   syzbot <syzbot+dafbca0e20fbc5946925@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, kristian@klausen.dk,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit 2b9ac22b12a266eb4fec246a07b504dd4983b16b
Author: Kristian Klausen <kristian@klausen.dk>
Date:   Fri Jun 18 11:51:57 2021 +0000

    loop: Fix missing discard support when using LOOP_CONFIGURE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15dfb0f4680000
start commit:   57012c57536f Merge tag 'net-6.5-rc4' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17dfb0f4680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13dfb0f4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f28dfd7d77a7042
dashboard link: https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173a6716a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111c7c7ea80000

Reported-by: syzbot+dafbca0e20fbc5946925@syzkaller.appspotmail.com
Fixes: 2b9ac22b12a2 ("loop: Fix missing discard support when using LOOP_CONFIGURE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
