Return-Path: <SRS0=exTe=U7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FACC06510
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 16:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7922082F
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 16:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfGBQBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:01:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42412 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBQBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 12:01:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so595442plb.9;
        Tue, 02 Jul 2019 09:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SW2KCspeft8VbkNrb1bXHhZJO5zB/ZyN0RFjcBu6s8o=;
        b=lWntlNs6JRlW3zD6WV3jJlFWelqlnUp+toxQTeqYI2O038DhhjdmP6KeSgCVHI1m7m
         ++sPznkrOo0piaxJyAR8nBKSu/+x9B0MaLEaZ7ge1m4U4BRx13nHqZpRx49+uz0taRDB
         kL1NaPqIWdfDAPg9Pvl/NqEKCmH1g6Px4tITvhyU1gOm7hygL+2mSXj0eseb5/FUh1Lm
         5GDlxedT85VCCzT0oN5oayNIezaCxdFYs5OcFZZtbA9tlA3GiSC+sFeDHGFoqrBlPXW9
         Dn3Hj2xsoYE4qGn+2Pi8JfxjI4bXRt3E3PYfhOs/polloP8fxF6ONShsSNuG39rm1rKn
         z87w==
X-Gm-Message-State: APjAAAXcFGlqhaTIxU801Odt8BNdSpcUG0Rgg1l5/hLQeMjY1tQUMK+v
        YLT5nIJnWlA7vp71Yoi1EZE=
X-Google-Smtp-Source: APXvYqyHiegsC8VoMu/i/mZZOipM9Wo1gsNDjD6zACvWVF4MEDNMbJgh/wlOaAmIgZeRIZhabrtE0g==
X-Received: by 2002:a17:902:1e6:: with SMTP id b93mr36020282plb.295.1562083272888;
        Tue, 02 Jul 2019 09:01:12 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id q198sm22380266pfq.155.2019.07.02.09.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 09:01:11 -0700 (PDT)
Subject: Re: INFO: task hung in blkdev_issue_flush (2)
To:     syzbot <syzbot+e7624af9c1ef3b617512@syzkaller.appspotmail.com>,
        axboe@kernel.dk, idryomov@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, sagi@grimberg.me, snitzer@redhat.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        wgh@torlan.ru, zkabelac@redhat.com
References: <0000000000009c93d5058cb46073@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6a853698-6244-7c4e-77cd-73e4fd672376@acm.org>
Date:   Tue, 2 Jul 2019 09:01:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <0000000000009c93d5058cb46073@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/19 8:27 AM, syzbot wrote:
> Showing all locks held in the system:
> 1 lock held by khungtaskd/1043:
>   #0: 00000000f7c610b3 (rcu_read_lock){....}, at: 
> debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5149
> 2 locks held by rsyslogd/8451:
>   #0: 00000000dfc1566f (&f->f_pos_lock){+.+.}, at: 
> __fdget_pos+0xee/0x110 fs/file.c:801
>   #1: 0000000054220207 (&rq->lock){-.-.}, at: rq_lock 
> kernel/sched/sched.h:1168 [inline]
>   #1: 0000000054220207 (&rq->lock){-.-.}, at: __schedule+0x1f5/0x1560 
> kernel/sched/core.c:3397
> 2 locks held by getty/8541:
>   #0: 000000004ff543bd (&tty->ldisc_sem){++++}, at: 
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 000000002a3905f3 (&ldata->atomic_read_lock){+.+.}, at: 
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8542:
>   #0: 000000006e67fcec (&tty->ldisc_sem){++++}, at: 
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 00000000ee71e4f3 (&ldata->atomic_read_lock){+.+.}, at: 
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8543:
>   #0: 00000000bd0907a0 (&tty->ldisc_sem){++++}, at: 
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 000000000876abce (&ldata->atomic_read_lock){+.+.}, at: 
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8544:
>   #0: 00000000710d6f7d (&tty->ldisc_sem){++++}, at: 
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 00000000af289586 (&ldata->atomic_read_lock){+.+.}, at: 
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8545:
>   #0: 000000003399e62d (&tty->ldisc_sem){++++}, at: 
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 00000000ee97f91a (&ldata->atomic_read_lock){+.+.}, at: 
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8546:
>   #0: 00000000ff2274c6 (&tty->ldisc_sem){++++}, at: 
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 00000000b96c5a9f (&ldata->atomic_read_lock){+.+.}, at: 
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
> 2 locks held by getty/8547:
>   #0: 000000005165f028 (&tty->ldisc_sem){++++}, at: 
> ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
>   #1: 00000000e89d5b4a (&ldata->atomic_read_lock){+.+.}, at: 
> n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156

Since the tty layer does not call any block layer code, does this mean 
that the root cause is in the tty code instead of in the block layer?

Bart.

