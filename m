Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43633C433FE
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 19:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiJEToV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 15:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJEToT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 15:44:19 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6897F248
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 12:44:17 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id i9so2713988qvo.0
        for <linux-block@vger.kernel.org>; Wed, 05 Oct 2022 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=+nT8lWI0injf+BMBGVW6L1p9NchP4VKQRrdgg9o+VHQ=;
        b=a3D7973xF/OQjjrA2mT7MBbORWKJqyzoUblIpdXFNEbVwBrE+16eAGvZZCvT8bT22/
         9EkgA2ZSJajNaUULC5HptZqigpmw7RSco6CS2gzgYzkO8CkN83tAkGoCp6GvT6IwJvXG
         0/MAqWI2/JXkUF6ukUj1VtIUV9j+9qcFvE5r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=+nT8lWI0injf+BMBGVW6L1p9NchP4VKQRrdgg9o+VHQ=;
        b=qMJxgC1E8NVqcxfJKNSIlXxBwkA5VRIgwAQD+FZg32l1I03zdO8QQKGinViLGuyHMz
         iyEyo7sMn7AeM6q9CWkfc35rmzKHJ69JNkmnkflyXSVscYMM2JWhZ+AHj4gzoEKiAd0j
         QQQkGIgLK5zmTJeZa04ssugTzqo6TYW3E9CZXd2QDmg3EpTSIfN+rHtx/tLJG6vAnYLY
         GUN3j7oML/p5+mLGVUo0uXfKVIKJS7XhkZzWUrstaSId+kB59u2OUz3CltaYTzDwjaxn
         wXE9dbfByRqTV4jaDfxO7qGtn/2ThI+couA7R/p5my5luxAWnJS5rQP7MsgH+plKlUjy
         znLg==
X-Gm-Message-State: ACrzQf3hjJLJnoWysVjDZCkA7vzV7pxu+FQFBi+41uFQmFRGznzIVhwq
        BWsfhxYYgeYTWfE5fyA1yykRuarR2vK7dXYxbpotfwTLWVd0KQ==
X-Google-Smtp-Source: AMsMyM5hrJ+MSdH2pEhM/QF9yxBndbAntl2np0uhiXSWq7hR05ulkg5gxIy+vzWsob2klTsC0LFl+rQJODPD8Sif3Z4=
X-Received: by 2002:ad4:5949:0:b0:4ad:89bb:f00f with SMTP id
 eo9-20020ad45949000000b004ad89bbf00fmr1047675qvb.114.1664999056116; Wed, 05
 Oct 2022 12:44:16 -0700 (PDT)
MIME-Version: 1.0
From:   Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date:   Wed, 5 Oct 2022 21:43:50 +0200
Message-ID: <CAK8fFZ5w8CC7ez50dEd9nGJpc_c-ubJLk3+77d7Y5qN1pMkfRQ@mail.gmail.com>
Subject: again? - Write I/O queue hangup at random on recent Linus' kernels
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

I'm investigating a queue hangup issue of our databases running on the
5.19.y kernel.

I found "Write I/O queue hangup at random on recent Linus' kernels"
thread (https://www.spinics.net/lists/linux-bcache/msg10781.html)
already fixed some time. However our symptoms are similar:

[4321126.018688] INFO: task jbd2/vdc-8:57835 blocked for more than 122 seconds.
[4321126.019624]       Tainted: G            E     5.18.6-2.gdc.el8.x86_64 #1
[4321126.020380] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[4321126.021215] task:jbd2/vdc-8      state:D stack:    0 pid:57835
ppid:     2 flags:0x00004000
[4321126.022082] Call Trace:
[4321126.022437]  <TASK>
[4321126.022796]  __schedule+0x38c/0x7d0
[4321126.023243]  ? wbt_exit+0x30/0x30
[4321126.023681]  ? __wbt_done+0x30/0x30
[4321126.024119]  schedule+0x41/0xa0
[4321126.024522]  io_schedule+0x12/0x40
[4321126.024966]  rq_qos_wait+0xb2/0x120
[4321126.025398]  ? karma_partition+0x240/0x240
[4321126.025904]  ? wbt_exit+0x30/0x30
[4321126.026319]  wbt_wait+0x8e/0xc0
[4321126.026731]  __rq_qos_throttle+0x20/0x30
[4321126.027196]  blk_mq_submit_bio+0x3d2/0x620
[4321126.027682]  __submit_bio+0xf1/0x180
[4321126.028118]  submit_bio_noacct_nocheck+0x256/0x2a0
[4321126.028657]  ? submit_bio_noacct+0x270/0x400
[4321126.029146]  submit_bio+0x42/0xd0
[4321126.029553]  submit_bh_wbc+0x117/0x140
[4321126.030019]  jbd2_journal_commit_transaction+0x5c4/0x1ae0 [jbd2]
[4321126.030668]  ? pick_next_task_fair+0x3e/0x3b0
[4321126.031167]  ? finish_task_switch+0x8f/0x2c0
[4321126.031667]  ? try_to_del_timer_sync+0x4d/0x80
[4321126.032171]  kjournald2+0xc0/0x270 [jbd2]
[4321126.032653]  ? add_wait_queue+0xa0/0xa0
[4321126.033114]  ? commit_timeout+0x10/0x10 [jbd2]
[4321126.033621]  kthread+0xd7/0x100
[4321126.034047]  ? kthread_complete_and_exit+0x20/0x20
[4321126.034586]  ret_from_fork+0x1f/0x30
[4321126.035031]  </TASK>
[4321126.035340] INFO: task postmaster:58207 blocked for more than 122 seconds.
[4321126.036050]       Tainted: G            E     5.18.6-2.gdc.el8.x86_64 #1
[4321126.036734] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[4321126.037513] task:postmaster      state:D stack:    0 pid:58207
ppid: 58204 flags:0x00004000
[4321126.038351] Call Trace:
[4321126.038695]  <TASK>
[4321126.039003]  __schedule+0x38c/0x7d0
[4321126.039417]  ? wbt_exit+0x30/0x30
[4321126.039833]  ? __wbt_done+0x30/0x30
[4321126.040248]  schedule+0x41/0xa0
[4321126.040642]  io_schedule+0x12/0x40
[4321126.041062]  rq_qos_wait+0xb2/0x120
[4321126.041478]  ? karma_partition+0x240/0x240
[4321126.041966]  ? wbt_exit+0x30/0x30
[4321126.042369]  wbt_wait+0x8e/0xc0
[4321126.042772]  __rq_qos_throttle+0x20/0x30
[4321126.043220]  blk_mq_submit_bio+0x3d2/0x620
[4321126.043690]  ? ext4_put_io_end_defer+0x120/0x120 [ext4]
[4321126.044278]  __submit_bio+0xf1/0x180
[4321126.044700]  submit_bio_noacct_nocheck+0x256/0x2a0
[4321126.045227]  ? submit_bio_noacct+0x270/0x400
[4321126.045709]  submit_bio+0x42/0xd0
[4321126.046119]  ext4_io_submit+0x20/0x40 [ext4]
[4321126.046616]  ext4_bio_write_page+0x174/0x560 [ext4]
[4321126.047177]  mpage_submit_page+0x4e/0x70 [ext4]
[4321126.047697]  mpage_process_page_bufs+0xf8/0x110 [ext4]
[4321126.048270]  mpage_prepare_extent_to_map+0x1e8/0x430 [ext4]
[4321126.048883]  ext4_writepages+0x296/0xd30 [ext4]
[4321126.049397]  ? find_get_pages_range_tag+0x1b2/0x250
[4321126.049950]  ? __filemap_fdatawait_range+0x6c/0x120
[4321126.050476]  do_writepages+0xd2/0x1b0
[4321126.050933]  ? do_filp_open+0xc8/0x120
[4321126.051373]  ? jbd2_complete_transaction+0x41/0x80 [jbd2]
[4321126.051981]  filemap_fdatawrite_wbc+0x5b/0x80
[4321126.052470]  file_write_and_wait_range+0x9c/0xe0
[4321126.053001]  ext4_sync_file+0xf7/0x370 [ext4]
[4321126.053507]  do_fsync+0x38/0x70
[4321126.053917]  __x64_sys_fsync+0x10/0x20
[4321126.054357]  do_syscall_64+0x37/0x80
[4321126.054802]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[4321126.055398] RIP: 0033:0x7f4166211ff5
[4321126.055850] RSP: 002b:00007fff08aead78 EFLAGS: 00000246 ORIG_RAX:
000000000000004a
[4321126.056654] RAX: ffffffffffffffda RBX: 0000000000002ebb RCX:
00007f4166211ff5
[4321126.057395] RDX: 00007f41549af0e0 RSI: 00000000028f2048 RDI:
00000000000001c1
[4321126.058135] RBP: 000000000a00000e R08: 00007fff08aeb22f R09:
0000000000000000
[4321126.058873] R10: 00007fff08ba9090 R11: 0000000000000246 R12:
00007fff08aeae30
[4321126.059602] R13: 0000000000000002 R14: 00007fff08aeadf0 R15:
0000000000d47d60
[4321126.060346]  </TASK>
[4321126.060670] INFO: task postmaster:58208 blocked for more than 122 seconds.
[4321126.061380]       Tainted: G            E     5.18.6-2.gdc.el8.x86_64 #1
[4321126.062089] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[4321126.062882] task:postmaster      state:D stack:    0 pid:58208
ppid: 58204 flags:0x00000000
[4321126.063717] Call Trace:
[4321126.064068]  <TASK>
[4321126.064376]  __schedule+0x38c/0x7d0
[4321126.064814]  schedule+0x41/0xa0
[4321126.065220]  rwsem_down_write_slowpath+0x2a2/0x5a0
[4321126.065770]  ext4_buffered_write_iter+0x35/0xf0 [ext4]
[4321126.066355]  ext4_file_write_iter+0x71/0x690 [ext4]
[4321126.066927]  new_sync_write+0x109/0x190
[4321126.067388]  vfs_write+0x1f2/0x270
[4321126.067825]  ksys_pwrite64+0x61/0xa0
[4321126.068266]  ? syscall_trace_enter.isra.20+0x11e/0x1a0
[4321126.068842]  do_syscall_64+0x37/0x80
[4321126.069283]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[4321126.069853] RIP: 0033:0x7f4166212438
[4321126.070294] RSP: 002b:00007fff08ae9d98 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[4321126.071066] RAX: ffffffffffffffda RBX: 000000000004ad00 RCX:
00007f4166212438
[4321126.071805] RDX: 0000000000002000 RSI: 00007f3f882eef80 RDI:
0000000000000141
[4321126.072536] RBP: 0000000000002000 R08: 000000000a000010 R09:
0000000001b41540
[4321126.073275] R10: 000000000330e000 R11: 0000000000000246 R12:
0000000000002000
[4321126.074015] R13: 000000000330e000 R14: 00007f3f882eef80 R15:
00007f416690bd00
[4321126.074757]  </TASK>
[4321126.075308] INFO: task kworker/u60:3:23019 blocked for more than
122 seconds.
[4321126.076054]       Tainted: G            E     5.18.6-2.gdc.el8.x86_64 #1
[4321126.076763] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[4321126.077562] task:kworker/u60:3   state:D stack:    0 pid:23019
ppid:     2 flags:0x00004000
[4321126.078412] Workqueue: writeback wb_workfn (flush-252:32)
[4321126.079026] Call Trace:
[4321126.079385]  <TASK>
[4321126.079720]  __schedule+0x38c/0x7d0
[4321126.080162]  ? wbt_exit+0x30/0x30
[4321126.080584]  ? __wbt_done+0x30/0x30
[4321126.081031]  schedule+0x41/0xa0
[4321126.081443]  io_schedule+0x12/0x40
[4321126.081890]  rq_qos_wait+0xb2/0x120
[4321126.082329]  ? karma_partition+0x240/0x240
[4321126.082828]  ? wbt_exit+0x30/0x30
[4321126.083255]  wbt_wait+0x8e/0xc0
[4321126.083669]  __rq_qos_throttle+0x20/0x30
[4321126.084139]  blk_mq_submit_bio+0x3d2/0x620
[4321126.084619]  ? ext4_put_io_end_defer+0x120/0x120 [ext4]
[4321126.085233]  __submit_bio+0xf1/0x180
[4321126.085680]  submit_bio_noacct_nocheck+0x256/0x2a0
[4321126.086224]  ? submit_bio_noacct+0x270/0x400
[4321126.086726]  submit_bio+0x42/0xd0
[4321126.087140]  ext4_io_submit+0x20/0x40 [ext4]
[4321126.087656]  ext4_bio_write_page+0x174/0x560 [ext4]
[4321126.088211]  mpage_submit_page+0x4e/0x70 [ext4]
[4321126.088738]  mpage_process_page_bufs+0xf8/0x110 [ext4]
[4321126.089309]  mpage_prepare_extent_to_map+0x1e8/0x430 [ext4]
[4321126.089927]  ext4_writepages+0x296/0xd30 [ext4]
[4321126.090459]  ? jbd2_write_access_granted.part.13+0x7f/0x90 [jbd2]
[4321126.091122]  do_writepages+0xd2/0x1b0
[4321126.091558]  ? __find_get_block+0x9e/0x2e0
[4321126.092044]  __writeback_single_inode+0x41/0x350
[4321126.092564]  writeback_sb_inodes+0x1ec/0x460
[4321126.093063]  __writeback_inodes_wb+0x5f/0xc0
[4321126.093556]  wb_writeback+0x231/0x2c0
[4321126.094008]  wb_workfn+0x344/0x490
[4321126.094436]  ? check_preempt_curr+0x3f/0x70
[4321126.094928]  ? ttwu_do_wakeup+0x17/0x180
[4321126.095391]  process_one_work+0x1c5/0x390
[4321126.095867]  ? process_one_work+0x390/0x390
[4321126.096347]  worker_thread+0x30/0x360
[4321126.096792]  ? process_one_work+0x390/0x390
[4321126.097272]  kthread+0xd7/0x100
[4321126.097669]  ? kthread_complete_and_exit+0x20/0x20
[4321126.098193]  ret_from_fork+0x1f/0x30
[4321126.098614]  </TASK>
[4321126.098938] INFO: task postmaster:29387 blocked for more than 122 seconds.
[4321126.099643]       Tainted: G            E     5.18.6-2.gdc.el8.x86_64 #1
[4321126.100326] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[4321126.101101] task:postmaster      state:D stack:    0 pid:29387
ppid: 58204 flags:0x00000000
[4321126.101936] Call Trace:
[4321126.102263]  <TASK>
[4321126.102560]  __schedule+0x38c/0x7d0
[4321126.102988]  ? bit_wait+0x60/0x60
[4321126.103393]  schedule+0x41/0xa0
[4321126.103792]  io_schedule+0x12/0x40
[4321126.104197]  bit_wait_io+0xd/0x60
[4321126.104600]  __wait_on_bit+0x2a/0x90
[4321126.105034]  out_of_line_wait_on_bit+0x91/0xb0
[4321126.105531]  ? sched_autogroup_detach+0x20/0x20
[4321126.106044]  do_get_write_access+0x27a/0x3d0 [jbd2]
[4321126.106587]  jbd2_journal_get_write_access+0x4c/0x80 [jbd2]
[4321126.107191]  __ext4_journal_get_write_access+0x81/0x190 [ext4]
[4321126.107833]  ext4_reserve_inode_write+0x8f/0xc0 [ext4]
[4321126.108411]  __ext4_mark_inode_dirty+0x59/0x220 [ext4]
[4321126.108994]  ? __ext4_journal_start_sb+0xfd/0x110 [ext4]
[4321126.109576]  ext4_dirty_inode+0x59/0x70 [ext4]
[4321126.110100]  __mark_inode_dirty+0x137/0x380
[4321126.110579]  generic_update_time+0xa0/0xc0
[4321126.111057]  file_update_time+0xc8/0x110
[4321126.111516]  ? generic_write_checks+0x2d/0x70
[4321126.112019]  ext4_write_checks+0x20/0x30 [ext4]
[4321126.112539]  ext4_buffered_write_iter+0x40/0xf0 [ext4]
[4321126.113118]  ext4_file_write_iter+0x71/0x690 [ext4]
[4321126.113678]  ? trigger_load_balance+0x111/0x370
[4321126.114182]  ? scheduler_tick+0xbb/0x250
[4321126.114647]  ? tick_sched_handle.isra.22+0x60/0x60
[4321126.115171]  new_sync_write+0x109/0x190
[4321126.115617]  vfs_write+0x1f2/0x270
[4321126.116039]  ksys_pwrite64+0x61/0xa0
[4321126.116459]  ? syscall_trace_enter.isra.20+0x11e/0x1a0
[4321126.117017]  do_syscall_64+0x37/0x80
[4321126.117445]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[4321126.118000] RIP: 0033:0x7f4166212438
[4321126.118420] RSP: 002b:00007fff08aeb3c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[4321126.119181] RAX: ffffffffffffffda RBX: 00000000000018b8 RCX:
00007f4166212438
[4321126.119914] RDX: 0000000000002000 RSI: 00007f3f88262f80 RDI:
0000000000000095
[4321126.120644] RBP: 0000000000002000 R08: 000000000a000010 R09:
0000000000d47ce0
[4321126.121360] R10: 0000000004d48000 R11: 0000000000000246 R12:
0000000000002000
[4321126.122090] R13: 0000000004d48000 R14: 00007f3f88262f80 R15:
00007f416690bd00
[4321126.122828]  </TASK>
[4321126.123169] INFO: task postmaster:29388 blocked for more than 122 seconds.
[4321126.124552]       Tainted: G            E     5.18.6-2.gdc.el8.x86_64 #1
[4321126.125333] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[4321126.126128] task:postmaster      state:D stack:    0 pid:29388
ppid: 58204 flags:0x00000000
[4321126.126979] Call Trace:
[4321126.127317]  <TASK>
[4321126.127645]  __schedule+0x38c/0x7d0
[4321126.128070]  ? fault_dirty_shared_page+0xce/0x100
[4321126.128594]  ? bit_wait+0x60/0x60
[4321126.129016]  schedule+0x41/0xa0
[4321126.129408]  io_schedule+0x12/0x40
[4321126.129845]  bit_wait_io+0xd/0x60
[4321126.130254]  __wait_on_bit+0x2a/0x90
[4321126.130701]  out_of_line_wait_on_bit+0x91/0xb0
[4321126.131206]  ? sched_autogroup_detach+0x20/0x20
[4321126.131728]  do_get_write_access+0x27a/0x3d0 [jbd2]
[4321126.132275]  jbd2_journal_get_write_access+0x4c/0x80 [jbd2]
[4321126.132901]  __ext4_journal_get_write_access+0x81/0x190 [ext4]
[4321126.133525]  ext4_reserve_inode_write+0x8f/0xc0 [ext4]
[4321126.134114]  __ext4_mark_inode_dirty+0x59/0x220 [ext4]
[4321126.134701]  ? __ext4_journal_start_sb+0xfd/0x110 [ext4]
[4321126.135287]  ext4_dirty_inode+0x59/0x70 [ext4]
[4321126.135826]  __mark_inode_dirty+0x137/0x380
[4321126.136304]  generic_update_time+0xa0/0xc0
[4321126.136798]  file_update_time+0xc8/0x110
[4321126.137254]  ? generic_write_checks+0x2d/0x70
[4321126.137771]  ext4_write_checks+0x20/0x30 [ext4]
[4321126.138290]  ext4_buffered_write_iter+0x40/0xf0 [ext4]
[4321126.138876]  ext4_file_write_iter+0x71/0x690 [ext4]
[4321126.139423]  ? __handle_mm_fault+0x791/0x810
[4321126.139931]  new_sync_write+0x109/0x190
[4321126.140381]  vfs_write+0x1f2/0x270
[4321126.140818]  ksys_pwrite64+0x61/0xa0
[4321126.141252]  ? syscall_trace_enter.isra.20+0x11e/0x1a0
[4321126.141850]  do_syscall_64+0x37/0x80
[4321126.142283]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[4321126.142854] RIP: 0033:0x7f4166212438
[4321126.143282] RSP: 002b:00007fff08aeafb8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[4321126.144056] RAX: ffffffffffffffda RBX: 0000000000005198 RCX:
00007f4166212438
[4321126.144809] RDX: 0000000000002000 RSI: 00007f3f881c2f80 RDI:
0000000000000181
[4321126.145525] RBP: 0000000000002000 R08: 000000000a000010 R09:
0000000000d47ce0
[4321126.146260] R10: 0000000032ace000 R11: 0000000000000246 R12:
0000000000002000
[4321126.147001] R13: 0000000032ace000 R14: 00007f3f881c2f80 R15:
00007f416690bd00
[4321126.147761]  </TASK>
[4321126.148080] INFO: task postmaster:29398 blocked for more than 123 seconds.
[4321126.148815]       Tainted: G            E     5.18.6-2.gdc.el8.x86_64 #1
[4321126.149500] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[4321126.150304] task:postmaster      state:D stack:    0 pid:29398
ppid: 58204 flags:0x00000000
[4321126.151154] Call Trace:
[4321126.151504]  <TASK>
[4321126.151843]  __schedule+0x38c/0x7d0
[4321126.152266]  ? bit_wait+0x60/0x60
[4321126.152680]  schedule+0x41/0xa0
[4321126.153075]  io_schedule+0x12/0x40
[4321126.153485]  bit_wait_io+0xd/0x60
[4321126.153917]  __wait_on_bit+0x2a/0x90
[4321126.154341]  out_of_line_wait_on_bit+0x91/0xb0
[4321126.154878]  ? sched_autogroup_detach+0x20/0x20
[4321126.155381]  do_get_write_access+0x27a/0x3d0 [jbd2]
[4321126.155950]  jbd2_journal_get_write_access+0x4c/0x80 [jbd2]
[4321126.156546]  __ext4_journal_get_write_access+0x81/0x190 [ext4]
[4321126.157197]  ext4_reserve_inode_write+0x8f/0xc0 [ext4]
[4321126.157793]  __ext4_mark_inode_dirty+0x59/0x220 [ext4]
[4321126.158367]  ? __ext4_journal_start_sb+0xfd/0x110 [ext4]
[4321126.158987]  ext4_dirty_inode+0x59/0x70 [ext4]
[4321126.159551]  __mark_inode_dirty+0x137/0x380
[4321126.160058]  generic_update_time+0xa0/0xc0
[4321126.160529]  file_update_time+0xc8/0x110
[4321126.161009]  ? generic_write_checks+0x2d/0x70
[4321126.161498]  ext4_write_checks+0x20/0x30 [ext4]
[4321126.162049]  ext4_buffered_write_iter+0x40/0xf0 [ext4]
[4321126.162615]  ext4_file_write_iter+0x71/0x690 [ext4]
[4321126.163184]  ? __handle_mm_fault+0x791/0x810
[4321126.163681]  new_sync_write+0x109/0x190
[4321126.164145]  vfs_write+0x1f2/0x270
[4321126.164559]  ksys_pwrite64+0x61/0xa0
[4321126.165012]  ? syscall_trace_enter.isra.20+0x11e/0x1a0
[4321126.165563]  do_syscall_64+0x37/0x80
[4321126.166015]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[4321126.166561] RIP: 0033:0x7f4166212438
[4321126.167015] RSP: 002b:00007fff08aeafb8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[4321126.167783] RAX: ffffffffffffffda RBX: 0000000000001fb8 RCX:
00007f4166212438
[4321126.168500] RDX: 0000000000002000 RSI: 00007f3f881d4f80 RDI:
0000000000000097
[4321126.169236] RBP: 0000000000002000 R08: 000000000a000010 R09:
0000000000d47ce0
[4321126.169980] R10: 0000000003e54000 R11: 0000000000000246 R12:
0000000000002000
[4321126.170706] R13: 0000000003e54000 R14: 00007f3f881d4f80 R15:
00007f416690bd00
[4321126.171440]  </TASK>
[4321126.171774] INFO: task postmaster:29413 blocked for more than 123 seconds.
[4321126.172483]       Tainted: G            E     5.18.6-2.gdc.el8.x86_64 #1
[4321126.173210] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[4321126.174012] task:postmaster      state:D stack:    0 pid:29413
ppid: 58204 flags:0x00000000
[4321126.174847] Call Trace:
[4321126.175187]  <TASK>
[4321126.175496]  __schedule+0x38c/0x7d0
[4321126.175936]  ? fault_dirty_shared_page+0xce/0x100
[4321126.176453]  ? bit_wait+0x60/0x60
[4321126.176874]  schedule+0x41/0xa0
[4321126.177266]  io_schedule+0x12/0x40
[4321126.177690]  bit_wait_io+0xd/0x60
[4321126.178112]  __wait_on_bit+0x2a/0x90
[4321126.178540]  out_of_line_wait_on_bit+0x91/0xb0
[4321126.179066]  ? sched_autogroup_detach+0x20/0x20
[4321126.179570]  do_get_write_access+0x27a/0x3d0 [jbd2]
[4321126.180135]  jbd2_journal_get_write_access+0x4c/0x80 [jbd2]
[4321126.180742]  __ext4_journal_get_write_access+0x81/0x190 [ext4]
[4321126.181384]  ext4_reserve_inode_write+0x8f/0xc0 [ext4]
[4321126.181983]  __ext4_mark_inode_dirty+0x59/0x220 [ext4]
[4321126.182559]  ? __ext4_journal_start_sb+0xfd/0x110 [ext4]
[4321126.183167]  ext4_dirty_inode+0x59/0x70 [ext4]
[4321126.183697]  __mark_inode_dirty+0x137/0x380
[4321126.184187]  generic_update_time+0xa0/0xc0
[4321126.184671]  file_update_time+0xc8/0x110
[4321126.185142]  ? generic_write_checks+0x2d/0x70
[4321126.185648]  ext4_write_checks+0x20/0x30 [ext4]
[4321126.186182]  ext4_buffered_write_iter+0x40/0xf0 [ext4]
[4321126.186770]  ext4_file_write_iter+0x71/0x690 [ext4]
[4321126.187328]  ? __handle_mm_fault+0x791/0x810
[4321126.187835]  new_sync_write+0x109/0x190
[4321126.188295]  vfs_write+0x1f2/0x270
[4321126.188722]  ksys_pwrite64+0x61/0xa0
[4321126.189164]  ? syscall_trace_enter.isra.20+0x11e/0x1a0
[4321126.189732]  do_syscall_64+0x37/0x80
[4321126.190180]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[4321126.190743] RIP: 0033:0x7f4166212438
[4321126.191180] RSP: 002b:00007fff08aeb3c8 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[4321126.191950] RAX: ffffffffffffffda RBX: 0000000000001b90 RCX:
00007f4166212438
[4321126.192679] RDX: 0000000000002000 RSI: 00007f3f88258f80 RDI:
0000000000000092
[4321126.193401] RBP: 0000000000002000 R08: 000000000a000010 R09:
0000000000d47ce0
[4321126.194138] R10: 0000000003398000 R11: 0000000000000246 R12:
0000000000002000
[4321126.194869] R13: 0000000003398000 R14: 00007f3f88258f80 R15:
00007f416690bd00
[4321126.195588]  </TASK>
[4321126.195922] INFO: task postmaster:31309 blocked for more than 123 seconds.
[4321126.196646]       Tainted: G            E     5.18.6-2.gdc.el8.x86_64 #1
[4321126.197348] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[4321126.198151] task:postmaster      state:D stack:    0 pid:31309
ppid: 58204 flags:0x00000004
[4321126.198988] Call Trace:
[4321126.199333]  <TASK>
[4321126.199653]  __schedule+0x38c/0x7d0
[4321126.200080]  ? bit_wait+0x60/0x60
[4321126.200482]  schedule+0x41/0xa0
[4321126.200891]  io_schedule+0x12/0x40
[4321126.201305]  bit_wait_io+0xd/0x60
[4321126.201722]  __wait_on_bit+0x2a/0x90
[4321126.202162]  out_of_line_wait_on_bit+0x91/0xb0
[4321126.202672]  ? sched_autogroup_detach+0x20/0x20
[4321126.203188]  do_get_write_access+0x27a/0x3d0 [jbd2]
[4321126.203739]  jbd2_journal_get_write_access+0x4c/0x80 [jbd2]
[4321126.204349]  __ext4_journal_get_write_access+0x81/0x190 [ext4]
[4321126.204997]  ext4_reserve_inode_write+0x8f/0xc0 [ext4]
[4321126.205576]  __ext4_mark_inode_dirty+0x59/0x220 [ext4]
[4321126.206169]  ? __ext4_journal_start_sb+0xfd/0x110 [ext4]
[4321126.206768]  ext4_dirty_inode+0x59/0x70 [ext4]
[4321126.207291]  __mark_inode_dirty+0x137/0x380
[4321126.207787]  generic_update_time+0xa0/0xc0
[4321126.208265]  file_update_time+0xc8/0x110
[4321126.208730]  ? generic_write_checks+0x2d/0x70
[4321126.209234]  ext4_write_checks+0x20/0x30 [ext4]
[4321126.209772]  ext4_buffered_write_iter+0x40/0xf0 [ext4]
[4321126.210350]  ext4_file_write_iter+0x71/0x690 [ext4]
[4321126.210914]  ? __handle_mm_fault+0x791/0x810
[4321126.211409]  new_sync_write+0x109/0x190
[4321126.211875]  vfs_write+0x1f2/0x270
[4321126.212301]  ksys_pwrite64+0x61/0xa0
[4321126.212740]  ? syscall_trace_enter.isra.20+0x11e/0x1a0
[4321126.213306]  do_syscall_64+0x37/0x80
[4321126.213748]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[4321126.214301] RIP: 0033:0x7f4166212438
[4321126.214738] RSP: 002b:00007fff08aeaf28 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[4321126.215502] RAX: ffffffffffffffda RBX: 0000000000003fa8 RCX:
00007f4166212438
[4321126.216241] RDX: 0000000000002000 RSI: 00007f3f8821ef80 RDI:
000000000000012c
[4321126.216977] RBP: 0000000000002000 R08: 000000000a000010 R09:
0000000000d47ce0
[4321126.217710] R10: 000000001a368000 R11: 0000000000000246 R12:
0000000000002000
[4321126.218435] R13: 000000001a368000 R14: 00007f3f8821ef80 R15:
00007f416690bd00
[4321126.219166]  </TASK>
[4321126.219482] INFO: task postmaster:31311 blocked for more than 123 seconds.
[4321126.220197]       Tainted: G            E     5.18.6-2.gdc.el8.x86_64 #1
[4321126.220899] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[4321126.221691] task:postmaster      state:D stack:    0 pid:31311
ppid: 58204 flags:0x00000004
[4321126.222526] Call Trace:
[4321126.222886]  <TASK>
[4321126.223198]  __schedule+0x38c/0x7d0
[4321126.223620]  schedule+0x41/0xa0
[4321126.224027]  rwsem_down_write_slowpath+0x2a2/0x5a0
[4321126.224561]  ext4_buffered_write_iter+0x35/0xf0 [ext4]
[4321126.225148]  ext4_file_write_iter+0x71/0x690 [ext4]
[4321126.225706]  ? __handle_mm_fault+0x791/0x810
[4321126.226195]  new_sync_write+0x109/0x190
[4321126.226664]  vfs_write+0x1f2/0x270
[4321126.227086]  ksys_pwrite64+0x61/0xa0
[4321126.227517]  ? syscall_trace_enter.isra.20+0x11e/0x1a0
[4321126.228091]  do_syscall_64+0x37/0x80
[4321126.228537]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[4321126.229105] RIP: 0033:0x7f4166212438
[4321126.229542] RSP: 002b:00007fff08aeaf28 EFLAGS: 00000246 ORIG_RAX:
0000000000000012
[4321126.230319] RAX: ffffffffffffffda RBX: 0000000000002e60 RCX:
00007f4166212438
[4321126.231055] RDX: 0000000000002000 RSI: 00007f3f881b6f80 RDI:
00000000000000de
[4321126.231795] RBP: 0000000000002000 R08: 000000000a000010 R09:
0000000000d47ce0
[4321126.232519] R10: 000000003687a000 R11: 0000000000000246 R12:
0000000000002000
[4321126.233249] R13: 000000003687a000 R14: 00007f3f881b6f80 R15:
00007f416690bd00
[4321126.233984]  </TASK>


Can you help to solve our issue?
-- 
Jaroslav Pulchart
Sr. Principal SW Engineer
GoodData
