Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C803C43217
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 13:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiKXNdE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Nov 2022 08:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiKXNdE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2022 08:33:04 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73444442EA
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 05:33:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d6so1473971pll.7
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 05:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Y3e9X1IDOfJPx9XCEvNfx0UsBqjonQfvzqBLVdf08E=;
        b=pPNG7NJYTQx9IyngAcMhh4Fxp72NStAoooCLvc/J9bNUrBtZZzP0+yHVT5sAikjLGC
         vREcX7FQ+D16Arcc4Bi5YL+4bWMEsw1G8bJ4ROigjWWn70H6GuwZe2O55i52xRRRClgc
         tOBX8jyMDGrORMXXwn9cfg5hpSlXIqKNZ4RmgDPrHXC4qyAWMEhlVi4E8QFI+L2cUPzv
         2ns71il88mMX4TkeHEAMHw28qYzONGHZ4Zs+3L2WKYOnTXQmnDi1AIxlJIte0Re2KHsi
         gpD091G6FZpD22gsp8353PZdLXO7C6smS44LH/HLujlvAqvPClGkfwgACf6Ox3S9pj/2
         2ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y3e9X1IDOfJPx9XCEvNfx0UsBqjonQfvzqBLVdf08E=;
        b=ivWeaV0uYkEv91LFD/bEchjPgC7Qy8yYT4b35zd18I9pmRCri4jH+GFSGmygeq+Nce
         Sne9QE0Mz6NYgLMgQDJqKtqCJlWgByxuq8+UuwzbvsdqLIXU1yePG0Tof4KUDFO5JSj8
         5OV0jakKb5jhI4IwKoPd2UHJbSHyTT767AU+sJRwZZ5G/rL32wKDxd5rg5780b65tFJ5
         W3pq4Ad6umxyEje5qwVXak+62WA7hUlj/5aGRX3ESWf7LdfK3Dnf+CVHOHqdzMjTrFNy
         nLHyJks6WeU9IccAzMtWuFpvopi6whkRi99gAW2+f/9mXsr2PBmqdcQQUuddjmkz8N/y
         aV+w==
X-Gm-Message-State: ANoB5pkkklK8PZ40G8nFPSkWyv0BVyxqGXTEBjn/Plw7wlRQbsghGGMp
        kJxFl6j6cN8XhLxuZaqqLvZRrw==
X-Google-Smtp-Source: AA0mqf7f/HM4urmK4RtwSLc83EQ0Nn3AnSY+uT7z0ovRjJgmwZN3g/IZjo3Jeb+iSraEnTbvKE6zRQ==
X-Received: by 2002:a17:90b:1e0f:b0:213:c5ae:55ec with SMTP id pg15-20020a17090b1e0f00b00213c5ae55ecmr34669225pjb.182.1669296782866;
        Thu, 24 Nov 2022 05:33:02 -0800 (PST)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b001895b2c4cf6sm1252498plk.297.2022.11.24.05.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 05:33:02 -0800 (PST)
Message-ID: <b1e62dce-771f-85fa-3d60-6948615eb27c@kernel.dk>
Date:   Thu, 24 Nov 2022 06:33:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: block/for-next: Reinitialization of active object
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
References: <69af7ccb-6901-c84c-0e95-5682ccfb750c@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <69af7ccb-6901-c84c-0e95-5682ccfb750c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/22 4:17 PM, Bart Van Assche wrote:
> Hi,
> 
> If I run blktests test block/027 the warning and bug shown below appear.
> It is the first time that I see a complaint like this while running
> blktests. I have not yet tried to root-cause this issue.
> 
> root[7931]: run blktests block/027
> [ ... ]
> kernel: ------------[ cut here ]------------
> kernel: ODEBUG: init active (active state 0) object type: work_struct hint: css_release_work_fn+0x0/0x480
> kernel: WARNING: CPU: 38 PID: 498 at lib/debugobjects.c:502 debug_print_object+0xda/0x110
> kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> kernel: Workqueue: cgwb_release cgwb_release_workfn
> kernel: RIP: 0010:debug_print_object+0xda/0x110
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  __debug_object_init+0x217/0x290
> kernel:  debug_object_init+0x16/0x20
> kernel:  __init_work+0x20/0x30
> kernel:  css_release+0x1f/0xb0
> kernel:  percpu_ref_put_many.constprop.0+0x150/0x160
> kernel:  blkcg_destroy_blkgs+0x20b/0x230
> kernel:  blkcg_unpin_online+0x4e/0x90
> kernel:  cgwb_release_workfn+0xba/0x210
> kernel:  process_one_work+0x57d/0xa80
> kernel:  worker_thread+0x90/0x650
> kernel:  kthread+0x185/0x1c0
> kernel:  ret_from_fork+0x1f/0x30
> kernel:  </TASK>
> kernel: irq event stamp: 121765
> kernel: hardirqs last  enabled at (121775): [<ffffffff811ae168>] __up_console_sem+0x58/0x60
> kernel: hardirqs last disabled at (121792): [<ffffffff811ae14d>] __up_console_sem+0x3d/0x60
> kernel: softirqs last  enabled at (121790): [<ffffffff824004d0>] __do_softirq+0x4d0/0x757
> kernel: softirqs last disabled at (121785): [<ffffffff810e4e61>] __irq_exit_rcu+0xd1/0x140
> kernel: ---[ end trace 0000000000000000 ]---
> kernel: BUG: sleeping function called from invalid context at kernel/workqueue.c:3010
> kernel: in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 498, name: kworker/38:1
> kernel: preempt_count: 0, expected: 0
> kernel: RCU nest depth: 1, expected: 0
> kernel: 3 locks held by kworker/38:1/498:
> kernel:  #0: ffff888102c6b538 ((wq_completion)cgwb_release){+.+.}-{0:0}, at: process_one_work+0x479/0xa80
> kernel:  #1: ffff88810357fdf0 ((work_completion)(&wb->release_work)){+.+.}-{0:0}, at: process_one_work+0x479/0xa80
> kernel:  #2: ffffffff830c52a0 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many.constprop.0+0x0/0x160
> kernel: CPU: 38 PID: 498 Comm: kworker/38:1 Tainted: G        W   E      6.1.0-rc6-dbg #5
> kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
> kernel: Workqueue: cgwb_release cgwb_release_workfn
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  show_stack+0x4e/0x53
> kernel:  dump_stack_lvl+0x51/0x66
> kernel:  dump_stack+0x10/0x12
> kernel:  __might_resched.cold+0x173/0x198
> kernel:  __might_sleep+0x72/0xe0
> kernel:  start_flush_work+0x30/0x560
> kernel:  __flush_work+0xf7/0x170
> kernel:  __cancel_work_timer+0x22a/0x2c0
> kernel:  work_fixup_init+0x20/0x40
> kernel:  __debug_object_init+0x23b/0x290
> kernel:  debug_object_init+0x16/0x20
> kernel:  __init_work+0x20/0x30
> kernel:  css_release+0x1f/0xb0
> kernel:  percpu_ref_put_many.constprop.0+0x150/0x160
> kernel:  blkcg_destroy_blkgs+0x20b/0x230
> kernel:  blkcg_unpin_online+0x4e/0x90
> kernel:  cgwb_release_workfn+0xba/0x210
> kernel:  process_one_work+0x57d/0xa80
> kernel:  worker_thread+0x90/0x650
> kernel:  kthread+0x185/0x1c0
> kernel:  ret_from_fork+0x1f/0x30
> kernel:  </TASK>
> kernel: null_blk: disk nullb0 created
> kernel: null_blk: module loaded

There was another blkcg related crash reported that looks similar
to this. Can you try and bisect for-6.2/block and see where you
end up?

-- 
Jens Axboe


