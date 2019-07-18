Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D253C76191
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 12:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233D721019
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 12:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfGRMoM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 08:44:12 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:43033 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbfGRMoM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 08:44:12 -0400
X-QQ-mid: bizesmtp20t1563453845t39ajz53
Received: from lzy-H3050.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 18 Jul 2019 20:44:01 +0800 (CST)
X-QQ-SSF: 01400000002000H0ZG31000A0000000
X-QQ-FEAT: HgcpZqDDs6ROJ8hl8RjM0wrFdGBre7MHVWP/zaal5wwqMZkp/K94YBV7SGQoJ
        NVflHLOVLbUdeh6amlzvBWcdygjVVm6GgR5i3z0YCr+idbztbzOJf7h5H3D3dUvnFnqiB/y
        wd6Uc+yJY4dw8FVzlmS9s/U5fFk/+NHjR6jwaL9uPdEDJxxPIN+3xJakYUNoEHTEfymSSsz
        a8bObvQMFxRhzyFWegR2q8vbukRE/7Iv7eBaBWMu0unCQPj/q8wxpe81/dxdqRoPN+6scLk
        MF3hWAEnACPXbTWnFG0GcNSOFaV3ELe/GbsuawBHmZ0W7jpjdsHiaTM8UNesFwDhgbXYEc5
        SYc11ODo6j5HdzQEDU+5YuIPPgqqExy42D43AmA
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, liuyun01@kylinos.cn
Subject: [RFC PATCH] io_uring: add a memory barrier before atomic_read
Date:   Thu, 18 Jul 2019 20:44:00 +0800
Message-Id: <1563453840-19778-1-git-send-email-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a hang issue while using fio to do some basic test. The issue can
been easily reproduced using bellow scripts:

        while true
        do
                fio  --ioengine=io_uring  -rw=write -bs=4k -numjobs=1 \
                     -size=1G -iodepth=64 -name=uring   --filename=/dev/zero
        done

After serveral minutes, maybe more, fio would block at
io_uring_enter->io_cqring_wait in order to waiting for previously committed
sqes to be completed and cann't return to user anymore until we send a SIGTERM
to fio. After got SIGTERM, fio turns to hang at io_ring_ctx_wait_and_kill with
a backtrace like this:

        [54133.243816] Call Trace:
        [54133.243842]  __schedule+0x3a0/0x790
        [54133.243868]  schedule+0x38/0xa0
        [54133.243880]  schedule_timeout+0x218/0x3b0
        [54133.243891]  ? sched_clock+0x9/0x10
        [54133.243903]  ? wait_for_completion+0xa3/0x130
        [54133.243916]  ? _raw_spin_unlock_irq+0x2c/0x40
        [54133.243930]  ? trace_hardirqs_on+0x3f/0xe0
        [54133.243951]  wait_for_completion+0xab/0x130
        [54133.243962]  ? wake_up_q+0x70/0x70
        [54133.243984]  io_ring_ctx_wait_and_kill+0xa0/0x1d0
        [54133.243998]  io_uring_release+0x20/0x30
        [54133.244008]  __fput+0xcf/0x270
        [54133.244029]  ____fput+0xe/0x10
        [54133.244040]  task_work_run+0x7f/0xa0
        [54133.244056]  do_exit+0x305/0xc40
        [54133.244067]  ? get_signal+0x13b/0xbd0
        [54133.244088]  do_group_exit+0x50/0xd0
        [54133.244103]  get_signal+0x18d/0xbd0
        [54133.244112]  ? _raw_spin_unlock_irqrestore+0x36/0x60
        [54133.244142]  do_signal+0x34/0x720
        [54133.244171]  ? exit_to_usermode_loop+0x7e/0x130
        [54133.244190]  exit_to_usermode_loop+0xc0/0x130
        [54133.244209]  do_syscall_64+0x16b/0x1d0
        [54133.244221]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The reason is that we had added a req to ctx->pending_async at the very end, but
it got no chance to be processed anymore. How could this be happened?

        fio#cpu0                                        wq#cpu1

        io_add_to_prev_work                    io_sq_wq_submit_work

          atomic_read() <<< 1

                                                  atomic_dec_return() << 1->0
                                                  list_empty();    <<< true;

          list_add_tail()
          atomic_read() << 0 or 1?

As was said in atomic_ops.rst, atomic_read does not guarantee that the runtime
initialization by any other thread is visible yet, so we must take care of that
with a proper implicit or explicit memory barrier;

This issue was detected with the help of Jackie's <liuyun01@kylinos.cn>

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 56fe6e1..26e7223 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1766,6 +1766,7 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
 	ret = true;
 	spin_lock(&list->lock);
 	list_add_tail(&req->list, &list->list);
+	smp_mb();
 	if (!atomic_read(&list->cnt)) {
 		list_del_init(&req->list);
 		ret = false;
-- 
2.7.4



