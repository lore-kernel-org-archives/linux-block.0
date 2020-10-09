Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340B0C433E7
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 22:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA17C22370
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 22:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7gvFWxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbgJIWLB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 18:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732880AbgJIWLB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Oct 2020 18:11:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF97C0613D2;
        Fri,  9 Oct 2020 15:10:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so11782146wrp.8;
        Fri, 09 Oct 2020 15:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VIp30qMwLSnEThfrPskup6NFW2FXz0ahX3T7yecRIeY=;
        b=b7gvFWxJGGej+lggOzW5q/IRPocIg3awgWWgepKxiIAOrKowSx9YCb2MxgmMjXkPy4
         g8UtTtErBm3axweCZbngy1gvl/wsF3M5Oe3x/06BOOypT+nhmJpVOiQSZX6dbrDfT/Lj
         B6l93u4TcdwpZEKzc/pdWnGbShsgGAQ+I7GQPPUCKdsWUji2q2pVLtBI+pFHQYO3LWO1
         l4lLJF9EgDkO3zj9XeJBEYzmT84Av9TQoCu+/M8lyrxlw1eX90nppoOYhN8876PEiY7w
         67sswZA1voCNpXCfBV8YcUCZNo0bLrClUbXOD22dW2OWKK68cj1vQVlp4X3VRl9AJAIy
         Q2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VIp30qMwLSnEThfrPskup6NFW2FXz0ahX3T7yecRIeY=;
        b=Vq7fT7eLyaL/xIbNz6ZZxT3sx6aiffk8jI84deoExXODxjX7WIz6lI6MUS/maMvx5S
         FzMVTK+EFjaZw7UWpQl7augAtNGnrY/uMY8uVY7HHntIxM2GhEpCeHRwkwG3WQrS0Jte
         xyPHF+lbRUQlhsINfQdthUaClY9kIXKAhiONce88LqWBIuCO1nJaZvY4xbpYBD/96MyA
         f8qWHuCBmSGSYywMKqRLjSxPU5588weY2bU+5ZV6AomNGJkyBBNVOOuQWvQGJetddDdk
         JcsiBwWIFJ+49t6uHmpRfVH3AhFGapEuUDt4MAd0XUDUUVMPO1fzWinMXruwR5+w+7/D
         uGhg==
X-Gm-Message-State: AOAM532udeHDSezZ5hG1jtINV3UOojmmTHNuNe78vRbwEDR7wZAJGxO4
        +5Lhh++rnx2juDT/GLIy+Y+1xePMVuIbEawC6jyTD3zZCtvyzQ==
X-Google-Smtp-Source: ABdhPJzOqTcX6w3BircgBEqJ/NUO8y71R8fqhtf3tPdV4a3r4RNOoKD5SSuCOEBCawpbHnDsShIDG9PYgjf+ETh307g=
X-Received: by 2002:a5d:504a:: with SMTP id h10mr16441984wrt.85.1602281457096;
 Fri, 09 Oct 2020 15:10:57 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 10 Oct 2020 03:10:45 +0500
Message-ID: <CABXGCsP63mN+G1xE7UBfVRuDRcJiRRC7EXU2y25f9rXkoU-0LQ@mail.gmail.com>
Subject: [bugreport 5.9-rc8] general protection fault, probably for
 non-canonical address 0x46b1b0f0d8856e4a: 0000 [#1] SMP NOPTI
To:     linux-block@vger.kernel.org, paolo.valente@linaro.org,
        axboe@fb.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Paolo, Jens I am sorry for the noise.
But today I hit the kernel panic and git blame said that you have
created the file in which happened panic (this I saw from trace)

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname -r`/vmlinux
__bfq_deactivate_entity+0x15a
__bfq_deactivate_entity+0x15a/0x240:
bfq_gt at block/bfq-wf2q.c:20
(inlined by) bfq_insert at block/bfq-wf2q.c:381
(inlined by) bfq_idle_insert at block/bfq-wf2q.c:621
(inlined by) __bfq_deactivate_entity at block/bfq-wf2q.c:1203

https://github.com/torvalds/linux/blame/master/block/bfq-wf2q.c#L1203

$ head /sys/block/*/queue/scheduler
==> /sys/block/nvme0n1/queue/scheduler <==
[none] mq-deadline kyber bfq

==> /sys/block/sda/queue/scheduler <==
mq-deadline kyber [bfq] none

==> /sys/block/zram0/queue/scheduler <==
none

Trace:
general protection fault, probably for non-canonical address
0x46b1b0f0d8856e4a: 0000 [#1] SMP NOPTI
CPU: 27 PID: 1018 Comm: kworker/27:1H Tainted: G        W
--------- ---  5.9.0-0.rc8.28.fc34.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 2606 08/13/2020
Workqueue: kblockd blk_mq_run_work_fn
RIP: 0010:__bfq_deactivate_entity+0x15a/0x240
Code: 48 2b 41 28 48 85 c0 7e 05 49 89 5c 24 18 49 8b 44 24 08 4d 8d
74 24 08 48 85 c0 0f 84 d6 00 00 00 48 8b 7b 28 eb 03 48 89 c8 <48> 8b
48 28 48 8d 70 10 48 8d 50 08 48 29 f9 48 85 c9 48 0f 4f d6
RSP: 0018:ffffadf6c0c6fc00 EFLAGS: 00010002
RAX: 46b1b0f0d8856e4a RBX: ffff8dc2773b5c88 RCX: 46b1b0f0d8856e4a
RDX: ffff8dc7d02ed0a0 RSI: ffff8dc7d02ed0a8 RDI: 0000584e64e96beb
RBP: ffff8dc2773b5c00 R08: ffff8dc9054cb938 R09: 0000000000000000
R10: 0000000000000018 R11: 0000000000000018 R12: ffff8dc904927150
R13: 0000000000000001 R14: ffff8dc904927158 R15: ffff8dc2773b5c88
FS:  0000000000000000(0000) GS:ffff8dc90e0c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000003e8ebe4000 CR3: 00000007c2546000 CR4: 0000000000350ee0
Call Trace:
 bfq_deactivate_entity+0x4f/0xc0
 bfq_del_bfqq_busy+0xbf/0x170
 __bfq_bfqq_expire+0x95/0xc0
 bfq_bfqq_expire+0x3c5/0x9a0
 ? bfq_active_extract+0x8e/0x140
 bfq_dispatch_request+0x438/0x1070
 __blk_mq_do_dispatch_sched+0x1c7/0x290
 ? dequeue_entity+0xa4/0x420
 __blk_mq_sched_dispatch_requests+0x129/0x180
 blk_mq_sched_dispatch_requests+0x30/0x60
 __blk_mq_run_hw_queue+0x49/0x110
 process_one_work+0x1b4/0x370
 worker_thread+0x53/0x3e0
 ? process_one_work+0x370/0x370
 kthread+0x11b/0x140
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x22/0x30
Modules linked in: tun snd_seq_dummy snd_hrtimer uinput rfcomm
xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp
nf_conntrack_tftp bridge stp llc nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set
nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter cmac
bnep sunrpc vfat fat mt76x2u snd_hda_codec_realtek mt76x2_common
mt76x02_usb snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi
mt76_usb mt76x02_lib edac_mce_amd iwlmvm snd_hda_intel mt76
snd_intel_dspcfg kvm_amd mac80211 gspca_zc3xx snd_usb_audio
snd_hda_codec gspca_main uvcvideo btusb snd_usbmidi_lib iwlwifi
snd_hda_core videobuf2_vmalloc kvm videobuf2_memops btrtl snd_rawmidi
videobuf2_v4l2 snd_hwdep
 btbcm snd_seq btintel videobuf2_common eeepc_wmi irqbypass
snd_seq_device asus_wmi xpad bluetooth joydev sparse_keymap libarc4
rapl cfg80211 ff_memless snd_pcm videodev video pcspkr wmi_bmof
sp5100_tco snd_timer mc k10temp i2c_piix4 snd ecdh_generic ecc
soundcore rfkill acpi_cpufreq binfmt_misc zram ip_tables
hid_logitech_hidpp hid_logitech_dj amdgpu iommu_v2 gpu_sched ttm
drm_kms_helper cec crct10dif_pclmul crc32_pclmul crc32c_intel drm ccp
igb ghash_clmulni_intel nvme nvme_core dca i2c_algo_bit wmi
pinctrl_amd fuse
---[ end trace 09deb55d1b05f40c ]---


Full system log: https://pastebin.com/6cKHZzAi
Full kernel log: https://pastebin.com/316HjHit

Unfortunately, I did not know how reproduce this bug. I am not doing
anything unusual on the computer when it happened.
I could provide any useful info for further investigation.


--
Best Regards,
Mike Gavrilov.
