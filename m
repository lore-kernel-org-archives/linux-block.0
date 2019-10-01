Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D37ECE58A
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 17:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0472133F
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 17:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfJARod (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfJARod (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Oct 2019 13:44:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C7A120679;
        Tue,  1 Oct 2019 17:44:31 +0000 (UTC)
Date:   Tue, 1 Oct 2019 13:44:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Lockup on USB and block devices
Message-ID: <20191001134430.1f9c9c75@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/kekvu7GvFlZ6dqAOAP+5C7f"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--MP_/kekvu7GvFlZ6dqAOAP+5C7f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Not sure who to blame, but my server locked up when upgraded (accessing
volume group information), and echoing in "w" into sysrq-trigger showed
a bit of information.

First, looking at my dmesg I see that my usb-storage is hung up, for
whatever reason. Thus, this could be the source of all issues.


[5434447.145737] INFO: task usb-storage:32246 blocked for more than 120 seconds.
[5434447.145740]       Not tainted 5.2.4-custom #4

(BTW, I was upgrading to my 5.2.17 kernel when this happened)

[5434447.145741] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[5434447.145743] usb-storage     D    0 32246      2 0x80004000
[5434447.145745] Call Trace:
[5434447.145749]  ? __schedule+0x1e8/0x600
[5434447.145752]  schedule+0x29/0x90
[5434447.145755]  schedule_timeout+0x208/0x300
[5434447.145765]  ? usb_hcd_submit_urb+0xbe/0xb90 [usbcore]
[5434447.145773]  ? usb_alloc_urb+0x23/0x70 [usbcore]
[5434447.145782]  ? usb_sg_init+0x92/0x2b0 [usbcore]
[5434447.145791]  ? usb_hcd_submit_urb+0xbe/0xb90 [usbcore]
[5434447.145795]  ? __switch_to_asm+0x34/0x70
[5434447.145798]  wait_for_completion+0x111/0x180
[5434447.145800]  ? wake_up_q+0x70/0x70
[5434447.145809]  usb_sg_wait+0xfa/0x150 [usbcore]
[5434447.145814]  usb_stor_bulk_transfer_sglist.part.4+0x64/0xb0 [usb_storage]
[5434447.145818]  usb_stor_bulk_srb+0x49/0x80 [usb_storage]
[5434447.145821]  usb_stor_Bulk_transport+0x167/0x3e0 [usb_storage]
[5434447.145824]  ? schedule+0x29/0x90
[5434447.145828]  ? usb_stor_disconnect+0xb0/0xb0 [usb_storage]
[5434447.145832]  usb_stor_invoke_transport+0x3a/0x4e0 [usb_storage]
[5434447.145835]  ? wait_for_completion_interruptible+0x12d/0x1d0
[5434447.145837]  ? wake_up_q+0x70/0x70
[5434447.145841]  usb_stor_control_thread+0x1c5/0x270 [usb_storage]
[5434447.145845]  kthread+0x116/0x130
[5434447.145847]  ? kthread_create_worker_on_cpu+0x70/0x70
[5434447.145851]  ret_from_fork+0x35/0x40


But then this messed up with this I presume:

[5434567.980526] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[5434567.980529] pool            D    0 32364      1 0x00000000
[5434567.980532] Call Trace:
[5434567.980543]  ? __schedule+0x1e8/0x600
[5434567.980547]  schedule+0x29/0x90
[5434567.980558]  scsi_block_when_processing_errors+0xb7/0xc0 [scsi_mod]
[5434567.980564]  ? finish_wait+0x80/0x80
[5434567.980568]  sd_open+0x49/0x170 [sd_mod]
[5434567.980574]  __blkdev_get+0x45a/0x510
[5434567.980577]  ? bd_acquire+0xb0/0xb0
[5434567.980579]  blkdev_get+0x108/0x300
[5434567.980582]  ? bd_acquire+0xb0/0xb0
[5434567.980588]  do_dentry_open+0x13a/0x370
[5434567.980593]  path_openat+0x2c6/0x1450
[5434567.980598]  ? part_stat_show+0x427/0x450
[5434567.980603]  do_filp_open+0x93/0x100
[5434567.980608]  ? __check_object_size+0x15d/0x189
[5434567.980612]  do_sys_open+0x186/0x220
[5434567.980616]  do_syscall_64+0x4e/0x100
[5434567.980621]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[5434567.980625] RIP: 0033:0x7f8b4b034d0e
[5434567.980632] Code: Bad RIP value.
[5434567.980633] RSP: 002b:00007f8b49a389d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[5434567.980636] RAX: ffffffffffffffda RBX: 00007f8b3c035490 RCX: 00007f8b4b034d0e
[5434567.980638] RDX: 0000000000000800 RSI: 000055d82f508d30 RDI: 00000000ffffff9c
[5434567.980639] RBP: 0000000000000000 R08: 0000000000000000 R09: 000055d82f3eff80
[5434567.980641] R10: 0000000000000000 R11: 0000000000000293 R12: 00007f8b49a38bd0
[5434567.980642] R13: 00007f8b49a38af8 R14: 0000000000000000 R15: 00007f8b3c035490


and all access to __blkdev_get() blocks on this volume too:


[5437427.042327] vgs             D    0 32353      1 0x80004004
[5437427.042334] Call Trace:
[5437427.042341]  ? __schedule+0x1e8/0x600
[5437427.042347]  schedule+0x29/0x90
[5437427.042354]  schedule_timeout+0x208/0x300
[5437427.042363]  ? __kfifo_from_user_r+0xb0/0xb0 
[5437427.042369]  ? __percpu_ref_switch_mode+0xcd/0x170
[5437427.042375]  ? __wake_up_common_lock+0x89/0xc0
[5437427.042381]  wait_for_completion+0x111/0x180 
[5437427.042387]  ? wake_up_q+0x70/0x70
[5437427.042395]  exit_aio+0xdc/0xe3
[5437427.042404]  mmput+0x28/0x120
[5437427.042411]  do_exit+0x28b/0xb90
[5437427.042420]  ? __switch_to+0x3a6/0x460
[5437427.042425]  ? _cond_resched+0x15/0x30
[5437427.042428]  ? mutex_lock+0xe/0x30
[5437427.042430]  ? aio_read_events+0x28a/0x320
[5437427.042434]  do_group_exit+0x3a/0xa0
[5437427.042438]  get_signal+0x14b/0x840
[5437427.042444]  do_signal+0x36/0x660
[5437427.042449]  ? __hrtimer_init+0xb0/0xb0
[5437427.042452]  ? do_io_getevents+0x7c/0xc0
[5437427.042456]  exit_to_usermode_loop+0x71/0xe0
[5437427.042459]  do_syscall_64+0xf2/0x100
[5437427.042463]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[5437427.042465] RIP: 0033:0x7fc12f303f59
[5437427.042470] Code: Bad RIP value.
[5437427.042472] RSP: 002b:00007fffffad42e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d0
[5437427.042474] RAX: fffffffffffffffc RBX: 00007fc12efa2700 RCX: 00007fc12f303f59
[5437427.042475] RDX: 0000000000000040 RSI: 0000000000000001 RDI: 00007fc12f974000
[5437427.042477] RBP: 00007fc12f974000 R08: 0000000000000000 R09: 00000002fffffe30
[5437427.042478] R10: 00007fffffad4370 R11: 0000000000000246 R12: 0000000000000001
[5437427.042479] R13: 0000000000000002 R14: 0000000000000040 R15: 00007fffffad4370


Full dmesg is attached.

-- Steve

--MP_/kekvu7GvFlZ6dqAOAP+5C7f
Content-Type: application/x-xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=dmesg.xz

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
AgAAAAAEWVo=

--MP_/kekvu7GvFlZ6dqAOAP+5C7f--
