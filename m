Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F44C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 11:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4268260F55
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 11:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhHKLoR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 07:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237397AbhHKLoO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 07:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628682230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xn4gpQxLpvNEpv/XbFmfoXYUGk77ImifYMgiMC7bMC0=;
        b=VtATfEmuon0Dwiql/UK6H7azsx9nOAen7Kk+0BPqY/jGhA+v2cv39OBBWkW+vfRwpin2Es
        Z6QHN5ujljmbKqzX+MvApj8jktIbzrXGnoC6pqfroViV07RdyNgMHGsxtbba97gbDu9Nf+
        nlw+fm5ohypPo0ZCnuaJE3aKXHaVFqo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-H2CKUXI6Nuqdg1C5baWVgQ-1; Wed, 11 Aug 2021 07:43:48 -0400
X-MC-Unique: H2CKUXI6Nuqdg1C5baWVgQ-1
Received: by mail-ot1-f72.google.com with SMTP id i9-20020a0568302109b02905090e0df297so852788otc.0
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 04:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xn4gpQxLpvNEpv/XbFmfoXYUGk77ImifYMgiMC7bMC0=;
        b=l8B92RGFTWGaoUtjRuBhYSxGBzo5rR9OcWn1h0N0ZYX8VzsoLQFMxpWWVC8DQ7gOp+
         T3r3Aohxv+KUKKvGHCTzEh6jeXq5QkeJiwt9VefXwAEFw8vLmTGlYovLgp4oR6gE8jxx
         S+HRVmEcnQCG8wNZCPrqFejzyPw1CRs+CgvQhvEOfbkM2tV1ooiwcaT2PKn1pp6iThF4
         80KiovA2CNo7hZFhipn8Fsa5u/o52qapFIWEryjD/Vf3W/odjlI6IziMxNdXt+hqf8LV
         NmADYGSRtrCnxDXhzsSD1+T5cD7Qib47HC5tSA4mqRsh5I/pdrrorU4fptLjfInOZjT/
         ItaA==
X-Gm-Message-State: AOAM533TzvoDqrDBKhqjoTzvR6DFm6KX/zZ4F1O/7FQt1lBNos7lSJtm
        lzOTXNgqQhCUEZ00rSHhSVgvNzaRFgvezzOZl1NFRxn3P5WhHDyEVYWJIQ9t73UMVxZ3DaUJPhD
        jg+LLIbRrrPdqhexrsnsMwWOjMumoWvZEFy0g5Nk=
X-Received: by 2002:aca:180c:: with SMTP id h12mr2374702oih.60.1628682227625;
        Wed, 11 Aug 2021 04:43:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN4MmK5f2+vW7pdbPrm4at1S4Dyoo4p7J3WLGlare/9buGljJDe+2SQ/BbuOm+mTOwb4RmP8xN7Pao2Rtt8Dw=
X-Received: by 2002:aca:180c:: with SMTP id h12mr2374691oih.60.1628682227429;
 Wed, 11 Aug 2021 04:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <cki.D0FC7AC895.R5GM6IYQCK@redhat.com>
In-Reply-To: <cki.D0FC7AC895.R5GM6IYQCK@redhat.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Wed, 11 Aug 2021 13:43:36 +0200
Message-ID: <CA+QYu4pP5vt40DAj4Ly3e=uOZN8ystFRiqH5yXC-EaSCJzUt_g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=F0=9F=92=A5_PANICKED=3A_Test_report_for_kernel_5=2E14=2E0=2Drc5?=
        =?UTF-8?Q?_=28block=2C_4e9e1af5=29?=
To:     CKI Project <cki-project@redhat.com>
Cc:     skt-results-master@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Xiong Zhou <xzhou@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Zorro Lang <zlang@redhat.com>, Li Wang <liwang@redhat.com>,
        Yi Zhang <yizhan@redhat.com>, Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We've been hitting the following panic on recent runs on block tree
when running the "storage/blk suite" [1]. WE've hit it only  on
ppc64le [2] and aarch64[3].

The 3 commits that we've reproduced it so far are:
Commit: 4e9e1af58800 - Merge branch 'for-5.15/block' into for-next
Commit: 39a7b1209b44 - Merge branch 'io_uring-bio-cache.3' into for-next
Commit: 9b1a1a00a51e - Merge branch 'for-5.15/io_uring' into for-next


[ 4703.622170] xfs filesystem being mounted at /mnt/blktests supports
timestamps until 2038 (0x7fffffff)
[ 4734.025241] restraintd[1155]: *** Current Time: Wed Aug 11 03:42:52
2021  Localwatchdog at: Wed Aug 11 04:38:52 2021
[ 4734.367901] XFS (nvme0n1): Unmounting Filesystem
[ 4734.448255] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 4734.576623] BUG: Kernel NULL pointer dereference on read at 0x00000328
[ 4734.576646] Faulting instruction address: 0xc0000000009725dc
[ 4734.576657] Oops: Kernel access of bad area, sig: 11 [#1]
[ 4734.576665] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA PowerN=
V
[ 4734.576676] Modules linked in: nvme_loop nvme_fabrics nvmet
nvme_core loop dm_log_writes dm_flakey rfkill sunrpc tg3 ses enclosure
scsi_transport_sas rtc_opal powernv_rng ipmi_powernv crct10dif_vpmsum
i2c_opal ipmi_devintf ipmi_msghandler leds_powernv drm fuse
drm_panel_orientation_quirks i2c_core zram ip_tables xfs vmx_crypto
crc32c_vpmsum ipr [last unloaded: nvme_core]
[ 4734.576748] CPU: 14 PID: 0 Comm: swapper/14 Not tainted 5.14.0-rc5 #1
[ 4734.576759] NIP:  c0000000009725dc LR: c000000000926c14 CTR: c0000000009=
72570
[ 4734.576769] REGS: c0000000096db500 TRAP: 0380   Not tainted  (5.14.0-rc5=
)
[ 4734.576778] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
24004222  XER: 20000000
[ 4734.576800] CFAR: c000000000926c10 IRQMASK: 0
[ 4734.576800] GPR00: c000000000926c14 c0000000096db7a0
c000000002844e00 c0000000811b7c80
[ 4734.576800] GPR04: 0000000000000000 0000000000000800
0000000000000800 0000000000000000
[ 4734.576800] GPR08: ffffffffffffffff 0000000000000000
c0000000da89bfe8 0000000000000020
[ 4734.576800] GPR12: c000000000972570 c0000003fffb2280
c0000003fa35ff90 0000000000000100
[ 4734.576800] GPR16: 0000000000000001 0000000004200042
c000000002873a00 0000000000000001
[ 4734.576800] GPR20: c0000003fbe09568 c0000003fbe09528
c0000000096db910 0000000000000000
[ 4734.576800] GPR24: 0000000000000020 ffffffffffffffff
c0000000811b7c90 0000000000000002
[ 4734.576800] GPR28: c00000000d82d260 0000000000000000
0000000000000000 c000000010e4ff00
[ 4734.576902] NIP [c0000000009725dc] wb_timer_fn+0x6c/0x5b0
[ 4734.576916] LR [c000000000926c14] blk_stat_timer_fn+0x1c4/0x200
[ 4734.576927] Call Trace:
[ 4734.576931] [c0000000096db7a0] [000000000000000e] 0xe (unreliable)
[ 4734.576943] [c0000000096db800] [c000000000926c14]
blk_stat_timer_fn+0x1c4/0x200
[ 4734.576955] [c0000000096db860] [c00000000022f350] call_timer_fn+0x50/0x1=
c0
[ 4734.576968] [c0000000096db8f0] [c00000000022f7e4]
__run_timers.part.0+0x324/0x450
[ 4734.576980] [c0000000096db9c0] [c00000000022f964] run_timer_softirq+0x54=
/0xa0
[ 4734.576993] [c0000000096db9f0] [c00000000113a780] __do_softirq+0x160/0x3=
e0
[ 4734.577007] [c0000000096dbae0] [c00000000015ade4] __irq_exit_rcu+0x1b4/0=
x1c0
[ 4734.577020] [c0000000096dbb10] [c00000000015afc0] irq_exit+0x20/0x40
[ 4734.577031] [c0000000096dbb30] [c0000000000251b4] timer_interrupt+0x184/=
0x400
[ 4734.577044] [c0000000096dbb90] [c0000000000163a4]
replay_soft_interrupts+0x124/0x2c0
[ 4734.577057] [c0000000096dbd70] [c000000000016678]
arch_local_irq_restore+0x138/0x170
[ 4734.577070] [c0000000096dbda0] [c000000000dbd2f4]
cpuidle_enter_state+0x104/0x560
[ 4734.577084] [c0000000096dbe00] [c000000000dbd7ec] cpuidle_enter+0x4c/0x7=
0
[ 4734.577096] [c0000000096dbe40] [c0000000001ab718] do_idle+0x368/0x470
[ 4734.577109] [c0000000096dbf00] [c0000000001aba88] cpu_startup_entry+0x38=
/0x50
[ 4734.577121] [c0000000096dbf30] [c00000000005b9ac] start_secondary+0x29c/=
0x2b0
[ 4734.577134] [c0000000096dbf90] [c00000000000d354]
start_secondary_prolog+0x10/0x14
[ 4734.577146] Instruction dump:
[ 4734.577153] ebe30060 83df0098 813f00b8 7d3e4a14 83df00d8 e95f0060
ebbf0028 7fde4a14
[ 4734.577171] eb830050 7bde0020 e92a0090 2c3d0000 <e9290328> eb490098
418200ec e93f0030
[ 4734.577190] ---[ end trace 28f0fbead3bf79d0 ]---
[ 4734.577992]
[ 4735.578017] Kernel panic - not syncing: Aiee, killing interrupt handler!
[ 4735.579752] ---[ end Kernel panic - not syncing: Aiee, killing
interrupt handler! ]---


[1] https://gitlab.com/cki-project/kernel-tests/-/tree/main/storage/blktest=
s/blk
[2] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehous=
e-public/2021/08/10/351063758/build_ppc64le_redhat%3A1492847161/tests/10473=
601_ppc64le_1_console.log
[3] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehous=
e-public/2021/08/10/351063758/build_aarch64_redhat%3A1492847160/tests/10473=
599_aarch64_1_console.log

Thank you,
Bruno

On Wed, Aug 11, 2021 at 1:35 PM CKI Project <cki-project@redhat.com> wrote:
>
>
> Hello,
>
> We ran automated tests on a recent commit from this kernel tree:
>
>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe=
/linux-block.git
>             Commit: 4e9e1af58800 - Merge branch 'for-5.15/block' into for=
-next
>
> The results of these automated tests are provided below.
>
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: PANICKED
>
> All kernel binaries, config files, and logs are available for download he=
re:
>
>   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?p=
refix=3Ddatawarehouse-public/2021/08/10/351063758
>
> One or more kernel tests failed:
>
>     s390x:
>      =E2=9D=8C LTP
>
>     ppc64le:
>      =E2=9D=8C LTP
>      =F0=9F=92=A5 POSIX pjd-fstest suites
>      =E2=9D=8C Loopdev Sanity
>      =E2=9D=8C Memory: fork_mem
>      =F0=9F=92=A5 Storage blktests
>
>     aarch64:
>      =F0=9F=92=A5 Storage blktests
>      =E2=9D=8C LTP
>
> We hope that these logs can help you find the problem quickly. For the fu=
ll
> detail on our testing procedures, please scroll to the bottom of this mes=
sage.
>
> Please reply to this email if you have any questions about the tests that=
 we
> ran or if you have any suggestions on how to make future tests more effec=
tive.
>
>         ,-.   ,-.
>        ( C ) ( K )  Continuous
>         `-',-.`-'   Kernel
>           ( I )     Integration
>            `-'
> _________________________________________________________________________=
_____
>
> Compile testing
> ---------------
>
> We compiled the kernel for 4 architectures:
>
>     aarch64:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>     ppc64le:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>     s390x:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>     x86_64:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>
>
> Hardware testing
> ----------------
> We booted each kernel and ran the following tests:
>
>   aarch64:
>     Host 1:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Reboot test
>        =E2=9C=85 xfstests - ext4
>        =E2=9C=85 xfstests - xfs
>        =E2=9C=85 storage: software RAID testing
>        =E2=9C=85 Storage: swraid mdadm raid_module test
>        =F0=9F=9A=A7 =E2=9D=8C xfstests - btrfs
>        =F0=9F=9A=A7 =F0=9F=92=A5 Storage blktests
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - filesyste=
m fio test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - queue sch=
eduler test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>     Host 2:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Reboot test
>        =E2=9C=85 ACPI table test
>        =E2=9D=8C LTP
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 CIFS Connectathon
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest suites
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory: fork_mem
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility)
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: SCSI VPD
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 NFS Connectathon
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 lvm cache test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 lvm snapper test
>
>   ppc64le:
>     Host 1:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Reboot test
>        =E2=9D=8C LTP
>        =E2=9C=85 CIFS Connectathon
>        =F0=9F=92=A5 POSIX pjd-fstest suites
>        =E2=9D=8C Loopdev Sanity
>        =E2=9D=8C Memory: fork_mem
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility)
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 NFS Connectathon
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 lvm cache test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 lvm snapper test
>
>     Host 2:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Reboot test
>        =E2=9C=85 xfstests - ext4
>        =E2=9C=85 xfstests - xfs
>        =E2=9C=85 storage: software RAID testing
>        =E2=9C=85 Storage: swraid mdadm raid_module test
>        =F0=9F=9A=A7 =E2=9C=85 xfstests - btrfs
>        =F0=9F=9A=A7 =F0=9F=92=A5 Storage blktests
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - filesyste=
m fio test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - queue sch=
eduler test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: lvm device-mappe=
r test - upstream
>
>   s390x:
>     Host 1:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Reboot test
>        =E2=9D=8C LTP
>        =E2=9C=85 CIFS Connectathon
>        =E2=9C=85 POSIX pjd-fstest suites
>        =E2=9C=85 Loopdev Sanity
>        =E2=9C=85 Memory: fork_mem
>        =E2=9C=85 Memory function: memfd_create
>        =E2=9C=85 AMTU (Abstract Machine Test Utility)
>        =E2=9C=85 Ethernet drivers sanity
>        =F0=9F=9A=A7 =E2=9D=8C xarray-idr-radixtree-test
>        =F0=9F=9A=A7 =E2=9C=85 NFS Connectathon
>        =F0=9F=9A=A7 =E2=9C=85 lvm cache test
>        =F0=9F=9A=A7 =E2=9C=85 lvm snapper test
>
>     Host 2:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9C=85 Boot test
>        =E2=9C=85 Reboot test
>        =E2=9C=85 Storage: swraid mdadm raid_module test
>        =F0=9F=9A=A7 =E2=9C=85 Storage blktests
>        =F0=9F=9A=A7 =E2=9C=85 Storage nvme - tcp
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>   x86_64:
>     Host 1:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Reboot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage SAN device stress - qla2xxx dr=
iver
>
>     Host 2:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Reboot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage SAN device stress - mpt3sas_ge=
n1
>
>     Host 3:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Reboot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - ext4
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - nfsv4.2
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: software RAID testing
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_module test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - cifsv3.11
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - filesyste=
m fio test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - queue sch=
eduler test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: lvm device-mappe=
r test - upstream
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>     Host 4:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Reboot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage SAN device stress - lpfc drive=
r
>
>     Host 5:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9C=85 Boot test
>        =E2=9C=85 Reboot test
>        =E2=9C=85 ACPI table test
>        =E2=9C=85 LTP
>        =E2=9C=85 CIFS Connectathon
>        =E2=9C=85 POSIX pjd-fstest suites
>        =E2=9C=85 Loopdev Sanity
>        =E2=9C=85 Memory: fork_mem
>        =E2=9C=85 Memory function: memfd_create
>        =E2=9C=85 AMTU (Abstract Machine Test Utility)
>        =E2=9C=85 Ethernet drivers sanity
>        =E2=9C=85 storage: SCSI VPD
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 NFS Connectathon
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 lvm cache test
>        =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 lvm snapper test
>
>     Host 6:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Reboot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage SAN device stress - qedf drive=
r
>
>     Host 7:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Reboot test
>        =E2=9C=85 Storage SAN device stress - qla2xxx driver
>
>     Host 8:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Reboot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage SAN device stress - qedf drive=
r
>
>   Test sources: https://gitlab.com/cki-project/kernel-tests
>     =F0=9F=92=9A Pull requests are welcome for new tests or improvements =
to existing tests!
>
> Aborted tests
> -------------
> Tests that didn't complete running successfully are marked with =E2=9A=A1=
=E2=9A=A1=E2=9A=A1.
> If this was caused by an infrastructure issue, we try to mark that
> explicitly in the report.
>
> Waived tests
> ------------
> If the test run included waived tests, they are marked with =F0=9F=9A=A7.=
 Such tests are
> executed but their results are not taken into account. Tests are waived w=
hen
> their results are not reliable enough, e.g. when they're just introduced =
or are
> being fixed.
>
> Testing timeout
> ---------------
> We aim to provide a report within reasonable timeframe. Tests that haven'=
t
> finished running yet are marked with =E2=8F=B1.
>

