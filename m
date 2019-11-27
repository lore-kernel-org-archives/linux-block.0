Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF0BC432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 19:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625F520862
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 19:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+xus56I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfK0T0W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:26:22 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:45940 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfK0T0W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 14:26:22 -0500
Received: by mail-pj1-f67.google.com with SMTP id r11so2639860pjp.12
        for <linux-block@vger.kernel.org>; Wed, 27 Nov 2019 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eVNNKDEwK+00GI4nXd9IX+dWdzOAiwJNjdPjOU+ejY0=;
        b=U+xus56I5dr6Aqz7wXSwbowuREWFV2uxsdtZciqEjc59w56SO7/eYwEFYbRbNq7t3r
         /z5JwgMRey9oFd9dGmRbOwyDt/UxPsAyJbhZY8wmo2Fl9A1YwXkrd8PQPXBMwFYhmxcS
         AZzznEDKcHT6GlYef5U3newa8JYZBvm14OOSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eVNNKDEwK+00GI4nXd9IX+dWdzOAiwJNjdPjOU+ejY0=;
        b=oSvK7BiAs0cR45aQyv5jgLIluuhB/f1Cb/VCGiS5uOKXUrtkwZTe1F1Ev2PlQfaILy
         ylHTkbgYHWWeEgRKUQVoH36VEnUHZ+zUDcS8AnEhUOI9isKs0clIDMqg5aHYN5CWTq3G
         TJkDk46izPVXMqlXEXWmlWS0YiWeXcwXe3IzP5SaoxvEZCYv4PP01PRviNvGe65vSzga
         P81UMEdAs6RMUb3foL0upa9nbiWURQzfs0VaznrdL7WUpu1I5SJZMrh9wmUljUKOBUVE
         j9R9/qil/fARE1OWpyiLuOXc8s2oWBBqt09CdzpzXz4Qz+w+TwZLqG9z3oUBQZZpfXlg
         QwOA==
X-Gm-Message-State: APjAAAXFF+ks6ysu28XoyLj2ILjsT29I9tD1tTZeCuybTP5n7SpSOS5h
        u/8bBqyPWyED30K2UTqxV8D83stxZa4=
X-Google-Smtp-Source: APXvYqxyZCRdeC8jUm68R3lJljLtvG9x0YOYSTxJ4Qiw8dH/Q8nTdrPSERPqvHWi0TfhZ5eZN1cVIA==
X-Received: by 2002:a17:902:bf01:: with SMTP id bi1mr5940322plb.241.1574882781626;
        Wed, 27 Nov 2019 11:26:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 20sm16837474pgw.71.2019.11.27.11.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:26:20 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:26:19 -0800
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
Message-ID: <201911271124.F01A0B37@keescook>
References: <201911262053.C6317530@keescook>
 <00000000000085ce5905984f2c8b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000085ce5905984f2c8b@google.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 26, 2019 at 11:45:00PM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
> 
> Reported-and-tested-by:
> syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         8b2ded1c block: don't warn when doing fsync on read-only d..
> git tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d727e10a28207217
> dashboard link: https://syzkaller.appspot.com/bug?extid=21cfe1f803e0e158acf1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Note: testing is done by a robot and is best-effort only.

It seems for successful tests, I still need to tell syzbot that this is
fixed?

#syz fix: block: don't warn when doing fsync on read-only devices

-- 
Kees Cook
