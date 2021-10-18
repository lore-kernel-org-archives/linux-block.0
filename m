Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9398CC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 11:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C8E61356
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 11:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJRLM4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 07:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230350AbhJRLMz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 07:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634555442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=4ONTD8kZwHejyhuqLR07ribowPqNpmDpocf2+wOHMuI=;
        b=EhtEafMoHBIaTol0XF1DajvMVdmVkY9iGZPiKYWfLsHUrOnBOqaoCSmtlUQXRQJyG0UGWA
        kcB9WjqBWnwHiOVCcrnzo0Cl6BA3MpXZ/0wKFWPm9x/LzFn1A2/aAAGbdIz1kOdZYBAPDh
        bxE3s/yjzCx6Oq5gO7wk1mAdU0fPJ2c=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-MknMwaGZMVewrHNzo2lQLg-1; Mon, 18 Oct 2021 07:10:41 -0400
X-MC-Unique: MknMwaGZMVewrHNzo2lQLg-1
Received: by mail-yb1-f197.google.com with SMTP id b197-20020a2534ce000000b005b71a4e189eso19888953yba.5
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 04:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4ONTD8kZwHejyhuqLR07ribowPqNpmDpocf2+wOHMuI=;
        b=gd/vqnvPax3agMae4KtiC2SSbdFMrKtJO/a6vAMFhgDudubYbD2KJP1borZAe2vRcH
         nXajrS37+3ApidBr+SXrT7LuJIrQJvEbDDM5yqLQnvUKUXuaGYbV7DiANjWTPY4YwkKq
         RU7ecggvaOgoW9bHjtGB9XfzmmW2Ecf8x9VTnqOfoFrR42blUSZkSb7a4e5J8fQGAnu+
         iyq+pye+LOtpXhc9JIKOaeLDKjzgRhvQ6VQ8Ow/NIwRtqwZ81A6l0KYLLzGhqUGoH8RP
         2xQEZ2e32sIMZpT0KG58vzWR16zXSwtU2ZdjIYpwQ9/JSHuJlAtjRdGOrYKKe693MlDC
         AudA==
X-Gm-Message-State: AOAM533mirQTto5tBdKPXkupN4PDM/ijhlyfnmFPcTa0VkVS+AWSATZ2
        htvDsJ3G6ZSihpeAbz351E3Q5Bo7gAcY2pFg328IcaZ4uC7eBMdFBmPH+FcDYPrTTba1CrXlQTE
        d8Exh0jtzaa4AETmyDMPfageAmMIG/UZtgNdNk24=
X-Received: by 2002:a25:3104:: with SMTP id x4mr28593931ybx.512.1634555440449;
        Mon, 18 Oct 2021 04:10:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziuLV19IKELOEdgXDQwonJrvvC0ym9bjKSICdltY4mr4dgp/lR1R1zmjKuSFCEH65yWo0KlX+iUJBr9cDoQFg=
X-Received: by 2002:a25:3104:: with SMTP id x4mr28593908ybx.512.1634555440217;
 Mon, 18 Oct 2021 04:10:40 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 18 Oct 2021 19:10:06 +0800
Message-ID: <CAHj4cs87BapQJcV0a=M6=dc9PrsGH6qzqJEt9fbjLK1aShnMPg@mail.gmail.com>
Subject: [regression] ndctl destroy-namespace operation hang from 5.15.0-rc6
To:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

This regression was introduced from 5.15.0-rc6, pls help check it, thanks.

# ndctl list -N
[
  {
    "dev":"namespace1.0",
    "mode":"fsdax",
    "map":"dev",
    "size":16909336576,
    "uuid":"979a045b-6fac-4755-904d-3283a561c74d",
    "sector_size":512,
    "align":2097152,
    "blockdev":"pmem1"
  }
]

# ndctl destroy-namespace all -r all -f         ---> hang

[  246.608610] INFO: task ndctl:1934 blocked for more than 122 seconds.
[  246.614973]       Tainted: G S        I       5.15.0-rc6 #1
[  246.620546] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  246.628373] task:ndctl           state:D stack:    0 pid: 1934
ppid:  1896 flags:0x00004000
[  246.628377] Call Trace:
[  246.628379]  __schedule+0x382/0x8c0
[  246.628385]  schedule+0x3a/0xa0
[  246.628386]  blk_mq_freeze_queue_wait+0x62/0x90
[  246.628391]  ? finish_wait+0x80/0x80
[  246.628396]  del_gendisk+0xbb/0x210
[  246.628399]  release_nodes+0x39/0xa0
[  246.628403]  devres_release_all+0x88/0xc0
[  246.628406]  device_release_driver_internal+0x107/0x1e0
[  246.628410]  unbind_store+0xf0/0x120
[  246.628412]  kernfs_fop_write_iter+0x12d/0x1c0
[  246.628416]  new_sync_write+0x11f/0x1b0
[  246.628420]  vfs_write+0x184/0x260
[  246.628422]  ksys_write+0x59/0xd0
[  246.628423]  do_syscall_64+0x37/0x80
[  246.628426]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  246.628430] RIP: 0033:0x7f1b0c7db648
[  246.628432] RSP: 002b:00007ffd68b47088 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  246.628433] RAX: ffffffffffffffda RBX: 000000000074cb60 RCX: 00007f1b0c7db648
[  246.628435] RDX: 0000000000000007 RSI: 000000000074cb60 RDI: 0000000000000006
[  246.628436] RBP: 0000000000000007 R08: 000000000074cb20 R09: 00007f1b0c86e620
[  246.628436] R10: 0000000000000016 R11: 0000000000000246 R12: 0000000000000006
[  246.628437] R13: 00007f1b0d92c7e8 R14: 0000000000000000 R15: 000000000074c820
[  369.483990] INFO: task ndctl:1934 blocked for more than 245 seconds.
[  369.490348]       Tainted: G S        I       5.15.0-rc6 #1
[  369.495922] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  369.503747] task:ndctl           state:D stack:    0 pid: 1934
ppid:  1896 flags:0x00004000
[  369.503750] Call Trace:
[  369.503752]  __schedule+0x382/0x8c0
[  369.503757]  schedule+0x3a/0xa0
[  369.503759]  blk_mq_freeze_queue_wait+0x62/0x90
[  369.503763]  ? finish_wait+0x80/0x80
[  369.503768]  del_gendisk+0xbb/0x210
[  369.503771]  release_nodes+0x39/0xa0
[  369.503774]  devres_release_all+0x88/0xc0
[  369.503778]  device_release_driver_internal+0x107/0x1e0
[  369.503782]  unbind_store+0xf0/0x120
[  369.503784]  kernfs_fop_write_iter+0x12d/0x1c0
[  369.503788]  new_sync_write+0x11f/0x1b0
[  369.503792]  vfs_write+0x184/0x260
[  369.503793]  ksys_write+0x59/0xd0
[  369.503795]  do_syscall_64+0x37/0x80
[  369.503797]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  369.503801] RIP: 0033:0x7f1b0c7db648
[  369.503803] RSP: 002b:00007ffd68b47088 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  369.503805] RAX: ffffffffffffffda RBX: 000000000074cb60 RCX: 00007f1b0c7db648
[  369.503806] RDX: 0000000000000007 RSI: 000000000074cb60 RDI: 0000000000000006
[  369.503807] RBP: 0000000000000007 R08: 000000000074cb20 R09: 00007f1b0c86e620
[  369.503808] R10: 0000000000000016 R11: 0000000000000246 R12: 0000000000000006
[  369.503809] R13: 00007f1b0d92c7e8 R14: 0000000000000000 R15: 000000000074c820
[  492.359355] INFO: task kworker/u64:17:188 blocked for more than 122 seconds.
[  492.366399]       Tainted: G S        I       5.15.0-rc6 #1
[  492.371973] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  492.379796] task:kworker/u64:17  state:D stack:    0 pid:  188
ppid:     2 flags:0x00004000
[  492.379800] Workqueue: nfit acpi_nfit_scrub [nfit]
[  492.379806] Call Trace:
[  492.379807]  __schedule+0x382/0x8c0
[  492.379811]  schedule+0x3a/0xa0
[  492.379813]  schedule_preempt_disabled+0xa/0x10
[  492.379815]  __mutex_lock.isra.11+0x329/0x440
[  492.379818]  nd_device_notify+0x1e/0x50 [libnvdimm]
[  492.379827]  ? nd_region_conflict+0x70/0x70 [libnvdimm]
[  492.379837]  child_notify+0xc/0x10 [libnvdimm]
[  492.379847]  device_for_each_child+0x54/0x90
[  492.379850]  nd_region_notify+0x3a/0xd0 [libnvdimm]
[  492.379860]  nd_device_notify+0x3b/0x50 [libnvdimm]
[  492.379867]  ars_complete+0x68/0xa0 [nfit]
[  492.379871]  acpi_nfit_scrub+0xa1/0x3a0 [nfit]
[  492.379875]  ? __switch_to_asm+0x42/0x70
[  492.379878]  ? finish_task_switch+0xaf/0x2c0
[  492.379881]  process_one_work+0x1cb/0x370
[  492.379883]  worker_thread+0x30/0x380
[  492.379885]  ? process_one_work+0x370/0x370
[  492.379887]  kthread+0x118/0x140
[  492.379889]  ? set_kthread_struct+0x40/0x40
[  492.379891]  ret_from_fork+0x1f/0x30
[  492.379912] INFO: task ndctl:1934 blocked for more than 368 seconds.
[  492.386262]       Tainted: G S        I       5.15.0-rc6 #1
[  492.391834] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  492.399659] task:ndctl           state:D stack:    0 pid: 1934
ppid:  1896 flags:0x00004000
[  492.399661] Call Trace:
[  492.399662]  __schedule+0x382/0x8c0
[  492.399664]  schedule+0x3a/0xa0
[  492.399665]  blk_mq_freeze_queue_wait+0x62/0x90
[  492.399670]  ? finish_wait+0x80/0x80
[  492.399673]  del_gendisk+0xbb/0x210
[  492.399676]  release_nodes+0x39/0xa0
[  492.399678]  devres_release_all+0x88/0xc0
[  492.399681]  device_release_driver_internal+0x107/0x1e0
[  492.399684]  unbind_store+0xf0/0x120
[  492.399687]  kernfs_fop_write_iter+0x12d/0x1c0
[  492.399690]  new_sync_write+0x11f/0x1b0
[  492.399694]  vfs_write+0x184/0x260
[  492.399695]  ksys_write+0x59/0xd0
[  492.399697]  do_syscall_64+0x37/0x80
[  492.399699]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  492.399702] RIP: 0033:0x7f1b0c7db648
[  492.399703] RSP: 002b:00007ffd68b47088 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  492.399706] RAX: ffffffffffffffda RBX: 000000000074cb60 RCX: 00007f1b0c7db648
[  492.399707] RDX: 0000000000000007 RSI: 000000000074cb60 RDI: 0000000000000006
[  492.399708] RBP: 0000000000000007 R08: 000000000074cb20 R09: 00007f1b0c86e620
[  492.399709] R10: 0000000000000016 R11: 0000000000000246 R12: 0000000000000006
[  492.399709] R13: 00007f1b0d92c7e8 R14: 0000000000000000 R15: 000000000074c820



--
Best Regards,
  Yi Zhang

