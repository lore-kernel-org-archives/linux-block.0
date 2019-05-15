Return-Path: <SRS0=Ir13=TP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1CFC04E53
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 11:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4E220843
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 11:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbfEOL7C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 May 2019 07:59:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:42184 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbfEOL7B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 07:59:01 -0400
Received: by mail-it1-f197.google.com with SMTP id t196so2030966ita.7
        for <linux-block@vger.kernel.org>; Wed, 15 May 2019 04:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wLlE37yrPzANdfG8Iq9EHwFi5Q9N85cm606vgS2oU/4=;
        b=YB/Ix7MP04NnUB+qqm1W/wq8+i45bsMI0A/u+BGlU3EdeEGYVKkH5BsL3+7thPb9v2
         U6I1w4PhhQMAIg99o3XY29Gzt0TAD0CklZNqBPM/RZ7qWUcYRyFzNwEyjYpkOKotn9PL
         09GfPAtmPZAb1dWIUQ9PwA+yJWkszyemaPErB5lIZRBlLZbmV3hc47uB5/DxyHis9pfl
         SCqoMrbmXk+yBz1tHAvUCQMb//fHwIjlyAeoQKPynlVt4eb62TRThge5ITIjzHuAKXXu
         hznAWIIyZUI0mZI7w5GdVSyYaTZDrd6dfxNDRjrgJGJWyfbe6zH4cGMS522Pe/9vWeq+
         +Gqg==
X-Gm-Message-State: APjAAAVJfFJGIlOa9q7RPEOzlyKb5IvyHKjkSd1UhxqCei2EA98AgKAO
        /D2HixayduPkug3QMlw1qsREP5+lnnrPAhcS8NkNmm2MofRB
X-Google-Smtp-Source: APXvYqxhuea74sT72yLEr885VWUmC0yDDZPYDcDl1CPKw5tL3esMrV9W9iAbuAnr0eDXBy6JlimI1pULYWtWhNarz5FlgldoTSCn
MIME-Version: 1.0
X-Received: by 2002:a24:f68b:: with SMTP id u133mr7534350ith.139.1557921541063;
 Wed, 15 May 2019 04:59:01 -0700 (PDT)
Date:   Wed, 15 May 2019 04:59:01 -0700
In-Reply-To: <20190515102133.GA16193@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b0c360588ebe04f@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133626d8a00000

Note: testing is done by a robot and is best-effort only.
