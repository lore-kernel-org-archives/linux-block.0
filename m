Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49284CCA473
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 02:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiFVC0C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 22:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiFVC0B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 22:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89B8433A17
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 19:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655864759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=rub1k0hTkvuY6qzgoWVW2ifK93q0NGoqLKkeOehtpBM=;
        b=JDNM7OxFJh4EXuy6IN386GPDqkgen9VU/duWJ0/LEzsMSqGyitHUKsYULEz7xttjyYlz6N
        Wq5B4HIuGZc7x7Pljq2An8TvV0DiPqgVBDrc1tXyf67jURuIH5f2WwM0DQEbckBlotvxab
        xNZsdjdjwwCy+q10LoOqpDROn3u+LAU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-rL7Nt37ZOPuQpzfo2c7n3w-1; Tue, 21 Jun 2022 22:25:56 -0400
X-MC-Unique: rL7Nt37ZOPuQpzfo2c7n3w-1
Received: by mail-pg1-f198.google.com with SMTP id g34-20020a635662000000b0040d1da6ada4so476155pgm.1
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 19:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rub1k0hTkvuY6qzgoWVW2ifK93q0NGoqLKkeOehtpBM=;
        b=X9cUzTcMZqn2WQ0EPRvFck79q1EdzJoeGHO6lv/abcSLVeUREmvQNcgJ8JCNg2JqB2
         hqzCyZI82wSXKdS0iKQR4RfwEIm5gf9HLh1ngBNIhUg/bBaQP22Txn79WeQFN0vgQecN
         uggKCS7zgMD9e5Zy6T5QX06UIH51Gn4P42xwACA36H9Chw0jGuUw0N80UO86cupqncWp
         IE3FZ+Ujdb8IMlnmperGhjfZoB8zGRqgtpF2kLGr47pTBVYmhSoCNHsErSnUVAYTmxU7
         mhMssJPK2yauWIL3WsNC3JXeFTF1YzXoKtNLwzrgm4yTaiNkYE4g6WQKOT0LxB9fhD4W
         zTJQ==
X-Gm-Message-State: AJIora9Lw4fBRCBF8wd5/24gDHunVrEmS0TIMPTtC8WgdaJb1ixZFfhE
        NCqz0Ot5R9A2pmsx20hUew832dL/xhGHCN0Y6Vs+yi16Ht5wBrOaZLUqLFDSGnAdFXOP7W6khwr
        6EV3+vJZO/Oi61WoyyYhBp57CV3o9IVAaq1lfzVc=
X-Received: by 2002:a63:4446:0:b0:405:2d62:95e6 with SMTP id t6-20020a634446000000b004052d6295e6mr900015pgk.328.1655864755468;
        Tue, 21 Jun 2022 19:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vVkaINc/KKqta830zhbeOn2mtAwsndvDBTxtCFu7/89yPPPJ/a1I0Re/YX/cgBlmwwqU2/olxh97yMeFAFPRk=
X-Received: by 2002:a63:4446:0:b0:405:2d62:95e6 with SMTP id
 t6-20020a634446000000b004052d6295e6mr899998pgk.328.1655864755157; Tue, 21 Jun
 2022 19:25:55 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Wed, 22 Jun 2022 10:25:43 +0800
Message-ID: <CAHj4cs--KPTAGP=jj+7KMe=arDv=HeGeOgs1T8vbusyk=EjXow@mail.gmail.com>
Subject: [bug report] I/O blocked during nvme pci rescan/remove/reset test
 with two nvme disks
To:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello
I reproduced the below I/O blocked issue during nvme pci
rescan/reset/remove test with two NVMe disks on the latest
linux-block/for-next, pls help check it, thanks.

[51184.910570] nvme nvme1: 48/0/0 default/read/poll queues
[51186.996061] pci 0000:87:00.0: [8086:0a55] type 00 class 0x010802
[51186.996124] pci 0000:87:00.0: reg 0x10: [mem 0xd3800000-0xd3803fff 64bit]
[51186.997357] pci 0000:87:00.0: BAR 0: assigned [mem
0xd3800000-0xd3803fff 64bit]
[51186.997741] nvme nvme1: pci function 0000:87:00.0
[51187.016653] nvme nvme1: 48/0/0 default/read/poll queues
[51187.031004]  nvme1n1: p1
[51189.995841] nvme nvme0: 31/0/0 default/read/poll queues
[51190.198376] nvme nvme1: 48/0/0 default/read/poll queues
[51195.380767] pci 0000:86:00.0: [8086:0953] type 00 class 0x010802
[51195.380832] pci 0000:86:00.0: reg 0x10: [mem 0xd3900000-0xd3903fff 64bit]
[51195.380966] pci 0000:86:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[51195.393766] pci 0000:87:00.0: [8086:0a55] type 00 class 0x010802
[51195.393831] pci 0000:87:00.0: reg 0x10: [mem 0xd3800000-0xd3803fff 64bit]
[51195.394995] pci 0000:86:00.0: BAR 6: assigned [mem
0xd3900000-0xd390ffff pref]
[51195.395005] pci 0000:86:00.0: BAR 0: assigned [mem
0xd3910000-0xd3913fff 64bit]
[51195.395037] pci 0000:87:00.0: BAR 0: assigned [mem
0xd3800000-0xd3803fff 64bit]
[51195.395420] nvme nvme0: pci function 0000:86:00.0
[51195.395702] nvme nvme1: pci function 0000:87:00.0
[51195.414531] nvme nvme1: 48/0/0 default/read/poll queues
[51195.428759]  nvme1n1: p1
[51198.394239] nvme nvme0: 31/0/0 default/read/poll queues
[51198.405370]  nvme0n1: p1
[51198.590384] nvme nvme1: 48/0/0 default/read/poll queues
[51200.553556] pci 0000:87:00.0: [8086:0a55] type 00 class 0x010802
[51200.553621] pci 0000:87:00.0: reg 0x10: [mem 0xd3800000-0xd3803fff 64bit]
[51200.554800] pci 0000:87:00.0: BAR 0: assigned [mem
0xd3800000-0xd3803fff 64bit]
[51200.555174] nvme nvme1: pci function 0000:87:00.0
[51200.573516] nvme nvme1: 48/0/0 default/read/poll queues
[51200.587858]  nvme1n1: p1
[51202.856978] nvme nvme0: 31/0/0 default/read/poll queues
[51206.178358] pci 0000:86:00.0: [8086:0953] type 00 class 0x010802
[51206.178423] pci 0000:86:00.0: reg 0x10: [mem 0xd3910000-0xd3913fff 64bit]
[51206.178557] pci 0000:86:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[51206.179661] pci 0000:86:00.0: BAR 6: assigned [mem
0xd3900000-0xd390ffff pref]
[51206.179671] pci 0000:86:00.0: BAR 0: assigned [mem
0xd3910000-0xd3913fff 64bit]
[51206.180057] nvme nvme0: pci function 0000:86:00.0
[51206.302723] nvme nvme1: 48/0/0 default/read/poll queues
[51208.269290] pci 0000:87:00.0: [8086:0a55] type 00 class 0x010802
[51208.269354] pci 0000:87:00.0: reg 0x10: [mem 0xd3800000-0xd3803fff 64bit]
[51208.270576] pci 0000:87:00.0: BAR 0: assigned [mem
0xd3800000-0xd3803fff 64bit]
[51208.270884] nvme nvme1: pci function 0000:87:00.0
[51208.289461] nvme nvme1: 48/0/0 default/read/poll queues
[51208.303177]  nvme1n1: p1
[51211.070104] nvme nvme0: 31/0/0 default/read/poll queues
[51211.080531] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 0
[51211.080538] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[51211.080547] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 0
[51211.080550] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[51211.080556] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 0
[51211.080558] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[51211.080563] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 0
[51211.080566] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[51211.080570] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 0
[51211.080573] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[51211.080577] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 0
[51211.080579] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[51211.080581] Dev nvme0n1: unable to read RDB block 0
[51211.080585] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 0
[51211.080587] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[51211.080592] I/O error, dev nvme0n1, sector 0 op 0x0:(READ) flags
0x0 phys_seg 1 prio class 0
[51211.080594] Buffer I/O error on dev nvme0n1, logical block 0, async page read
[51211.080596]  nvme0n1: unable to read partition table
[51211.083942] I/O error, dev nvme0n1, sector 3125627392 op 0x0:(READ)
flags 0x80700 phys_seg 1 prio class 0
[51211.083973] I/O error, dev nvme0n1, sector 3125627392 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[51211.083978] Buffer I/O error on dev nvme0n1, logical block
390703424, async page read
[51211.454527] nvme nvme1: 48/0/0 default/read/poll queues
[51213.417104] pci 0000:87:00.0: [8086:0a55] type 00 class 0x010802
[51213.417169] pci 0000:87:00.0: reg 0x10: [mem 0xd3800000-0xd3803fff 64bit]
[51213.418351] pci 0000:87:00.0: BAR 0: assigned [mem
0xd3800000-0xd3803fff 64bit]
[51213.418724] nvme nvme1: pci function 0000:87:00.0
[51213.437681] nvme nvme1: 48/0/0 default/read/poll queues
[51213.451835]  nvme1n1: p1
[51215.142444] nvme nvme0: 31/0/0 default/read/poll queues
[51216.606364] nvme nvme1: 48/0/0 default/read/poll queues
[51218.570918] pci 0000:87:00.0: [8086:0a55] type 00 class 0x010802
[51218.570983] pci 0000:87:00.0: reg 0x10: [mem 0xd3800000-0xd3803fff 64bit]
[51218.572165] pci 0000:87:00.0: BAR 0: assigned [mem
0xd3800000-0xd3803fff 64bit]
[51218.572539] nvme nvme1: pci function 0000:87:00.0
[51218.591636] nvme nvme1: 48/0/0 default/read/poll queues
[51218.605022]  nvme1n1: p1
[51221.750225] nvme nvme1: 48/0/0 default/read/poll queues
[51223.721738] pci 0000:87:00.0: [8086:0a55] type 00 class 0x010802
[51223.721802] pci 0000:87:00.0: reg 0x10: [mem 0xd3800000-0xd3803fff 64bit]
[51223.722964] pci 0000:87:00.0: BAR 0: assigned [mem
0xd3800000-0xd3803fff 64bit]
[51223.723358] nvme nvme1: pci function 0000:87:00.0
[51223.743645] nvme nvme1: 48/0/0 default/read/poll queues
[51223.757692]  nvme1n1: p1
[51226.901932] nvme nvme1: 48/0/0 default/read/poll queues
[51228.873546] pci 0000:87:00.0: [8086:0a55] type 00 class 0x010802
[51228.873611] pci 0000:87:00.0: reg 0x10: [mem 0xd3800000-0xd3803fff 64bit]
[51228.874820] pci 0000:87:00.0: BAR 0: assigned [mem
0xd3800000-0xd3803fff 64bit]
[51228.875198] nvme nvme1: pci function 0000:87:00.0
[51228.894161] nvme nvme1: 48/0/0 default/read/poll queues
[51228.907613]  nvme1n1: p1
[51232.053773] nvme nvme1: 48/0/0 default/read/poll queues
[51234.131361] pci 0000:87:00.0: [8086:0a55] type 00 class 0x010802
[51234.131425] pci 0000:87:00.0: reg 0x10: [mem 0xd3800000-0xd3803fff 64bit]
[51234.132584] pci 0000:87:00.0: BAR 0: assigned [mem
0xd3800000-0xd3803fff 64bit]
[51234.132949] nvme nvme1: pci function 0000:87:00.0
[51234.151738] nvme nvme1: 48/0/0 default/read/poll queues
[51234.165192]  nvme1n1: p1
[51237.317630] nvme nvme1: 48/0/0 default/read/poll queues
[51362.993640] INFO: task kworker/u97:2:28679 blocked for more than 122 seconds.
[51363.000796]       Tainted: G S        I       5.19.0-rc3+ #1
[51363.006463] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[51363.014294] task:kworker/u97:2   state:D stack:    0 pid:28679
ppid:     2 flags:0x00004000
[51363.014300] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[51363.014312] Call Trace:
[51363.014313]  <TASK>
[51363.014316]  __schedule+0x3ed/0x990
[51363.014329]  ? _raw_spin_lock_irqsave+0x17/0x40
[51363.014333]  schedule+0x44/0xb0
[51363.014337]  blk_mq_freeze_queue_wait+0x62/0x90
[51363.014345]  ? add_wait_queue_priority+0xa0/0xa0
[51363.014357]  nvme_wait_freeze+0x31/0x50 [nvme_core]
[51363.014371]  nvme_reset_work+0xc4b/0x1070 [nvme]
[51363.014377]  process_one_work+0x1c8/0x390
[51363.014386]  worker_thread+0x1b9/0x360
[51363.014389]  ? process_one_work+0x390/0x390
[51363.014392]  kthread+0xe8/0x110
[51363.014396]  ? kthread_complete_and_exit+0x20/0x20
[51363.014399]  ret_from_fork+0x22/0x30
[51363.014406]  </TASK>
[51363.014411] INFO: task main.sh:34574 blocked for more than 122 seconds.
[51363.021034]       Tainted: G S        I       5.19.0-rc3+ #1
[51363.026700] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[51363.034534] task:main.sh         state:D stack:    0 pid:34574
ppid: 33964 flags:0x00004000
[51363.034538] Call Trace:
[51363.034539]  <TASK>
[51363.034541]  __schedule+0x3ed/0x990
[51363.034546]  schedule+0x44/0xb0
[51363.034549]  schedule_timeout+0x265/0x300
[51363.034551]  ? resched_curr+0x23/0xc0
[51363.034556]  ? _raw_spin_lock_irqsave+0x17/0x40
[51363.034559]  wait_for_completion+0x94/0x130
[51363.034561]  __flush_work+0x138/0x1f0
[51363.034566]  ? flush_workqueue_prep_pwqs+0x110/0x110
[51363.034569]  pci_reset_function+0x47/0x70
[51363.034577]  reset_store+0x57/0xa0
[51363.034580]  kernfs_fop_write_iter+0x130/0x1c0
[51363.034585]  new_sync_write+0x10c/0x190
[51363.034593]  vfs_write+0x218/0x2a0
[51363.034596]  ksys_write+0x59/0xd0
[51363.034598]  do_syscall_64+0x3a/0x80
[51363.034605]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[51363.034608] RIP: 0033:0x7f309c720ad8
[51363.034610] RSP: 002b:00007ffe381be618 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[51363.034613] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f309c720ad8
[51363.034614] RDX: 0000000000000002 RSI: 0000556a2f887b20 RDI: 0000000000000001
[51363.034615] RBP: 0000556a2f887b20 R08: 000000000000000a R09: 00007f309c780d40
[51363.034616] R10: 000000000000000a R11: 0000000000000246 R12: 00007f309c9c16e0
[51363.034617] R13: 0000000000000002 R14: 00007f309c9bc860 R15: 0000000000000002
[51363.034619]  </TASK>

-- 
Best Regards,
  Yi Zhang

