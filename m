Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ACBC04AAF
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 12:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2150320848
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 12:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfEPMdB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 08:33:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:46162 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfEPMdB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 08:33:01 -0400
Received: by mail-io1-f72.google.com with SMTP id h189so2536320ioa.13
        for <linux-block@vger.kernel.org>; Thu, 16 May 2019 05:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r+Egu140poF9tk75Gappftvz+qoaAR2oEuAec5aF1lc=;
        b=Vo9ZS4D4t4EZXCXsJe0rfTH4EchKkL9arTsUmYGBHK0evtbJhuImaJb0HvSAtXxX9h
         0CHacRJ9uJVE42x0GeFJt0ZFpn+O5Q+Yf6hwX0x1luRTmvMcl9zEYvUI/bqU0Opwq+Oz
         y2jd3EGKOv/DHmGaWRaOvnTfCAyKngH9Q8r02X5Q7VwtvCfX1Rhs+TPEhZ5ABjyOfoeS
         AVEBtpyFBJupbfq0YxmUu2cr3nGnI4McJh43XpT6117VVF0pR7uddcbj13uCInL87V28
         zMbzQYGG0rQwlxIoxZg6twQdhd6tIk32G8GmzKk666xkSMQddW8pLDHjVwRKIkqxu8kf
         I08g==
X-Gm-Message-State: APjAAAVD5k4AX0/5kpR/IpcolbOEJhpRbU4+1m8inXt1zLRwOThdEDRp
        Lt2qqDEpc93hfIiQvl1L0PQdjqTsG+3LmyINShyDEvLxGW94
X-Google-Smtp-Source: APXvYqxi4qMlBgNoO/Oy+N4ls5yZp4lS3lRfW02dBfYXmkjFfsJ3hI2rbfbc0oB9b59/5ibzuynp9DYFx7tHwakcm80fTlZInRdf
MIME-Version: 1.0
X-Received: by 2002:a05:660c:2ce:: with SMTP id j14mr12523202itd.70.1558009980711;
 Thu, 16 May 2019 05:33:00 -0700 (PDT)
Date:   Thu, 16 May 2019 05:33:00 -0700
In-Reply-To: <20190516114817.GD13274@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074f88405890077a3@google.com>
Subject: Re: INFO: task hung in __get_super
From:   syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dvyukov@google.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com

Tested on:

commit:         e93c9c99 Linux 5.1
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.1
kernel config:  https://syzkaller.appspot.com/x/.config?x=5edd1df52e9bc982
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135c5b02a00000

Note: testing is done by a robot and is best-effort only.
