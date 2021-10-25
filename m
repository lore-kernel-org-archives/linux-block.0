Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CF3C433FE
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 13:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCB360FE8
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 13:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhJYNi1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhJYNi1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 09:38:27 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A1DC061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 06:36:04 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id a17-20020a4a6851000000b002b59bfbf669so3657078oof.9
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dmWGSJIsWb+aOhh0t3aM9irYHyVwx9PbhT/vqJqSCww=;
        b=LglnzvaS+9x5eDFBfxX3Ns+bJmd4gGKGOjU0AyidUv3GKPGIAC7emhNnlUqR0Rd8ze
         MK36DBH0zCFVf/itOZsmxIRI3Pvj7sa3fwp2BmGrbGOnuchOydTb52M+WSYAfUJMis1K
         ss/kAmtT8NBDtXI7HXXUyVYy6TLq/1SY9I82KCNaVNp7dsaL5frhYLUBzPwpED1VrzYZ
         5bvJZCY/utf4LZSvu/IDw7RtLo8xKnS+oWLGvAGj9izV/DR7zz7mIkfRh4iv7gLZgNDm
         blOERQpo/DibDiCjYeRSIax9duJBCbnmenDEw5rxOoaeT/l6GbZfPKhNBOnMXO8Uwlv/
         7VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dmWGSJIsWb+aOhh0t3aM9irYHyVwx9PbhT/vqJqSCww=;
        b=pkSOavDCocLCUByK3n2tZTsHEn9gcvJ0n//I3Dp7lxfggjxFNZ0vQdBF8IBLK+Ty++
         qkZz26em+gxf6Ei9UKVrF7Z41pze9h4YpORlG+lKmlf3hz+ZEprJqz/8DE8zQci4V8vG
         6jI60hzq41zUyoEbV5G3YHpfwcxjDNUQ/fzdk1urQpMljHYK2KDSeGkLwGbMwkUesqx+
         XSY7DwJOvvZ9rOAcc31A1H72eWrlliKnWVEz27JGnviL4vhZqcoTpK/wu1RXRNwl5Qre
         8nXrL/xvIfVKtQDJOSM8oE+6FAoWVroVIY0Az8FzpF4ATvyZPQ72uQdEedqkD98XOKa0
         ZA6Q==
X-Gm-Message-State: AOAM5338kfR/K6KHKu+GXhPRhB7ABaFm4ZGsWGFw5pvfjT//4SK7HI64
        0MHN5jT+pFzTUQ+uPtQSKECShA==
X-Google-Smtp-Source: ABdhPJz1xo+TzaHfm3pkLhyBFd5zEZY2L2UdL2gRpvW7tQVkwfkm2gcP3YuM9jlqSMVVY6Zjgqj9cw==
X-Received: by 2002:a4a:dfdb:: with SMTP id p27mr12147573ood.70.1635168964117;
        Mon, 25 Oct 2021 06:36:04 -0700 (PDT)
Received: from ?IPv6:2600:380:6060:12a6:721f:26e:6f8:a9aa? ([2600:380:6060:12a6:721f:26e:6f8:a9aa])
        by smtp.gmail.com with ESMTPSA id w16sm3534007oti.3.2021.10.25.06.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 06:36:03 -0700 (PDT)
Subject: Re: [syzbot] KCSAN: data-race in sbitmap_queue_clear /
 sbitmap_queue_clear (3)
To:     syzbot <syzbot+4f8bfd804b4a1f95b8f6@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000089871905cf2b7d09@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f37aa186-8820-451f-6fa2-eee45799a428@kernel.dk>
Date:   Mon, 25 Oct 2021 07:35:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000089871905cf2b7d09@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/21 5:16 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2f111a6fd5b5 Merge tag 'ceph-for-5.15-rc7' of git://github..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10dae330b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b2868748300e5cf6
> dashboard link: https://syzkaller.appspot.com/bug?extid=4f8bfd804b4a1f95b8f6
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4f8bfd804b4a1f95b8f6@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in sbitmap_queue_clear / sbitmap_queue_clear
> 
> write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 1:
>  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
>  blk_mq_put_tag+0x82/0x90
>  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
>  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
>  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
>  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
>  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
>  blk_complete_reqs block/blk-mq.c:584 [inline]
>  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
>  __do_softirq+0x12c/0x26e kernel/softirq.c:558
>  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
>  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
>  kthread+0x262/0x280 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30
> 
> write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 0:
>  sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
>  blk_mq_put_tag+0x82/0x90
>  __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
>  blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
>  __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
>  blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
>  lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
>  blk_complete_reqs block/blk-mq.c:584 [inline]
>  blk_done_softirq+0x69/0x90 block/blk-mq.c:589
>  __do_softirq+0x12c/0x26e kernel/softirq.c:558
>  run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
>  smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
>  kthread+0x262/0x280 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30

This is just a per-cpu alloc hint, it's racy by nature. What's the
preferred way to silence these?

-- 
Jens Axboe

