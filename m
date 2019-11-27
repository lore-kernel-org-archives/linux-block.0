Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB43C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 04:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1CF20835
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 04:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AJN1uF00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfK0EzB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 23:55:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44424 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfK0EzB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 23:55:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so9178546plb.11
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 20:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x014kdajHiZwpaMlsuru1v/99Jfm4YTVrAu4JkOB+AM=;
        b=AJN1uF00joCEDQS1lgwWjvl6jjwKkhRtQSqHBSMUPbots4Osm7CiLFx9g2olFkTR61
         tZk9wuX7nMi86+lGcxoUh/shKpzeyiPWjlfVX98t+OkeZlZ43fcQtLhZg0tXsMjkxz1K
         aiIgt/Vms09hZRioSwZmIl5tUTcEid9icHiCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x014kdajHiZwpaMlsuru1v/99Jfm4YTVrAu4JkOB+AM=;
        b=qHTQXS2JHbib5ogw+btIxLeUAnFLoscMvkQOvSLqxsZ816ZbVrqLVuH2FFht21I8t7
         zvNjdQD46QuHSLZEQgmMK0/CxpB6liSdFU5mINDSPMEPQNNxLU/SDNLHYFlSrKdLxVdi
         R6RXqU8MmXma9q/FSymhZp5/uXbTtpWEgoG9kwe0qyMPTq9b3pp2jrgKTGvqu6T2Z2Gy
         QnLuo9kWQj7H3e4ZBnXpmveNiYIDno5JdC07C1a/xpWPrFvXpnOtHGosboxmjcRzKRCC
         r2qjPY7AbLseNIvyN/JhvLzjz1g4pKpUiy7wXZbmHWO7Mn5haCLebG3708EudzG+hdgO
         VOAQ==
X-Gm-Message-State: APjAAAXPLxHlfINzG5mDz2g4l0NrxTso3r8DZVlbU6z3nHZIqYTRY4CK
        qemkd8uK6U7qHT9Wu5h8Tt4PSw==
X-Google-Smtp-Source: APXvYqzqV9mvaxiXAzfVPCiGwO1coeJXDQeUreYCGoe9LA2oovG2u34yRY5JIW856tzsTA0nfk4Oug==
X-Received: by 2002:a17:902:b610:: with SMTP id b16mr2140885pls.70.1574830500738;
        Tue, 26 Nov 2019 20:55:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p16sm14894293pfn.171.2019.11.26.20.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 20:54:59 -0800 (PST)
Date:   Tue, 26 Nov 2019 20:54:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     syzbot <syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com>
Cc:     00moses.alexander00@gmail.com, axboe@kernel.dk, bvanassche@acm.org,
        hare@suse.com, hch@lst.de, idryomov@gmail.com,
        joseph.qi@linux.alibaba.com, jthumshirn@suse.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, sagi@grimberg.me, snitzer@redhat.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org, wgh@torlan.ru, zkabelac@redhat.com
Subject: Re: WARNING in generic_make_request_checks
Message-ID: <201911262053.C6317530@keescook>
References: <0000000000003c4e6d0572f85eb2@google.com>
 <000000000000350fb80597ee3931@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000350fb80597ee3931@google.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 22, 2019 at 04:05:01AM -0800, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit a32e236eb93e62a0f692e79b7c3c9636689559b9
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Fri Aug 3 19:22:09 2018 +0000
> 
>     Partially revert "block: fail op_is_write() requests to read-only
> partitions"
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119503d2e00000
> start commit:   60f5a217 Merge tag 'usercopy-fix-v4.18-rc8' of git://git.k..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=139503d2e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=159503d2e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
> dashboard link: https://syzkaller.appspot.com/bug?extid=21cfe1f803e0e158acf1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b87bfc400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117ccc8c400000
> 
> Reported-by: syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com
> Fixes: a32e236eb93e ("Partially revert "block: fail op_is_write() requests
> to read-only partitions"")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 8b2ded1c94c06f841f8c1612bcfa33c85012a36b

See https://lore.kernel.org/lkml/20191125174037.GA768@infradead.org/

-- 
Kees Cook
