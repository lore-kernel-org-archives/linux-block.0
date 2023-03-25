Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A059C77B60
	for <linux-block@archiver.kernel.org>; Sat, 25 Mar 2023 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjCYNvo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Mar 2023 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjCYNvm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Mar 2023 09:51:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC1B14209
        for <linux-block@vger.kernel.org>; Sat, 25 Mar 2023 06:51:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7442773pjc.1
        for <linux-block@vger.kernel.org>; Sat, 25 Mar 2023 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679752301; x=1682344301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/Zuvcu6lFFk4lhiDCtHiJ70UT/G8eibKvgSIBf7Ncs=;
        b=Tk+o+f+in3bj+WCOGebxaIW/jdxMus+K+Fo5WFvCVk9GSGVZ4WbbgK5aef7Mw2yPmi
         mvwxN8yjVJ0zzdRExVS+YkMq+Du4xpzliSL1nVyw86+Su8yyUTdjOEJGMSNzW23gqqEu
         HynpIZks09eprueTvojPGOwBZ5tbQ49sfXOZMjJhEPo5PijYRrWT4ZHC2oMx7yxxyYoh
         I2zVeu/KNkedxsN261VFIZhmidyeZDCbNXGf0qZq091EwkxJFsk80z0xwC0xhd4ETJGd
         U6ELDoVBQQwlbJZ7wiCqtBxLbc8kJWVIJ8JwzYgU1rruf8o3J2q4L2X7JXYxWJjEcQLd
         fpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679752301; x=1682344301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/Zuvcu6lFFk4lhiDCtHiJ70UT/G8eibKvgSIBf7Ncs=;
        b=20aAamhUAex/PEXjfgxWBmPYYHb25LM58Ym4r66FMK9aaf/M9mC8EbJdQ4y+GfHs7q
         zmuFw+8sLnfdC9zd31Zzatbd7ZHH0xOF/AuaUWPAGPDckcJfzwfa9rjXDr+uOnIR0AGf
         mT3ITrt2/6dECx7wi/6/VLEhBQM3H1ZapV6agNeae5076MBL+DcehlvjKWh1irdJkQSX
         jDokTioRDBswACpjdSX/MSxjVEie2GxSQXSQWflSgAugqQXvTE5Tg5o5imUy/QWOtv+4
         vzNVmYun3pcJIUT9OL5mD0s8eSjdImQgZvRUd8zY75W+x3x/fgwuaieZihZNAjvK8kDO
         yajQ==
X-Gm-Message-State: AAQBX9eZmZRW5hTHwbnrKqC4JGp0/9UG4NlDIs5RMnJPf3I9ZjbVkN9Y
        pJkZQWhatjtx/kzpjaoeNfT0VWqFfnsVgzEjKmf0tA==
X-Google-Smtp-Source: AKy350bDZYkL5UddwxwKLLD9V8p7X7PN4lYmdubpSd/i7oGIfak+dFZ2wp/5Zr7NylK/j3v72K9BJQ==
X-Received: by 2002:a17:90a:644b:b0:233:b57f:23c5 with SMTP id y11-20020a17090a644b00b00233b57f23c5mr5392032pjm.2.1679752300614;
        Sat, 25 Mar 2023 06:51:40 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a2b0200b002349608e80csm4551019pjc.47.2023.03.25.06.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 06:51:40 -0700 (PDT)
Message-ID: <1ab303f9-b7f5-840b-d3fb-c742af033896@kernel.dk>
Date:   Sat, 25 Mar 2023 07:51:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bug report] kernel panic at _find_next_zero_bit in io_uring
 testing
Content-Language: en-US
To:     Guangwu Zhang <guazhang@redhat.com>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>
References: <CAGS2=YohS-+HDNaTfd_0xP249ewTc5ffgY+XB+kQnDQ+c_BwMg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAGS2=YohS-+HDNaTfd_0xP249ewTc5ffgY+XB+kQnDQ+c_BwMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/23 1:25 AM, Guangwu Zhang wrote:
> Hello,
> 
> We found this kernel panic issue with upstream kernel 6.3.0-rc3 and
> it's 100% reproduced, let me know if you need more info/testing,
> thanks
> 
> kernel repo : https://github.com/torvalds/linux.git
> reproducer :  run the testing from  git://git.kernel.dk/liburing
> 
> [ 1089.762678] Running test recv-msgall-stream.t:
> [ 1089.922127] Running test recv-multishot.t:
> [ 1090.231772] Running test reg-hint.t:
> [ 1090.282612] general protection fault, probably for non-canonical
> address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [ 1090.294014] KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
> [ 1090.301586] CPU: 3 PID: 36765 Comm: reg-hint.t Kdump: loaded Not
> tainted 6.3.0-rc3.kasan+ #1
> [ 1090.310035] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
> 2.16.1 08/17/2022
> [ 1090.317612] RIP: 0010:_find_next_zero_bit+0x47/0x110
> [ 1090.322603] Code: 55 48 c7 c5 ff ff ff ff 48 d3 e5 48 c1 e9 06 53
> 48 89 fb 4c 8d 2c cd 00 00 00 00 4e 8d 24 2f 4c 89 e6 48 83 ec 10 48
> c1 ee 03 <80> 3c 16 00 0f 85 9a 00 00 00 49 8b 34 24 48 f7 d6 48 21 ee
> 75 4b
> [ 1090.341358] RSP: 0018:ffff88848659fb68 EFLAGS: 00010246
> [ 1090.346601] RAX: 0000000000000010 RBX: 0000000000000000 RCX: 0000000000000000
> [ 1090.353742] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [ 1090.360882] RBP: ffffffffffffffff R08: ffff888118b22704 R09: ffff888118b22717
> [ 1090.368024] R10: ffffed10231644e2 R11: 0000000000000001 R12: 0000000000000000
> [ 1090.375167] R13: 0000000000000000 R14: ffff8884c5c1a000 R15: 0000000000000000
> [ 1090.382307] FS:  00007fd9683a6740(0000) GS:ffff88887f680000(0000)
> knlGS:0000000000000000
> [ 1090.390403] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1090.396158] CR2: 0000000000404060 CR3: 0000000486274006 CR4: 00000000007706e0
> [ 1090.403297] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1090.410439] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1090.417580] PKRU: 55555554
> [ 1090.420292] Call Trace:
> [ 1090.422748]  <TASK>
> [ 1090.424862]  __io_fixed_fd_install+0x136/0x1d0
> [ 1090.429328]  io_fixed_fd_install+0x4c/0xc0
> [ 1090.433444]  io_socket+0x282/0x3b0
> [ 1090.436866]  io_issue_sqe+0x153/0xeb0
> [ 1090.440549]  io_submit_sqes+0x41d/0xcd0
> [ 1090.444407]  __do_sys_io_uring_enter+0x4e9/0x830
> [ 1090.449044]  ? __pfx___do_sys_io_uring_enter+0x10/0x10
> [ 1090.454197]  ? __pfx___handle_mm_fault+0x10/0x10
> [ 1090.458833]  ? __pfx_mt_find+0x10/0x10
> [ 1090.462601]  do_syscall_64+0x59/0x90
> [ 1090.466196]  ? handle_mm_fault+0x1a0/0x660
> [ 1090.470311]  ? up_read+0x1c/0xb0
> [ 1090.473560]  ? do_user_addr_fault+0x313/0xeb0
> [ 1090.477935]  ? syscall_exit_work+0x103/0x130
> [ 1090.482227]  ? exc_page_fault+0x57/0xc0
> [ 1090.486084]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 1090.491153] RIP: 0033:0x402f3e
> [ 1090.494221] Code: 41 89 ca 8b ba cc 00 00 00 41 b9 08 00 00 00 b8
> aa 01 00 00 41 83 ca 10 f6 82 d0 00 00 00 01 44 0f 44 d1 45 31 c0 31
> d2 0f 05 <c3> 90 89 30 eb 99 0f 1f 40 00 8b 3f 45 31 c0 83 e7 06 41 0f
> 95 c0
> [ 1090.512975] RSP: 002b:00007ffeb6c4ee98 EFLAGS: 00000246 ORIG_RAX:
> 00000000000001aa
> [ 1090.520556] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000402f3e
> [ 1090.527697] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
> [ 1090.534830] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000008
> [ 1090.541965] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeb6c4f0a8
> [ 1090.549106] R13: 0000000000401860 R14: 0000000000406e08 R15: 00007fd9683e9000
> [ 1090.556253]  </TASK>

What Ming said, but also there's never any need to report a bug caused
by a liburing regression test, since we're the ones that make those
anyway... The only exception is if it's triggering something that
didn't trigger before, eg we've regressed. If you look at the test
case you reported, I just added that a few days ago, and its intent
is very much to trigger this bug that got fixed here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=02a4d923e4400a36d340ea12d8058f69ebf3a383

-- 
Jens Axboe


