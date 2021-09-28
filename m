Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016AEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC6C561131
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 10:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbhI1Km5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Sep 2021 06:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240280AbhI1Kmv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 06:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632825672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=Iu25a+cqnBrHkIKSfPPiJTfwCo9Wph8TbFl7lcWV0QE=;
        b=YcIWGYyhcBm69xVGzsMGFhCWIk0iHPY7hglfF30mbIZsj1PAVDCQHUUGEuuV1vNXqOV2NC
        VKeLEz9xrb6vhvZpW3pI0ajuOog0DEI8ABbVPQXDK3kvEqHIvc+4ja2dcJT2xo4TFgR4pR
        vWgJOPCpAeMO80df8xve3LkWGuCYe78=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-IJqy338sNcKDUVGeK5N0jQ-1; Tue, 28 Sep 2021 06:41:11 -0400
X-MC-Unique: IJqy338sNcKDUVGeK5N0jQ-1
Received: by mail-oi1-f198.google.com with SMTP id j200-20020acaebd1000000b0027357b3466aso19471082oih.1
        for <linux-block@vger.kernel.org>; Tue, 28 Sep 2021 03:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Iu25a+cqnBrHkIKSfPPiJTfwCo9Wph8TbFl7lcWV0QE=;
        b=NnQVDdX7kDNYR/R6NDsCdlpKrUP0+beFHVbX63Sfc2QgMgt3uJ0EELhiXNZkWBJtKX
         ctw4OBQcNs2Q4nZ5jq1dHLcu5nAWRwP3XC+yfL7Z37V768ZkcWsfwfhZX22Fgm6Aucc8
         E+9V6MQikt6UIHtFJh4VUYVsQE+fmp9DDke1zpLPiMHI7GwMO5eDcmdBQoBd9dsURH/T
         9azsieVE0c3R+vkbejh82jhd0Iy9BKUGuOaOC7pFKuys8qdsH128pSNoX0jdvNlANLDB
         NsBC4dCo0rI/ERMt9b20lL7s6PP2gGsOyBiOoOLq8DtRqy8Bszxj8gL7Zv9TRZrzmsPh
         WSxw==
X-Gm-Message-State: AOAM5308eGooKRpGFd3O/75zsux/jZE+nEodcY9r+Yi712Wtqellp39/
        v/R9RBG7bZXm2pGY4HS1iIewQLxleaCoEac09IPlF/W9LSn9SLT5q1noPvtW55p0BSJQpmk3r97
        Fnfn64+rr9HUJuIzV0eZPgcnIIAqxDFjml8fEiNc=
X-Received: by 2002:a54:4f1d:: with SMTP id e29mr3051080oiy.179.1632825670114;
        Tue, 28 Sep 2021 03:41:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxguprT5Kh+XNwcMXaa/xjlzAHVOdzCXISGeISVXs6yPk5zkBGlnnZsxcg5XWTANTYg4+5V0X1BkJquCNdkBSY=
X-Received: by 2002:a54:4f1d:: with SMTP id e29mr3051069oiy.179.1632825669870;
 Tue, 28 Sep 2021 03:41:09 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 28 Sep 2021 12:40:59 +0200
Message-ID: <CA+QYu4oBndcsqv9f4r5Xn_C+WnPO1HYf4TGJ9b7=95R0akZX-Q@mail.gmail.com>
Subject: btrfs - ppc64le - NIP [c0000000004bfbf4] kmem_cache_alloc_node+0x1c4/0x4d0
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        CKI Project <cki-project@redhat.com>,
        Xiong Zhou <xzhou@redhat.com>, Huanian Li <huanli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When testing stable tree from
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
using cki xfstests for btrfs [1] on ppc64le we hit the following
panic:

[11660.843269] Running test [T:132376093 - xfstests - btrfs]
[11679.449129] BUG: Unable to handle kernel data access on read at
0xf7b347dd8c8fdb98
[11679.449160] Faulting instruction address: 0xc0000000004bfa94
[11679.449175] Oops: Kernel access of bad area, sig: 11 [#1]
[11679.449186] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[11679.449211] Modules linked in: xt_nat xt_addrtype xt_mark
nft_chain_nat xt_MASQUERADE nf_nat xt_comment veth bridge stp llc
vsock_loopback vmw_vsock_virtio_transport_common vsock loop tun af_key
crypto_user scsi_transport_iscsi xt_multiport ip_gre ip_tunnel gre
bluetooth ecdh_generic overlay xt_CONNSECMARK xt_SECMARK nft_counter
xt_state xt_conntrack nft_compat ah6 ah4 nft_objref nft_ct
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink vfat
fat jfs sctp ip6_udp_tunnel udp_tunnel ipmi_watchdog ipmi_poweroff
ipmi_ssif ipmi_devintf dm_log_writes rfkill sunrpc at24 joydev
tpm_i2c_nuvoton crct10dif_vpmsum ofpart regmap_i2c ipmi_powernv
powernv_flash mtd opal_prd tg3 rtc_opal ipmi_msghandler i2c_opal fuse
zram ip_tables xfs ast i2c_algo_bit drm_vram_helper drm_kms_helper
syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm
vmx_crypto crc32c_vpmsum drm i2c_core drm_panel_orientation_quirks
[last unloaded: raid10]
[11679.449536] CPU: 48 PID: 1114140 Comm: configure Tainted: G
  OE     5.14.7 #1
[11679.449562] NIP:  c0000000004bfa94 LR: c0000000004bf94c CTR: c000000000976790
[11679.449595] REGS: c000000088b9f0a0 TRAP: 0380   Tainted: G
 OE      (5.14.7)
[11679.449629] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
88222248  XER: 000000ad
[11679.449663] CFAR: c0000000004bfa78 IRQMASK: 1
[11679.449663] GPR00: c0000000004bf94c c000000088b9f340
c000000002866d00 0000000000000000
[11679.449663] GPR04: 0000000000002900 ffffffffffffffff
00000000000004b5 c009e000014f04c0
[11679.449663] GPR08: 0000000000000118 f7b347dd8c8fda80
c009dfe0057b04c0 6f723cbf8c9e92a8
[11679.449663] GPR12: 0000000000004000 c000001ffffab800
000000015217f760 0000000000000000
[11679.449663] GPR16: 0000000121d387b8 c000000088b9fbf0
0000000000000000 0000000000080001
[11679.449663] GPR20: c0000000460cc0a0 0000000000000001
0000000000060800 c0000000414c11f0
[11679.449663] GPR24: 0000000000000000 c0000000028a8af8
c00000000097520c ffffffffffffffff
[11679.449663] GPR28: 0000000000002900 0000000000000000
0000000000000001 c00000002ff9d080
[11679.449887] NIP [c0000000004bfa94] kmem_cache_alloc_node+0x1c4/0x4d0
[11679.449924] LR [c0000000004bf94c] kmem_cache_alloc_node+0x7c/0x4d0
[11679.449957] Call Trace:
[11679.449973] [c000000088b9f340] [c000000088b9f3d0]
0xc000000088b9f3d0 (unreliable)
[11679.450018] [c000000088b9f3b0] [c00000000097520c] bfq_get_queue+0x1cc/0x680
[11679.450052] [c000000088b9f470] [c000000000975d20] bfq_init_rq+0x530/0xc90
[11679.450085] [c000000088b9f550] [c0000000009768a4]
bfq_insert_requests+0x114/0x16f0
[11679.450120] [c000000088b9f6c0] [c00000000093a86c]
blk_mq_sched_insert_requests+0xac/0x1e0
[11679.450156] [c000000088b9f710] [c000000000932468]
blk_mq_flush_plug_list+0x138/0x1f0
[11679.450182] [c000000088b9f780] [c00000000091d8e8] blk_finish_plug+0x68/0x90
[11679.450206] [c000000088b9f7b0] [c0000000003eb990] read_pages+0x1d0/0x4b0
[11679.450230] [c000000088b9f830] [c0000000003ebe8c]
page_cache_ra_unbounded+0x21c/0x300
[11679.450266] [c000000088b9f8d0] [c0000000003dc4ac]
filemap_get_pages+0x11c/0x7d0
[11679.450301] [c000000088b9f9a0] [c0000000003dcc4c] filemap_read+0xec/0x480
[11679.450326] [c000000088b9fad0] [c008000019d224d8]
xfs_file_buffered_read+0xe0/0x120 [xfs]
[11679.450450] [c000000088b9fb10] [c008000019d23ad4]
xfs_file_read_iter+0xac/0x170 [xfs]
[11679.450568] [c000000088b9fb50] [c00000000051ade4] __kernel_read+0x144/0x360
[11679.450593] [c000000088b9fc40] [c000000000526a74] bprm_execve+0x254/0x7e0
[11679.450616] [c000000088b9fd10] [c00000000052792c]
do_execveat_common+0x17c/0x250
[11679.450650] [c000000088b9fd70] [c000000000527a48] sys_execve+0x48/0x60
[11679.450683] [c000000088b9fdb0] [c00000000002d47c]
system_call_exception+0x11c/0x360
[11679.450718] [c000000088b9fe10] [c00000000000c1e8]
system_call_vectored_common+0xe8/0x278
[11679.450754] --- interrupt: 3000 at 0x7fff9a6f0d04
[11679.450784] NIP:  00007fff9a6f0d04 LR: 0000000000000000 CTR: 0000000000000000
[11679.450798] REGS: c000000088b9fe80 TRAP: 3000   Tainted: G
 OE      (5.14.7)
[11679.450812] MSR:  900000000280f033
<SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 42224442  XER: 00000000
[11679.450860] IRQMASK: 0
[11679.450860] GPR00: 000000000000000b 00007fffc7ec6ba0
00007fff9a817000 0000000152180480
[11679.450860] GPR04: 000000015217ecb0 0000000152141a00
00000001520f0012 000000000015217e
[11679.450860] GPR08: 000000015212ad60 0000000000000000
0000000000000000 0000000000000000
[11679.450860] GPR12: 0000000000000000 00007fff9a95afa0
000000015217f760 0000000000000000
[11679.450860] GPR16: 0000000121d387b8 0000000121d394d4
0000000000000000 000000000000001f
[11679.450860] GPR20: 000000015217ecb0 000000015217fd70
0000000000000000 0000000152180480
[11679.450860] GPR24: 0000000000000000 000000015217f760
000000015216bc60 000000015217ecb0
[11679.450860] GPR28: 0000000152141a00 ffffffffffffffff
000000015217ff10 0000000000100000
[11679.451087] NIP [00007fff9a6f0d04] 0x7fff9a6f0d04
[11679.451107] LR [0000000000000000] 0x0
[11679.451125] --- interrupt: 3000
[11679.451142] Instruction dump:
[11679.451161] 2e1bffff 3b000000 3bc00001 2c2a0000 4182009c 41920010
894a0007 7c1b5000
[11679.451240] 4082008c 811f0028 e95f0000 e97f00b8 <7ce9402a> 7c094214
79490720 0b090000
[11679.451352] ---[ end trace 91affa7e930d27d6 ]---
[11679.533226]
[11680.533327] Kernel panic - not syncing: Fatal exception
[11682.416281] ---[ end Kernel panic - not syncing: Fatal exception ]---

We don't have a reliable reproducer, but we have hit this 3 times so far.

It might be related to the issue found with KASAN [2].

[1] https://gitlab.com/cki-project/kernel-tests/-/tree/main/filesystems/xfs/xfstests
[2] https://lore.kernel.org/linux-block/98103103-c517-59d2-a4d6-9b0758cbdfc1@kernel.dk/T/

Thank you,
Bruno

