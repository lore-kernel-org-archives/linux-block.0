Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B6DC43334
	for <linux-block@archiver.kernel.org>; Fri,  8 Jul 2022 16:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiGHQDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jul 2022 12:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbiGHQDl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jul 2022 12:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BB8B25C69
        for <linux-block@vger.kernel.org>; Fri,  8 Jul 2022 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657296217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=6H7ZjwyzSQ8hGonkqlETZCtzSTJLBbixJg+2FnenLaU=;
        b=Ntcw+DoWakh1Xdnhe8Nd6QmJ3hkZBpYnx6KQAEKy6Fg1hax3qsDS7PFAM/VSiIYhy6dqnh
        y9FYDok2KAastlbrm72d8QxUuzVJDjBpvbA6Ij6lBcMjFdsalW07+gAlTuJIBrDNxUAnhD
        jEh06AVToRBuUtWvyOrgP/5pXMmDB4A=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-C-W2VL2KOt64lrZbAGUvhg-1; Fri, 08 Jul 2022 12:03:36 -0400
X-MC-Unique: C-W2VL2KOt64lrZbAGUvhg-1
Received: by mail-pg1-f198.google.com with SMTP id o10-20020a655bca000000b00412787983b3so6216373pgr.12
        for <linux-block@vger.kernel.org>; Fri, 08 Jul 2022 09:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6H7ZjwyzSQ8hGonkqlETZCtzSTJLBbixJg+2FnenLaU=;
        b=SU98+HjdS0yffwUm8Xn3w/a1XviU1iBygGB4tzjbwgKnAb21fb1LXjVadkAgeu6J5y
         LDFMb5CHPUb3eAfBpET/bqkQig+5M95L0dqhYcjL38kW2S6a9zYwPNGfognRt9J/hXvQ
         3ESt/0VbffyYtzmKBJcOMFRhlcYkJ+l2BJb/X8Av4oNqhNZB3dhgGKmyKG4y63wjCeDc
         zmTdKut/ORpzvwka+0TuOBemGuCc9IMzxyAtonJR9ZcY9/PnFm3OKiX/uRxDHwNs6pYp
         6XhDwqITC9R6hotuHwU/8ue4OosU+ZDxnQcTT6afdrgOpFfzDbnT8p/z3RtUMIb40Mhg
         v0pg==
X-Gm-Message-State: AJIora9MaLwBbc3J4jdBa2rHFvu5dga/jTdN5ef1gkG4i/YSLiJbxy7e
        lJotkug345bzVG/CWqDhojwPSCGThrBcv2dHNHciHoQUDXnhW++1In0OuXL+4X1qk5ikT5TU7/m
        rryOdle1bgpyiuyGLKBUP4nWNrovx/wDnT+9hOck=
X-Received: by 2002:a17:902:db10:b0:16c:1bf9:dec9 with SMTP id m16-20020a170902db1000b0016c1bf9dec9mr4342951plx.15.1657296214952;
        Fri, 08 Jul 2022 09:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tjc84fSv6MyYmk1LP58p8X3o2VlrxZEWMFlgP4j8lldO9e7iREe/YxP87QF9DCPSTEyfG5ni930GPdOi1CqsQ=
X-Received: by 2002:a17:902:db10:b0:16c:1bf9:dec9 with SMTP id
 m16-20020a170902db1000b0016c1bf9dec9mr4342918plx.15.1657296214491; Fri, 08
 Jul 2022 09:03:34 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sat, 9 Jul 2022 00:03:23 +0800
Message-ID: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
Subject: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
To:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

I reproduced this issue on the linux-block/for-next, pls help check
it, feel free to let me know if you need info/test, thanks.

[ 6026.144114] run blktests nvme/012 at 2022-07-08 08:15:09
[ 6026.271866] loop0: detected capacity change from 0 to 2097152
[ 6026.294403] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 6026.322827] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 6026.347984] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:90390a00-4597-11e9-b935-3c18a0043981.
[ 6026.364007] nvme nvme0: creating 32 I/O queues.
[ 6026.380279] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[ 6026.398481] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[ 6027.653759] XFS (nvme0n1): Mounting V5 Filesystem
[ 6027.677423] XFS (nvme0n1): Ending clean mount
[ 6173.064201] XFS (nvme0n1): Unmounting Filesystem
[ 6173.656286] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 6174.005589] ------------[ cut here ]------------
[ 6174.010200] workqueue: WQ_MEM_RECLAIM
nvmet-wq:nvmet_tcp_release_queue_work [nvmet_tcp] is flushing
!WQ_MEM_RECLAIM nvmet_tcp_wq:nvmet_tcp_io_work [nvmet_tcp]
[ 6174.010216] WARNING: CPU: 20 PID: 14456 at kernel/workqueue.c:2628
check_flush_dependency+0x110/0x14c
[ 6174.033579] Modules linked in: nvme_tcp nvme_fabrics nvmet_tcp
nvmet nvme nvme_core loop tls mlx4_ib ib_uverbs ib_core mlx4_en rfkill
sunrpc vfat fat joydev acpi_ipmi mlx4_core igb ipmi_ssif cppc_cpufreq
fuse zram xfs uas usb_storage dwc3 ulpi udc_core ast crct10dif_ce
drm_vram_helper ghash_ce drm_ttm_helper sbsa_gwdt ttm
i2c_xgene_slimpro ahci_platform gpio_dwapb xgene_hwmon xhci_plat_hcd
ipmi_devintf ipmi_msghandler [last unloaded: nvmet]
[ 6174.072622] CPU: 20 PID: 14456 Comm: kworker/20:8 Not tainted 5.19.0-rc5+ #1
[ 6174.079660] Hardware name: Lenovo HR350A            7X35CTO1WW
/FALCON     , BIOS hve104q-1.14 06/25/2020
[ 6174.089474] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tcp]
[ 6174.096168] pstate: 004000c5 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 6174.103117] pc : check_flush_dependency+0x110/0x14c
[ 6174.107985] lr : check_flush_dependency+0x110/0x14c
[ 6174.112851] sp : ffff800026b2bb10
[ 6174.116153] x29: ffff800026b2bb10 x28: 0000000000000000 x27: ffff80000a94f240
[ 6174.123279] x26: ffff800009304a90 x25: 0000000000000001 x24: ffff80000a570448
[ 6174.130405] x23: ffff009f6c6d82a8 x22: fffffbffee9cea00 x21: ffff800001395430
[ 6174.137532] x20: ffff0008c0fb3000 x19: ffff00087b7dda00 x18: ffffffffffffffff
[ 6174.144657] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000006
[ 6174.151783] x14: 0000000000000001 x13: 204d49414c434552 x12: 5f4d454d5f515721
[ 6174.158909] x11: 00000000ffffdfff x10: ffff80000a53eb70 x9 : ffff80000824f754
[ 6174.166034] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 : 00000000000affa8
[ 6174.173160] x5 : 0000000000001fff x4 : 0000000000000000 x3 : 0000000000000027
[ 6174.180286] x2 : 0000000000000002 x1 : ffff0008c6080000 x0 : 0000000000000092
[ 6174.187412] Call trace:
[ 6174.189847]  check_flush_dependency+0x110/0x14c
[ 6174.194367]  start_flush_work+0xd8/0x410
[ 6174.198278]  __flush_work+0x88/0xe0
[ 6174.201755]  __cancel_work_timer+0x118/0x194
[ 6174.206014]  cancel_work_sync+0x20/0x2c
[ 6174.209837]  nvmet_tcp_release_queue_work+0xcc/0x300 [nvmet_tcp]
[ 6174.215834]  process_one_work+0x2b8/0x704
[ 6174.219832]  worker_thread+0x80/0x42c
[ 6174.223483]  kthread+0xfc/0x110
[ 6174.226613]  ret_from_fork+0x10/0x20
[ 6174.230179] irq event stamp: 0
[ 6174.233221] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 6174.239478] hardirqs last disabled at (0): [<ffff800008198c44>]
copy_process+0x674/0x14a0
[ 6174.247644] softirqs last  enabled at (0): [<ffff800008198c44>]
copy_process+0x674/0x14a0
[ 6174.255809] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 6174.262063] ---[ end trace 0000000000000000 ]-----

Best Regards,
  Yi Zhang

