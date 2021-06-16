Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED70C48BE8
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15536135C
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhFPNC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhFPNCS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 09:02:18 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B707C061574
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 06:00:13 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id d27-20020a4a3c1b0000b029024983ef66dbso657965ooa.3
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wr3evAdCjQtOBqG7bWvgB68DiYXGxJ1XTZfxGH51J5I=;
        b=w97B3s49URV+ATkttjsdN0zOG8oOjVQPHIECkcvPIkev3cXQMKkqKDGceaUXg6TRlB
         ZNfFARexpheCQDAZDqTy3Uo+NfrnuOVVadFiL3AEaKutz5Vtofyfnx4sk/qK4R75gM/c
         Qjy4Aup6kIuOscF1OWhA+RxwSiWRHNJNTye6zPEG542g8FPGt5dVCtD0NCyXD+fy8Mav
         h9UdpknUijW50fkRtrnMqvB/ahko46bGyk6LvrkblyA2bQIMRjK+ll8HFYnjhqQ6dXBz
         SE+dl0O29hV9bXID+KBr6U23JKzLELSpqZxmq/FsSxclkVusX35GefQNpFSFXi7bAuu2
         GihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wr3evAdCjQtOBqG7bWvgB68DiYXGxJ1XTZfxGH51J5I=;
        b=NXzoGiCG1JvMRYsd3MFUBYP9fHSp8TgGq3ihNtxTboDKTL5sKeyMTctsTrsnbBli01
         si5XdtshcWVCB+uD2tG46G+VSDlhlWQoTZEzt8C51SD/tyOvVqRM06khT3DJOZNkZTw5
         cvWpREyJi9ZHRBru/6uN0zM0E/9GXZ4fODfy1jTwQyn8d5cxhwX7I2mh7kiwbjrZYqTt
         R6WhNLskqGeAD+5z0r2d6mmNkG9e3mFJOEpRuFSTGj5CeJvtPqqbpuU0NZLLDz6u8xAW
         OJM65zxJhpNOlrDlg9xQWWPxAejYirL/F+W29dFR+aXXgBr3WuqvJZqo6lrl29vZifDp
         y7zg==
X-Gm-Message-State: AOAM532LHI0CW161vD0evq2qLgSx2CvktYavt8S5Y9k71BiTj3iBAp+Z
        vnaSaFPiUrq4/1vPNp2RAu8kEA==
X-Google-Smtp-Source: ABdhPJxmaLQ98fPlcumfuprdDdLFkFT/5m2A/oQjFNB9PbXSSRVXmQHQY0OngqHatwxcNNdyoZ288A==
X-Received: by 2002:a4a:5182:: with SMTP id s124mr3984545ooa.34.1623848412425;
        Wed, 16 Jun 2021 06:00:12 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id p65sm459376oop.0.2021.06.16.06.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 06:00:12 -0700 (PDT)
Subject: Re: kernel panic when scanning MTD partitions
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-block@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <YMntfiE7J8r0dtV1@Red>
 <1424d9da-5e11-3ba8-82ae-85f95f60ca9d@kernel.dk> <YMn1lhq4Sl9ipY9a@Red>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <00d45681-5dfc-3c93-5699-4652c71128dd@kernel.dk>
Date:   Wed, 16 Jun 2021 07:00:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YMn1lhq4Sl9ipY9a@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/21 6:59 AM, Corentin Labbe wrote:
> Le Wed, Jun 16, 2021 at 06:54:41AM -0600, Jens Axboe a écrit :
>> On 6/16/21 6:24 AM, Corentin Labbe wrote:
>>> Hello
>>>
>>> When scanning MTD partitions my kernel panic:
>>> Searching for RedBoot partition table in 30000000.flash at offset 0xfe0000
>>> 7 RedBoot partitions found on MTD device 30000000.flash
>>> Creating 7 MTD partitions on "30000000.flash":
>>> 0x000000000000-0x000000020000 : "BOOT"
>>> 8<--- cut here ---
>>> Unable to handle kernel NULL pointer dereference at virtual address 00000034
>>> pgd = (ptrval)
>>> [00000034] *pgd=00000000
>>> Internal error: Oops: 17 [#1] PREEMPT ARM
>>> Modules linked in:
>>> CPU: 0 PID: 1 Comm: swapper Not tainted 5.13.0-rc6-next-20210615+ #101
>>> Hardware name: Gemini (Device Tree)
>>> PC is at _set_bit+0x20/0x4c
>>> LR is at blk_queue_write_cache+0x20/0x5c
>>> pc : [<c02f2194>]    lr : [<c029d6c0>]    psr: 60000093
>>> sp : c1439ca0  ip : 60000013  fp : c4058c00
>>> r10: 00000000  r9 : c4058ab8  r8 : c1c553b8
>>> r7 : c3f71080  r6 : 00000000  r5 : 00000000  r4 : 00000000
>>> r3 : 00020000  r2 : 00000011  r1 : 00000034  r0 : 00000000
>>> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
>>> Control: 0000397f  Table: 02338000  DAC: 00000053
>>> Register r0 information: NULL pointer
>>> Register r1 information: non-paged memory
>>> Register r2 information: non-paged memory
>>> Register r3 information: non-paged memory
>>> Register r4 information: NULL pointer
>>> Register r5 information: NULL pointer
>>> Register r6 information: NULL pointer
>>> Register r7 information: slab kmalloc-128 start c3f71080 pointer offset 0 size 128
>>> Register r8 information: slab dentry start c1c553b8 pointer offset 0 size 40
>>> Register r9 information: slab kmalloc-1k start c4058800 pointer offset 696 size 1024
>>> Register r10 information: NULL pointer
>>> Register r11 information: slab kmalloc-1k start c4058c00 pointer offset 0 size 1024
>>> Register r12 information: non-paged memory
>>> Process swapper (pid: 1, stack limit = 0x(ptrval))
>>> Stack: (0xc1439ca0 to 0xc143a000)
>>> 9ca0: c231a480 c07ab67c 00000000 c03cd1b8 00000000 c00f4b18 c07ab67c c231a480
>>> 9cc0: c4058c00 c07ab67c 05a00000 c03ce474 c07ab67c c4058c00 c07ab658 c03ccf88
>>> 9ce0: c4058c00 c07ab660 c07ab434 c03c7328 c068ab50 00000000 c4058cf8 c40912c0
>>> 9d00: ffffffff 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>> 9d20: 00000101 00000000 00000001 c03c6ba8 00000000 00020000 00000001 00000001
>>> 9d40: c4058c00 00000000 00000000 4af56ea3 00000000 c4058800 c4058800 c406f000
>>> 9d60: 00000007 c03ca0fc 00000000 00000000 00000007 c07ab638 c05c6c84 00000000
>>> 9d80: 00000007 c4058800 c1438000 00000000 00000000 c03c9f90 00000001 c05c6c88
>>> 9da0: 00000000 00000000 c406f000 00000007 c07ab638 4af56ea3 00002201 c4058800
>>> 9dc0: c05c6c84 00000000 00000000 c221c2a0 c2215810 00000000 00000000 c03c7694
>>> 9de0: 00000001 c4009c20 c4008500 c2215800 c221c2a0 c03dc4a0 00000000 c0196864
>>> 9e00: 00000000 c4008500 c4052b58 00000000 00000002 4af56ea3 00000000 00000000
>>> 9e20: c2215810 c07ab928 00000000 c07ab928 00000000 c07bb000 c06f73e0 c037b898
>>> 9e40: c2215810 c0815554 00000000 00000000 c07ab928 c03796fc c2215810 c07ab928
>>> 9e60: c2215854 c07ab928 c071c830 c06d408c c07bb000 c0379b4c c2215810 00000000
>>> 9e80: c2215854 c037a0ec 00000000 c07ab928 c2215810 c07a9fb0 c071c830 c037a17c
>>> 9ea0: 00000000 c07ab928 c037a0f4 c0377584 c143e11c c143e10c c140c530 4af56ea3
>>> 9ec0: c07ab928 c4008480 00000000 c0378a68 c068d2f4 c068d2f4 c06f73e0 c07ab928
>>> 9ee0: 00000000 00000000 c07bb000 c037a818 c07117f8 ffffe000 00000000 c00097ac
>>> 9f00: c1403b00 c1403b08 c1403aff c0035200 00000000 c0694bc0 0000009f 00000000
>>> 9f20: 00000000 c06f73e0 00000006 00000006 00000000 c1403b16 c1403b1d 4af56ea3
>>> 9f40: 00000000 00000006 0000009f 4af56ea3 c071c84c c0724380 00000007 c1403b00
>>> 9f60: c071c850 c06f8108 00000006 00000006 00000000 c06f73e0 00000000 0000009f
>>> 9f80: c0558560 00000000 c0558560 00000000 00000000 00000000 00000000 00000000
>>> 9fa0: 00000000 c0558570 00000000 c0008348 00000000 00000000 00000000 00000000
>>> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
>>> [<c02f2194>] (_set_bit) from [<c029d6c0>] (blk_queue_write_cache+0x20/0x5c)
>>> [<c029d6c0>] (blk_queue_write_cache) from [<c03cd1b8>] (add_mtd_blktrans_dev+0x218/0x3cc)
>>> [<c03cd1b8>] (add_mtd_blktrans_dev) from [<c03ce474>] (mtdblock_add_mtd+0x60/0x78)
>>> [<c03ce474>] (mtdblock_add_mtd) from [<c03ccf88>] (blktrans_notify_add+0x3c/0x54)
>>> [<c03ccf88>] (blktrans_notify_add) from [<c03c7328>] (add_mtd_device+0x3bc/0x5e8)
>>> [<c03c7328>] (add_mtd_device) from [<c03ca0fc>] (add_mtd_partitions+0xc4/0x16c)
>>> [<c03ca0fc>] (add_mtd_partitions) from [<c03c9f90>] (parse_mtd_partitions+0x370/0x418)
>>> [<c03c9f90>] (parse_mtd_partitions) from [<c03c7694>] (mtd_device_parse_register+0x74/0x2c4)
>>> [<c03c7694>] (mtd_device_parse_register) from [<c03dc4a0>] (physmap_flash_probe+0x5e8/0x808)
>>> [<c03dc4a0>] (physmap_flash_probe) from [<c037b898>] (platform_probe+0x5c/0xbc)
>>> [<c037b898>] (platform_probe) from [<c03796fc>] (really_probe+0xf8/0x4e8)
>>> [<c03796fc>] (really_probe) from [<c0379b4c>] (driver_probe_device+0x60/0xb8)
>>> [<c0379b4c>] (driver_probe_device) from [<c037a0ec>] (device_driver_attach+0xa8/0xb0)
>>> [<c037a0ec>] (device_driver_attach) from [<c037a17c>] (__driver_attach+0x88/0x11c)
>>> [<c037a17c>] (__driver_attach) from [<c0377584>] (bus_for_each_dev+0x78/0xc4)
>>> [<c0377584>] (bus_for_each_dev) from [<c0378a68>] (bus_add_driver+0xe8/0x1d0)
>>> [<c0378a68>] (bus_add_driver) from [<c037a818>] (driver_register+0x88/0x118)
>>> [<c037a818>] (driver_register) from [<c00097ac>] (do_one_initcall+0x50/0x1e0)
>>> [<c00097ac>] (do_one_initcall) from [<c06f8108>] (kernel_init_freeable+0x178/0x200)
>>> [<c06f8108>] (kernel_init_freeable) from [<c0558570>] (kernel_init+0x10/0x100)
>>> [<c0558570>] (kernel_init) from [<c0008348>] (ret_from_fork+0x14/0x2c)
>>> Exception stack(0xc1439fb0 to 0xc1439ff8)
>>> 9fa0:                                     00000000 00000000 00000000 00000000
>>> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>> 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>> Code: e3a03001 e1a03213 e10fc000 e321f093 (e7912100) 
>>> ---[ end trace f3b2f52ba3b0d435 ]---
>>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>>> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
>>>
>>> This happen on 5.13.0-rc6-next-20210615+ on my ARM Gemini ssi1328.
>>
>> Should be fixed once for-next updates the block branch.
>>
> 
> Thanks, do you have a link to the fix ? or patch name.

Yep, this one:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.14/block&id=07a719f8fdbe4ae0f825fa1a6d2755a63deb265e

-- 
Jens Axboe

