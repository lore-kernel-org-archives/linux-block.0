Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6FAC4361B
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC5C22CA0
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 18:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbgLDSwP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbgLDSwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 13:52:15 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39026C061A52
        for <linux-block@vger.kernel.org>; Fri,  4 Dec 2020 10:51:29 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id x16so10145837ejj.7
        for <linux-block@vger.kernel.org>; Fri, 04 Dec 2020 10:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=i6PGv4ZUKAWV06uB1yhL9icgz9mN5bj5ndLK9GnWxk4=;
        b=ci93SS+CG6n0v7E4m7ULxrSPf6CyS56AlDA1CA3gLog8XB8KPLFjtY02DPCC+YmAP4
         NTSvdsS5QxuDfGgi/5R8/BPFPR4lAhDEO8xVX1Bls2UNztuEGA8hKBEvArcbZdlCdJ2A
         1cKBeXmpgNxN0zSk6K6LfBaBlwFOKHTjylz9QYfMs6H8yzKiS7yeBQHbV1Ag3fb5XReo
         s8+XEqToy4hKB79jSxoqC6b2K1M0P+1wHgJQhJ0VfscYwQO1UyRrGjYV5rkjGpGs+3l3
         SZoQGRluKFL7En+aVsfL2tne9XZnX12h/In1vr7/vOHoZLoST6je8O+GsYsV7c5FzIwB
         5FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=i6PGv4ZUKAWV06uB1yhL9icgz9mN5bj5ndLK9GnWxk4=;
        b=idIqFx5FX+vbeWnNxg/i7d+D4fYZRCanL6Fcor9JSihCOI5u2sk39t5V4JicB/E0ew
         v4XGuNFoVMAbtt0xKBZ3x8MYlQFalWoVa8sqqQGdZlRGsu7GE8AaZe57l0eCavcj8NLj
         P3W+W+0MaXZwSdwsj2egkBY1tT5WtO1gtE+egOcaVACmYGHE24ycsrtFI/PnZVKKFd0H
         ifHNddGaEaNseJ6qD19oaKLshur2vDBaF1zm42qClzy0nPMdb8XIF7yH7t6nA25mVe8p
         w4HeCAComj3+OvKo8G28vCoSf8zgmAsmqzGbVEdbLrNT07hug/FiNr15AI7Tbzk8x05p
         Oycg==
X-Gm-Message-State: AOAM531ecZJLXYt0aKINs9UlaUm2zcA7UZwvlQ3GxYpuqVo9IhnDB/hB
        90oB9+GamVKzAHfCrsRHxSOcNb3S7dfqJTWwOlP9REXOsUBexGSm
X-Google-Smtp-Source: ABdhPJwYRfoc/E4oLYnRcv+D4dfKVOGaL668JMsf1AKzUeQ8rQO0PcEq3B1noPj2MzArOpC8sYGsrjVD7IMkxypyHA4=
X-Received: by 2002:a17:906:2ec3:: with SMTP id s3mr8195458eji.133.1607107887772;
 Fri, 04 Dec 2020 10:51:27 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 5 Dec 2020 00:21:16 +0530
Message-ID: <CA+G9fYvGeHv-iPy2J3tdYGfr1A7ZuUrZystuQ9tDxV7vbP8iPg@mail.gmail.com>
Subject: BUG: KCSAN: data-race in dec_zone_page_state / write_cache_pages
To:     linux-mm <linux-mm@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

LKFT started testing KCSAN enabled kernel from the linux next tree.
Here we have found BUG: KCSAN: data-race in dec_zone_page_state /
write_cache_pages

This report is from an x86_64 machine clang-11 linux next 20201201.
Since we are running for the first time we do not call this regression.

[   45.484972] BUG: KCSAN: data-race in dec_zone_page_state / write_cache_pages
[   45.492030]
[   45.493532] read-write (marked) to 0xffffd4e284455380 of 8 bytes by
task 269 on cpu 0:
[   45.501453]  write_cache_pages+0x270/0x6a0
[   45.505560]  generic_writepages+0x63/0xa0
[   45.509582]  blkdev_writepages+0xe/0x10
[   45.513429]  do_writepages+0x79/0x140
[   45.517096]  __writeback_single_inode+0x6d/0x390
[   45.521714]  writeback_sb_inodes+0x4fd/0xbe0
[   45.525986]  wb_writeback+0x42e/0x690
[   45.529652]  wb_do_writeback+0x4d2/0x530
[   45.533578]  wb_workfn+0xc8/0x4a0
[   45.536897]  process_one_work+0x4a6/0x830
[   45.540908]  worker_thread+0x5f7/0xaa0
[   45.544661]  kthread+0x20b/0x220
[   45.547893]  ret_from_fork+0x22/0x30
[   45.551471]
[   45.552963] read to 0xffffd4e284455380 of 8 bytes by task 499 on cpu 2:
[   45.559576]  dec_zone_page_state+0x1d/0x140
[   45.563764]  clear_page_dirty_for_io+0x2ab/0x3a0
[   45.568382]  write_cache_pages+0x388/0x6a0
[   45.572480]  generic_writepages+0x63/0xa0
[   45.576495]  blkdev_writepages+0xe/0x10
[   45.580334]  do_writepages+0x79/0x140
[   45.584000]  __filemap_fdatawrite_range+0x155/0x190
[   45.588880]  file_write_and_wait_range+0x51/0xa0
[   45.593498]  blkdev_fsync+0x45/0x70
[   45.596991]  __x64_sys_fsync+0xda/0x120
[   45.600830]  do_syscall_64+0x3b/0x50
[   45.604409]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   45.609460]
[   45.610950] Reported by Kernel Concurrency Sanitizer on:
[   45.616259] CPU: 2 PID: 499 Comm: mkfs.ext4 Not tainted
5.10.0-rc6-next-20201201 #2
[   45.623908] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018

metadata:
    git_repo: https://gitlab.com/aroxell/lkft-linux-next
    target_arch: x86
    toolchain: clang-11
    git_describe: next-20201201
    download_url: https://builds.tuxbuild.com/1l8eiWgGMi6W4aDobjAAlOleFVl/

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/2002643#L1866

-- 
Linaro LKFT
https://lkft.linaro.org
