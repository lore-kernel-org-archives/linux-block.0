Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A499C433ED
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063C061959
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhC3Hil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhC3HiE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:38:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FA4C061764
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o19so17039149edc.3
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3m1ZLIUbsmjdhyhdmher/khBF18PienCGDpXwk+t7E=;
        b=RDDf9AlTD24XS+F+mTPvLmr1uXGef1hweL3DMhlwDldxxmpxENfQXMpo0wAUpfvLA3
         bJuX1kQwd1G/KxJSNJ5cEMCNcYm6i0ewqyEb7yX3JNGtaEhOVCEZdGg6N9jAhrR1fS0C
         iPd+PnN0dss+2yaoHRWtm5c+3WTczoqjvcDemA7YmK9yxVwwtRyrkqkxCDxQgosOQb6A
         mkGDwr7H3ihoPN68XnWLo9BMB30FsLzgDHf2HUjACaWEdzrVdfsLjvnTc00kiknkQjES
         aVfdZLTkS2pQO0lhCdkTkMcU8MuPN0aC51gC34Cw3iSBaXfZFsn/QkUsmtEiVz4SVpLG
         D0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3m1ZLIUbsmjdhyhdmher/khBF18PienCGDpXwk+t7E=;
        b=TRlPXBf0hBcen6lZZYmrca3AZ0I6dfLR71fN1RaK4dsxfu2k8RtQ0ML38w+4N//LhF
         wXhVbuik1tMBhWcS1zlW19HT4+wmYgZig7uRyrt9ZjQCoXyBbRTmnyeo1+Stb2ASSIBV
         ji+968sV+Ijf0vbbmMmjHf1x8zt0HViOCHu3mry9z9BbxO2kQpLvHyEMQPoNWyGgDPzq
         KDEYFoHGalkTp5BC5WSeL7jjz+eNNJIrWjX1V8pfzvOXeMLjVFdU844Dva6Z0MShn+lE
         grZi9X7nywbMXffSggjb5kCTWAZLOoC7yoJS0LbZ2CgSJMN0Qjv3OyEBgGIFd2Y4mr1K
         QJIg==
X-Gm-Message-State: AOAM532hPmB14TfskR5Ao4o+v9KVVdCSPiuZZXxc2kMO3Rvsdk+do+qw
        Xal6HQWuvj2XYH+qqkx38NbH/O8yBu1Fvg==
X-Google-Smtp-Source: ABdhPJwiebV/NI055SD5ocJmW/ohEEdwI9lFzXtyRNcr1hc9wQ4M7wHBmOipOutUZtlQxFwxRO2aKQ==
X-Received: by 2002:aa7:cf90:: with SMTP id z16mr32215719edx.273.1617089880957;
        Tue, 30 Mar 2021 00:38:00 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:00 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 06/24] docs: fault-injection: Add fault-injection manual of RNBD
Date:   Tue, 30 Mar 2021 09:37:34 +0200
Message-Id: <20210330073752.1465613-7-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

It describes how to use the fault-injection of RNBD.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
---
 .../fault-injection/rnbd-fault-injection.rst  | 208 ++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 Documentation/fault-injection/rnbd-fault-injection.rst

diff --git a/Documentation/fault-injection/rnbd-fault-injection.rst b/Documentation/fault-injection/rnbd-fault-injection.rst
new file mode 100644
index 000000000000..21594e5e3c91
--- /dev/null
+++ b/Documentation/fault-injection/rnbd-fault-injection.rst
@@ -0,0 +1,208 @@
+RNBD (RDMA Network Block Device) Fault Injection
+================================================
+This document introduces how to enable and use the error injection of RNBD
+via debugfs in the /sys/kernel/debug directory. When enabled, users can
+enable specific error injection point and change the default status code
+via the debugfs.
+
+Following examples show how to inject an error into the RNBD.
+
+First, enable CONFIG_FAULT_INJECTION_DEBUG_FS kernel config,
+recompile the kernel. After booting up the kernel, map a target device.
+
+On client, /sys/kernel/debug/rnbdX directory is created after mapping.
+And /sys/kernel/debug/<mapped-device> directory is created on server.
+
+Example 1: Inject an error into request processing of rnbd-client
+-----------------------------------------------------------------
+
+::
+
+  echo 1 > /sys/kernel/debug/rnbd0/fault_inject/times
+  echo 100 > /sys/kernel/debug/rnbd0/fault_inject/probability
+  echo 1 > /sys/kernel/debug/rnbd0/fault_inject/fail-request
+  dd if=/dev/rnbd0 of=./dd bs=1k count=10
+
+Expected Result::
+
+  dd succeeds but generates an IO error
+
+Message from dmesg::
+
+  FAULT_INJECTION: forcing a failure.
+  name fault_inject, interval 1, probability 100, space 0, times 1
+  CPU: 4 PID: 0 Comm: swapper/4 Tainted: G           O      5.4.77-pserver+ #167
+  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
+  Call Trace:
+    <IRQ>
+    dump_stack+0x97/0xe0
+    should_fail.cold+0x5/0x11
+    rnbd_clt_should_fail_request+0x5e/0x80 [rnbd_client]
+    msg_io_conf+0x42/0xb0 [rnbd_client]
+    complete_rdma_req+0x264/0x600 [rtrs_client]
+    rtrs_clt_rdma_done+0x4a2/0x690 [rtrs_client]
+    __ib_process_cq+0x94/0x100 [ib_core]
+    ib_poll_handler+0x3f/0xa0 [ib_core]
+    irq_poll_softirq+0xf8/0x280
+    __do_softirq+0x122/0x550
+    irq_exit+0xfb/0x100
+    do_IRQ+0x8a/0x170
+    common_interrupt+0xf/0xf
+    </IRQ>
+  RIP: 0010:default_idle+0x2b/0x1d0
+  Code: 1f 44 00 00 41 55 41 54 65 44 8b 25 7f fe 0a 5a 55 53 0f 1f 44 00 00 e8 53 65 30 ff e9 07 00 00 00 0f 00 2d b7 59 4b 00 fb f4 <65> 44 8b 25 5d fe 0a 5a 0f 1f 44 00 00 5b 5d 41 5c 41 5d c3 65 8b
+  RSP: 0018:ffff88811963fdc8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdd
+  RAX: 0000000000000000 RBX: ffff888119633240 RCX: dffffc0000000000
+  RDX: 0000000000000007 RSI: 0000000000000006 RDI: ffff888119633ad4
+  RBP: 0000000000000004 R08: ffffffffa516d49d R09: 0000000000000000
+  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
+  R13: 0000000000000000 R14: ffff888119633240 R15: 0000000000000000
+    do_idle+0x314/0x370
+    cpu_startup_entry+0x19/0x20
+    start_secondary+0x212/0x280
+    secondary_startup_64+0xa4/0xb0
+  rnbd_client L432: </dev/nullb0@bla> read I/O failed with err: -16
+  blk_update_request: device resource error, dev rnbd0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 4 prio class 0
+
+Example 2: Inject an error into unmapping of rnbd-client
+--------------------------------------------------------
+
+::
+
+  echo 100 > /sys/kernel/debug/rnbd0/fault_inject/probability
+  echo 1 > /sys/kernel/debug/rnbd0/fault_inject/times
+  echo 1 > /sys/kernel/debug/rnbd0/fault_inject/fail-unmap
+  echo normal > /sys/block/rnbd0/rnbd/unmap_device
+
+Expected Result::
+
+  echo: write error: Device or resource busy
+
+Message from dmesg::
+
+  FAULT_INJECTION: forcing a failure.
+  name fault_inject, interval 1, probability 100, space 0, times 1
+  CPU: 2 PID: 648 Comm: bash Tainted: G           O      5.4.77-pserver+ #169
+  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
+  Call Trace:
+    dump_stack+0x97/0xe0
+    should_fail.cold+0x5/0x11
+    rnbd_clt_should_fail_unmap+0x38/0x60 [rnbd_client]
+    rnbd_clt_unmap_device+0x3c/0x1c0 [rnbd_client]
+    rnbd_clt_unmap_dev_store.cold+0xe5/0x13f [rnbd_client]
+    kernfs_fop_write+0x141/0x240
+    vfs_write+0xf2/0x250
+    ksys_write+0xc3/0x160
+    do_syscall_64+0x68/0x260
+    entry_SYSCALL_64_after_hwframe+0x49/0xbe
+  RIP: 0033:0x7ff883091504
+  Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 48 8d 05 f9 61 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
+  RSP: 002b:00007ffe1bc91458 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
+  RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007ff883091504
+  RDX: 0000000000000007 RSI: 000056389b73a180 RDI: 0000000000000001
+  RBP: 000056389b73a180 R08: 000000000000000a R09: 00007ff883121e80
+  R10: 000000000000000a R11: 0000000000000246 R12: 00007ff883163760
+  R13: 0000000000000007 R14: 00007ff88315e760 R15: 0000000000000007
+  rnbd_client L335: </dev/nullb0@bla> unmap_device: -16
+  rnbd_client L321: </dev/nullb0@bla> Unmapping device, option: normal.
+
+Example 3: Inject an error into bio process of rnbd-server
+----------------------------------------------------------
+
+After client maps null0b, you can see /sys/kernel/debug/nullb0 directory on server::
+
+  echo 100 > /sys/kernel/debug/nullb0/fault_inject/probability
+  echo 1 > /sys/kernel/debug/nullb0/fault_inject/times
+  echo 1 > /sys/kernel/debug/nullb0/fault_inject/fail-bio
+
+Then you can generate IO on client::
+
+  dd if=/dev/rnbd0 of=./dd bs=1k count=10
+
+Expected Result on client::
+
+  dd succeeds but generates an IO error
+
+Message from dmesg on client::
+
+  rtrs_client L453: <bla>: IO request failed: error=-16 path=ip:192.168.122.142@ip:192.168.122.130 [mlx4_0:1] notify=1
+  rnbd_client L432: </dev/nullb0@bla> read I/O failed with err: -16
+  blk_update_request: device resource error, dev rnbd0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 4 prio class 0
+
+Message from dmesg on server::
+
+  FAULT_INJECTION: forcing a failure.
+  name fault_inject, interval 1, probability 100, space 0, times 1
+  CPU: 4 PID: 31 Comm: ksoftirqd/4 Tainted: G           O      5.4.77-pserver+ #169
+  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
+  Call Trace:
+    dump_stack+0x97/0xe0
+    should_fail.cold+0x5/0x11
+    rnbd_should_fail_bio+0x38/0x51 [rnbd_server]
+    rnbd_endio+0x41/0x70 [rnbd_server]
+    rnbd_dev_bi_end_io+0x43/0x50 [rnbd_server]
+    blk_update_request+0x1af/0x520
+    blk_mq_end_request+0x2e/0x200
+    blk_done_softirq+0x16e/0x1c0
+    __do_softirq+0x122/0x550
+    run_ksoftirqd+0x24/0x30
+    smpboot_thread_fn+0x1a2/0x2d0
+    kthread+0x191/0x1e0
+    ret_from_fork+0x3a/0x50
+
+Example 4: Change the status code
+---------------------------------
+
+The default status code is -16 (-EBUSY) but you can change it::
+
+  echo 1 > /sys/kernel/debug/rnbd0/fault_inject/times
+  echo 100 > /sys/kernel/debug/rnbd0/fault_inject/probability
+  echo 1 > /sys/kernel/debug/rnbd0/fault_inject/fail-request
+  echo -10 > /sys/kernel/debug/rnbd0/fault_inject/status
+  dd if=/dev/rnbd0 of=./dd bs=1k count=10
+
+Expected Result::
+
+  The error value is -10
+
+Message from dmesg::
+
+  FAULT_INJECTION: forcing a failure.
+  name fault_inject, interval 1, probability 100, space 0, times 1
+  CPU: 4 PID: 0 Comm: swapper/4 Tainted: G           O      5.4.77-pserver+ #170
+  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
+  Call Trace:
+  <IRQ>
+    dump_stack+0x97/0xe0
+    should_fail.cold+0x5/0x11
+    rnbd_clt_should_fail_request+0x5e/0x80 [rnbd_client]
+    msg_io_conf+0x42/0xb0 [rnbd_client]
+    complete_rdma_req+0x264/0x600 [rtrs_client]
+    rtrs_clt_rdma_done+0x4a2/0x690 [rtrs_client]
+    __ib_process_cq+0x94/0x100 [ib_core]
+    ib_poll_handler+0x3f/0xa0 [ib_core]
+    irq_poll_softirq+0xf8/0x280
+    __do_softirq+0x122/0x550
+    irq_exit+0xfb/0x100
+    do_IRQ+0x8a/0x170
+    common_interrupt+0xf/0xf
+    </IRQ>
+  RIP: 0010:default_idle+0x2b/0x1d0
+  Code: 1f 44 00 00 41 55 41 54 65 44 8b 25 7f fe 0a 7c 55 53 0f 1f 44 00 00 e8 53 65 30 ff e9 07 00 00 00 0f 00 2d b7 59 4b 00 fb f4 <65> 44 8b 25 5d fe 0a 7c 0f 1f 44 00 00 5b 5d 41 5c 41 5d c3 65 8b
+  RSP: 0018:ffff888114e2fdc8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdd
+  RAX: 0000000000000000 RBX: ffff888114e26440 RCX: dffffc0000000000
+  RDX: 0000000000000007 RSI: 0000000000000006 RDI: ffff888114e26cd4
+  RBP: 0000000000000004 R08: ffffffff8316d49d R09: 0000000000000000
+  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
+  R13: 0000000000000000 R14: ffff888114e26440 R15: 0000000000000000
+    ? lockdep_hardirqs_on+0x17d/0x250
+    ? default_idle+0x1d/0x1d0
+    do_idle+0x314/0x370
+    ? arch_cpu_idle_exit+0x40/0x40
+    ? schedule_idle+0x46/0x60
+    cpu_startup_entry+0x19/0x20
+    start_secondary+0x212/0x280
+    ? set_cpu_sibling_map+0xcb0/0xcb0
+    secondary_startup_64+0xa4/0xb0
+  rnbd_client L432: </dev/nullb0@bla> read I/O failed with err: -10
+  blk_update_request: I/O error, dev rnbd0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 3 prio class 0
-- 
2.25.1

