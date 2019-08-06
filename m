Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90A1C31E40
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 22:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AB821874
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 22:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N+N2WWOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfHFWjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:39:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46187 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfHFWjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Aug 2019 18:39:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so38414822plz.13
        for <linux-block@vger.kernel.org>; Tue, 06 Aug 2019 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DIpHTKWjD4rF/KJrRuSkwHeOUpaLVVDIAggz3LoXJms=;
        b=N+N2WWOptMgDNYTYkzTbcV47a9wPJ1n1/idslwNMmF4/tunvjufQbJtkdQJvLQfy5P
         7jFvHwayOjWOUIIEegAPOuDrnw/fJNs2FF/X62PNS5evAi+6c4G1Df9ADYSuHxB5tfn7
         NnyebRDEkTWpS5eci438g80RQAqqmxJsL3ttoyi5+1nckv0CwQLy/23T9wpwVnwUml7H
         9zgAnfsbBQIjG9RGFeyQbI2r04Top8OUG86uWR+B5WJ91hEP6SsHck0k+oTAY1cTQNmu
         XDPtkGmZEMGGBOT3WCB0aqGqCh4KBmIqvDs3bx8isEM1UPvbmtHfwIdHd1Lg/J7/j49a
         K0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DIpHTKWjD4rF/KJrRuSkwHeOUpaLVVDIAggz3LoXJms=;
        b=qUiXDLkwBaHE5cLhNVcmKrs7monmO+a0oJ/UcBoASO+XizX9tPohn2qtJvuGxJ0q4d
         FPzaC0TG6tWjW12yxbL9jsBvnhI4pwv/ntRMikFeFGjqKOdybIqTpNhrOBnfTBxY7vCS
         jFe79Oz2qfNc1Jjzz9o6y/e05Wv6QMbPeCRdkv8ZX3hVBObvFVbTWVT7DbsKZo3k+QP6
         ZWQFQqsvfD6xqdF4l1TrURzVxuwWbAR0oe2ASlMd5mrkNSguPaUmO5ySlnIxmJIZc8on
         d0M0tEOu/kGLbUog8LlEXqo7zZkiOVAgOJxgB+0zGPA4EmowoEbbfB95md/x3/dHmiq8
         YvRQ==
X-Gm-Message-State: APjAAAXRAMRch3TLPxFfxHrMPJvFOnN0hNM1bTkcJUXW0SO+3cV25h1S
        wtOoitS3b+cL1z4MLkM10HvrQD440NHDzQ==
X-Google-Smtp-Source: APXvYqz6Oz3jiqEmfuZp9KTeQL2O1NALaEdQDSAjpvH9fuXBTRbDtV4rjJfzyiy2z3EoqFMfsQNvlQ==
X-Received: by 2002:a17:902:1e6:: with SMTP id b93mr5198362plb.295.1565131157719;
        Tue, 06 Aug 2019 15:39:17 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:ed52:95d0:ca21:f42b? ([2605:e000:100e:83a1:ed52:95d0:ca21:f42b])
        by smtp.gmail.com with ESMTPSA id q198sm91525702pfq.155.2019.08.06.15.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 15:39:16 -0700 (PDT)
Subject: Re: WARNING: refcount bug in blk_mq_free_request (2)
To:     Keith Busch <kbusch@kernel.org>,
        syzbot <syzbot+f4316dab9d4518b755eb@syzkaller.appspotmail.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <000000000000d0df7f058f625d13@google.com>
 <20190806154313.GC24030@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8663d0d5-f643-ae20-7c1f-446e165c49d2@kernel.dk>
Date:   Tue, 6 Aug 2019 15:39:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806154313.GC24030@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/19 8:43 AM, Keith Busch wrote:
> On Mon, Aug 05, 2019 at 10:52:07AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    e21a712a Linux 5.3-rc3
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10cf349a600000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
>> dashboard link: https://syzkaller.appspot.com/bug?extid=f4316dab9d4518b755eb
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117a1906600000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aa11aa600000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+f4316dab9d4518b755eb@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> refcount_t: underflow; use-after-free.
>> WARNING: CPU: 1 PID: 16 at lib/refcount.c:190 refcount_sub_and_test_checked
>> lib/refcount.c:190 [inline]
>> WARNING: CPU: 1 PID: 16 at lib/refcount.c:190
>> refcount_sub_and_test_checked+0x1d0/0x200 lib/refcount.c:180
>> Kernel panic - not syncing: panic_on_warn set ...
>> CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.3.0-rc3 #98
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>    __dump_stack lib/dump_stack.c:77 [inline]
>>    dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>>    panic+0x2dc/0x755 kernel/panic.c:219
>>    __warn.cold+0x20/0x4c kernel/panic.c:576
>>    report_bug+0x263/0x2b0 lib/bug.c:186
>>    fixup_bug arch/x86/kernel/traps.c:179 [inline]
>>    fixup_bug arch/x86/kernel/traps.c:174 [inline]
>>    do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
>>    do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
>>    invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1026
>> RIP: 0010:refcount_sub_and_test_checked lib/refcount.c:190 [inline]
>> RIP: 0010:refcount_sub_and_test_checked+0x1d0/0x200 lib/refcount.c:180
>> Code: 1d 7e b3 64 06 31 ff 89 de e8 9c a3 35 fe 84 db 75 94 e8 53 a2 35 fe
>> 48 c7 c7 80 02 c6 87 c6 05 5e b3 64 06 01 e8 18 15 07 fe <0f> 0b e9 75 ff
>> ff ff e8 34 a2 35 fe e9 6e ff ff ff 48 89 df e8 b7
>> RSP: 0018:ffff8880a990fbb0 EFLAGS: 00010286
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: 0000000000000100 RSI: ffffffff815c3ba6 RDI: ffffed1015321f68
>> RBP: ffff8880a990fc48 R08: ffff8880a9900440 R09: ffffed1015d24101
>> R10: ffffed1015d24100 R11: ffff8880ae920807 R12: 00000000ffffffff
>> R13: 0000000000000001 R14: ffff8880a990fc20 R15: 0000000000000000
>>    refcount_dec_and_test_checked+0x1b/0x20 lib/refcount.c:220
>>    blk_mq_free_request+0x3b8/0x580 block/blk-mq.c:524
>>    __blk_mq_end_request block/blk-mq.c:550 [inline]
>>    blk_mq_end_request+0x456/0x560 block/blk-mq.c:559
>>    nbd_complete_rq+0x42/0x50 drivers/block/nbd.c:322
>>    blk_done_softirq+0x2fe/0x4d0 block/blk-softirq.c:37
>>    __do_softirq+0x262/0x98c kernel/softirq.c:292
>>    run_ksoftirqd kernel/softirq.c:603 [inline]
>>    run_ksoftirqd+0x8e/0x110 kernel/softirq.c:595
>>    smpboot_thread_fn+0x6a3/0xa40 kernel/smpboot.c:165
>>    kthread+0x361/0x430 kernel/kthread.c:255
>>    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..
> 
> It looks like ndb's timeout handler may complete the same request twice:
> first via ndb_config_put()->ndb_clear_sock(), then again explicitly
> through a direct call to blk_mq_complete_request().

Adding Josef.

-- 
Jens Axboe

