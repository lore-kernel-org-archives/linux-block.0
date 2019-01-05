Return-Path: <SRS0=xcXT=PN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270F3C43387
	for <linux-block@archiver.kernel.org>; Sat,  5 Jan 2019 17:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55BB21721
	for <linux-block@archiver.kernel.org>; Sat,  5 Jan 2019 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546709750;
	bh=lZpZ+QaM4Q9G+eShAvVRuTC9Ny61XwJdnmA56GwadU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HQVtR3IvTJZF4da+TJJLUYGKngZeF3xL49TXh2WX+1DQs7dEdCO9K8G+C4B/4rC/i
	 e4w1ufFCucWXEc0hcO/I/zu3Ux/gQ7GzriOoKM/d/DrWUk1ayIcuyg4v4q/6a3K5QY
	 9i3qpGT+Yfz5doQZ5JDNKmefkXsGz+dOV+BjOdqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfAERft (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAERft (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Jan 2019 12:35:49 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 818CA2087F;
        Sat,  5 Jan 2019 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546709747;
        bh=lZpZ+QaM4Q9G+eShAvVRuTC9Ny61XwJdnmA56GwadU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPBB4e/YoysvATA56nwETTHWdTISlLbug7SHqo1OhELApvbRYrqM1aKVBmJThzFSR
         0iGNBVSHb+EEfJQCVsnJLsdR1fV3ONfJ5aPt3PCEUoXGthRXblbf0kUgzYM6n0NdHQ
         kL+DyV8iRBGL2IKt7jP35f8gTjFNrrQU12Y3gifM=
Date:   Sat, 5 Jan 2019 18:35:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: 047fb56f7e ("blk-mq: fix changelog"):  BUG: unable to handle
 kernel NULL pointer dereference at 00000030
Message-ID: <20190105173533.GA26461@kroah.com>
References: <5c30e6f2.FK3oPXlyr6MtdG/V%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c30e6f2.FK3oPXlyr6MtdG/V%lkp@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jan 06, 2019 at 01:18:42AM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git debugfs_cleanup
> 
> commit 047fb56f7ecf53620d6e93fbcc8ca9166108d14c
> Author:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> AuthorDate: Fri Jan 4 14:06:22 2019 +0100
> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CommitDate: Fri Jan 4 17:29:15 2019 +0100
> 
>     blk-mq: fix changelog
> 
> 464573328e  wireless: fix changelog
> 047fb56f7e  blk-mq: fix changelog
> 24aeb03f70  lib: WIP, break up
> +------------------------------------------+------------+------------+------------+
> |                                          | 464573328e | 047fb56f7e | 24aeb03f70 |
> +------------------------------------------+------------+------------+------------+
> | boot_successes                           | 33         | 0          | 0          |
> | boot_failures                            | 0          | 13         | 19         |
> | BUG:unable_to_handle_kernel              | 0          | 13         | 19         |
> | Oops:#[##]                               | 0          | 13         | 19         |
> | EIP:debugfs_create_files                 | 0          | 13         | 19         |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 13         | 19         |
> +------------------------------------------+------------+------------+------------+
> 
> [    1.939685] toshiba: not a supported Toshiba laptop
> [    1.940314] platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver Initializing
> [    1.941204] platform pc8736x_gpio.0: no device found
> [    1.941848] nsc_gpio initializing
> [    1.942249] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
> [    1.943923] BUG: unable to handle kernel NULL pointer dereference at 00000030
> [    1.944889] #PF error: [normal kernel read fault]
> [    1.945527] *pdpt = 0000000000000000 *pde = f000ff53f000ff53 
> [    1.946287] Oops: 0000 [#1] SMP PTI
> [    1.946760] CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 4.20.0-11088-g047fb56 #1
> [    1.947149] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    1.947149] Workqueue: events_unbound async_run_entry_fn
> [    1.947149] EIP: debugfs_create_files+0x9/0x50
> [    1.947149] Code: 00 e8 db 11 52 00 8b 16 8b 4e 04 8d 83 c0 03 00 00 e8 4b 24 da ff 5b 5e 5d c3 8d b4 26 00 00 00 00 55 89 e5 56 53 89 c6 89 cb <8b> 40 30 89 90 14 02 00 00 8b 01 85 c0 74 26 90 8d b4 26 00 00 00
> [    1.947149] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: da18f800
> [    1.947149] ESI: 00000000 EDI: da18f800 EBP: c005de24 ESP: c005de1c
> [    1.947149] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210246
> [    1.947149] CR0: 80050033 CR2: 00000030 CR3: 01da4000 CR4: 003406f0
> [    1.947149] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [    1.947149] DR6: fffe0ff0 DR7: 00000400
> [    1.947149] Call Trace:
> [    1.947149]  blk_mq_debugfs_register_sched_hctx+0x2f/0x40
> [    1.947149]  blk_mq_init_sched+0x156/0x1c0
> [    1.947149]  elevator_init_mq+0x4b/0x80
> [    1.947149]  blk_mq_init_allocated_queue+0x409/0x460
> [    1.947149]  blk_mq_init_queue+0x23/0x60
> [    1.947149]  blk_mq_init_sq_queue+0x77/0x90
> [    1.947149]  floppy_async_init+0xc0/0xd2c
> [    1.947149]  ? __lock_acquire+0x35/0x860
> [    1.947149]  async_run_entry_fn+0x2e/0xf0
> [    1.947149]  process_one_work+0x195/0x3c0
> [    1.947149]  ? process_one_work+0x176/0x3c0
> [    1.947149]  worker_thread+0x39/0x3d0
> [    1.947149]  kthread+0xda/0x110
> [    1.947149]  ? process_one_work+0x3c0/0x3c0
> [    1.947149]  ? kthread_park+0xa0/0xa0
> [    1.947149]  ret_from_fork+0x19/0x30
> [    1.947149] Modules linked in:
> [    1.947149] CR2: 0000000000000030
> [    1.947149] ---[ end trace 34fc82d8056f573a ]---
> [    1.947150] BUG: unable to handle kernel NULL pointer dereference at 00000030

This is my fault, due to some debugfs patches I'm working on, it's not a
block-specific issue at the moment.

sorry for the noise.

greg k-h
