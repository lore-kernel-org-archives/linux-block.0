Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D22EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 04:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjFUEc3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 00:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUEc2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 00:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57275171C
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 21:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687321900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=ShzQvgnvSXBGlOeuQ7IMEWJ0anBKb9Mpn1ZOSZri1jg=;
        b=gl9yZNAPAkx39uqGmpVy0g5/pbrrv/N72PKwTS8l7YHcN/dqwsz6MqRfibCnYmFXlGAb5K
        XiTnjFsBTGgAmqGpHHSC4MDZx7L7Gy+IuViUaYOrdBTddz7HC8DDtpY/yWuNVLJMDSTwZV
        r+YPaJxNnDJYBUPwAIGx7h4EzhlpM0s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-6zgrZmO_PIeag7AIz0-m2Q-1; Wed, 21 Jun 2023 00:31:38 -0400
X-MC-Unique: 6zgrZmO_PIeag7AIz0-m2Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-987ffac39e3so253096766b.0
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 21:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687321897; x=1689913897;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShzQvgnvSXBGlOeuQ7IMEWJ0anBKb9Mpn1ZOSZri1jg=;
        b=NR98vVAJVTrfE4OlG8W432wmsxzg2Hxtzjsz0nm2LnNqvHElJfi3KBs+x6P6BRMBZN
         57quRZQMjUsRQTdTRxPy1YYZpeNABWH5IxvMHZyOU0VRjGYBm3SUjJZJeXSA29TMnZJ9
         8GODaSgy6OXnVRE39vEt18/ajtJiLSrQOF1kZb6m5wiqQE1JfGvK74NjEv7J3QsH+4h+
         +lGVzme6fmML4WYdCsNW64AADqrjhyY/Jq8Y3JK1UdFyzOkJ/NXQ46jEQcn9XDwVzMgB
         Fei9hOKEyH3glVpPuFNaYeGX/GZaLVNjTJik7wFCo4dsxeQHi4IK4AV6n6JccZsc9h6a
         YMAg==
X-Gm-Message-State: AC+VfDwmdw619SAhgU5Yc1180orEg9e7Q8Xce6MSfa1qY2PtcMA4cn2M
        JWwt05EpFvtkbeASDYdC+UKDE3p3OyTZ9H3FD6Gsf58UeCgb32NPE0skJ7Dz9NLZb13IQneSpMi
        vClOTdUCMVDQMKyTPBwZUeYwp08Ee0L6Yi+3ny4zRVwimEdyIS2dA
X-Received: by 2002:a17:906:5d0c:b0:988:6e75:6b3d with SMTP id g12-20020a1709065d0c00b009886e756b3dmr8516390ejt.33.1687321897366;
        Tue, 20 Jun 2023 21:31:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51nLW3DzlV8aGxsA24nLMWs0mkHetEZeJIHzxUov5mRgWDxxj2+AiPnrL6bns9fr2lsT8pXLS+iMNoQcgr8bE=
X-Received: by 2002:a17:906:5d0c:b0:988:6e75:6b3d with SMTP id
 g12-20020a1709065d0c00b009886e756b3dmr8516378ejt.33.1687321897058; Tue, 20
 Jun 2023 21:31:37 -0700 (PDT)
MIME-Version: 1.0
From:   Guangwu Zhang <guazhang@redhat.com>
Date:   Wed, 21 Jun 2023 12:32:44 +0800
Message-ID: <CAGS2=YrBjpLPOKa-gzcKuuOG60AGth5794PNCDwatdnnscB9ug@mail.gmail.com>
Subject: [bug report] system will hung up when cpu hot plug
To:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

We found this kernel issue with latest linux-block/for-next, let me
know if you need more info/testing, thanks

kernel repo:
    Merge branch 'for-6.5/block' into for-next
    * for-6.5/block:
      reiserfs: fix blkdev_put() warning from release_journal_dev()

test steps:
1. run cpu online/offline in background
2. run fio with ioengine=io_uring_cmd

[  358.994290] smpboot: CPU 17 is now offline
[  360.059002] smpboot: CPU 4 is now offline
[  484.806374] INFO: task kworker/35:1:325 blocked for more than 121 seconds.
[  484.813285]       Not tainted 6.4.0-rc3.kasan+ #1
[  484.818002] "echo 0 > /proc/sys/kernel/hung_task_tim
eout_secs"
disables this message.
[  484.825834] task:kworker/35:1    state:D stack:0     pid:325
ppid:2      flags:0x00004000
[  484.825843] Workqueue: events cpuset_hotplug_workfn
[  484.825854] Call Trace:
[  484.825857]  <TASK>
[  484.825860]  __schedule+0x60e/0x1530
[  484.825868]  ? synchronize_rcu+0x212/0x260
[  484.825874]  ? __pfx___schedule+0x10/0x10
[  484.825878]  ? _raw_spin_lock_irqsave+0x87/0xe0
[  484.825884]  ? rcu_nocb_try_bypass+0x12c/0xf70
[  484.825889]  ? _raw_spin_lock_irq+0x82/0xe0
[  484.825893]  schedule+0x12d/0x210
[  484.825897]  percpu_rwsem_wait+0x1ba/0x3e0
[  484.825905]  ? __pfx_percpu_rwsem_wait+0x10/0x10
[  484.825910]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[  484.825915]  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
[  484.825921]  ? _raw_spin_lock_irq+0x82/0xe0
[  484.825924]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  484.825927]  ? _raw_spin_lock_irq+0x82/0xe0
[  484.825931]  __percpu_down_read+0xde/0x2a0
[  484.825937]  cpus_read_lock+0x4b/0x50
[  484.825944]  cpuset_hotplug_workfn+0x321/0xcd0
[  484.825949]  ? __schedule+0x616/0x1530
[  484.825953]  ? __pfx_cpuset_hotplug_workfn+0x10/0x10
[  484.825957]  ? _raw_spin_lock_irq+0x82/0xe0
[  484.825961]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  484.825965]  process_one_work+0x686/0x1100
[  484.825971]  worker_thread+0x583/0xe90
[  484.825976]  ? __kthread_parkme+0x83/0x140
[  484.825982]  ? __pfx_worker_thread+0x10/0x10
[  484.825985]  kthread+0x2a6/0x380
[  484.825990]  ? __pfx_kthread+0x10/0x10
[  484.825995]  ret_from_fork+0x29/0x50
[  484.826004]  </TASK>
[  484.826007] INFO: task kworker/36:1:327 blocked for more than 121 seconds.
[  484.832886]       Not tainted 6.4.0-rc3.kasan+ #1
[  484.837591] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  484.845421] task:kworker/36:1    state:D stack:0     pid:327
ppid:2      flags:0x00004000
[  484.845426] Workqueue: events vmstat_shepherd
[  484.845432] Call Trace:
[  484.845434]  <TASK>
[  484.845436]  __schedule+0x60e/0x1530
[  484.845440]  ? __pfx___schedule+0x10/0x10
[  484.845443]  ? __pfx_newidle_balance+0x10/0x10
[  484.845448]  ? _raw_spin_lock_irq+0x82/0xe0
[  484.845452]  ? _raw_spin_lock_irq+0x82/0xe0
[  484.845455]  schedule+0x12d/0x210
[  484.845458]  percpu_rwsem_wait+0x1ba/0x3e0
[  484.845462]  ? __pfx_percpu_rwsem_wait+0x10/0x10
[  484.845467]  ? __pfx_percpu_rwsem_wake_function+0x10/0x10
[  484.845472]  __percpu_down_read+0xde/0x2a0
[  484.845476]  cpus_read_lock+0x4b/0x50
[  484.845479]  vmstat_shepherd+0x39/0x1c0
[  484.845483]  process_one_work+0x686/0x1100
[  484.845486]  worker_thread+0x583/0xe90
[  484.845490]  ? __kthread_parkme+0x83/0x140
[  484.845493]  ? __pfx_worker_thread+0x10/0x10
[  484.845496]  kthread+0x2a6/0x380
[  484.845499]  ? __pfx_kthread+0x10/0x10
[  484.845503]  ret_from_fork+0x29/0x50
[  484.845507]  </TASK>
[  484.845568] INFO: task iou-wrk-3681:3682 blocked for more than 121 seconds.
[  484.852531]       Not tainted 6.4.0-rc3.kasan+ #1
[  484.857240] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  484.865073] task:iou-wrk-3681    state:D stack:0     pid:3682
ppid:3660   flags:0x00004000
[  484.865077] Call Trace:
[  484.865079]  <TASK>
[  484.865081]  __schedule+0x60e/0x1530
[  484.865084]  ? __pfx___schedule+0x10/0x10
[  484.865088]  schedule+0x12d/0x210
[  484.865091]  io_schedule+0xc3/0x140
[  484.865094]  blk_mq_get_tag+0x395/0xaa0
[  484.865100]  ? __pfx_blk_mq_get_tag+0x10/0x10
[  484.865104]  ? nvme_prep_rq.part.0+0x2d9/0x4e0 [nvme]
[  484.865116]  ? __pfx_autoremove_wake_function+0x10/0x10
[  484.865121]  ? nvme_queue_rq+0x4c7/0x790 [nvme]
[  484.865132]  __blk_mq_alloc_requests+0x5de/0xc30
[  484.865138]  ? _raw_spin_lock+0x81/0xe0
[  484.865141]  ? __pfx___blk_mq_alloc_requests+0x10/0x10
[  484.865145]  blk_mq_alloc_request+0x467/0x5e0
[  484.865149]  ? __pfx_blk_mq_alloc_request+0x10/0x10
[  484.865154]  ? security_capable+0x53/0xa0
[  484.865158]  nvme_uring_cmd_io+0x5c2/0xcd0 [nvme_core]
[  484.865190]  ? __pfx_nvme_uring_cmd_io+0x10/0x10 [nvme_core]
[  484.865218]  ? common_interrupt+0x17/0xa0
[  484.865224]  ? common_interrupt+0x17/0xa0
[  484.865229]  io_uring_cmd+0x1f1/0x3d0
[  484.865233]  io_issue_sqe+0x4ff/0xe80
[  484.865238]  ? _raw_spin_lock+0x8f/0xe0
[  484.865241]  io_wq_submit_work+0x23e/0xa00
[  484.865245]  io_worker_handle_work+0x404/0xa80
[  484.865252]  io_wq_worker+0x6c5/0x9d0
[  484.865257]  ? __pfx_io_wq_worker+0x10/0x10
[  484.865269]  ret_from_fork+0x29/0x50
[  484.865274]  </TASK>


-- 
Guangwu Zhang
Thanks

