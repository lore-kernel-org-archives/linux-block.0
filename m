Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C696C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 14:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiKHONw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiKHONv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 09:13:51 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A8C13E13
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 06:13:50 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso1661878pjn.0
        for <linux-block@vger.kernel.org>; Tue, 08 Nov 2022 06:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcQMPR+vY4HDnxFrn6DWfgOLsByM9wrckBFX6ElxCNo=;
        b=Bizwli3rHid237sI4fMedw4c8a0QLD9BkHZak1F3/W2+Ttp4sBANl46L65mjSkjyYq
         ug1PKOs0KVPJW6TP0t45QeiEMzgpMAL45uaLZDGsfzoCjFQdVqDMMaw/P40TebA8xqfC
         umhQpYXilzAXzrE8okAaowBOjzKlr9ENR/2WOMXbDhhEHDFsIyrl7gzd70QgkJpV7/hu
         ENG9jAn3nVRCZlRJKKK822sj5g/tY3xd099LfQgDv9nLZKIkMrlJCxGm4S4S58CxfP1M
         Hmudfr1TOBKCEGK5pDesRmBsyUyypKca+S6KiVZbAiBZvPXIjQkqnxL32/QIYYiAYor0
         94oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcQMPR+vY4HDnxFrn6DWfgOLsByM9wrckBFX6ElxCNo=;
        b=T0lAMi0349H5OPlb4DrZAP8mWwGPKybPjpscYACeygbmvc22hbBmaSCjsFIOjNO1b3
         fGJj48pkQpEto/5p1b/LRItYETx5TX6k8fTl6uCGVrcUrKKpUJJXcrLPQH4jkM0CXEMe
         N3KEWRdT4ti69JEjCAJ/tVG2Rc1vrRjQ2BXvxe+RcjoGfIv3Ue09wvZ+eKwVpM4mrnxK
         OAIRBJVJf52epsVxuXd36suZdPL/2hejQK4rDnM2VMCgxbq+89+pvr/+V+zji12EvS+6
         hT67BizgFbl0cE6epWyLPld8dW7jStRJy8fU6E6Dk1w1Pytl4tCiCSEDshAWy6HId2tW
         /HCA==
X-Gm-Message-State: ACrzQf3YA5gHcHSr1bSEnHnochLsluPLLZE04JHXZNMwxZPYpzIvASuC
        WK6NKoZg6cuv0DzIE7ZqkWB+wg==
X-Google-Smtp-Source: AMsMyM5zxvdud31Qbb+bQN25uiMe9e8WvZFbz7Q1KitTWD0alMPuk/FYR15AQKD+QTt79ecUubHnAA==
X-Received: by 2002:a17:90b:3803:b0:213:9911:5efd with SMTP id mq3-20020a17090b380300b0021399115efdmr55615477pjb.94.1667916829870;
        Tue, 08 Nov 2022 06:13:49 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w188-20020a627bc5000000b005672daedc8fsm6425059pfc.81.2022.11.08.06.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:13:49 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
        josef@toxicpanda.com, paolo.valente@linaro.org, jack@suse.cz
Cc:     linux-block@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
In-Reply-To: <20221108103434.2853269-1-yukuai1@huaweicloud.com>
References: <20221108103434.2853269-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block, bfq: fix null pointer dereference in bfq_bio_bfqg()
Message-Id: <166791682840.41277.4130538125529354302.b4-ty@kernel.dk>
Date:   Tue, 08 Nov 2022 07:13:48 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 8 Nov 2022 18:34:34 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Out test found a following problem in kernel 5.10, and the same problem
> should exist in mainline:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000094
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP
> CPU: 7 PID: 155 Comm: kworker/7:1 Not tainted 5.10.0-01932-g19e0ace2ca1d-dirty 4
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-b4
> Workqueue: kthrotld blk_throtl_dispatch_work_fn
> RIP: 0010:bfq_bio_bfqg+0x52/0xc0
> Code: 94 00 00 00 00 75 2e 48 8b 40 30 48 83 05 35 06 c8 0b 01 48 85 c0 74 3d 4b
> RSP: 0018:ffffc90001a1fba0 EFLAGS: 00010002
> RAX: ffff888100d60400 RBX: ffff8881132e7000 RCX: 0000000000000000
> RDX: 0000000000000017 RSI: ffff888103580a18 RDI: ffff888103580a18
> RBP: ffff8881132e7000 R08: 0000000000000000 R09: ffffc90001a1fe10
> R10: 0000000000000a20 R11: 0000000000034320 R12: 0000000000000000
> R13: ffff888103580a18 R14: ffff888114447000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88881fdc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000094 CR3: 0000000100cdb000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  bfq_bic_update_cgroup+0x3c/0x350
>  ? ioc_create_icq+0x42/0x270
>  bfq_init_rq+0xfd/0x1060
>  bfq_insert_requests+0x20f/0x1cc0
>  ? ioc_create_icq+0x122/0x270
>  blk_mq_sched_insert_requests+0x86/0x1d0
>  blk_mq_flush_plug_list+0x193/0x2a0
>  blk_flush_plug_list+0x127/0x170
>  blk_finish_plug+0x31/0x50
>  blk_throtl_dispatch_work_fn+0x151/0x190
>  process_one_work+0x27c/0x5f0
>  worker_thread+0x28b/0x6b0
>  ? rescuer_thread+0x590/0x590
>  kthread+0x153/0x1b0
>  ? kthread_flush_work+0x170/0x170
>  ret_from_fork+0x1f/0x30
> Modules linked in:
> CR2: 0000000000000094
> ---[ end trace e2e59ac014314547 ]---
> RIP: 0010:bfq_bio_bfqg+0x52/0xc0
> Code: 94 00 00 00 00 75 2e 48 8b 40 30 48 83 05 35 06 c8 0b 01 48 85 c0 74 3d 4b
> RSP: 0018:ffffc90001a1fba0 EFLAGS: 00010002
> RAX: ffff888100d60400 RBX: ffff8881132e7000 RCX: 0000000000000000
> RDX: 0000000000000017 RSI: ffff888103580a18 RDI: ffff888103580a18
> RBP: ffff8881132e7000 R08: 0000000000000000 R09: ffffc90001a1fe10
> R10: 0000000000000a20 R11: 0000000000034320 R12: 0000000000000000
> R13: ffff888103580a18 R14: ffff888114447000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88881fdc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000094 CR3: 0000000100cdb000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix null pointer dereference in bfq_bio_bfqg()
      commit: f02be9002c480cd3ec0fcf184ad27cf531bd6ece

Best regards,
-- 
Jens Axboe


