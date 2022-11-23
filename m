Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF5C433FE
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 23:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKWXRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiKWXRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 18:17:44 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F360DF17
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 15:17:40 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso53058pjq.5
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 15:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6KjeuimzDZ/Cx4Hsf5YDM0APCp0nao9auzl1Uk+IHGM=;
        b=RW2kpthqUzDUyN5jIYmLk0KjFLJLSy9t3V0XOQHNnWrvbltxlWdvdaBDk+nb22CXoI
         AtfcFehgmrMX2fu+N6ENuipr5UROd85mQacqFh0rFO2vHcJ7mAZM+fY8IE0/YBU3sDd8
         Cd2rzcNlBwecFN3e6C2BNWiWTBgE8FnWUl8NZWmYvM8xcTFml5d535xb3zqxsxQLTXqm
         4VeIN6mq+PV7TGDfBYyHN+Mv7hWTRedHt0xIbUHal8RGgzQR5yhpe/t1PPAxzBL7YEgB
         VGSh5BcDDu6KkfkJktQsR726qjAXKhhXiS/9E1L8EclTUG/8hoz4oUH6QTwI5wO7Oypl
         50EQ==
X-Gm-Message-State: ANoB5pnczNqwrDwcnKRLeIHf5zgtTCTuW3qNanIrHakWFfrtJRowYp/H
        FYaXDlOmkt+Sd4+ZXWfwn+BPEfGN78o=
X-Google-Smtp-Source: AA0mqf6MBEL3dbkFTouwqSHx+6OksWJCum4YjmQXYgxJyjXfxUzVvIfvMj4y0G+naYJbEoyFI+wqmg==
X-Received: by 2002:a17:902:ef93:b0:189:3998:17d4 with SMTP id iz19-20020a170902ef9300b00189399817d4mr7963358plb.25.1669245459030;
        Wed, 23 Nov 2022 15:17:39 -0800 (PST)
Received: from ?IPV6:2601:642:4c02:686d:4311:4764:eee7:ac6d? ([2601:642:4c02:686d:4311:4764:eee7:ac6d])
        by smtp.gmail.com with ESMTPSA id q11-20020aa7960b000000b0057460ac725bsm1832718pfg.136.2022.11.23.15.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 15:17:38 -0800 (PST)
Message-ID: <69af7ccb-6901-c84c-0e95-5682ccfb750c@acm.org>
Date:   Wed, 23 Nov 2022 15:17:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: block/for-next: Reinitialization of active object
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

If I run blktests test block/027 the warning and bug shown below appear.
It is the first time that I see a complaint like this while running
blktests. I have not yet tried to root-cause this issue.

root[7931]: run blktests block/027
[ ... ]
kernel: ------------[ cut here ]------------
kernel: ODEBUG: init active (active state 0) object type: work_struct hint: css_release_work_fn+0x0/0x480
kernel: WARNING: CPU: 38 PID: 498 at lib/debugobjects.c:502 debug_print_object+0xda/0x110
kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
kernel: Workqueue: cgwb_release cgwb_release_workfn
kernel: RIP: 0010:debug_print_object+0xda/0x110
kernel: Call Trace:
kernel:  <TASK>
kernel:  __debug_object_init+0x217/0x290
kernel:  debug_object_init+0x16/0x20
kernel:  __init_work+0x20/0x30
kernel:  css_release+0x1f/0xb0
kernel:  percpu_ref_put_many.constprop.0+0x150/0x160
kernel:  blkcg_destroy_blkgs+0x20b/0x230
kernel:  blkcg_unpin_online+0x4e/0x90
kernel:  cgwb_release_workfn+0xba/0x210
kernel:  process_one_work+0x57d/0xa80
kernel:  worker_thread+0x90/0x650
kernel:  kthread+0x185/0x1c0
kernel:  ret_from_fork+0x1f/0x30
kernel:  </TASK>
kernel: irq event stamp: 121765
kernel: hardirqs last  enabled at (121775): [<ffffffff811ae168>] __up_console_sem+0x58/0x60
kernel: hardirqs last disabled at (121792): [<ffffffff811ae14d>] __up_console_sem+0x3d/0x60
kernel: softirqs last  enabled at (121790): [<ffffffff824004d0>] __do_softirq+0x4d0/0x757
kernel: softirqs last disabled at (121785): [<ffffffff810e4e61>] __irq_exit_rcu+0xd1/0x140
kernel: ---[ end trace 0000000000000000 ]---
kernel: BUG: sleeping function called from invalid context at kernel/workqueue.c:3010
kernel: in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 498, name: kworker/38:1
kernel: preempt_count: 0, expected: 0
kernel: RCU nest depth: 1, expected: 0
kernel: 3 locks held by kworker/38:1/498:
kernel:  #0: ffff888102c6b538 ((wq_completion)cgwb_release){+.+.}-{0:0}, at: process_one_work+0x479/0xa80
kernel:  #1: ffff88810357fdf0 ((work_completion)(&wb->release_work)){+.+.}-{0:0}, at: process_one_work+0x479/0xa80
kernel:  #2: ffffffff830c52a0 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many.constprop.0+0x0/0x160
kernel: CPU: 38 PID: 498 Comm: kworker/38:1 Tainted: G        W   E      6.1.0-rc6-dbg #5
kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
kernel: Workqueue: cgwb_release cgwb_release_workfn
kernel: Call Trace:
kernel:  <TASK>
kernel:  show_stack+0x4e/0x53
kernel:  dump_stack_lvl+0x51/0x66
kernel:  dump_stack+0x10/0x12
kernel:  __might_resched.cold+0x173/0x198
kernel:  __might_sleep+0x72/0xe0
kernel:  start_flush_work+0x30/0x560
kernel:  __flush_work+0xf7/0x170
kernel:  __cancel_work_timer+0x22a/0x2c0
kernel:  work_fixup_init+0x20/0x40
kernel:  __debug_object_init+0x23b/0x290
kernel:  debug_object_init+0x16/0x20
kernel:  __init_work+0x20/0x30
kernel:  css_release+0x1f/0xb0
kernel:  percpu_ref_put_many.constprop.0+0x150/0x160
kernel:  blkcg_destroy_blkgs+0x20b/0x230
kernel:  blkcg_unpin_online+0x4e/0x90
kernel:  cgwb_release_workfn+0xba/0x210
kernel:  process_one_work+0x57d/0xa80
kernel:  worker_thread+0x90/0x650
kernel:  kthread+0x185/0x1c0
kernel:  ret_from_fork+0x1f/0x30
kernel:  </TASK>
kernel: null_blk: disk nullb0 created
kernel: null_blk: module loaded

