Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD3C433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 11:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5DF23109
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 11:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbhALL1C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 06:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbhALL1C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 06:27:02 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A9EC061575
        for <linux-block@vger.kernel.org>; Tue, 12 Jan 2021 03:26:21 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id m6so1214730pfm.6
        for <linux-block@vger.kernel.org>; Tue, 12 Jan 2021 03:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=69lJu+5uJVh3g3QBR1OSlKVM9BJBfcSQPSXxMNaTocE=;
        b=hP8Azw9xBW9eu1pXHPKelXVV0ijD0O+s5OIogg7yckgPeU38vnSrtZgnYvg85Sym1+
         oj6ffRT0bLKN7Y8jzuCEaBQbeFZQXszFk7fEV2CKxW1WGZoDMYB5j//j6NdCru8KCNf9
         h02FV2mBdXhqv6KBbVt9WhdHVs5uGLuapcG9yxcfrF8ELvH47cz5ihzDJE1sysAf5Ez5
         pq9eZ+3vArevzUlXjx+Cd4jXeGlWdbGQvGdTasudvAcqWKWh4kFhgj+N4cGw2R0E4ryH
         KYoU2XUuCGZ3DjM/smZIN9GQReN+wu4bNvcRehgaPEbFqLOH7IIN3VEJy9DvT/1aL57c
         lFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=69lJu+5uJVh3g3QBR1OSlKVM9BJBfcSQPSXxMNaTocE=;
        b=jySwEbI4fPuY6OTOeHDrijEioJDKD5GqPP90TfXnePGt3HfUIQKfUu10nFM0SRcLfv
         U8Ez26zLOrHtii6xFK+yfxpyG/VXj6igetahmqAAOs0wqpy01jSiux7DDXzYNZAHxzS6
         6ejoFJVpu3cBcUK3NWFbaX58D5lvHmd1gJ2Oo0ZXky8Tt6C811UyYynbWUgJ8WW3Scn2
         e5rMAnHFiLt0vkK1FRFZ9DljDkO8XVzM7gL4Ym0kBYxSEd4KsEaqKoT8KDzvn1T5McJu
         5r7cqYWXLsaT3zlNL4uEh6PEcJK2Y3NRl3v3dK5TO2gHGRYTUaUaEm0B07O4fSip/SUN
         Pqfw==
X-Gm-Message-State: AOAM532cF1GGaoEb+PTueXKfYr1p+uIqjDCzkkjdGnmIKshC2HWs5Vv1
        2Rfz/Ho9TfEifpj0sVRiyZ0=
X-Google-Smtp-Source: ABdhPJyDEo3T7deZnXcLUwDLF+oKf6/a/m6Oz8qNzK34lIw8PUt3ShbwB1fcGo5oBkChSlJh0mltCA==
X-Received: by 2002:a63:3246:: with SMTP id y67mr4285814pgy.438.1610450781118;
        Tue, 12 Jan 2021 03:26:21 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id u24sm2878418pjx.56.2021.01.12.03.26.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jan 2021 03:26:20 -0800 (PST)
Date:   Tue, 12 Jan 2021 20:26:18 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Subject: Re: nvme: enable char device per namespace
Message-ID: <20210112112618.GA25093@localhost.localdomain>
References: <CGME20201216181838eucas1p15c687e5d1319d3fa581990e6cca73295@eucas1p1.samsung.com>
 <20201216181828.21040-1-javier.gonz@samsung.com>
 <20210111185347.oqqzdmoglg3lzo5y@mpHalley.localdomain>
 <20210112092207.GA4888@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112092207.GA4888@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21-01-12 18:22:07, Minwoo Im wrote:
> Hello Javier,
> 
> I tested this patch based on nvme-5.11:
> 
> [    1.219747] BUG: unable to handle page fault for address: 0000000100000041
> [    1.220518] #PF: supervisor read access in kernel mode
> [    1.220582] #PF: error_code(0x0000) - not-present page
> [    1.220582] PGD 0 P4D 0
> [    1.220582] Oops: 0000 [#1] SMP PTI
> [    1.220582] CPU: 0 PID: 7 Comm: kworker/u16:0 Not tainted 5.11.0-rc1+ #46
> [    1.220582] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [    1.220582] Workqueue: nvme-wq nvme_scan_work
> [    1.220582] RIP: 0010:nvme_ns_id_attrs_are_visible+0x10f/0x152
> [    1.220582] Code: 81 7d d0 80 f9 a1 82 74 0a 48 81 7d d0 a0 f9 a1 82 75 50 48 8b 45 e8 48 89 45 f8 48 8b 45 f8 48 83 e8 60 48 8b 80 60 03 00 00 <48> 8b 40 40 48 3d e0 d1 4d 82 74 07 b8 00 00 00 00 eb 2e 48 8b 45
> [    1.220582] RSP: 0000:ffffc90000047b70 EFLAGS: 00010282
> [    1.220582] RAX: 0000000100000001 RBX: ffffffff824ddb20 RCX: 0000000000000124
> [    1.220582] RDX: ffff8881026eac00 RSI: ffffffff82a1f980 RDI: ffff888102745058
> [    1.220582] RBP: ffffc90000047ba8 R08: ffff888102948718 R09: 0000000000000000
> [    1.220582] R10: 0000000000000000 R11: ffff888100465080 R12: ffff888102745058
> [    1.220582] R13: ffff888102948600 R14: 0000000000000000 R15: ffffffff82a1f548
> [    1.220582] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
> [    1.220582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.220582] CR2: 0000000100000041 CR3: 000000000280c001 CR4: 0000000000370ef0
> [    1.220582] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.220582] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    1.220582] Call Trace:
> [    1.220582]  internal_create_group+0xde/0x390
> [    1.220582]  internal_create_groups.part.4+0x3e/0xa0
> [    1.220582]  device_add+0x3cf/0x830
> [    1.220582]  ? cdev_get+0x20/0x20
> [    1.220582]  ? cdev_purge+0x60/0x60
> [    1.220582]  cdev_device_add+0x44/0x70
> [    1.220582]  ? cdev_init+0x50/0x60
> [    1.220582]  nvme_alloc_chardev_ns+0x187/0x1eb
> [    1.220582]  nvme_alloc_ns+0x367/0x460
> [    1.220582]  nvme_validate_or_alloc_ns+0xe2/0x139
> [    1.220582]  nvme_scan_ns_list+0x113/0x17a
> [    1.220582]  nvme_scan_work+0xa5/0x106
> [    1.220582]  process_one_work+0x1dd/0x3e0
> [    1.220582]  worker_thread+0x2d/0x3b0
> [    1.220582]  ? cancel_delayed_work+0x90/0x90
> [    1.220582]  kthread+0x117/0x130
> [    1.220582]  ? kthread_park+0x90/0x90
> [    1.220582]  ret_from_fork+0x22/0x30
> [    1.220582] Modules linked in:
> [    1.220582] CR2: 0000000100000041
> [    1.220582] ---[ end trace b1f509a1bbfbc113 ]---
> [    1.220582] RIP: 0010:nvme_ns_id_attrs_are_visible+0x10f/0x152
> [    1.220582] Code: 81 7d d0 80 f9 a1 82 74 0a 48 81 7d d0 a0 f9 a1 82 75 50 48 8b 45 e8 48 89 45 f8 48 8b 45 f8 48 83 e8 60 48 8b 80 60 03 00 00 <48> 8b 40 40 48 3d e0 d1 4d 82 74 07 b8 00 00 00 00 eb 2e 48 8b 45
> [    1.220582] RSP: 0000:ffffc90000047b70 EFLAGS: 00010282
> [    1.220582] RAX: 0000000100000001 RBX: ffffffff824ddb20 RCX: 0000000000000124
> [    1.220582] RDX: ffff8881026eac00 RSI: ffffffff82a1f980 RDI: ffff888102745058
> [    1.220582] RBP: ffffc90000047ba8 R08: ffff888102948718 R09: 0000000000000000
> [    1.220582] R10: 0000000000000000 R11: ffff888100465080 R12: ffff888102745058
> [    1.220582] R13: ffff888102948600 R14: 0000000000000000 R15: ffffffff82a1f548
> [    1.220582] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
> [    1.220582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.220582] CR2: 0000000100000041 CR3: 000000000280c001 CR4: 0000000000370ef0
> [    1.220582] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.220582] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> And this happens when CONFIG_NVME_MULTIPATH=y configured.  Please refere
> attached log up there :)
> 
> Thanks!

If this chardev has to have ns_id_attr_group, we need to consider
nvme_ns_id_attrs_are_visible() to take care of dev_to_disk(dev) in case
non-block device.

Thanks!
