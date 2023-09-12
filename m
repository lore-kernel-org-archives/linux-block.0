Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AA0CA0ECF
	for <linux-block@archiver.kernel.org>; Tue, 12 Sep 2023 10:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjILKR4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Sep 2023 06:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjILKRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Sep 2023 06:17:45 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431B719A3
        for <linux-block@vger.kernel.org>; Tue, 12 Sep 2023 03:17:41 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-273983789adso6499153a91.0
        for <linux-block@vger.kernel.org>; Tue, 12 Sep 2023 03:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513860; x=1695118660;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HY7DpSorxrkfJmOH+CwT7iChclD4psUg07PYg6KnRjE=;
        b=E8YbVkXYeov+6aPkNiG2eaNrmU0G2QZgiXk9sJqrJC/h/mYXCgSHknQRQcsS2h92LZ
         NRDnsHzfU2KoOf2072kSvHRnKppkuEd+sBrhEL7Pi5RKI37rXnphb41+PqFNytBv5415
         XeHB9FAGtpR303uNYzPYXaCMAcfD0gVeCVe4PawnL9iP+8EtgSIzGphFaQ0zUNKZ7sPS
         yrDm5G0cT509rVcMjbzQlCegHA+QWbndhhhBYmnG16q3gCJGQGXCD631gIVXFeo2Z51c
         ewnApcZA/eQKI9nlKo0+MgfW+s3CGPI0QIDaWAqIroJoX/b9jJBqdwJq9oSElCY9s4kj
         R7xA==
X-Gm-Message-State: AOJu0YzSYpMCiFw6S/pyfjY4wq+Mv79IYX+OtrKr3HhnkwJLSQLqwx1r
        Hc/Xy71EU4GdWyU6tSYEJlu0XzoCVoYMV9Wp+/7ELE8rdc+/
X-Google-Smtp-Source: AGHT+IFHaM/l+ezhbRMOgbt2kDm2MF38rZXvdiyr980HaM/iynb8ZU7cdmHx6OaJcCHqEKdaFjFW7nDNbB8YGB2EnqWEIlwISzC6
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d30b:b0:263:317f:7ca4 with SMTP id
 p11-20020a17090ad30b00b00263317f7ca4mr3179077pju.9.1694513860796; Tue, 12 Sep
 2023 03:17:40 -0700 (PDT)
Date:   Tue, 12 Sep 2023 03:17:40 -0700
In-Reply-To: <20230912083519.e2yveio72emi7rd4@debian.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd66f3060526c093@google.com>
Subject: Re: [syzbot] [block?] WARNING in blk_rq_map_user_iov
From:   syzbot <syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dan.j.williams@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ricardo@marliere.net, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com

Tested on:

commit:         0bb80ecc Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c0be80680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba194e5cfd385dbf
dashboard link: https://syzkaller.appspot.com/bug?extid=a532b03fdfee2c137666
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e02dc8680000

Note: testing is done by a robot and is best-effort only.
