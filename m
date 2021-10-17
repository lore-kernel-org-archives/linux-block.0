Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F014CC433F5
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 22:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE43F61050
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 22:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbhJQWF4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344736AbhJQWFx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 18:05:53 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F394BC06161C
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 15:03:42 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id k3so2547759ilo.7
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=a++EeukHLheQaAyV9/MPOEWxfhGKeLO2fJxeA799MI4=;
        b=jwJaAxsXFjwSP9UUxCP1mNsBL/gJb9sYYNvz5Ea+bTYp7ChX2i3tdiv+CqnhYjXXXS
         tTwP6yqC+DoROopr4qAtgTtuFRt8ghWv+YKvOTF3fkMKncljBicmVC6vktwaGO3URorI
         rLAgl/Kl7yTtdmDVd22SJBNc80ZcAjuErGh9rez1oFFB6KeW++7qbFH0z2X2H/4yU4Oh
         01ZgR98FaruE/K0o5j0EYO0NRjPC/sGl0OLimCpA1EjEuYPxKWK8dhfIZYzJEt1f/Ca4
         dbtcpd2QF1lg3ESVEG3+vr5C0qaHpEh/h4s16qkICJZt6UcWv3EhDJJctkNk9Qb9SWKj
         UEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a++EeukHLheQaAyV9/MPOEWxfhGKeLO2fJxeA799MI4=;
        b=5NnuillGWmfSxi10nCgHAH2cgbO2ddHD99AtcBVYRpTTdwI6mRajOKOAN4RFOzTmz/
         7fJv0FqOLBxp4L8K7YIH2rW3rCwSEdNpHryj7v0v5HctlDlepwmuIPofO+GFRZUprxC+
         8PkY9nbd1H2bPg75mACCe1//ZMRrqGwdStHaTAaVjmbw8ilNpWAimR+sfzLeO4L1hXn4
         JlvoJuhgPh3CjPQNUVNLy6LVI4C31mZPyIWLsvzTJLB5e5YeKD6KwS+CqQujwiZn7myx
         XfsGlVuOGJEWz1a6ueZlyGIvfuoe6lt0xSc51rqv3CLC8t92DANKeuzoVNSxZxCVUGOA
         JjDQ==
X-Gm-Message-State: AOAM530FGXCcN5u0YPbZYkoG2CcOg0k2rOG8PHQnewZQKjAlBHHPsaPc
        m3HuEJY+ezBKmzmIlbzq4IwfEQ==
X-Google-Smtp-Source: ABdhPJwHjzRFKzWFufectUTBvQGlekfLU+TiHjM9a01CoVk+ADLcYFEtLHi2xTK9v13yo1I2StXLSg==
X-Received: by 2002:a05:6e02:1d1e:: with SMTP id i30mr12174005ila.248.1634508222329;
        Sun, 17 Oct 2021 15:03:42 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i15sm6080256ilb.30.2021.10.17.15.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 15:03:40 -0700 (PDT)
Subject: Re: [syzbot] general protection fault in hctx_lock
To:     syzbot <syzbot+005b78d4c45263d656dd@syzkaller.appspotmail.com>,
        hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000c7c18505ce93467e@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23531d29-9d96-6744-bab9-797e65379037@kernel.dk>
Date:   Sun, 17 Oct 2021 16:03:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000c7c18505ce93467e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/21 3:40 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7c832d2f9b95 Add linux-next specific files for 20211015
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10e9df10b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f6ac42766a768877
> dashboard link: https://syzkaller.appspot.com/bug?extid=005b78d4c45263d656dd
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1154f80cb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1750eeecb00000
> 
> The issue was bisected to:
> 
> commit f328476e373a7ce4b4d16c48fe85571044e025f5
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Tue Oct 12 10:40:45 2021 +0000
> 
>     blk-mq: cleanup blk_mq_submit_bio

It's a potential use-after-free using rq->mq_hctx after inserting a flush.
I'll fold in a fix, as I'm shuffling things around anyway.

-- 
Jens Axboe

