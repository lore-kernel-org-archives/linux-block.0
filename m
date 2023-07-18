Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A0EB64DA
	for <linux-block@archiver.kernel.org>; Tue, 18 Jul 2023 12:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjGRMxP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jul 2023 08:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjGRMxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2023 08:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DA4188
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689684749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=81HUz5TsjLf2tkUXAeCvH6wBtAZ4xsXWeh9xXuk3h0I=;
        b=BaJx8f2/vcCL38BvVYCxXkkD4dTciaKHj4szKVqIsnrhUSNoB9rNuXhV2eeFho2ihKiEUT
        5bvYEKBoSk3UiunMbzUWtc0p8AOxPsPOBOYwUeDfgjAVVhQQ5SvXnzdHepFegYCZO8Zh8C
        N2R08nhGwcPfZZjCdDdjmxSpq9/WlMM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-MFy_Ul1GOhCX6NmPoqs4wA-1; Tue, 18 Jul 2023 08:52:28 -0400
X-MC-Unique: MFy_Ul1GOhCX6NmPoqs4wA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2631fc29e8aso2792832a91.3
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 05:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684747; x=1692276747;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81HUz5TsjLf2tkUXAeCvH6wBtAZ4xsXWeh9xXuk3h0I=;
        b=UiX/WzMw6HMlOecScXtcVci46o2fHlULvOCGxVC2PGPtm3j5eNtKW1AMu+6HTMAe9E
         4mUPxnK/NtHWkgxeaQk0HDItsC8/n7XsazRNbcgeFNovZq5ulGEiyPLaJ/si1DkJ3ui9
         cY8Unw4JKeKCmqH87hBNL1Tb6JofNVhjeV3y4KGbSObf9HkK5CxGjDc701o1uaZFb/14
         LazUrQxGNLAhk+wRK8hIB3buBlBTpj3wTh0neHESOIrHWucdsrL7ay34uX8Ab6CUYNdM
         XavkVbBQ0AWrtsakE2IxiZ1f/wfsSnyQrm7GivEC5ZP1vVtwmd7M2s+n+/PdH6o0nEUj
         n8AQ==
X-Gm-Message-State: ABy/qLbgNKZPtya7kPbBG6fol9BxhAX9r2f5eMxq8ommM1XseXPfkAZX
        huPM3u7RPIhY8b3g0UwYXw7OAk4YvaO95Fw+VXlXw5CLIXFpmjDUQoKdsgWU/rZ4+QZGAWX+yTi
        lQZPG4gmuXNGbMD2H5J9KxygmLZcj9lMdWB5QRNDfTlGJX0rnHUOxRps=
X-Received: by 2002:a17:90b:3112:b0:262:ebb9:dd60 with SMTP id gc18-20020a17090b311200b00262ebb9dd60mr11373781pjb.20.1689684747354;
        Tue, 18 Jul 2023 05:52:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGvxPA95PkPTVO/xjrMI2ejhidENujGKn3ICHdHVTKbJjxTA/b9gWHKY3hwf3ujOLRqmH5o81MLzFTplO/FvIk=
X-Received: by 2002:a17:90b:3112:b0:262:ebb9:dd60 with SMTP id
 gc18-20020a17090b311200b00262ebb9dd60mr11373765pjb.20.1689684746901; Tue, 18
 Jul 2023 05:52:26 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 18 Jul 2023 20:52:15 +0800
Message-ID: <CAHj4cs96VFJoncjaam1u4JT4PWZEJxWxR3BhJVRH6p0uCBvd5g@mail.gmail.com>
Subject: [bug report] Unable to handle kernel paging request observed during
 blktest nvme/047
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

I connected one remote testing server and running stress blktests
nvme/tcp nvme/047, my local PC's network suddenly disconnect,
when I connect the remote test server again, found the server panic,
here is the full log.

[ 2775.059752] run blktests nvme/047 at 2023-07-18 07:14:35
[ 2775.077916] loop0: detected capacity change from 0 to 2097152
[ 2775.086905] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2775.097228] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 2775.107654] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2775.122214] nvme nvme1: creating 128 I/O queues.
[ 2775.131320] nvme nvme1: mapped 128/0/0 default/read/poll queues.
[ 2775.156774] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[ 2776.457015] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 2776.819885] nvmet: creating nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2776.834469] nvme nvme1: creating 128 I/O queues.
[ 2776.843587] nvme nvme1: mapped 128/0/0 default/read/poll queues.
[ 2776.868188] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[ 2777.130742] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 2778.008799] run blktests nvme/047 at 2023-07-18 07:14:38
[ 2778.026652] loop0: detected capacity change from 0 to 2097152
[ 2778.035601] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2778.046391] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 2778.057017] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2778.071593] nvme nvme1: creating 128 I/O queues.
[ 2778.080719] nvme nvme1: mapped 128/0/0 default/read/poll queues.
[ 2778.106150] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[ 2779.409008] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 2779.749743] nvmet: creating nvm controller 2 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2779.764303] nvme nvme1: creating 128 I/O queues.
[ 2779.773359] nvme nvme1: mapped 128/0/0 default/read/poll queues.
[ 2779.797745] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[ 2780.053958] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[ 2780.350049] ------------[ cut here ]------------
[ 2780.354658] WARNING: CPU: 118 PID: 1874 at kernel/workqueue.c:1635
__queue_work+0x3cc/0x460
[ 2780.362999] Modules linked in: nvmet_tcp nvmet nvme_fabrics loop
rfkill sunrpc vfat fat ast acpi_ipmi drm_shmem_helper ipmi_ssif
arm_spe_pmu drm_kms_helper ipmi_devintf ipmi_msghandler arm_cmn
arm_dmc620_pmu arm_dsu_pmu cppc_cpufreq fuse drm xfs libcrc32c
crct10dif_ce nvme ghash_ce igb sha2_ce nvme_core sha256_arm64 sha1_ce
sbsa_gwdt i2c_designware_platform nvme_common i2c_algo_bit
i2c_designware_core xgene_hwmon dm_mirror dm_region_hash dm_log dm_mod
[last unloaded: nvme_tcp]
[ 2780.405219] CPU: 118 PID: 1874 Comm: kworker/118:1H Kdump: loaded
Not tainted 6.5.0-rc2+ #1
[ 2780.413557] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
F31n (SCP: 2.10.20220810) 09/30/2022
[ 2780.422848] Workqueue: kblockd blk_mq_run_work_fn
[ 2780.427542] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2780.434490] pc : __queue_work+0x3cc/0x460
[ 2780.438487] lr : __queue_work+0x408/0x460
[ 2780.442484] sp : ffff800086ec3ba0
[ 2780.445785] x29: ffff800086ec3ba0 x28: ffff07ffb8a4d6c0 x27: ffff07fff7bf1400
[ 2780.452908] x26: ffff07ffe52e0af8 x25: ffff07ffb8a4d708 x24: 0000000000000000
[ 2780.460030] x23: ffff800086ec3cd8 x22: ffff07ff94d70000 x21: 0000000000000000
[ 2780.467152] x20: ffff0800814f2400 x19: ffff07ff94d70008 x18: 0000000000000000
[ 2780.474275] x17: 0000000000000000 x16: ffffd3eb60e7a5e0 x15: 0000000000000000
[ 2780.481397] x14: 0000000000000000 x13: 0000000000000038 x12: 0101010101010101
[ 2780.488519] x11: 7f7f7f7f7f7f7f7f x10: fefefefefefefeff x9 : ffffd3eb60e7a588
[ 2780.495641] x8 : fefefefefefefeff x7 : 0000000000000008 x6 : 000000010003c8e4
[ 2780.502763] x5 : ffff07ffe52e4db0 x4 : 0000000000000000 x3 : 0000000000000000
[ 2780.509885] x2 : 0000000000000000 x1 : 0000000004208060 x0 : ffff07ff84c67e00
[ 2780.517008] Call trace:
[ 2780.519441]  __queue_work+0x3cc/0x460
[ 2780.523091]  queue_work_on+0x70/0xc0
[ 2780.526654]  0xffffd3eb3893ff74
[ 2780.529784]  blk_mq_dispatch_rq_list+0x148/0x578
[ 2780.534389]  __blk_mq_sched_dispatch_requests+0xb4/0x1b8
[ 2780.539689]  blk_mq_sched_dispatch_requests+0x40/0x80
[ 2780.544727]  blk_mq_run_work_fn+0x44/0x98
[ 2780.548723]  process_one_work+0x1f4/0x488
[ 2780.552720]  worker_thread+0x74/0x420
[ 2780.556369]  kthread+0x100/0x110
[ 2780.559585]  ret_from_fork+0x10/0x20
[ 2780.563148] ---[ end trace 0000000000000000 ]---
[ 2789.825110] nvmet: ctrl 2 keep-alive timer (5 seconds) expired!
[ 2789.831054] nvmet: ctrl 2 fatal error occurred!
[ 2789.835585] Unable to handle kernel paging request at virtual
address ffffd3eb3893e448
[ 2789.843489] Mem abort info:
[ 2789.846272]   ESR = 0x0000000086000007
[ 2789.850007]   EC = 0x21: IABT (current EL), IL = 32 bits
[ 2789.855309]   SET = 0, FnV = 0
[ 2789.858350]   EA = 0, S1PTW = 0
[ 2789.861478]   FSC = 0x07: level 3 translation fault
[ 2789.866344] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000080457515000
[ 2789.873032] [ffffd3eb3893e448] pgd=1000080ffffff003,
p4d=1000080ffffff003, pud=1000080029323003, pmd=1000080039493003,
pte=0000000000000000
[ 2789.885542] Internal error: Oops: 0000000086000007 [#1] SMP
[ 2789.891102] Modules linked in: nvmet_tcp nvmet loop rfkill sunrpc
vfat fat ast acpi_ipmi drm_shmem_helper ipmi_ssif arm_spe_pmu
drm_kms_helper ipmi_devintf ipmi_msghandler arm_cmn arm_dmc620_pmu
arm_dsu_pmu cppc_cpufreq fuse drm xfs libcrc32c crct10dif_ce nvme
ghash_ce igb sha2_ce nvme_core sha256_arm64 sha1_ce sbsa_gwdt
i2c_designware_platform nvme_common i2c_algo_bit i2c_designware_core
xgene_hwmon dm_mirror dm_region_hash dm_log dm_mod [last unloaded:
nvme_fabrics]
[ 2789.932537] CPU: 0 PID: 60955 Comm: kworker/0:125 Kdump: loaded
Tainted: G        W          6.5.0-rc2+ #1
[ 2789.942177] Hardware name: GIGABYTE R152-P31-00/MP32-AR1-00, BIOS
F31n (SCP: 2.10.20220810) 09/30/2022
[ 2789.951469] Workqueue: nvmet-wq nvmet_fatal_error_handler [nvmet]
[ 2789.957560] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2789.964509] pc : 0xffffd3eb3893e448
[ 2789.967985] lr : tcp_fin+0xb8/0x1a0
[ 2789.971463] sp : ffff800080003a80
[ 2789.974764] x29: ffff800080003a80 x28: ffff07ffdf93b480 x27: 0000000000000001
[ 2789.981886] x26: ffffd3eb6181a1d0 x25: ffff08008a3c1020 x24: 0000000000000000
[ 2789.989009] x23: ffffd3eb637c9480 x22: ffff08008a3c1020 x21: ffff080089b94310
[ 2789.996131] x20: ffff080089b942e8 x19: ffff07ffdf93b480 x18: ffffffffffffffff
[ 2790.003254] x17: ffff3423d4d57000 x16: ffff800080000000 x15: ffff800143a0b9c7
[ 2790.010376] x14: 0000000000000000 x13: 2164657272756363 x12: 6f20726f72726520
[ 2790.017498] x11: ffffd3eb637c9480 x10: 0000000000004411 x9 : ffffd3eb6191d9e8
[ 2790.024621] x8 : ffff800080003ae8 x7 : 0000000000000000 x6 : 0000000000004103
[ 2790.031744] x5 : ffff3423d4d57000 x4 : ffffd3eb62bbc478 x3 : ffffffffffffffff
[ 2790.038866] x2 : 0000000000000000 x1 : ffffd3eb3893e448 x0 : ffff07ffdf93b480
[ 2790.045989] Call trace:
[ 2790.048422]  0xffffd3eb3893e448
[ 2790.051551]  tcp_data_queue+0x43c/0x570
[ 2790.055374]  tcp_rcv_established+0x2ec/0x868
[ 2790.059631]  tcp_v4_do_rcv+0x1c8/0x370
[ 2790.063368]  tcp_v4_rcv+0xc98/0xd20
[ 2790.066844]  ip_protocol_deliver_rcu+0x48/0x1e0
[ 2790.071362]  ip_local_deliver_finish+0x80/0xd0
[ 2790.075792]  ip_local_deliver+0x80/0x128
[ 2790.079702]  ip_rcv_finish+0x94/0xb8
[ 2790.083264]  ip_rcv+0x58/0x100
[ 2790.086306]  __netif_receive_skb_one_core+0x5c/0x90
[ 2790.091172]  __netif_receive_skb+0x1c/0x70
[ 2790.095255]  process_backlog+0xc8/0x1c8
[ 2790.099077]  __napi_poll+0x3c/0x218
[ 2790.102553]  net_rx_action+0x340/0x448
[ 2790.106289]  __do_softirq+0x118/0x3d4
[ 2790.109939]  ____do_softirq+0x14/0x28
[ 2790.113589]  call_on_irq_stack+0x24/0x30
[ 2790.117499]  do_softirq_own_stack+0x20/0x30
[ 2790.121669]  do_softirq+0xa8/0xc0
[ 2790.124973]  __local_bh_enable_ip+0xa0/0xb8
[ 2790.129143]  __dev_queue_xmit+0x350/0x698
[ 2790.133140]  neigh_hh_output+0x9c/0x108
[ 2790.136964]  ip_finish_output2+0x3fc/0x4d0
[ 2790.141047]  __ip_finish_output+0xa4/0x1a0
[ 2790.145131]  ip_finish_output+0x38/0xf0
[ 2790.148954]  ip_output+0xfc/0x1b8
[ 2790.152256]  __ip_queue_xmit+0x16c/0x400
[ 2790.156166]  ip_queue_xmit+0x18/0x28
[ 2790.159729]  __tcp_transmit_skb+0x3ec/0x7f0
[ 2790.163900]  tcp_write_xmit+0x534/0xb08
[ 2790.167723]  __tcp_push_pending_frames+0x40/0x108
[ 2790.172415]  tcp_send_fin+0x6c/0x240
[ 2790.175978]  tcp_shutdown+0x60/0x70
[ 2790.179453]  inet_shutdown+0xb4/0x128
[ 2790.183103]  kernel_sock_shutdown+0x1c/0x30
[ 2790.187274]  nvmet_tcp_delete_ctrl+0x6c/0xa0 [nvmet_tcp]
[ 2790.192576]  nvmet_fatal_error_handler+0x3c/0x50 [nvmet]
[ 2790.197882]  process_one_work+0x1f4/0x488
[ 2790.201879]  worker_thread+0x74/0x420
[ 2790.205529]  kthread+0x100/0x110
[ 2790.208745]  ret_from_fork+0x10/0x20
[ 2790.212309] Code: ???????? ???????? ???????? ???????? (????????)
[ 2790.218390] SMP: stopping secondary CPUs
[ 2790.223318] Starting crashdump kernel...
[ 2790.227228] Bye!
-- 
Best Regards,
  Yi Zhang

