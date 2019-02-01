Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78248C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 08:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F8720869
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 08:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BJnwSD8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfBAIbK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:31:10 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45788 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbfBAIbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 03:31:09 -0500
Received: by mail-vs1-f66.google.com with SMTP id x28so3657615vsh.12
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 00:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgjcUiq7Q/kVIYOW2+NCgq5Wl/YZD+sGBjyn3lsn6I8=;
        b=BJnwSD8aKy+luMs2zp25mOU+7mcBT2QjQnl7SFmMrMBGNoTV7EInDNgiVxq1ohGWQz
         BtftcwGBGgo7Dt07ia9+S8MJj9U64qNTMiSTWsuQlFHU/e7ftAaIvSR5zlMkExmvRj97
         yGP9yFyEkb1QeSfr2nTvKT+q9Ujf5Il+ewoq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgjcUiq7Q/kVIYOW2+NCgq5Wl/YZD+sGBjyn3lsn6I8=;
        b=o8k7V3X0l5Hsk7bXne0IybSj321dn9t0Zdsr7HMNZTqCGWhSmlHS5v2GnC0TuMnyAG
         3tlcrhEy58dFBx7s0krSzRN4MWmG6f+gtuxC8E/cyrYtOBVAaYhqnR5SfxjjotagkV/A
         N1fOXxYrVruAN5+kntJPwDdmH7twvowFPOBpusrTB6F5k1sy+zXfYMTE7UKHRgwQ9zJj
         d1jEy+wQdVZf4fxd9QpzzWOCSSJUGkMHAM/eYnkWmoOxaqsQolxlG4KgS6UiNh0+GKzm
         c8Ge0OqG7RfRv1lJcP3SyV79eXbnlIKdrNkUhUlv2dPSvdQBDu0RgcBkDnseK6i2oVRk
         Z9+g==
X-Gm-Message-State: AJcUukd6tWg6ES5O5dLZCDI/JmU9ieNPkjapEaJMiXRtfsXphdj8Bq27
        grJ9tv53REaNtktTGN46ziBEKU1zLBk=
X-Google-Smtp-Source: ALg8bN5TR2l5EPYlTQCyLnuVq33oAhXeLpo1uEtpUyei2yoeMaWvpRZfbC7V23WBeYZKuozPys95MA==
X-Received: by 2002:a67:f445:: with SMTP id r5mr16874134vsn.164.1549009868243;
        Fri, 01 Feb 2019 00:31:08 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id b131sm9209428vkf.45.2019.02.01.00.31.07
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 00:31:07 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id d19so1942897uaq.11
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 00:31:07 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr16133921uac.122.1549009866601;
 Fri, 01 Feb 2019 00:31:06 -0800 (PST)
MIME-Version: 1.0
References: <000000000000784c000580b16bdd@google.com>
In-Reply-To: <000000000000784c000580b16bdd@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 1 Feb 2019 21:30:54 +1300
X-Gmail-Original-Message-ID: <CAGXu5j+TTQPGZC3QR1MzX16LT9rypAzMjm15DU39Kfz+jx-p7A@mail.gmail.com>
Message-ID: <CAGXu5j+TTQPGZC3QR1MzX16LT9rypAzMjm15DU39Kfz+jx-p7A@mail.gmail.com>
Subject: Re: general protection fault in debugfs_create_files
To:     syzbot <syzbot+a9d09761be47db706560@syzkaller.appspotmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 7:53 AM syzbot
<syzbot+a9d09761be47db706560@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=172ed528c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
> dashboard link: https://syzkaller.appspot.com/bug?extid=a9d09761be47db706560
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149209ef400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e00c2f400000

#syz fix: blk-mq: protect debugfs_create_files() from failures

-- 
Kees Cook
