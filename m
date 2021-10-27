Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDB4C433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 01:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5B61039
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 01:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhJ0BQP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 21:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhJ0BQP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 21:16:15 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5AC061570
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 18:13:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so1310133ote.8
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 18:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XTzCIFbbWHgBRTNDHOQfYs5/FYOOoAIhpY0q6kfq4fA=;
        b=hVU7T8PfzhsM129Q1Yeq5wQnnQRIGeFjd0dMnNadmAWrg2czHvkXvzqxz6OCYR1qhI
         n8qaW635EcWqtJ2DtXAzG2gV3F/1D2dRDCy9Gb0hDCDFgSty/58dZW4C2J44YLWJjSU2
         vtxeQRSb1rlSYnWqxQLtzDGiRZ5eGznVwXQJOzIZzh+zXp6xwWGzJJ7Q1TvCbsYRD4Hh
         DWYQhcjl8MiAJrKhT2HfpKgl+yNCoJNFtFnEq8+5XNoVYePK1NgJbynDqy4CXpJJPuOC
         3l1f1b8rKlFTZ2/QMzDcTAQ+yNvN1B1hZrJmQTZoTPl+z69bFDqxn69Trrhj0UoF57UI
         wX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XTzCIFbbWHgBRTNDHOQfYs5/FYOOoAIhpY0q6kfq4fA=;
        b=SfPIX0fI8wRPGXdFR5ZZbTPH52QYuo+ykKEs+w4UHT2WZfly1BI99hlV7SBfcx10M6
         5uLRBrTuL9rSBeHIgLa43RH7Us8ro/REq18GP+CiasYeddYK0SDQWutFDY0lULpL4paJ
         e3rvIVqKBOx8Ngd013KzEeqCxCrTAM1C0Q+HTU1EzimnhGYSKRvxvXbYbKRw2sUyxEuo
         L+tOKl+GhnTsQVlRdCvKO+oW2s3NheKeFhb+MfGhgxSwX5eQU1PypPwLIkE7fBJ8Tske
         2fjeNVHPfLp2HVBpAXZ3+NvJY4IUixWJT1ckGYO3Ynvrh0kvmXLafvBBe537c2Pl6LR2
         OaUg==
X-Gm-Message-State: AOAM530f6zd8muz4lEhRX9eywLVtM+6eqzf/ZQ+91QlyOERSwXn9g4kz
        QXzD8uegDbCZJ3scpbsw2+l1XDAt6zQ=
X-Google-Smtp-Source: ABdhPJx/Q9s5psPu8CpWfAneCiClB6+zukhRgJJFd3XHO64JkQH1xQXlL0rag5SDgxBHDk2BnO6jjg==
X-Received: by 2002:a05:6830:1d45:: with SMTP id p5mr20995316oth.119.1635297229675;
        Tue, 26 Oct 2021 18:13:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b9sm5096725ots.77.2021.10.26.18.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 18:13:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Oct 2021 18:13:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 2/2] block: attempt direct issue of plug list
Message-ID: <20211027011347.GA3111117@roeck-us.net>
References: <20211019120834.595160-1-axboe@kernel.dk>
 <20211019120834.595160-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019120834.595160-3-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Tue, Oct 19, 2021 at 06:08:34AM -0600, Jens Axboe wrote:
> If we have just one queue type in the plug list, then we can extend our
> direct issue to cover a full plug list as well.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

This patch results in a number of warning tracebacks in linux-next.
Reverting it fixes the problem. Example tracebacks and bisect result
attached.

Guenter

---
boot from mmc, ext2:

[   10.868421] ------------[ cut here ]------------
[   10.868795] WARNING: CPU: 0 PID: 1 at kernel/sched/core.c:9477 __might_sleep+0x70/0x98
[   10.869013] do not call blocking ops when !TASK_RUNNING; state=2 set at [<(ptrval)>] prepare_to_wait+0x6c/0xb0
[   10.869350] CPU: 0 PID: 1 Comm: swapper Not tainted 5.15.0-rc7-next-20211026-sx1 #1
[   10.869547] Hardware name: OMAP310 based Siemens SX1
[   10.869779] [<c000dc00>] (unwind_backtrace) from [<c000cc54>] (show_stack+0x10/0x18)
[   10.870010] [<c000cc54>] (show_stack) from [<c0430830>] (dump_stack+0x20/0x2c)
[   10.870197] [<c0430830>] (dump_stack) from [<c0018bf8>] (__warn+0xac/0xec)
[   10.870372] [<c0018bf8>] (__warn) from [<c0424218>] (warn_slowpath_fmt+0x68/0x80)
[   10.870556] [<c0424218>] (warn_slowpath_fmt) from [<c003ba2c>] (__might_sleep+0x70/0x98)
[   10.870751] [<c003ba2c>] (__might_sleep) from [<c03f4fb4>] (__mmc_claim_host+0x54/0x1d0)
[   10.870947] [<c03f4fb4>] (__mmc_claim_host) from [<c04053c8>] (mmc_mq_queue_rq+0x12c/0x214)
[   10.871148] [<c04053c8>] (mmc_mq_queue_rq) from [<c02b35c8>] (__blk_mq_try_issue_directly+0xe8/0x134)
[   10.871368] [<c02b35c8>] (__blk_mq_try_issue_directly) from [<c02b45c0>] (blk_mq_request_issue_directly+0x30/0x50)
[   10.871609] [<c02b45c0>] (blk_mq_request_issue_directly) from [<c02b4750>] (blk_mq_flush_plug_list+0x170/0x1f4)
[   10.871842] [<c02b4750>] (blk_mq_flush_plug_list) from [<c02a9ee8>] (blk_flush_plug+0x50/0xec)
[   10.872047] [<c02a9ee8>] (blk_flush_plug) from [<c003b410>] (io_schedule_prepare+0x40/0x50)
[   10.872244] [<c003b410>] (io_schedule_prepare) from [<c04324d8>] (io_schedule+0xc/0x24)
[   10.872436] [<c04324d8>] (io_schedule) from [<c0432814>] (bit_wait_io+0xc/0x34)
[   10.872616] [<c0432814>] (bit_wait_io) from [<c0432548>] (__wait_on_bit+0x58/0x98)
[   10.872801] [<c0432548>] (__wait_on_bit) from [<c04325fc>] (out_of_line_wait_on_bit+0x74/0x84)
[   10.873004] [<c04325fc>] (out_of_line_wait_on_bit) from [<c010dfdc>] (__wait_on_buffer+0x34/0x44)
[   10.873215] [<c010dfdc>] (__wait_on_buffer) from [<c018b688>] (wait_on_buffer+0x24/0x34)
[   10.873411] [<c018b688>] (wait_on_buffer) from [<c018d6d4>] (ext4_read_bh+0x58/0x68)
[   10.873598] [<c018d6d4>] (ext4_read_bh) from [<c015aad0>] (ext4_get_branch+0x9c/0x124)
[   10.873789] [<c015aad0>] (ext4_get_branch) from [<c015ada8>] (ext4_ind_map_blocks+0x158/0xa0c)
[   10.873991] [<c015ada8>] (ext4_ind_map_blocks) from [<c0161f74>] (ext4_map_blocks+0x320/0x558)
[   10.874197] [<c0161f74>] (ext4_map_blocks) from [<c017ec78>] (ext4_mpage_readpages+0x31c/0x6a8)
[   10.874403] [<c017ec78>] (ext4_mpage_readpages) from [<c0160044>] (ext4_readahead+0x24/0x2c)
[   10.874602] [<c0160044>] (ext4_readahead) from [<c009ba18>] (read_pages+0x48/0x118)
[   10.874793] [<c009ba18>] (read_pages) from [<c009bda0>] (page_cache_ra_unbounded+0xfc/0x1e8)
[   10.874994] [<c009bda0>] (page_cache_ra_unbounded) from [<c0094a3c>] (filemap_read+0x19c/0x81c)
[   10.875202] [<c0094a3c>] (filemap_read) from [<c0154524>] (ext4_file_read_iter+0x9c/0xf4)
[   10.875400] [<c0154524>] (ext4_file_read_iter) from [<c00da450>] (__kernel_read+0xc4/0x14c)
[   10.875604] [<c00da450>] (__kernel_read) from [<c00e066c>] (bprm_execve+0x204/0x4bc)
[   10.875795] [<c00e066c>] (bprm_execve) from [<c00e1370>] (kernel_execve+0xe4/0x114)
[   10.875982] [<c00e1370>] (kernel_execve) from [<c0423a6c>] (run_init_process+0x60/0x98)
[   10.876175] [<c0423a6c>] (run_init_process) from [<c0423ab0>] (try_to_run_init_process+0xc/0x3c)
[   10.876383] [<c0423ab0>] (try_to_run_init_process) from [<c04314f0>] (kernel_init+0x90/0x108)
[   10.876585] [<c04314f0>] (kernel_init) from [<c00084d0>] (ret_from_fork+0x14/0x24)
[   10.876797] Exception stack(0xc103bfb0 to 0xc103bff8)
[   10.877217] bfa0:                                     00000000 00000000 00000000 00000000
[   10.877439] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   10.877634] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   10.877830] irq event stamp: 65423
[   10.877943] hardirqs last  enabled at (65431): [<c004ea98>] __up_console_sem+0x38/0x58
[   10.878178] hardirqs last disabled at (65438): [<c004ea80>] __up_console_sem+0x20/0x58
[   10.878372] softirqs last  enabled at (65008): [<c0009734>] __do_softirq+0x32c/0x404
[   10.878579] softirqs last disabled at (64993): [<c001cb00>] irq_exit+0x120/0x15c
[   10.878788] ---[ end trace 3925c0327f8d873a ]---

---
boot from flash, squashfs:

[   10.742470] ------------[ cut here ]------------
[   10.742812] WARNING: CPU: 0 PID: 1 at kernel/sched/core.c:9477 __might_sleep+0x70/0x98
[   10.743021] do not call blocking ops when !TASK_RUNNING; state=2 set at [<(ptrval)>] __wait_for_common+0xa4/0x158
[   10.743365] CPU: 0 PID: 1 Comm: swapper Not tainted 5.15.0-rc7-next-20211026-sx1 #1
[   10.743593] Hardware name: OMAP310 based Siemens SX1
[   10.743815] [<c000dc00>] (unwind_backtrace) from [<c000cc54>] (show_stack+0x10/0x18)
[   10.744036] [<c000cc54>] (show_stack) from [<c0430830>] (dump_stack+0x20/0x2c)
[   10.744215] [<c0430830>] (dump_stack) from [<c0018bf8>] (__warn+0xac/0xec)
[   10.744383] [<c0018bf8>] (__warn) from [<c0424218>] (warn_slowpath_fmt+0x68/0x80)
[   10.744709] [<c0424218>] (warn_slowpath_fmt) from [<c003ba2c>] (__might_sleep+0x70/0x98)
[   10.744922] [<c003ba2c>] (__might_sleep) from [<c0433654>] (__mutex_lock+0x24/0x264)
[   10.745106] [<c0433654>] (__mutex_lock) from [<c0433968>] (mutex_lock_nested+0x18/0x24)
[   10.745306] [<c0433968>] (mutex_lock_nested) from [<c03e46f0>] (mtd_queue_rq+0xcc/0x3f0)
[   10.745497] [<c03e46f0>] (mtd_queue_rq) from [<c02b35c8>] (__blk_mq_try_issue_directly+0xe8/0x134)
[   10.745702] [<c02b35c8>] (__blk_mq_try_issue_directly) from [<c02b45c0>] (blk_mq_request_issue_directly+0x30/0x50)
[   10.745928] [<c02b45c0>] (blk_mq_request_issue_directly) from [<c02b4750>] (blk_mq_flush_plug_list+0x170/0x1f4)
[   10.746148] [<c02b4750>] (blk_mq_flush_plug_list) from [<c02a9ee8>] (blk_flush_plug+0x50/0xec)
[   10.746345] [<c02a9ee8>] (blk_flush_plug) from [<c003b410>] (io_schedule_prepare+0x40/0x50)
[   10.746535] [<c003b410>] (io_schedule_prepare) from [<c04324a4>] (io_schedule_timeout+0x10/0x38)
[   10.746732] [<c04324a4>] (io_schedule_timeout) from [<c04329cc>] (__wait_for_common+0xd8/0x158)
[   10.746928] [<c04329cc>] (__wait_for_common) from [<c02a5068>] (submit_bio_wait+0x4c/0x6c)
[   10.747119] [<c02a5068>] (submit_bio_wait) from [<c01b22f4>] (squashfs_bio_read+0x154/0x20c)
[   10.747314] [<c01b22f4>] (squashfs_bio_read) from [<c01b2688>] (squashfs_read_data+0x2dc/0x3d8)
[   10.747510] [<c01b2688>] (squashfs_read_data) from [<c01b2a3c>] (squashfs_cache_get+0x23c/0x2e8)
[   10.747707] [<c01b2a3c>] (squashfs_cache_get) from [<c01b5ba4>] (squashfs_readpage_block+0x28/0x80)
[   10.747909] [<c01b5ba4>] (squashfs_readpage_block) from [<c01b3f74>] (squashfs_readpage+0x580/0x5f4)
[   10.748112] [<c01b3f74>] (squashfs_readpage) from [<c009baa4>] (read_pages+0xd4/0x118)
[   10.748297] [<c009baa4>] (read_pages) from [<c009bda0>] (page_cache_ra_unbounded+0xfc/0x1e8)
[   10.748490] [<c009bda0>] (page_cache_ra_unbounded) from [<c0094a3c>] (filemap_read+0x19c/0x81c)
[   10.748688] [<c0094a3c>] (filemap_read) from [<c00da450>] (__kernel_read+0xc4/0x14c)
[   10.748870] [<c00da450>] (__kernel_read) from [<c00e066c>] (bprm_execve+0x204/0x4bc)
[   10.749051] [<c00e066c>] (bprm_execve) from [<c00e1370>] (kernel_execve+0xe4/0x114)
[   10.749232] [<c00e1370>] (kernel_execve) from [<c0423a6c>] (run_init_process+0x60/0x98)
[   10.749417] [<c0423a6c>] (run_init_process) from [<c0423ab0>] (try_to_run_init_process+0xc/0x3c)
[   10.749615] [<c0423ab0>] (try_to_run_init_process) from [<c04314f0>] (kernel_init+0x90/0x108)
[   10.749808] [<c04314f0>] (kernel_init) from [<c00084d0>] (ret_from_fork+0x14/0x24)
[   10.750013] Exception stack(0xc103bfb0 to 0xc103bff8)
[   10.750280] bfa0:                                     00000000 00000000 00000000 00000000
[   10.750482] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   10.750667] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   10.750851] irq event stamp: 67803
[   10.750958] hardirqs last  enabled at (67811): [<c004ea98>] __up_console_sem+0x38/0x58
[   10.751179] hardirqs last disabled at (67818): [<c004ea80>] __up_console_sem+0x20/0x58
[   10.751364] softirqs last  enabled at (67552): [<c0009734>] __do_softirq+0x32c/0x404
[   10.751559] softirqs last disabled at (67547): [<c001cb00>] irq_exit+0x120/0x15c
[   10.751753] ---[ end trace e6cf94fcaae1cea0 ]---

---
boot from flash, ext2:

[   12.328280] WARNING: CPU: 0 PID: 1 at kernel/sched/core.c:9477 __might_sleep+0x98/0xac
[   12.328504] do not call blocking ops when !TASK_RUNNING; state=2 set at [<80154954>] prepare_to_wait+0x4c/0x12c
[   12.328787] CPU: 0 PID: 1 Comm: swapper Not tainted 5.15.0-rc7-next-20211026 #1
[   12.328942] Hardware name: Generic DT based system
[   12.329134] Backtrace:
[   12.329337] [<80b7d33c>] (dump_backtrace) from [<80b7d710>] (show_stack+0x20/0x24)
[   12.329609]  r7:00002505 r6:00000009 r5:8014c45c r4:80e397cc
[   12.329752] [<80b7d6f0>] (show_stack) from [<80b9705c>] (dump_stack+0x28/0x30)
[   12.329895] [<80b97034>] (dump_stack) from [<80115040>] (__warn+0xe4/0x164)
[   12.330035]  r5:8014c45c r4:80de4198
[   12.330120] [<80114f5c>] (__warn) from [<80b7dda0>] (warn_slowpath_fmt+0xa0/0xe4)
[   12.330264]  r7:8014c45c r6:00002505 r5:80de4198 r4:80de444c
[   12.330371] [<80b7dd04>] (warn_slowpath_fmt) from [<8014c45c>] (__might_sleep+0x98/0xac)
[   12.330523]  r8:00000001 r7:8287827c r6:00000001 r5:00000248 r4:80de4914
[   12.330641] [<8014c3c4>] (__might_sleep) from [<80b9d28c>] (__mutex_lock+0x48/0x6f4)
[   12.330792]  r6:00000000 r5:00000000 r4:82878210
[   12.330889] [<80b9d244>] (__mutex_lock) from [<80b9da60>] (mutex_lock_nested+0x2c/0x34)
[   12.331049]  r10:82878200 r9:82382920 r8:00000001 r7:8287827c r6:82878210 r5:828a5038
[   12.331185]  r4:828a5000
[   12.331259] [<80b9da34>] (mutex_lock_nested) from [<807ca3dc>] (mtd_queue_rq+0x1b4/0x560)
[   12.331411] [<807ca228>] (mtd_queue_rq) from [<805e04d4>] (__blk_mq_try_issue_directly+0x178/0x1c4)
[   12.331577]  r10:8197fbbc r9:82382920 r8:00000001 r7:00000001 r6:8287ce00 r5:00000000
[   12.331708]  r4:828a5000
[   12.331781] [<805e035c>] (__blk_mq_try_issue_directly) from [<805e240c>] (blk_mq_flush_plug_list+0x338/0x5c0)
[   12.331957]  r9:8197e000 r8:8197f77c r7:8287ce00 r6:8197fbac r5:00000001 r4:828a5000
[   12.332087] [<805e20d4>] (blk_mq_flush_plug_list) from [<805d42a8>] (blk_flush_plug+0xf8/0x144)
[   12.332249]  r10:8197fbbc r9:8197fbac r8:80b9ba20 r7:8197f860 r6:00000001 r5:8197f854
[   12.332379]  r4:00000000
[   12.332452] [<805d41b0>] (blk_flush_plug) from [<80b9b584>] (io_schedule+0x50/0x78)
[   12.332602]  r10:00000008 r9:00000002 r8:80b9ba20 r7:8197f860 r6:81004254 r5:8197f854
[   12.332731]  r4:00000000
[   12.332805] [<80b9b534>] (io_schedule) from [<80b9ba3c>] (bit_wait_io+0x1c/0x80)
[   12.332946]  r5:8197f854 r4:00000002
[   12.333031] [<80b9ba20>] (bit_wait_io) from [<80b9b60c>] (__wait_on_bit+0x60/0xac)
[   12.333172]  r5:8197f854 r4:8197e000
[   12.333256] [<80b9b5ac>] (__wait_on_bit) from [<80b9b6f8>] (out_of_line_wait_on_bit+0xa0/0xd4)
[   12.333414]  r9:8277d3b0 r8:801550cc r7:61c88647 r6:8197f86c r5:81002020 r4:8197e000
[   12.333542] [<80b9b658>] (out_of_line_wait_on_bit) from [<8031b554>] (__wait_on_buffer+0x44/0x50)
[   12.333705]  r8:82bbd000 r7:40000113 r6:60000113 r5:00000000 r4:827808c8
[   12.333823] [<8031b510>] (__wait_on_buffer) from [<803ed810>] (ext4_read_bh+0x13c/0x190)
[   12.333975]  r5:00000000 r4:827808c8
[   12.334061] [<803ed6d4>] (ext4_read_bh) from [<803a0f00>] (ext4_get_branch+0xcc/0x168)
[   12.334211]  r7:8197f9b0 r6:00000001 r5:827808c8 r4:8197f9e4
[   12.334318] [<803a0e34>] (ext4_get_branch) from [<803a12d4>] (ext4_ind_map_blocks+0x1e4/0xd1c)
[   12.334477]  r10:00000000 r9:00000000 r8:00000004 r7:00000000 r6:8277d3b0 r5:0000000c
[   12.334608]  r4:00000000
[   12.334681] [<803a10f0>] (ext4_ind_map_blocks) from [<803a9d8c>] (ext4_map_blocks+0x114/0x668)
[   12.334849]  r10:8277d360 r9:00000000 r8:00000004 r7:00000000 r6:8277d3b0 r5:0000000c
[   12.334980]  r4:8197fb08
[   12.335053] [<803a9c78>] (ext4_map_blocks) from [<803d39bc>] (ext4_mpage_readpages+0x564/0x858)
[   12.335215]  r10:00000004 r9:00000000 r8:00000004 r7:00000004 r6:00000000 r5:0000000c
[   12.335345]  r4:00000000
[   12.335419] [<803d3458>] (ext4_mpage_readpages) from [<803a7bd0>] (ext4_readahead+0x44/0x48)
[   12.335579]  r10:8772af00 r9:01112cca r8:803a7b8c r7:80c18298 r6:00000000 r5:8197fc14
[   12.335710]  r4:8197fcd4
[   12.335784] [<803a7b8c>] (ext4_readahead) from [<80274b68>] (read_pages+0x94/0x27c)
[   12.335927] [<80274ad4>] (read_pages) from [<8027512c>] (page_cache_ra_unbounded+0x204/0x2a0)
[   12.336083]  r10:8772af00 r9:01112cca r8:8277d4f8 r7:8197fcd4 r6:00000003 r5:00000004
[   12.336213]  r4:8772af00
[   12.336287] [<80274f28>] (page_cache_ra_unbounded) from [<802754a0>] (ondemand_readahead+0x2d8/0x380)
[   12.336450]  r10:00000000 r9:00000000 r8:00000020 r7:00000000 r6:00000003 r5:82eb00f8
[   12.336580]  r4:8197fcd4
[   12.336654] [<802751c8>] (ondemand_readahead) from [<8027573c>] (page_cache_sync_ra+0x6c/0x70)
[   12.336811]  r10:00000000 r9:8197fe60 r8:00000000 r7:00000001 r6:8277d4f8 r5:8197fd54
[   12.336941]  r4:8197fe60
[   12.337014] [<802756d0>] (page_cache_sync_ra) from [<80267e04>] (filemap_get_pages+0x114/0x818)
[   12.337167] [<80267cf0>] (filemap_get_pages) from [<8026aad8>] (filemap_read+0xf0/0x3f0)
[   12.337319]  r10:8197fe48 r9:8197fe60 r8:00000000 r7:82eb0020 r6:8197fe48 r5:00000000
[   12.337450]  r4:8277d3b0
[   12.337523] [<8026a9e8>] (filemap_read) from [<8026aee0>] (generic_file_read_iter+0x108/0x164)
[   12.337680]  r10:82bb385c r9:00000000 r8:00000000 r7:00000100 r6:8197fe48 r5:00000000
[   12.337998]  r4:8197fe60
[   12.338092] [<8026add8>] (generic_file_read_iter) from [<80399048>] (ext4_file_read_iter+0x5c/0x140)
[   12.338266]  r10:82bb385c r9:00000000 r8:00000000 r7:8197fef8 r6:8277d3b0 r5:8197fe60
[   12.338396]  r4:8197fe48
[   12.338470] [<80398fec>] (ext4_file_read_iter) from [<802ce8a8>] (__kernel_read+0x130/0x2e0)
[   12.338626]  r7:8197fef8 r6:00000100 r5:00000000 r4:82eb0020
[   12.338731] [<802ce778>] (__kernel_read) from [<802ceaa0>] (kernel_read+0x48/0x8c)
[   12.338884]  r9:00000000 r8:8100ca3c r7:819e21e0 r6:8106cc08 r5:8106cbe8 r4:82bb3800
[   12.339012] [<802cea58>] (kernel_read) from [<802d7cd0>] (bprm_execve+0x2a4/0x61c)
[   12.339156]  r5:8106cbe8 r4:82bb3800
[   12.339240] [<802d7a2c>] (bprm_execve) from [<802d8f70>] (kernel_execve+0x120/0x180)
[   12.339387]  r10:00000000 r9:00000000 r8:8100ca3c r7:8100c9b0 r6:819e21e0 r5:82bb3800
[   12.339516]  r4:00000000
[   12.339589] [<802d8e50>] (kernel_execve) from [<80b7d0e4>] (run_init_process+0xb4/0xe0)
[   12.339742]  r9:00000000 r8:00000000 r7:80eb1744 r6:810dc540 r5:8100ca48 r4:80dde074
[   12.339871] [<80b7d030>] (run_init_process) from [<80b7d12c>] (try_to_run_init_process+0x1c/0x48)
[   12.340028]  r7:00000000 r6:00000000 r5:80dde074 r4:810ff000
[   12.340135] [<80b7d110>] (try_to_run_init_process) from [<80b97f20>] (kernel_init+0xcc/0x140)
[   12.340287]  r5:8100c9b0 r4:810ff000
[   12.340371] [<80b97e54>] (kernel_init) from [<801000f8>] (ret_from_fork+0x14/0x3c)
[   12.340555] Exception stack(0x8197ffb0 to 0x8197fff8)
[   12.340720] ffa0:                                     00000000 00000000 00000000 00000000
[   12.340873] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   12.341015] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   12.341154]  r5:80b97e54 r4:00000000
[   12.341297] irq event stamp: 338305
[   12.341394] hardirqs last  enabled at (338313): [<8016b190>] __up_console_sem+0x70/0x90
[   12.341546] hardirqs last disabled at (338320): [<8016b17c>] __up_console_sem+0x5c/0x90
[   12.341693] softirqs last  enabled at (337228): [<801015ac>] __do_softirq+0x3a4/0x4bc
[   12.341849] softirqs last disabled at (337219): [<8011abf8>] __irq_exit_rcu+0x154/0x198
[   12.342017] ---[ end trace 90c4b572201178ca ]---

---
bisect:

# bad: [2376e5fe91bcad74b997d2cc0535abff79ec73c5] Add linux-next specific files for 20211026
# good: [3906fe9bb7f1a2c8667ae54e967dc8690824f4ea] Linux 5.15-rc7
git bisect start 'HEAD' 'v5.15-rc7'
# good: [18298270669947b661fe47bf7ec755a6d254c464] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 18298270669947b661fe47bf7ec755a6d254c464
# bad: [2701cbf5818d2e249bc890297b6ccb4665bee93d] Merge branch 'auto-latest' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect bad 2701cbf5818d2e249bc890297b6ccb4665bee93d
# good: [3462546aa74a9901a8955c3b2c3e55d736353360] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
git bisect good 3462546aa74a9901a8955c3b2c3e55d736353360
# bad: [0cb3815f5831d5d81e742a6ec9b8c5a8a24e3a3b] Merge branch 'for-next' of git://git.kernel.dk/linux-block.git
git bisect bad 0cb3815f5831d5d81e742a6ec9b8c5a8a24e3a3b
# bad: [36413f42eaf5ccaa42f9a79756129abc34cd27c9] Merge branch 'for-5.16/drivers' into for-next
git bisect bad 36413f42eaf5ccaa42f9a79756129abc34cd27c9
# good: [d28e4dff085c5a87025c9a0a85fb798bd8e9ca17] block: ataflop: more blk-mq refactoring fixes
git bisect good d28e4dff085c5a87025c9a0a85fb798bd8e9ca17
# good: [88eb469d0dcbd2206f8f16e76a2ab7a32475fbed] Merge branch 'for-5.16/bdev-size' into for-next
git bisect good 88eb469d0dcbd2206f8f16e76a2ab7a32475fbed
# bad: [49389040df8f2ac0e03412d6dcad0ef322cbbc1b] Merge branch 'for-5.16/block' into for-next
git bisect bad 49389040df8f2ac0e03412d6dcad0ef322cbbc1b
# bad: [ce807b324fd4e02ecd8d5e49fab16baad4af9575] Merge branch 'for-5.16/io_uring' into for-next
git bisect bad ce807b324fd4e02ecd8d5e49fab16baad4af9575
# good: [06114f3294e91818408c0008446ccf41d67cd63e] Merge branch 'for-5.16/bdev-size' into for-next
git bisect good 06114f3294e91818408c0008446ccf41d67cd63e
# bad: [44b2b16cb77838b9596e6551088b1b18657398c2] Merge branch 'for-5.16/block' into for-next
git bisect bad 44b2b16cb77838b9596e6551088b1b18657398c2
# bad: [59d62b58f1203a6b59a3e51244dee91ea80340cd] Merge branch 'for-5.16/block' into for-next
git bisect bad 59d62b58f1203a6b59a3e51244dee91ea80340cd
# bad: [dc5fc361d891e089dfd9c0a975dc78041036b906] block: attempt direct issue of plug list
git bisect bad dc5fc361d891e089dfd9c0a975dc78041036b906
# good: [bc490f81731e181b07b8d7577425c06ae91692c8] block: change plugging to use a singly linked list
git bisect good bc490f81731e181b07b8d7577425c06ae91692c8
# first bad commit: [dc5fc361d891e089dfd9c0a975dc78041036b906] block: attempt direct issue of plug list
