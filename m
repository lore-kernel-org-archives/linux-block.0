Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C6C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 09:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFF360FD7
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 09:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhJZJgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 05:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230226AbhJZJgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 05:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635240817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+xwJnIvrJONldp4+eOJbSRx3C0c0W1vOpysC+bggrTM=;
        b=Ygj9SHq8cnHoQGYu9IGNAWQHbn+XRpUt7C9MNTXMazKEQRM7CYVqNPSxR25vbtVE88Lu1w
        6QaKlhScm/NFJ/1O1IECq7hvbur9+wdWBihYCCVPja3d+YkzoRM9soevML3I/OXcAXlI+n
        EjQ2pHwtj2rihFtxdYhDYtMV52FyrYE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-9wfgXQqdOtemAd8HXyxcrw-1; Tue, 26 Oct 2021 05:33:35 -0400
X-MC-Unique: 9wfgXQqdOtemAd8HXyxcrw-1
Received: by mail-yb1-f197.google.com with SMTP id r67-20020a252b46000000b005bea12c4befso21526869ybr.19
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 02:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+xwJnIvrJONldp4+eOJbSRx3C0c0W1vOpysC+bggrTM=;
        b=eJN5u3HlGCqPppdflfvWGu6cHteMKIkUSBBmzpiRyjVijWR20D6XS95Sb+fEIBE4eS
         gFFciUKMwKJ+tVX07Nd4dAXJRyQZ0WmrRZAt3CtFFDtKL/GiRH6oq7q/O5D333MjJJ1x
         IbRjGHmO5KE0ML8/vRqUYWzRYvycvMjBfZqNLrMTFYmQ7HaLZppKAKc/01QILsrlNIXR
         EnQSiR0cXsdcFKIlY6SuWP2cRHmoNYRnJ8/Tn3/QzTADqka7daWbwlFTSU7oym1Ly7K9
         o5a9yIpg/R9gCpMsAJEFssni0NsRi74zTNVGMeZ99pCCBNrGUqjOesLCmGSCveMmWV+K
         vwpA==
X-Gm-Message-State: AOAM533jWYUPdarcsqRojXv8ZNu43QpE6VoywWKMkQ+LzYENVd1rK7ga
        FfEVr08pP6F/bPgwit2xUTVBiDnsTgI5Qyi7cEiPixlccie+N6tg9pnJ9KITqAVGgtT0Uy/HPbL
        qE6KIYlvDqBJ0KQLLvZj6FS/uqOKIVyD2p9UAmMU=
X-Received: by 2002:a25:81c6:: with SMTP id n6mr22484086ybm.412.1635240815252;
        Tue, 26 Oct 2021 02:33:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL8C/8Ck7G8V4fohMgg97tF65Mf4k7OrJqDig5svAAKaAxX7BENQetVpFHIDooY0VStm88hVeW4Qj46b3ANpU=
X-Received: by 2002:a25:81c6:: with SMTP id n6mr22484067ybm.412.1635240814920;
 Tue, 26 Oct 2021 02:33:34 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 26 Oct 2021 17:33:23 +0800
Message-ID: <CAHj4cs-Co0mnojrWKGs5bhNrywTVW6OGtDp4yVN8RzaHPO4bog@mail.gmail.com>
Subject: [bug report] blktests block/029 triggered NULL pointer on latest linux-block/for-next
To:     linux-block <linux-block@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

Below NULL pointer was triggered[2] with blktests block/029 on latest
linux-block/for-next, pls check it.

[1]
9b3b463f3955 (HEAD -> for-next, origin/for-next) Merge branch
'for-5.16/block' into for-next

[2]
[  110.508269] run blktests block/029 at 2021-10-26 05:29:11
[  110.535182] null_blk: module loaded
[  110.674174] Kernel attempted to read user page (d8) - exploit
attempt? (uid: 0)
[  110.674212] BUG: Kernel NULL pointer dereference on read at 0x000000d8
[  110.674236] Faulting instruction address: 0xc0000000009414c4
[  110.674251] Oops: Kernel access of bad area, sig: 11 [#1]
[  110.674272] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  110.674308] Modules linked in: null_blk rfkill sunrpc joydev ofpart
ses enclosure scsi_transport_sas i40e at24 powernv_flash mtd
tpm_i2c_nuvoton regmap_i2c ipmi_powernv rtc_opal crct10dif_vpmsum
opal_prd ipmi_devintf i2c_opal ipmi_msghandler fuse zram ip_tables xfs
ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm
vmx_crypto crc32c_vpmsum i2c_core aacraid drm_panel_orientation_quirks
[  110.674485] CPU: 60 PID: 3469 Comm: check Not tainted 5.15.0-rc6+ #3
[  110.674520] NIP:  c0000000009414c4 LR: c000000000941638 CTR: 0000000000000000
[  110.674556] REGS: c00000003aea77c0 TRAP: 0300   Not tainted  (5.15.0-rc6+)
[  110.674580] MSR:  900000000280b033
<SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 84428482  XER: 00000006
[  110.674634] CFAR: c000000000941648 DAR: 00000000000000d8 DSISR:
40000000 IRQMASK: 0
[  110.674634] GPR00: c000000000941638 c00000003aea7a60
c0000000028a9a00 c00000001ad8a8c0
[  110.674634] GPR04: c000000089287e00 0000000000000001
00000000ffffffff ffffffffffffffff
[  110.674634] GPR08: 00000000000000d8 0000000000000000
00000000000000d8 0000000000000400
[  110.674634] GPR12: 0000000000008000 c000000ffff9e600
c00000001ac416c0 0000000000000000
[  110.674634] GPR16: 0000000000000001 0000000000000001
0000000000000000 c009dfffff94f300
[  110.674634] GPR20: 0000000000000000 0000000000000000
c0000000028e72b8 c0000000028e78a0
[  110.674634] GPR24: 0000000000000001 0000000000000008
c0000000aaa53838 c009dfffff94f388
[  110.674634] GPR28: c00000009d527698 c009dfffff94f3a0
0000000000000002 c0000000aaa53858
[  110.674942] NIP [c0000000009414c4] blk_mq_map_swqueue+0x1a4/0x490
[  110.674982] LR [c000000000941638] blk_mq_map_swqueue+0x318/0x490
[  110.675021] Call Trace:
[  110.675038] [c00000003aea7a60] [c000000000941638]
blk_mq_map_swqueue+0x318/0x490 (unreliable)
[  110.675080] [c00000003aea7b10] [c0000000009420e4]
blk_mq_update_nr_hw_queues+0x244/0x480
[  110.675128] [c00000003aea7bd0] [c00800000f3e2d60]
nullb_device_submit_queues_store+0x98/0x120 [null_blk]
[  110.675182] [c00000003aea7c20] [c000000000648aa8]
configfs_write_iter+0x118/0x1e0
[  110.675224] [c00000003aea7c70] [c000000000521494] new_sync_write+0x124/0x1b0
[  110.675281] [c00000003aea7d10] [c000000000524794] vfs_write+0x2c4/0x390
[  110.675299] [c00000003aea7d60] [c000000000524b08] ksys_write+0x78/0x130
[  110.675316] [c00000003aea7db0] [c00000000002d648]
system_call_exception+0x188/0x360
[  110.675335] [c00000003aea7e10] [c00000000000c1e8]
system_call_vectored_common+0xe8/0x278
[  110.675355] --- interrupt: 3000 at 0x7fffa1aefee4
[  110.675367] NIP:  00007fffa1aefee4 LR: 0000000000000000 CTR: 0000000000000000
[  110.675393] REGS: c00000003aea7e80 TRAP: 3000   Not tainted  (5.15.0-rc6+)
[  110.675429] MSR:  900000000280f033
<SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48422488  XER: 00000000
[  110.675482] IRQMASK: 0
[  110.675482] GPR00: 0000000000000004 00007fffc592dd30
00007fffa1be7000 0000000000000001
[  110.675482] GPR04: 0000000143297fc0 0000000000000002
0000000000000010 00000001432bd791
[  110.675482] GPR08: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
[  110.675482] GPR12: 0000000000000000 00007fffa1d2afa0
0000000000000000 0000000000000000
[  110.675482] GPR16: 000000010dfd87b8 000000010dfd94d4
0000000020000000 000000010deeae80
[  110.675482] GPR20: 0000000000000000 00007fffc592df54
000000010df83128 000000010dfd89bc
[  110.675482] GPR24: 000000010dfd8a50 0000000000000000
0000000143297fc0 0000000000000002
[  110.675482] GPR28: 0000000000000002 00007fffa1be16d8
0000000143297fc0 0000000000000002
[  110.675718] NIP [00007fffa1aefee4] 0x7fffa1aefee4
[  110.675750] LR [0000000000000000] 0x0
[  110.675769] --- interrupt: 3000
[  110.675789] Instruction dump:
[  110.675798] 2c290000 41820168 e91c0600 7bc926e4 e95c0048 7d28482a
7d29a82e 79291f24
[  110.675845] 7d2a482a f93d0000 390900d8 7d489214 <7d08a02a> 7d088839
4082004c 7d0050a8
[  110.675885] ---[ end trace b9b604499c6b5b71 ]---
[  110.814135]
[  111.814148] Kernel panic - not syncing: Fatal exception
[  113.674122] ---[ end Kernel panic - not syncing: Fatal exception ]---

-- 
Best Regards,
  Yi Zhang

