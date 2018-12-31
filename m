Return-Path: <SRS0=5hX+=PI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FA1C43387
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694E620643
	for <linux-block@archiver.kernel.org>; Mon, 31 Dec 2018 17:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mqQTA1tO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeLaRUd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Dec 2018 12:20:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43616 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbeLaRUd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Dec 2018 12:20:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so12874179pgk.10
        for <linux-block@vger.kernel.org>; Mon, 31 Dec 2018 09:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YNAT8rHz5hGWy/vgi2TyCGEubvALNl5/fFKu8eZEoKI=;
        b=mqQTA1tO7uLzdGdMPV8sMcTv0z9GG0l2fue8XqKtY59gjx4QQrvh4a8Y76PI3oAaVy
         JMdksMdt1iusGG/mu07RTquV6D9tmHntIDXrqiH5lChquDXjY/860s0jC9rMl0a0gUzE
         3z0ZIaEY5IlnswKrCOTGbKEJTwpY2jkJ3DE2YVocI7LyV6ToXs1dEzO/2w+amnYYPouO
         j9reCLFHsPs0pnnZtINaprqIiSasoiSsc5LT0Sj93jaB3NuBoyAjHzonvLuaOH5EaAvv
         oFhUCS8kuJfiCuMP3ohl3hNxKwstl4xoLR41+8aYZlZtJh1hgDyZUDvux8zVpDa43mv/
         oEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YNAT8rHz5hGWy/vgi2TyCGEubvALNl5/fFKu8eZEoKI=;
        b=rbg+WDIAb9V6q8gLyDLxYPDVXggt8xp+g7wb+6h12AhjKTA/2na/CkfQu5MrM5Aoeo
         d+Y/JEg8SOk5X9bvhqyp39cDaMOk+4jEO67mmed31gpIVfJlz63QAriBfrgLXsTtk+oX
         UxPh1HqSIkVWntvWu0h2JqQm8V5W810gy97br8/tbDPFC1O3YODS8xTWv2Z6DM2AUKYz
         zJhwMkLEucVGhy5mq6FpTmfSzjU1Kxu2qzO7wrxVwUEwR/AVRiDaBr0lhN6nekpWoyt0
         BNGn+zXoh7RhRy13Tq/vKoSOde7Kg4hd1PIbeu0z1uvqrO3rYndri8Mui8iN85AbDGSp
         AzcQ==
X-Gm-Message-State: AJcUukfRAEKPLtYk83CGR8BGT6/cEoc3FxCoMzeCc74r4/6QoMh6C7h7
        l44lewjw8wN6HM+ZymwrbbApeA==
X-Google-Smtp-Source: ALg8bN6P2VfjzXeXQKdulknKmgdXEQRzbz37AAl+7En8RXwooms2VHNlW04nU1HNVySXw+XBnsTlnA==
X-Received: by 2002:a63:6c48:: with SMTP id h69mr7842971pgc.139.1546276832563;
        Mon, 31 Dec 2018 09:20:32 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z191sm59764915pgd.74.2018.12.31.09.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 09:20:31 -0800 (PST)
Subject: Re: [PATCH] block/swim3: Fix regression on PowerBook G3
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <594abbd4bbf6a55878869bc02d1614269bb9b3c5.1546235049.git.fthain@telegraphics.com.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4712a99a-c1bd-f9bf-6674-57b6b891847d@kernel.dk>
Date:   Mon, 31 Dec 2018 10:20:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <594abbd4bbf6a55878869bc02d1614269bb9b3c5.1546235049.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/30/18 10:44 PM, Finn Thain wrote:
> As of v4.20, the swim3 driver crashes when loaded on a PowerBook G3
> (Wallstreet).
> 
> MacIO PCI driver attached to Gatwick chipset
> MacIO PCI driver attached to Heathrow chipset
> swim3 0.00015000:floppy: [fd0] SWIM3 floppy controller in media bay
> 0.00013020:ch-a: ttyS0 at MMIO 0xf3013020 (irq = 16, base_baud = 230400) is a Z85c30 ESCC - Serial port
> 0.00013000:ch-b: ttyS1 at MMIO 0xf3013000 (irq = 17, base_baud = 230400) is a Z85c30 ESCC - Infrared port
> macio: fixed media-bay irq on gatwick
> macio: fixed left floppy irqs
> swim3 1.00015000:floppy: [fd1] Couldn't request interrupt
> Unable to handle kernel paging request for data at address 0x00000024
> Faulting instruction address: 0xc02652f8
> Oops: Kernel access of bad area, sig: 11 [#1]
> BE SMP NR_CPUS=2 PowerMac
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.20.0 #2
> NIP:  c02652f8 LR: c026915c CTR: c0276d1c
> REGS: df43ba10 TRAP: 0300   Not tainted  (4.20.0)
> MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 28228288  XER: 00000100
> DAR: 00000024 DSISR: 40000000
> GPR00: c026915c df43bac0 df439060 c0731524 df494700 00000000 c06e1c08 00000001
> GPR08: 00000001 00000000 df5ff220 00001032 28228282 00000000 c0004ca4 00000000
> GPR16: 00000000 00000000 00000000 c073144c dfffe064 c0731524 00000120 c0586108
> GPR24: c073132c c073143c c073143c 00000000 c0731524 df67cd70 df494700 00000001
> NIP [c02652f8] blk_mq_free_rqs+0x28/0xf8
> LR [c026915c] blk_mq_sched_tags_teardown+0x58/0x84
> Call Trace:
> [df43bac0] [c0045f50] flush_workqueue_prep_pwqs+0x178/0x1c4 (unreliable)
> [df43bae0] [c026915c] blk_mq_sched_tags_teardown+0x58/0x84
> [df43bb00] [c02697f0] blk_mq_exit_sched+0x9c/0xb8
> [df43bb20] [c0252794] elevator_exit+0x84/0xa4
> [df43bb40] [c0256538] blk_exit_queue+0x30/0x50
> [df43bb50] [c0256640] blk_cleanup_queue+0xe8/0x184
> [df43bb70] [c034732c] swim3_attach+0x330/0x5f0
> [df43bbb0] [c034fb24] macio_device_probe+0x58/0xec
> [df43bbd0] [c032ba88] really_probe+0x1e4/0x2f4
> [df43bc00] [c032bd28] driver_probe_device+0x64/0x204
> [df43bc20] [c0329ac4] bus_for_each_drv+0x60/0xac
> [df43bc50] [c032b824] __device_attach+0xe8/0x160
> [df43bc80] [c032ab38] bus_probe_device+0xa0/0xbc
> [df43bca0] [c0327338] device_add+0x3d8/0x630
> [df43bcf0] [c0350848] macio_add_one_device+0x444/0x48c
> [df43bd50] [c03509f8] macio_pci_add_devices+0x168/0x1bc
> [df43bd90] [c03500ec] macio_pci_probe+0xc0/0x10c
> [df43bda0] [c02ad884] pci_device_probe+0xd4/0x184
> [df43bdd0] [c032ba88] really_probe+0x1e4/0x2f4
> [df43be00] [c032bd28] driver_probe_device+0x64/0x204
> [df43be20] [c032bfcc] __driver_attach+0x104/0x108
> [df43be40] [c0329a00] bus_for_each_dev+0x64/0xb4
> [df43be70] [c032add8] bus_add_driver+0x154/0x238
> [df43be90] [c032ca24] driver_register+0x84/0x148
> [df43bea0] [c0004aa0] do_one_initcall+0x40/0x188
> [df43bf00] [c0690100] kernel_init_freeable+0x138/0x1d4
> [df43bf30] [c0004cbc] kernel_init+0x18/0x10c
> [df43bf40] [c00121e4] ret_from_kernel_thread+0x14/0x1c
> Instruction dump:
> 5484d97e 4bfff4f4 9421ffe0 7c0802a6 bf410008 7c9e2378 90010024 8124005c
> 2f890000 419e0078 81230004 7c7c1b78 <81290024> 2f890000 419e0064 81440000
> ---[ end trace 12025ab921a9784c ]---
> 
> Reverting commit 8ccb8cb1892b ("swim3: convert to blk-mq") resolves the
> problem.
> 
> That commit added a struct blk_mq_tag_set to struct floppy_state and
> initialized it with a blk_mq_init_sq_queue() call. Unfortunately, there
> is a memset() in swim3_add_device() that subsequently clears the
> floppy_state struct. That means fs->tag_set->ops is a NULL pointer, and
> it gets dereferenced by blk_mq_free_rqs() which gets called in the
> request_irq() error path. Move the memset() to fix this bug.
> 
> BTW, the request_irq() failure for the left mediabay floppy (fd1) is not
> a regression. I don't know why it happens. The right media bay floppy
> (fd0) works fine however.

Applied, thanks.

-- 
Jens Axboe

