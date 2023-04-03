Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C22C76196
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 17:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDCRgQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Apr 2023 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDCRgP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2023 13:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF361980
        for <linux-block@vger.kernel.org>; Mon,  3 Apr 2023 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680543327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6sJzswR1pix/r9xSSZ16AmLAslPgKGbFdLpZ7IH++8M=;
        b=a4qqjhS0xZZZwiZ6uSUBe09fZWYjUXV5AWPYMLa4lRTh7UJ238qSjn93CJdTuNe3ekIrci
        TkC0n4QCLuQ7CwFYS4Zl9aHXbgDFsQNSOb5ic1BPf3hL83BwnX7ubtPN07LpePRqKthDij
        vkhm/WxsGX2fdERSurQ1E0Et+2WKOSo=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-eRKc1K22PU6fjNyl3hxjjA-1; Mon, 03 Apr 2023 13:35:26 -0400
X-MC-Unique: eRKc1K22PU6fjNyl3hxjjA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-17ab1d11480so16029379fac.13
        for <linux-block@vger.kernel.org>; Mon, 03 Apr 2023 10:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543325;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sJzswR1pix/r9xSSZ16AmLAslPgKGbFdLpZ7IH++8M=;
        b=XzsfYCLo0Rk4zo5hRxXBUP7bi5XAV0kS1KW93G/Z5HGBTKkmHLoz0ZybXE22gJUJ8z
         tvkQF0tJgf+BSkp9H/gAMQ3XcOBhk8CjWuRDGywrCkdSAQcWPqhhYxt2ShGhbBbuYVM8
         xLOcJMb0+p9RZlI7Lm8FxZrjN59IFLSkPvQdavd8ED+Lq4Q4tI9HHwwEqfnVgBO4jrVn
         BOCOh6icj7lnxSM1oEAZh3d5o6mEsJvd6h21/1AwGAVYJkyGDur5eVN2cEVluMwGQphS
         JohTvxvEpJEHERuMOzwJ560E/yqZjXyar1+UpjJAtiykxFL5YlRD8Zic/8Vn2QnSF2I5
         pXbg==
X-Gm-Message-State: AAQBX9dXgQ1IPvE2fmI4gvN7rew6XjzKsyGw12yo08kiX2IHp61EdV5X
        atSxk7n0w5dsL+pAXQJzCgdMvtGq7b1ztqec+QX23VM+Bk1IPTFKzVllqRv2FqreLJODEPChRiW
        nh0MYLBDveVR8/Dag2ohl7AUaLB2IQ3s=
X-Received: by 2002:a05:6871:88a:b0:17a:d7c5:f252 with SMTP id r10-20020a056871088a00b0017ad7c5f252mr18975oaq.26.1680543325569;
        Mon, 03 Apr 2023 10:35:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350a+9ITu5sC8DMUDcoQDlksVHxZBbKIxrIf2PNNUIkK3hesR+VJ0dkjn2P8HwZXxFpdHgkA9eg==
X-Received: by 2002:a05:6871:88a:b0:17a:d7c5:f252 with SMTP id r10-20020a056871088a00b0017ad7c5f252mr18961oaq.26.1680543325277;
        Mon, 03 Apr 2023 10:35:25 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:45:ae91:c478:3bf0? ([2600:6c64:4e7f:603b:45:ae91:c478:3bf0])
        by smtp.gmail.com with ESMTPSA id p2-20020a056830130200b006a2ddc13c46sm3840321otq.78.2023.04.03.10.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:35:24 -0700 (PDT)
Message-ID: <d1dbb7c5eca51993e9988849ab2e43e800ecb067.camel@redhat.com>
Subject: Issue with discard with NVME and Infinibox Storage
From:   Laurence Oberman <loberman@redhat.com>
To:     minlei@redhat.com, jmeneghi@redhat.com,
        "Hellwig, Christoph" <hch@infradead.org>, axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Mon, 03 Apr 2023 13:35:22 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ming and Christoph

Issue with Infinibox storage
----------------------------
Really discovered 2 issues here=20

Issue 1
Kernels 5.15 to 5.18 inclusive recognize the discard support on the
Infinibox device but they fail in the nvme_setup_discard function call


[  339.591118] ------------[ cut here ]------------
[  339.591134] WARNING: CPU: 3 PID: 32 at drivers/nvme/host/core.c:868
nvme_setup_discard+0x16e/0x1e0 [nvme_core]

[  339.591349] CPU: 3 PID: 32 Comm: kworker/3:0H Not tainted 5.15.0 #1
[  339.591404] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[  339.591423] Workqueue: kblockd blk_mq_run_work_fn
[  339.591458] RIP: 0010:nvme_setup_discard+0x16e/0x1e0 [nvme_core]
[  339.591475] Code: 38 48 8b b8 48 0b 00 00 48 2b 3d 2d 69 43 d3 48 c1
ff 06 48 c1 e7 0c 48 03 3d 2e 69 43 d3 48 89 f8 48 85 f6 0f 85 dd fe ff
ff <0f> 0b ba 00 00 00 80 48 01 d7 72 52 48 c7 c2 00 00 00 80 48 2b 15
[  339.591505] RSP: 0018:ffffbacb0052fcf8 EFLAGS: 00010212
[  339.591516] RAX: ffff93798b67e000 RBX: ffff937994565780 RCX:
ffff937a0b67e000
[  339.591529] RDX: 0000000000000020 RSI: 0000000000000000 RDI:
ffff93798b67e000
[  339.591541] RBP: ffff93799452f1b0 R08: ffff93798b67e000 R09:
00000000014000c0
[  339.591553] R10: 0000000000000800 R11: 0000000000000000 R12:
ffff9379a0df1000
[  339.591566] R13: 0000000000000001 R14: ffffbacb0052fde0 R15:
ffff9379a0df1000
[  339.591578] FS:  0000000000000000(0000) GS:ffff9379b9ec0000(0000)
knlGS:0000000000000000
[  339.591602] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  339.591617] CR2: 00007f4b7792f000 CR3: 000000010dcf2003 CR4:
0000000000770ee0
[  339.591641] PKRU: 55555554
[  339.591648] Call Trace:
[  339.591656]  nvme_setup_cmd+0xac/0x650 [nvme_core]
[  339.591673]  nvme_tcp_queue_rq+0x6a/0x390 [nvme_tcp]
[  339.591685]  blk_mq_dispatch_rq_list+0x139/0x810
[  339.591698]  ? blk_mq_flush_busy_ctxs+0xf9/0x120
[  339.591708]  __blk_mq_sched_dispatch_requests+0x135/0x140
[  339.591720]  blk_mq_sched_dispatch_requests+0x30/0x60
[  339.591746]  __blk_mq_run_hw_queue+0x2b/0x60
[  339.591757]  process_one_work+0x1cb/0x370
[  339.592339]  worker_thread+0x30/0x380
[  339.593200]  ? process_one_work+0x370/0x370
[  339.593990]  kthread+0x118/0x140
[  339.594710]  ? set_kthread_struct+0x40/0x40
[  339.595267]  ret_from_fork+0x1f/0x30
[  339.596077] ---[ end trace 547450bc9931a628 ]---
[  339.596806] blk_update_request: I/O error, dev nvme1c1n1, sector
20971712 op 0x3:(DISCARD) flags 0x2004000 phys_seg 1 prio class 0
[  339.741735] blk_update_request: I/O error, dev nvme1c1n1, sector
21037248 op 0x3:(DISCARD) flags 0x2004000 phys_seg 1 prio class 0
[  339.743952] blk_update_request: I/O error, dev nvme1c1n1, sector
21102784 op 0x3:(DISCARD) flags 0x2004000 phys_seg 1 prio class 0
[  339.745480] blk_update_request: I/O error, dev nvme1c1n1, sector
21168320 op 0x3:(DISCARD) flags 0x2004000 phys_seg 1 prio class 0
[  339.746425] blk_update_request: I/O error, dev nvme1c1n1, sector
21233856 op 0x3:(DISCARD) flags 0x2004000 phys_seg 1 prio class 0
[  339.747150] blk_update_request: I/O error, dev nvme1c1n1, sector
21299392 op 0x3:(DISCARD) flags 0x2004000 phys_seg 1 prio class 0
[  339.747948] blk_update_request: I/O error, dev nvme1c1n1, sector
21364928 op 0x3:(DISCARD) flags 0x2000000 phys_seg 1 prio class 0


Issue 2
Trying to narrow this down.
5.19 and higher (6.3 included), no longer support discard on the
Infinibox device and log this message so I cannot run the test for the
discard issue

[   35.989809] nvme nvme1: new ctrl: NQN "nqn.2020-
01.com.infinidat:36000-subsystem-696", addr 192.168.1.2:4420
[   64.810437] XFS (nvme1n1): mounting with "discard" option, but the
device does not support discard
[   64.812298] XFS (nvme1n1): Mounting V5 Filesystem 6763a33f-18cc-
4a26-894b-8b0f8d79a98a

I then bisected between 5.18 and 5.19 to this commit

1a86924e4f464757546d7f7bdc469be237918395 is the first bad commit
commit 1a86924e4f464757546d7f7bdc469be237918395
Author: Tom Yan <tom.ty89@gmail.com>
Date:   Fri Apr 29 12:52:43 2022 +0800

    nvme: fix interpretation of DMRSL
   =20
    DMRSLl is in the unit of logical blocks, while max_discard_sectors
is
    in the unit of "linux sector".
   =20
    Signed-off-by: Tom Yan <tom.ty89@gmail.com>
    Signed-off-by: Christoph Hellwig <hch@lst.de>

 drivers/nvme/host/core.c | 6 ++++--
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)


Note that Infindat mentioned this in our case they logged with us
They say they fully adhere to TP4040 MDTS.
Towards NVMe-oF 2.0 specification, TP4040  - Max Data Transfer for non-
IO Commands (MDTS) was released with additional fields to control these
parameters.
These parameters are supported in kernel versions 5.15 and above.  ****

Our storage target will reply with 0 for bit 2 of the ONCS, indicating
UNMAP is supported based on the DMRL, DMRSL, and DMSL values.=20
(older kernels will interpret these values as UNMAP NOT SUPPORTED)


Let me know your thoughts please. for both issues

Regards
Laurence Oberman


