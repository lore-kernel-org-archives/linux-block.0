Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64450C433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157A06023E
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 12:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhDZMsV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbhDZMsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 08:48:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C147CC061574
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 05:47:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 20so24921912pll.7
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 05:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QPxpC9iYR5mpQzHImP3CkrLQ3VY7vpD7mywk3HI7DqQ=;
        b=kdyvB2RCtaqPeWW+UzH8TrlfOnuHbwGgIhYxIlVVabg8Oh9PIqB20A336DmKBXOGpV
         sZH69kNl9K6T/wMfTrD/aFb+0AYd/nh3c6S7GjgwUyEwMUXlGMiaJFENafrcz7vLm8fs
         6IjusMFxYaaGSHXivSIfdMkKdW00TC4c8J6ONuFeSc4vENVuU0dhyAYG1bn3ftDZ+/Cr
         rMUsTWoXeRY96am54Vr0idAQmR4UpwklocdUiJi0cHn+nU8u7mzIbHJbmJkvORCZttsD
         UievD8LI1wJzS+95Kx2lZ+iqZQ4hvfcSEbZMH9WFlbiJ5dWvCn/aNkzGLpKp8vxv8bBB
         Z8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QPxpC9iYR5mpQzHImP3CkrLQ3VY7vpD7mywk3HI7DqQ=;
        b=i//Z+4adTNJj/6NEQTFAXUYp9MdBiEOmvLiUZ9IBwCXstJAWkoq5rE+IusfT7eQhov
         1aWMQ/ohtGVkuqiYBf/rOzDrJcwzzw6jgkXXY/dafrl6UHbCZTAzI7rTEoSSdwehAkPz
         qGB49Z/jHqRkoOOQKLMof2ZmuMTfllyjQ+OlFnkC1mIeKRgGc0ZVODqJvfIJKf+Ev6KG
         vZZZc+qcG2D+avEggX/kn7Yimi94KhVJUPW1xhKPh8+lvP7oI5SUZtmdyrLp18R2jMxJ
         TFYwSMP7jBq76UyXClv+g446cjCghNXxPJuncakPYaizZx9gLlNJBCqejwYkbNx7Nmzs
         Jktw==
X-Gm-Message-State: AOAM531qJL/5BiUVaU9jyoub0OFSY/Dp+bTIjOHx3iRi+yJ4kFCDzQil
        kicd9OMEUC4YHDChY3CSmURQzpO/rV5Gfg==
X-Google-Smtp-Source: ABdhPJxReNftSLEm87GDq7aZWXBFSXhBx1QxraV/1C4ZzankeKFCA1C+RcQSlm+ZL5ziB+R67LUzeg==
X-Received: by 2002:a17:90a:d582:: with SMTP id v2mr22387816pju.88.1619441239283;
        Mon, 26 Apr 2021 05:47:19 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i11sm11286972pfo.183.2021.04.26.05.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 05:47:18 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=f0=9f=92=a5_PANICKED=3a_Test_report_for_kernel_5?=
 =?UTF-8?B?LjEyLjAtcmM4IChibG9jaywgZmZhNzdhZjUp?=
To:     Bruno Goncalves <bgoncalv@redhat.com>,
        CKI Project <cki-project@redhat.com>
Cc:     skt-results-master@redhat.com, linux-block@vger.kernel.org,
        Memory Management <mm-qe@redhat.com>,
        Jan Stancek <jstancek@redhat.com>, Yi Zhang <yizhan@redhat.com>
References: <cki.82F4291912.BM5EDG8TM9@redhat.com>
 <CA+QYu4r1kC6VsaPzv0kN61fkrZZ6cxxOPh5_wrgUeZrLK-Dkng@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f5e6913-a7bc-045a-a0ef-4ccc15dd5046@kernel.dk>
Date:   Mon, 26 Apr 2021 06:47:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+QYu4r1kC6VsaPzv0kN61fkrZZ6cxxOPh5_wrgUeZrLK-Dkng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 2:40 AM, Bruno Goncalves wrote:
> We hit kernel panic with the recent commit (ffa77af5), like:
> 
> [    5.093548] usb 2-2: Product: AVO USB2 RIP
> [    5.101546] ata3.00: configured for UDMA/100
> [    5.104910] usb 2-2: Manufacturer: Avocent
> [    5.104912] usb 2-2: SerialNumber: 10343009E7D
> [    5.106686] device-mapper: uevent: version 1.0.3
> [    5.106719] BUG: kernel NULL pointer dereference, address: 0000000000000378
> [    5.106721] #PF: supervisor read access in kernel mode
> [    5.106722] #PF: error_code(0x0000) - not-present page
> [    5.106724] PGD 0 P4D 0  
> [    5.106726] Oops: 0000 [#1] SMP PTI
> [    5.106728] CPU: 2 PID: 7 Comm: kworker/u65:0 Tainted: G          I       5.12.0-rc8 #1
> [    5.106731] Hardware name: Hewlett-Packard HP Z600 Workstation/0B54h, BIOS 786G4 v03.19 03/11/2011
> [    5.106732] Workqueue: events_unbound async_run_entry_fn
> [    5.106738] RIP: 0010:bio_add_hw_page+0x4f/0x180
> [    5.106741] Code: 09 44 39 c8 0f 87 f3 00 00 00 0f b7 46 70 49 89 fc 49 89 d6 45 89 c5 66 85 c0 75 60 66 39 43 72 0f 86 d7 00 00 00 48 8b 53 08 <48> 8b 92 78 03 00 00 48 8b 52 50 8b 92 10 04 00 00 29 ea 39 53 28
> [    5.106743] RSP: 0000:ffffa1c64005fc38 EFLAGS: 00010202
> [    5.106745] RAX: 0000000000000000 RBX: ffff956641caad80 RCX: 0000000000000024
> [    5.106747] RDX: 0000000000000000 RSI: ffff956641caad80 RDI: ffff95667679afa0
> [    5.106748] RBP: 0000000000000024 R08: 0000000000000200 R09: 0000000000000400
> [    5.106749] R10: 0000000000000002 R11: ffff956641ca9e8f R12: ffff95667679afa0
> [    5.106750] R13: 0000000000000200 R14: ffffc299c00a9b40 R15: 0000000000000024
> [    5.106752] FS:  0000000000000000(0000) GS:ffff9566fc080000(0000) knlGS:0000000000000000
> [    5.106754] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.106755] CR2: 0000000000000378 CR3: 000000002a610001 CR4: 00000000000206e0
> [    5.106757] Call Trace:
> [    5.106760]  bio_add_pc_page+0x20/0x30
> [    5.106762]  blk_rq_map_kern+0x139/0x3f0
> [    5.106765]  __scsi_execute+0x204/0x250
> [    5.106770]  scsi_probe_and_add_lun+0x188/0xda0
> [    5.106774]  ? __pm_runtime_resume+0x58/0x80
> [    5.106778]  __scsi_add_device+0xdb/0xf0
> [    5.106781]  ata_scsi_scan_host+0x97/0x1d0
> [    5.106784]  async_run_entry_fn+0x39/0x160
> [    5.106786]  process_one_work+0x1ec/0x380
> [    5.106789]  worker_thread+0x53/0x3e0
> [    5.106791]  ? process_one_work+0x380/0x380
> [    5.106793]  kthread+0x11b/0x140
> [    5.106796]  ? __kthread_bind_mask+0x60/0x60
> [    5.106798]  ret_from_fork+0x22/0x30
> [    5.106804] Modules linked in:
> [    5.106805] CR2: 0000000000000378
> [    5.106807] ---[ end trace 9b02598b51db6513 ]---
> [    5.106808] RIP: 0010:bio_add_hw_page+0x4f/0x180
> [    5.106811] Code: 09 44 39 c8 0f 87 f3 00 00 00 0f b7 46 70 49 89 fc 49 89 d6 45 89 c5 66 85 c0 75 60 66 39 43 72 0f 86 d7 00 00 00 48 8b 53 08 <48> 8b 92 78 03 00 00 48 8b 52 50 8b 92 10 04 00 00 29 ea 39 53 28
> [    5.106813] RSP: 0000:ffffa1c64005fc38 EFLAGS: 00010202
> [    5.106814] RAX: 0000000000000000 RBX: ffff956641caad80 RCX: 0000000000000024
> [    5.106816] RDX: 0000000000000000 RSI: ffff956641caad80 RDI: ffff95667679afa0
> [    5.106817] RBP: 0000000000000024 R08: 0000000000000200 R09: 0000000000000400
> [    5.106818] R10: 0000000000000002 R11: ffff956641ca9e8f R12: ffff95667679afa0
> [    5.106819] R13: 0000000000000200 R14: ffffc299c00a9b40 R15: 0000000000000024
> [    5.106820] FS:  0000000000000000(0000) GS:ffff9566fc080000(0000) knlGS:0000000000000000
> [    5.106822] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.106823] CR2: 0000000000000378 CR3: 000000002a610001 CR4: 00000000000206e0
> [    5.410328] device-mapper: ioctl: 4.44.0-ioctl (2021-02-01) initialised: dm-devel@redhat.com <mailto:dm-devel@redhat.com>
> 
> 
> We can't say for sure what commit introduced the problem, but with commit "e62a826b" we didn't see this issue.

It was:

commit 15050b63567cb841e2b4137b957df52991f3b8ec
Author: Changheun Lee <nanich.lee@samsung.com>
Date:   Wed Apr 21 18:47:45 2021 +0900

    bio: limit bio max size

and it has been dropped.

-- 
Jens Axboe

