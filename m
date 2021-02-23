Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB1FC433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 03:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CA764E41
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 03:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBWDHO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 22:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhBWDHN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 22:07:13 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F06C061574
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 19:06:32 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id w36so9084820lfu.4
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 19:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3N9kYcLkqfFG5m6tp7UOFAPCxZxPf7JdbEB+PPgAJAM=;
        b=EdbrEwmyBqbrJgBShwPaBQilzQWWJ373gpmnVz7Ag68vo+t6ZFjFf1ksZh6KUtsVQw
         rrpupv4xvfgmgK4bUBcHEoyTtiq3semakajriwtgXEUj+f8srO/27P9O/9L6YhqwskjW
         uqsKTp5QVa9ZV8UH476RLOZtKDWQsD1tVRY4LOZ5lhT8Ys9lbNO7ESQMDzTeiT5bEOdk
         RUgqRAU8VmLpEXfWcRULspqIcF7c/mdQY/Op2DLLsBzayglDis/tv2vR4hP6p/F8Ogba
         DIwgHytu4vf1X/bP6MRIXAuKrnJkXnSq3yUZJu0wj78nMQ2PdIjdiHhiHQ9fFItZjdYL
         E8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3N9kYcLkqfFG5m6tp7UOFAPCxZxPf7JdbEB+PPgAJAM=;
        b=dIo5N1GH+iqHItQvbs5XoAduj8e3w4STmoR/aIr1O5N2irpIINY14eCPnvesFJhFP9
         iLamd+YMF4IcB1GR2Sniev6vjAV5Py9EMQduqXmd2KLzrGbBVKJl5r+Yk3vUXJIEWQEO
         78Xxe7aH45w7Vqpqk2ZvI6/4eFHp5gIKsMWLzPLJP1Sd2Aym2HxqDIMji8JTm+QPYdSM
         8+Sm2h7CD3N4dXLOYeY8POSj3Vs/BuTfsDdrhSCbwASzgXjMf2k+0RUl7YQow252ZJZj
         o24M/qgMtDsWac3lPvcEibMb/373Ni+t3r9BtuJ0jeVLYYRrIQ3OPmCcx0/uL2oGHHUN
         j2OA==
X-Gm-Message-State: AOAM531vwf//vYJXexVGZG6ifkyScfSfru3UuKZao2M+tmebvz2f3tIK
        TJl9QpSoMAEm7tGYcnJriFwv5aWTBItULPBhnvB1gA==
X-Google-Smtp-Source: ABdhPJxhBNx0Bmw11SoB87ONVStavxZNMn2xTvIgWsaSjW0cmpm0at4pyiOBiBGaTGzdbEl+e1f27zpPxLk7kdcH6W8=
X-Received: by 2002:a19:9c5:: with SMTP id 188mr14569247lfj.626.1614049591234;
 Mon, 22 Feb 2021 19:06:31 -0800 (PST)
MIME-Version: 1.0
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 22 Feb 2021 19:06:18 -0800
Message-ID: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
Subject: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing crash
 shortly after bootup
To:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>
Cc:     Alistair Delva <adelva@google.com>, Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey all,
  In testing Linus' HEAD today I found another[1] regression in the block merge.

This time I see a crash on my hikey960 board shortly after booting
ASOP. See the log below.

I bisected the issue down to "block: split bio_kmalloc from bio_alloc_bioset":
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3175199ab0ac8c874ec25c6bf169f74888917435

But unfortunately that does not revert cleanly against Linus' HEAD.

It seems like the issue is that the function is no longer handling the
case where the bio_set *bs is NULL as is done here:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/blk-crypto-fallback.c#n230

If there's anything I can do to help debug this issue, please let me know!

thanks
-john

[1]: "add a disk_uevent helper" also was giving me trouble as reported here:
https://lore.kernel.org/lkml/CALAqxLU3B8YcS_MTnr2Lpasvn8oLJvD2qO4hkfkZeEwVNfeHXg@mail.gmail.com/


[   34.600558] Unable to handle kernel read from unreadable memory at
virtual address 0000000000000068
[   34.609819] Mem abort info:
[   34.612644]   ESR = 0x96000005
[   34.615707]   EC = 0x25: DABT (current EL), IL = 32 bits
[   34.621157]   SET = 0, FnV = 0
[   34.624288]   EA = 0, S1PTW = 0
[   34.628312] Data abort info:
[   34.631236]   ISV = 0, ISS = 0x00000005
[   34.635222]   CM = 0, WnR = 0
[   34.638186] user pgtable: 4k pages, 39-bit VAs, pgdp=000000000774f000
[   34.644639] [0000000000000068] pgd=0000000000000000,
p4d=0000000000000000, pud=0000000000000000
[   34.653381] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[   34.658954] Modules linked in:
[   34.662007] CPU: 0 PID: 173 Comm: kworker/u16:3 Not tainted
5.11.0-04196-ga8e8932e4ae #559
[   34.670270] Hardware name: HiKey960 (DT)
[   34.674190] Workqueue: writeback wb_workfn (flush-8:48)
[   34.679429] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
[   34.685435] pc : bio_alloc_bioset+0x14/0x230
[   34.689720] lr : bio_clone_fast+0x28/0x80
[   34.693728] sp : ffffffc012a13530
[   34.697036] x29: ffffffc012a13530 x28: 0000000000003400
[   34.702351] x27: 0000000000000000 x26: ffffff8001993040
[   34.703203] dwmmc_k3 ff3ff000.dwmmc2: Unexpected interrupt latency
[   34.707662] x25: 0000000000000001 x24: ffffff8001fc8800
[   34.719145] x23: ffffffffffffffff x22: ffffffc012a137e8
[   34.724456] x21: 0000000000000c00 x20: ffffff8001fc8800
[   34.729767] x19: 0000000000000800 x18: fffffffe013efe80
[   34.735078] x17: 0000000000000068 x16: fffffffe012aa440
[   34.740389] x15: 0000000000001000 x14: ffffff8001fc8800
[   34.745700] x13: ffffff805c3e4000 x12: 00000000001ce000
[   34.751009] x11: 00000000000000fb x10: 0000000000001000
[   34.756320] x9 : 0000000000000033 x8 : 00000000000d9000
[   34.761631] x7 : 0000000000000000 x6 : 000000000000a000
[   34.766941] x5 : 0000000000000c00 x4 : 0000000000001000
[   34.772251] x3 : 0000000000000000 x2 : 0000000000000000
[   34.777561] x1 : 0000000000000000 x0 : 0000000000000c00
[   34.782873] Call trace:
[   34.784901] ueventd: LoadWithAliases was unable to load platform:regulatory
[   34.785313]  bio_alloc_bioset+0x14/0x230
[   34.796189]  bio_clone_fast+0x28/0x80
[   34.799848]  bio_split+0x50/0xd0
[   34.803072]  blk_crypto_fallback_encrypt_bio+0x2ec/0x5e8
[   34.808384]  blk_crypto_fallback_bio_prep+0xfc/0x140
[   34.813345]  __blk_crypto_bio_prep+0x13c/0x150
[   34.817784]  submit_bio_noacct+0x3c0/0x548
[   34.821880]  submit_bio+0x48/0x200
[   34.825278]  ext4_io_submit+0x50/0x68
[   34.828939]  ext4_writepages+0x558/0xca8
[   34.832860]  do_writepages+0x58/0x108
[   34.836522]  __writeback_single_inode+0x44/0x510
[   34.841137]  writeback_sb_inodes+0x1e0/0x4a8
[   34.845404]  __writeback_inodes_wb+0x78/0xe8
[   34.849670]  wb_writeback+0x274/0x3e8
[   34.853328]  wb_workfn+0x308/0x5f0
[   34.856726]  process_one_work+0x1ec/0x4d0
[   34.860734]  worker_thread+0x44/0x478
[   34.864392]  kthread+0x140/0x150
[   34.867618]  ret_from_fork+0x10/0x30
[   34.871197] Code: a9ba7bfd 910003fd f9000bf3 7900bfa1 (f9403441)
[   34.877289] ---[ end trace e6c2a3ab108278f0 ]---
[   34.893636] Kernel panic - not syncing: Oops: Fatal exception
