Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EEFC33C8C
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 12:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E01207E0
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 12:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaIXUUHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgAGMrM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:47:12 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40447 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGMrL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 07:47:11 -0500
Received: by mail-pj1-f68.google.com with SMTP id bg7so9226404pjb.5;
        Tue, 07 Jan 2020 04:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8PR6blzvkB8SglpJfQT+RrOlt95zYQCk8HEV2njqBwo=;
        b=jaIXUUHN0j3PCiVPXUW6bXJGdHIDjdS39RtdW3vDFM/lnwtTYpSfV7wN/8WtY5x1q5
         Qie7bQKR/ktUd7PRnyDzdKoXWQik027b7zkiiSetDkItvyAu4n9VK6ZZAgMIilnwEidh
         VIs2ajd1oNWJ6I5gRO1KowZ7wZICclu/0wBBfbjn2m6Ty4+zXkbbh6zlxCTnjHa7u5zC
         0qSiXVGHmbZn6zJZUAIA5ZMyHAtLFc8Xxl1D3h4LHENd4uFqCBcLUvhy9EKKTfN87yC5
         rcpuyojls5PjEKJPFldbj73VNgSx8tPxC6s2h3HcvUPaYFXluZGQGHqpPGn0QdAPXziO
         /PLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8PR6blzvkB8SglpJfQT+RrOlt95zYQCk8HEV2njqBwo=;
        b=tfz/Vm5kYQ/Fz2FGqMYeP1ZXMsAKI2iR1x25xcFjJ+ZG7YUgeceuowa/IkI+pG6+kO
         WTEVTguBKjrGu5sTR0UA5oBGF286vF/F9IezASTJRHEelS0YYYmbHpWXgq+bGG/kgKpy
         Is4lpCqm8uajQLCXmQEA94JYG82M4W8NpaC71IN0pICz0INOHlU6RvJ4Frq5UY2VSAKx
         0yaZNnouf9ZjO4B4+9kWFIeFjNKK508yDhRo8kwjN/SB/cqX3cNO/1wVame8QbZT6iBr
         zAp9mZR2mhjukQdXT7KE+CkxBuDJS26VNZEp7OFDufJI43ZngphTz6rEglQlxDev0EQJ
         YnJg==
X-Gm-Message-State: APjAAAUvUfcb/HADskQlfuP8CrfhsoidMRp4epQ9ZBEH58nleEQTw0WX
        P9t7/aukruJ+F28O6IukGdA=
X-Google-Smtp-Source: APXvYqwG2AFySHv4xdrbHl1Kvbp2vRu75/z8ant00zuSrHSPw+/P3kLLM2ggn0Y6WgYAD0AYTMqTZg==
X-Received: by 2002:a17:90a:30a4:: with SMTP id h33mr48911402pjb.50.1578401230840;
        Tue, 07 Jan 2020 04:47:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c15sm30391291pja.30.2020.01.07.04.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 04:47:09 -0800 (PST)
Date:   Tue, 7 Jan 2020 04:47:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200107124708.GA20285@roeck-us.net>
References: <20191229023230.28940-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229023230.28940-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Sun, Dec 29, 2019 at 10:32:30AM +0800, Ming Lei wrote:
> There are two issues in get_max_segment_size():
> 
> 1) the default segment boudary mask is bypassed, and some devices still
> require segment to not cross the default 4G boundary
> 
> 2) the segment start address isn't taken into account when checking
> segment boundary limit
> 
> Fixes the two issues.
> 
> Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

This patch, pushed into mainline as "block: fix splitting segments on
boundary masks", results in the following crash when booting 'versatilepb'
in qemu from disk. Bisect log is attached. Detailed log is at
https://kerneltests.org/builders/qemu-arm-master/builds/1410/steps/qemubuildcommand/logs/stdio

Guenter

---
Crash:

kernel BUG at block/bio.c:1885!
Internal error: Oops - BUG: 0 [#1] ARM
Modules linked in:
CPU: 0 PID: 1 Comm: init Not tainted 5.5.0-rc5 #1
Hardware name: ARM-Versatile (Device Tree Support)
PC is at bio_split+0x10c/0x15c
LR is at __blk_queue_split+0x378/0x628
...
[<c03b716c>] (bio_split) from [<c03c24c8>] (__blk_queue_split+0x378/0x628)
[<c03c24c8>] (__blk_queue_split) from [<c03c82cc>] (blk_mq_make_request+0x6c/0x7e4)
[<c03c82cc>] (blk_mq_make_request) from [<c03bc7d0>] (generic_make_request+0xec/0x340)
[<c03bc7d0>] (generic_make_request) from [<c03bca70>] (submit_bio+0x4c/0x170)
[<c03bca70>] (submit_bio) from [<c020666c>] (ext4_mpage_readpages+0x54c/0x8e0)
[<c020666c>] (ext4_mpage_readpages) from [<c01e1ec8>] (ext4_readpages+0x40/0x50)
[<c01e1ec8>] (ext4_readpages) from [<c00df808>] (read_pages+0x50/0x13c)
[<c00df808>] (read_pages) from [<c00dfd2c>] (__do_page_cache_readahead+0x1a8/0x1f0)
[<c00dfd2c>] (__do_page_cache_readahead) from [<c00d500c>] (filemap_fault+0x440/0x8f4)
[<c00d500c>] (filemap_fault) from [<c01ed494>] (ext4_filemap_fault+0x28/0x3c)
[<c01ed494>] (ext4_filemap_fault) from [<c0100b88>] (__do_fault+0x3c/0x1c0)
[<c0100b88>] (__do_fault) from [<c0105360>] (handle_mm_fault+0x284/0xaf4)
[<c0105360>] (handle_mm_fault) from [<c001f01c>] (do_page_fault+0x114/0x2e0)
[<c001f01c>] (do_page_fault) from [<c001f34c>] (do_DataAbort+0x38/0xbc)
[<c001f34c>] (do_DataAbort) from [<c000a0dc>] (__dabt_svc+0x5c/0xa0)
Exception stack(0xc783be28 to 0xc783be70)
be20:                   b6f81898 00000760 00000000 00000055 00000051 c0af3068
be40: c71f7a00 c71f7800 b6f51000 c71df320 c7954c80 00000006 00000000 c783be78
be60: c01a099c c07a4bb4 20000153 ffffffff
[<c000a0dc>] (__dabt_svc) from [<c07a4bb4>] (__clear_user_std+0x34/0x68)
[<c07a4bb4>] (__clear_user_std) from [<c01a099c>] (clear_user+0x40/0x50)
[<c01a099c>] (clear_user) from [<c019f204>] (load_elf_binary+0x1354/0x13c4)
[<c019f204>] (load_elf_binary) from [<c013996c>] (search_binary_handler.part.4+0x58/0x1fc)
[<c013996c>] (search_binary_handler.part.4) from [<c013b18c>] (__do_execve_file+0x780/0x9a4)
[<c013b18c>] (__do_execve_file) from [<c013b54c>] (do_execve+0x28/0x30)
[<c013b54c>] (do_execve) from [<c000af1c>] (try_to_run_init_process+0xc/0x3c)
[<c000af1c>] (try_to_run_init_process) from [<c07c42fc>] (kernel_init+0x88/0xf0)
[<c07c42fc>] (kernel_init) from [<c00090b0>] (ret_from_fork+0x14/0x24)
...
WARNING: CPU: 0 PID: 1 at kernel/exit.c:719 do_exit+0x54/0xb5c
Modules linked in:
CPU: 0 PID: 1 Comm: init Tainted: G      D           5.5.0-rc5 #1
Hardware name: ARM-Versatile (Device Tree Support)
[<c001e8b0>] (unwind_backtrace) from [<c001a774>] (show_stack+0x10/0x14)
[<c001a774>] (show_stack) from [<c0027dc4>] (__warn+0xe4/0x108)
[<c0027dc4>] (__warn) from [<c0027e90>] (warn_slowpath_fmt+0xa8/0xb8)
[<c0027e90>] (warn_slowpath_fmt) from [<c0029dfc>] (do_exit+0x54/0xb5c)
[<c0029dfc>] (do_exit) from [<c001a918>] (die+0x1a0/0x274)
[<c001a918>] (die) from [<c001abfc>] (do_undefinstr+0xac/0x258)
[<c001abfc>] (do_undefinstr) from [<c000a238>] (__und_svc_finish+0x0/0x48)
Exception stack(0xc783b950 to 0xc783b998)
b940:                                     c7226a80 00000000 00000c00 c7bebe00
b960: 00000000 c783b9e4 00000000 c7226a80 00007000 00000060 c7beb848 c783b9f0
b980: 00000060 c783b9a0 c03c24c8 c03b716c 60000153 ffffffff
[<c000a238>] (__und_svc_finish) from [<c03b716c>] (bio_split+0x10c/0x15c)
[<c03b716c>] (bio_split) from [<c03c24c8>] (__blk_queue_split+0x378/0x628)
[<c03c24c8>] (__blk_queue_split) from [<c03c82cc>] (blk_mq_make_request+0x6c/0x7e4)
[<c03c82cc>] (blk_mq_make_request) from [<c03bc7d0>] (generic_make_request+0xec/0x340)
[<c03bc7d0>] (generic_make_request) from [<c03bca70>] (submit_bio+0x4c/0x170)
[<c03bca70>] (submit_bio) from [<c020666c>] (ext4_mpage_readpages+0x54c/0x8e0)
[<c020666c>] (ext4_mpage_readpages) from [<c01e1ec8>] (ext4_readpages+0x40/0x50)
[<c01e1ec8>] (ext4_readpages) from [<c00df808>] (read_pages+0x50/0x13c)
[<c00df808>] (read_pages) from [<c00dfd2c>] (__do_page_cache_readahead+0x1a8/0x1f0)
[<c00dfd2c>] (__do_page_cache_readahead) from [<c00d500c>] (filemap_fault+0x440/0x8f4)
[<c00d500c>] (filemap_fault) from [<c01ed494>] (ext4_filemap_fault+0x28/0x3c)
[<c01ed494>] (ext4_filemap_fault) from [<c0100b88>] (__do_fault+0x3c/0x1c0)
[<c0100b88>] (__do_fault) from [<c0105360>] (handle_mm_fault+0x284/0xaf4)
[<c0105360>] (handle_mm_fault) from [<c001f01c>] (do_page_fault+0x114/0x2e0)
[<c001f01c>] (do_page_fault) from [<c001f34c>] (do_DataAbort+0x38/0xbc)
[<c001f34c>] (do_DataAbort) from [<c000a0dc>] (__dabt_svc+0x5c/0xa0)
Exception stack(0xc783be28 to 0xc783be70)
be20:                   b6f81898 00000760 00000000 00000055 00000051 c0af3068
be40: c71f7a00 c71f7800 b6f51000 c71df320 c7954c80 00000006 00000000 c783be78
be60: c01a099c c07a4bb4 20000153 ffffffff
[<c000a0dc>] (__dabt_svc) from [<c07a4bb4>] (__clear_user_std+0x34/0x68)
[<c07a4bb4>] (__clear_user_std) from [<c01a099c>] (clear_user+0x40/0x50)
[<c01a099c>] (clear_user) from [<c019f204>] (load_elf_binary+0x1354/0x13c4)
[<c019f204>] (load_elf_binary) from [<c013996c>] (search_binary_handler.part.4+0x58/0x1fc)
[<c013996c>] (search_binary_handler.part.4) from [<c013b18c>] (__do_execve_file+0x780/0x9a4)
[<c013b18c>] (__do_execve_file) from [<c013b54c>] (do_execve+0x28/0x30)
[<c013b54c>] (do_execve) from [<c000af1c>] (try_to_run_init_process+0xc/0x3c)
[<c000af1c>] (try_to_run_init_process) from [<c07c42fc>] (kernel_init+0x88/0xf0)
[<c07c42fc>] (kernel_init) from [<c00090b0>] (ret_from_fork+0x14/0x24)
Exception stack(0xc783bfb0 to 0xc783bff8)
bfa0:                                     00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
irq event stamp: 159876
hardirqs last  enabled at (159875): [<c009123c>] ktime_get+0x74/0x16c
hardirqs last disabled at (159876): [<c000a21c>] __und_svc+0x5c/0x70
softirqs last  enabled at (159728): [<c000aaf0>] __do_softirq+0x308/0x4bc
softirqs last disabled at (159697): [<c002cf94>] irq_exit+0x150/0x178
---[ end trace 42dd349d5c0726c1 ]---
BUG: sleeping function called from invalid context at ./include/linux/cgroup-defs.h:747
in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 1, name: init
INFO: lockdep is turned off.
irq event stamp: 159876
hardirqs last  enabled at (159875): [<c009123c>] ktime_get+0x74/0x16c
hardirqs last disabled at (159876): [<c000a21c>] __und_svc+0x5c/0x70
softirqs last  enabled at (159728): [<c000aaf0>] __do_softirq+0x308/0x4bc
softirqs last disabled at (159697): [<c002cf94>] irq_exit+0x150/0x178
CPU: 0 PID: 1 Comm: init Tainted: G      D W         5.5.0-rc5 #1
Hardware name: ARM-Versatile (Device Tree Support)
[<c001e8b0>] (unwind_backtrace) from [<c001a774>] (show_stack+0x10/0x14)
[<c001a774>] (show_stack) from [<c004fc4c>] (___might_sleep+0x1a8/0x2bc)
[<c004fc4c>] (___might_sleep) from [<c00380d0>] (exit_signals+0x28/0x134)
[<c00380d0>] (exit_signals) from [<c0029e70>] (do_exit+0xc8/0xb5c)
[<c0029e70>] (do_exit) from [<c001a918>] (die+0x1a0/0x274)
[<c001a918>] (die) from [<c001abfc>] (do_undefinstr+0xac/0x258)
[<c001abfc>] (do_undefinstr) from [<c000a238>] (__und_svc_finish+0x0/0x48)
Exception stack(0xc783b950 to 0xc783b998)
b940:                                     c7226a80 00000000 00000c00 c7bebe00
b960: 00000000 c783b9e4 00000000 c7226a80 00007000 00000060 c7beb848 c783b9f0
b980: 00000060 c783b9a0 c03c24c8 c03b716c 60000153 ffffffff
[<c000a238>] (__und_svc_finish) from [<c03b716c>] (bio_split+0x10c/0x15c)
[<c03b716c>] (bio_split) from [<c03c24c8>] (__blk_queue_split+0x378/0x628)
[<c03c24c8>] (__blk_queue_split) from [<c03c82cc>] (blk_mq_make_request+0x6c/0x7e4)
[<c03c82cc>] (blk_mq_make_request) from [<c03bc7d0>] (generic_make_request+0xec/0x340)
[<c03bc7d0>] (generic_make_request) from [<c03bca70>] (submit_bio+0x4c/0x170)
[<c03bca70>] (submit_bio) from [<c020666c>] (ext4_mpage_readpages+0x54c/0x8e0)
[<c020666c>] (ext4_mpage_readpages) from [<c01e1ec8>] (ext4_readpages+0x40/0x50)
[<c01e1ec8>] (ext4_readpages) from [<c00df808>] (read_pages+0x50/0x13c)
[<c00df808>] (read_pages) from [<c00dfd2c>] (__do_page_cache_readahead+0x1a8/0x1f0)
[<c00dfd2c>] (__do_page_cache_readahead) from [<c00d500c>] (filemap_fault+0x440/0x8f4)
[<c00d500c>] (filemap_fault) from [<c01ed494>] (ext4_filemap_fault+0x28/0x3c)
[<c01ed494>] (ext4_filemap_fault) from [<c0100b88>] (__do_fault+0x3c/0x1c0)
[<c0100b88>] (__do_fault) from [<c0105360>] (handle_mm_fault+0x284/0xaf4)
[<c0105360>] (handle_mm_fault) from [<c001f01c>] (do_page_fault+0x114/0x2e0)
[<c001f01c>] (do_page_fault) from [<c001f34c>] (do_DataAbort+0x38/0xbc)
[<c001f34c>] (do_DataAbort) from [<c000a0dc>] (__dabt_svc+0x5c/0xa0)
Exception stack(0xc783be28 to 0xc783be70)
be20:                   b6f81898 00000760 00000000 00000055 00000051 c0af3068
be40: c71f7a00 c71f7800 b6f51000 c71df320 c7954c80 00000006 00000000 c783be78
be60: c01a099c c07a4bb4 20000153 ffffffff
[<c000a0dc>] (__dabt_svc) from [<c07a4bb4>] (__clear_user_std+0x34/0x68)
[<c07a4bb4>] (__clear_user_std) from [<c01a099c>] (clear_user+0x40/0x50)
[<c01a099c>] (clear_user) from [<c019f204>] (load_elf_binary+0x1354/0x13c4)
[<c019f204>] (load_elf_binary) from [<c013996c>] (search_binary_handler.part.4+0x58/0x1fc)
[<c013996c>] (search_binary_handler.part.4) from [<c013b18c>] (__do_execve_file+0x780/0x9a4)
[<c013b18c>] (__do_execve_file) from [<c013b54c>] (do_execve+0x28/0x30)
[<c013b54c>] (do_execve) from [<c000af1c>] (try_to_run_init_process+0xc/0x3c)
[<c000af1c>] (try_to_run_init_process) from [<c07c42fc>] (kernel_init+0x88/0xf0)
[<c07c42fc>] (kernel_init) from [<c00090b0>] (ret_from_fork+0x14/0x24)
Exception stack(0xc783bfb0 to 0xc783bff8)
bfa0:                                     00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

---
bisect log:

# bad: [ae6088216ce4b99b3a4aaaccd2eb2dd40d473d42] Merge tag 'trace-v5.5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
# good: [738d2902773e30939a982c8df7a7f94293659810] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect start 'HEAD' '738d2902773e'
# bad: [84029fd04c201a4c7e0b07ba262664900f47c6f5] memcg: account security cred as well to kmemcg
git bisect bad 84029fd04c201a4c7e0b07ba262664900f47c6f5
# good: [e35d0165908ad2d2bdb76773ef77b551763eedbd] Merge tag 'sound-5.5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good e35d0165908ad2d2bdb76773ef77b551763eedbd
# bad: [3a562aee727a7bfbb3a37b1aa934118397dad701] Merge tag 'for-5.5-rc4-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect bad 3a562aee727a7bfbb3a37b1aa934118397dad701
# good: [bed723519a72c0f68fbfaf68ed5bf55d04e46566] Merge tag 'kbuild-fixes-v5.5-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect good bed723519a72c0f68fbfaf68ed5bf55d04e46566
# bad: [b6b4aafc99d7c8dbf7d9429bf054b591daab1ad0] Merge tag 'block-5.5-20200103' of git://git.kernel.dk/linux-block
git bisect bad b6b4aafc99d7c8dbf7d9429bf054b591daab1ad0
# bad: [429120f3df2dba2bf3a4a19f4212a53ecefc7102] block: fix splitting segments on boundary masks
git bisect bad 429120f3df2dba2bf3a4a19f4212a53ecefc7102
# good: [85a8ce62c2eabe28b9d76ca4eecf37922402df93] block: add bio_truncate to fix guard_bio_eod
git bisect good 85a8ce62c2eabe28b9d76ca4eecf37922402df93
# first bad commit: [429120f3df2dba2bf3a4a19f4212a53ecefc7102] block: fix splitting segments on boundary masks
