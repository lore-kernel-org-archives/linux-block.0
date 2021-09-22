Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AA0C433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 16:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69521610D1
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 16:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbhIVQMi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 12:12:38 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33773 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbhIVQMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 12:12:37 -0400
Received: by mail-io1-f69.google.com with SMTP id g2-20020a6b7602000000b005be59530196so3396472iom.0
        for <linux-block@vger.kernel.org>; Wed, 22 Sep 2021 09:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UmA5fLnL3GwryS2xj+yPX5YOnEleOA06k1MW7m7x+TQ=;
        b=0fph4gY79lONo+iK1wW0GGkY+tWG21Uj5j++OablvY2bB5KrXcgx9M3c8o64/UKQoq
         lSiotouwvSarTos7kS7Z4JkAJSr+EdxKZGi4/+TLw2EJoHFyq5ZPX6jzRy770ndk13uP
         34tQjNY5hMXYNCgarB3yQvkcMH3L7hS3DTnw82M64Ah/w+xjkW75y81aCJoQsnoUQ8Sb
         lZm+NJDnsUDL79tu7nwHb/CVB9sm9Zx5xQj3SEEFryXX/Cm1DOi1mUH9yOK1Bcpnp/Mh
         i5L0Kl2CeLUrGw7+4iWToMD5rdIhud/1W/fw+kPZ13vfgrKngllvCeXUKNLQeDgihz8c
         b8MQ==
X-Gm-Message-State: AOAM533Fk2imryiNQ5pI3XrY1uD47NX3MiwzdIzil22eNvrTifPN3OI1
        LUJV0w8sEWHtxDzKuhYIYSfEYBDSGeVOeDMmFX8zATyLBYPp
X-Google-Smtp-Source: ABdhPJxk7hBdI+nl+8MGWPeeiUS55BURR8MW1W0ABkOhmmB6xfRPaH4Zg21gdAytWslsTLtv90L4YtBUY3Dpl8CGzWDD5CQx3GH8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d86:: with SMTP id i6mr378919ilj.28.1632327067566;
 Wed, 22 Sep 2021 09:11:07 -0700 (PDT)
Date:   Wed, 22 Sep 2021 09:11:07 -0700
In-Reply-To: <000000000000e692c905bbe9192c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000050d0d05cc97c35f@google.com>
Subject: Re: [syzbot] general protection fault in nbd_disconnect_and_put
From:   syzbot <syzbot+db0c9917f71539bc4ad1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cs.temp3@bpchargemaster.com, hdanton@sina.com,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mail@anirudhrb.com, nbd@other.debian.org, nsd-public@police.gov.hk,
        stephen.s.brennan@oracle.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 794ebcea865bff47231de89269e9d542121ab7be
Author: Stephen Brennan <stephen.s.brennan@oracle.com>
Date:   Wed Sep 1 17:51:42 2021 +0000

    namei: Standardize callers of filename_lookup()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1163691d300000
start commit:   acd3d2859453 Merge tag 'fixes-v5.13' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f04bb30bd3c55050
dashboard link: https://syzkaller.appspot.com/bug?extid=db0c9917f71539bc4ad1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f63543d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122c8ef1d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: namei: Standardize callers of filename_lookup()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
