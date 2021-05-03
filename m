Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F79C43460
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 15:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604E961283
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 15:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhECPsC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 11:48:02 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:54235 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhECPsA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 May 2021 11:48:00 -0400
Received: by mail-pj1-f46.google.com with SMTP id p17so3353184pjz.3
        for <linux-block@vger.kernel.org>; Mon, 03 May 2021 08:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zi4uyI00rNr+GDZE8rWnfF5BEO93We/Xiia9K4ugR3w=;
        b=GdT087+o8ual0CKPNa1wL8jwp12BnLy8S6xd2RtkMpn6eIQyM0qdtMofbrde184XLB
         07L4UvYEd4vL1Ttkqxm0iaT1f9MkiiTLmO/YGCLscxsiBBK+vp/UdUAHRa4Gl7mcwtoR
         Q5D+sWqNp7FCRfo9VWbVuwTGVA/LEE1L8mZ0eKhsQNXKRGzXdE8gSpBvzSjZH73lVpL8
         rmyFmT8pd2+RHtIZ7g4wOXmDA2kB2vNkpGwJk4O8QCP8bFLPWC+8DwC3r/TQR/e0rsAo
         tvMdElAIh22L30nONq7vGfqCZtA9RSIOLLgAsvhT/ZAJ1z3D3Nik2JsAoG/zjF1Ct4nA
         W4Rg==
X-Gm-Message-State: AOAM531ov7jlTmVsbx2QCpQBGxi7sVgxYOSdsZcBd0ESU7A3kS1zQrm9
        8L17Z5hwoIEWn/hzOKywFvJRSKKd74w=
X-Google-Smtp-Source: ABdhPJxpv6S2884Z5X/xsmqLdZ3OUi+Eqqlm04FnPzWtgwi9vOjio9M//k/1m1cWPpBBco7D7UtCZg==
X-Received: by 2002:a17:902:e807:b029:ee:c73b:9fc4 with SMTP id u7-20020a170902e807b02900eec73b9fc4mr10073666plg.72.1620056826534;
        Mon, 03 May 2021 08:47:06 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:e960:31db:6b4:8ca7? ([2601:647:4000:d7:e960:31db:6b4:8ca7])
        by smtp.gmail.com with ESMTPSA id c4sm9164695pfn.48.2021.05.03.08.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 08:47:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] null_blk: poll queue support
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
Message-ID: <725ea863-c754-addf-f143-71d7e2f273de@acm.org>
Date:   Mon, 3 May 2021 08:47:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/21 8:29 AM, Jens Axboe wrote:
> There's currently no way to experiment with polled IO with null_blk,
> which seems like an oversight. This patch adds support for polled IO.
> We keep a list of issued IOs on submit, and then process that list
> when mq_ops->poll() is invoked.
> 
> A new parameter is added, poll_queues. It defaults to 1 like the
> submit queues, meaning we'll have 1 poll queue available.

Has anyone run blktests against blk-for-next since this patch got
queued? The following appears in the kernel log if I run blktests:

root[5563]: run blktests block/010
null_blk: module loaded
==================================================================
BUG: KASAN: null-ptr-deref in null_map_queues+0x131/0x1a0 [null_blk]
Read of size 8 at addr 0000000000000000 by task modprobe/5612

CPU: 7 PID: 5612 Comm: modprobe Not tainted 5.12.0-dbg+ #33
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
Call Trace:
 show_stack+0x52/0x58
 dump_stack+0x9d/0xcf
 kasan_report.cold+0x4b/0x50
 __asan_load8+0x69/0x90
 null_map_queues+0x131/0x1a0 [null_blk]
 blk_mq_update_queue_map+0x122/0x1a0
 blk_mq_alloc_tag_set+0x1c8/0x480
 null_init_tag_set+0x19c/0x220 [null_blk]
 null_init+0x1ac/0x1000 [null_blk]
 do_one_initcall+0xd3/0x460
 do_init_module+0x10a/0x400
 load_module+0xbe2/0xc50
 __do_sys_finit_module+0x131/0x1c0
 __x64_sys_finit_module+0x43/0x50
 do_syscall_64+0x3a/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f51f7fd367d
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bb f7 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd4a668728 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 00005609718ddbe0 RCX: 00007f51f7fd367d
RDX: 0000000000000000 RSI: 00005609718ddfe0 RDI: 0000000000000003
RBP: 0000000000040000 R08: 0000000000000000 R09: 000000000000003a
R10: 0000000000000003 R11: 0000000000000246 R12: 00005609718ddfe0
R13: 0000000000000000 R14: 00005609718ddd70 R15: 00005609718ddbe0
==================================================================

Thanks,

Bart.
