Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0ADC433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 08:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E3F61A45
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 08:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCZIgS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 04:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCZIfw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 04:35:52 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CC3C0613AA;
        Fri, 26 Mar 2021 01:35:51 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g38so5039975ybi.12;
        Fri, 26 Mar 2021 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CO4gZbxFyIsBp6fDq1sKand42JKRkUpqVJji7diN+V8=;
        b=RkfWe8t1cmxtlxZKbEd0kDtJCDkZlVC8UjQHdq4X2ZQjUPiibMVWt62ER1Kb+xPe0V
         N6/uabHDVsNyWbKrMBdzG1G+8dq8eSHJrE5IyG+7Bc6hksxLh6Uh81DZWkMiUD7uYHuu
         PyZt/XLN1ebLFCMtrBOLC7tMD3Mg7ZLfv6Hmm9qw3JNwJwkp4qo1iy8XmvduyPpvZcjS
         rhE22UYjCtNX25Ze9rt8n5sPcj0rzzDY22EjKL9TLMhS1WPNoAMVvpUJub1Ru0ADNJxL
         0py2kT2w/5sv1XEXrs1aofRuR8o1Ihcfq4aLM2A5vYi16JasjHJD81lRs/WT2cPIAP/r
         F8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CO4gZbxFyIsBp6fDq1sKand42JKRkUpqVJji7diN+V8=;
        b=ifWso9vUvUu6pG2D8PpsukPBqpjCR5VUbngozYG3wNm1Miojxb+nMQJOxuzQ976mrH
         uso5AmpzUcMWfLhsBaj+t1kXFAPS5bUmMaU0SkBj1newga1UcYZBi0ZBRR6v3RguTszL
         qMGkrX5hIi3PFWYv32dihWJxwv9SKvGsS4Zb2NA6MYLdVGyfQvYZIlx5aQzuU7yW/+KS
         8X0/bu9aYSKwXDmv7QnaCAPP8ULdCstkgHKYLeOpFwTkXI7eOGlPxKax3JOiAg1fZcVj
         9ynf2KPWW6DTFE9u0sZgedUd5Pi3D7PkNMZydEmr1Rlx+nvMbHUP7IwGEzZ/nsuxRJzy
         Isog==
X-Gm-Message-State: AOAM530GqyoklKDCtDGS8bXaadS1Ah2CYRVdvSvtvO4CvtqaNfA0fXEM
        HV/YY7BDh80xW6+4kNVBrt+Dv01j+xfsXA6FW0M=
X-Google-Smtp-Source: ABdhPJwTM3/lDZesWWLU4v5kz0+QC5oYDKNVR7OHeJEPnIurqnJKIzMCfTbYAkxbIB2i/Ba39xUX8lhECouORuQatrs=
X-Received: by 2002:a25:25d0:: with SMTP id l199mr18601780ybl.337.1616747751256;
 Fri, 26 Mar 2021 01:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000053da9405bd7d2644@google.com>
In-Reply-To: <00000000000053da9405bd7d2644@google.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 26 Mar 2021 16:35:40 +0800
Message-ID: <CACVXFVMf9n8bHP8ZTx74bBqoKRFHbPPLSBkvmdaV50xXwNKC1A@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
To:     syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 14, 2021 at 7:10 PM syzbot
<syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    280d542f Merge tag 'drm-fixes-2021-03-05' of git://anongit..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15ade5aed00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=952047a9dbff6a6a
> dashboard link: https://syzkaller.appspot.com/bug?extid=8fede7e30c7cee0de139

#syz test: https://github.com/ming1/linux.git v5.12-block-test
