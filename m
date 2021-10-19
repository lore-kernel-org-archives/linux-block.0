Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A92DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 02:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544EF611BF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 02:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhJSCQ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 22:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhJSCQZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 22:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634609653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r9uTB7g/Z++ocA+AW59QQABgnujq+wefCTQOPwLyTsw=;
        b=VJHLE/ScFO+J3Ry3MeBhyv3Opvp+cG+8e49cXWxVyDvu0JZebart6P43AnEmINwLnYtxly
        3pEoY1nchimjeCTQBj6EpFPwD+qG8c561JFLuXjBgDmNotUv+THqa7MBdhcxSs1cJhvlV7
        i61VKH0VeIi5S2y4F4MRoVFsSV2/pJY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-qdlDQpGNN1qGC7JQCIF4Gg-1; Mon, 18 Oct 2021 22:14:12 -0400
X-MC-Unique: qdlDQpGNN1qGC7JQCIF4Gg-1
Received: by mail-yb1-f200.google.com with SMTP id w201-20020a25dfd2000000b005be4c3971cdso4700780ybg.13
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 19:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r9uTB7g/Z++ocA+AW59QQABgnujq+wefCTQOPwLyTsw=;
        b=0ipJoOXdiTzaruUKEQmi13NXmCXZ3rzBMyU+AX5QkzVWlkrx+gL7FEc5TUnJfH/VJY
         QvhzwiI5Lg3MA+PdMvjS4vMzqQ3D3oksadU+3SM+i5AvlTRlG0C2z2J/toV3Urb8Vc2M
         Q3gkoHXlwbzCdx/Bmyjdd/KAO1DzByIatkBYr48r3Juy9EHHy6HNJdCNDHizgqt+pcan
         kdsnRwTXEbTeZcTW8Yim4UwcDn2J9239AVJDSaWeVtT0t0ZiNkLoLEAl+xAXRjXGCIx7
         K4tCqokfY4KITsASESzLvZUNl/ncF4vu24YIFtiZ2GMcWxRIg5F7oGMqxxJYNYlbWUOg
         N7Ew==
X-Gm-Message-State: AOAM532H1iPKtwsqtsj1u0bI8oks5XhS8pYZdDrozmhlyu44Tvu9xyDz
        +ORo4Yo0Rb44lw0N7I06zcNUCbqzsLS4NE5Lzb3dHkM4RLjdiBmhD1lHVvvdE2rp/X9Cd+0L1kq
        3ubovE0Dsy2/nZfFsXiDDkojagsWDD6qUt3bBWuY=
X-Received: by 2002:a25:496:: with SMTP id 144mr34139322ybe.522.1634609651484;
        Mon, 18 Oct 2021 19:14:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJl4ZQvjizjMwmb2WdVm9wkPfoy3vYJoUpJEDheLkTOIz5bfPN3Qxg1B+sTRAsrnSrRM2+VdIq6GNZ7mkETF8=
X-Received: by 2002:a25:496:: with SMTP id 144mr34139301ybe.522.1634609651213;
 Mon, 18 Oct 2021 19:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <cki.1BB6AA01C6.FWO6ZHIQNG@redhat.com>
In-Reply-To: <cki.1BB6AA01C6.FWO6ZHIQNG@redhat.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 19 Oct 2021 10:13:57 +0800
Message-ID: <CAHj4cs_3MSAHXaxwwCreLhpL7c+Tak4+y-Hv_Ld7kDT0ZbCRtw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=F0=9F=92=A5_PANICKED=3A_Waiting_for_review=3A_Test_report_f?=
        =?UTF-8?Q?or_kernel_5=2E15=2E0=2Drc6_=28block=2C_1983520d=29?=
To:     linux-block <linux-block@vger.kernel.org>
Cc:     skt-results-master@redhat.com,
        CKI Project <cki-project@redhat.com>,
        Changhui Zhong <czhong@redhat.com>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

With this commit, the servers boots with NULL pointer[1], pls help check it=
.

>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe=
/linux-block.git
>             Commit: 1983520d28d8 - Merge branch 'for-5.16/io_uring' into =
for-next
[1]
[    8.614036] Kernel attempted to read user page (f) - exploit
attempt? (uid: 0)
[    8.614071] BUG: Kernel NULL pointer dereference on read at 0x0000000f
[    8.614099] Faulting instruction address: 0xc00000000093b5b4
[    8.614118] Oops: Kernel access of bad area, sig: 11 [#1]
[    8.614143] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA Power=
NV
[    8.614192] Modules linked in: zram ip_tables ast i2c_algo_bit
drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops cec drm_ttm_helper ttm drm vmx_crypto crc32c_vpmsum
i2c_core drm_panel_orientation_quirks
[    8.614285] CPU: 52 PID: 0 Comm: swapper/52 Not tainted 5.15.0-rc6+ #1
[    8.614323] NIP:  c00000000093b5b4 LR: c00000000093b5a4 CTR: c0000000009=
72c50
[    8.614371] REGS: c000000018d3b430 TRAP: 0300   Not tainted  (5.15.0-rc6=
+)
[    8.614409] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR:
44004284  XER: 00000000
[    8.614464] CFAR: c000000000972cd0 DAR: 000000000000000f DSISR:
40000000 IRQMASK: 1
[    8.614464] GPR00: c00000000093b5a4 c000000018d3b6d0
c0000000028aa100 c000000044582a00
[    8.614464] GPR04: 00000000ffff8e2c 0000000000000001
0000000000000004 c000000001212930
[    8.614464] GPR08: 00000000000001d7 0000000000000007
c000000044361f80 0000000000000000
[    8.614464] GPR12: c000000000972c50 c000001ffffa7200
0000000000000000 0000000000000100
[    8.614464] GPR16: 0000000000000004 0000000004200042
0000000000000000 0000000000000001
[    8.614464] GPR20: c0000000028d3a00 c000000002167888
00000000ffff8e2d c000000002167888
[    8.614464] GPR24: c0000000021f0580 0000000000000001
c000000044582ae0 0000000000000801
[    8.614464] GPR28: c000000044361f80 c000000044361f80
c00000003b81f800 c000000044582a00
[    8.614852] NIP [c00000000093b5b4] blk_mq_free_request+0x74/0x210
[    8.614898] LR [c00000000093b5a4] blk_mq_free_request+0x64/0x210
[    8.614942] Call Trace:
[    8.614961] [c000000018d3b6d0] [c00000000093b8ec]
__blk_mq_end_request+0x19c/0x1d0 (unreliable)
[    8.615020] [c000000018d3b710] [c00000000092fdfc]
blk_flush_complete_seq+0x1ac/0x3d0
[    8.615077] [c000000018d3b770] [c0000000009302dc] flush_end_io+0x2bc/0x3=
90
[    8.615122] [c000000018d3b7d0] [c00000000093b7cc]
__blk_mq_end_request+0x7c/0x1d0
[    8.615174] [c000000018d3b810] [c000000000c20684]
scsi_end_request+0x124/0x270
[    8.615228] [c000000018d3b860] [c000000000c21458]
scsi_io_completion+0x1f8/0x740
[    8.615250] [c000000018d3b900] [c000000000c13e14]
scsi_finish_command+0x134/0x190
[    8.615292] [c000000018d3b990] [c000000000c21068] scsi_complete+0xa8/0x2=
00
[    8.615345] [c000000018d3ba10] [c000000000939870] blk_complete_reqs+0x80=
/0xa0
[    8.615409] [c000000018d3ba40] [c00000000115dfe0] __do_softirq+0x170/0x3=
fc
[    8.615475] [c000000018d3bb30] [c00000000015df38] __irq_exit_rcu+0x168/0=
x1a0
[    8.615535] [c000000018d3bb60] [c00000000015e140] irq_exit+0x20/0x40
[    8.615583] [c000000018d3bb80] [c000000000054670]
doorbell_exception+0x120/0x300
[    8.615616] [c000000018d3bbc0] [c000000000016cc4]
replay_soft_interrupts+0x1e4/0x2c0
[    8.615639] [c000000018d3bda0] [c000000000016ed8]
arch_local_irq_restore+0x138/0x1a0
[    8.615694] [c000000018d3bdd0] [c000000000de1714]
cpuidle_enter_state+0x104/0x540
[    8.615741] [c000000018d3be30] [c000000000de1bec] cpuidle_enter+0x4c/0x7=
0
[    8.615795] [c000000018d3be70] [c0000000001aef18] do_idle+0x2f8/0x3f0
[    8.615839] [c000000018d3bf00] [c0000000001af238] cpu_startup_entry+0x38=
/0x40
[    8.615901] [c000000018d3bf30] [c00000000005be6c] start_secondary+0x29c/=
0x2b0
[    8.615969] [c000000018d3bf90] [c00000000000d254]
start_secondary_prolog+0x10/0x14
[    8.616025] Instruction dump:
[    8.616074] 41820048 e93d0008 e9290000 e9890068 2c2c0000 41820010
7d8903a6 4e800421
[    8.616136] e8410018 e93f00d8 2c290000 41820140 <e8690008> 4bff6b91
60000000 39400000
[    8.616184] ---[ end trace cc3215be892e1be7 ]---
[    8.644628] systemd-journald[1408]: Received client request to
flush runtime journal.
[  OK  ] Finished Create Static Device Nodes in /dev.
         Starting Rule-based Manage=E2=80=A6for Device Events and Files...
[  OK  ] Finished Coldplug All udev Devices.
         Starting Wait for udev To =E2=80=A6plete Device Initialization...
[    8.690954] fuse: init (API version 7.34)
[  OK  ] Finished Load Kernel Module fuse.
[    8.694411]
         Mounting FUSE Control File System...
[  OK  ] Mounted FUSE Control File System.
[  OK  ] Started Rule-based Manager for Device Events and Files.
         Starting Load Kernel Module configfs...
[  OK  ] Finished Load Kernel Module configfs.
[    8.950307] IPMI message handler: version 39.2
[  OK  ] Found device /dev/zram0.
         Starting Create swap on /dev/zram0...
[    9.008355] zram0: detected capacity change from 0 to 16777216
[    9.694430] Kernel panic - not syncing: Aiee, killing interrupt handler!
[   11.080031] ---[ end Kernel panic - not syncing: Aiee, killing
interrupt handler! ]---



On Tue, Oct 19, 2021 at 8:22 AM CKI Project <cki-project@redhat.com> wrote:
>
>
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> =E2=94=82 REVIEW REQUIRED FOR FAILED TEST                               =
=E2=94=82
> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> =E2=94=82 This failed kernel test has been held for review by kernel    =
=E2=94=82
> =E2=94=82 test maintainers and the CKI team. Please investigate using   =
=E2=94=82
> =E2=94=82 the pipeline link below this box.                             =
=E2=94=82
> =E2=94=82                                                               =
=E2=94=82
> =E2=94=82 If the test failure is related to a non-kernel bug, no action =
=E2=94=82
> =E2=94=82 is needed. If a kernel bug is found, please reply all with    =
=E2=94=82
> =E2=94=82 your assessment and we will release the report.               =
=E2=94=82
> =E2=94=82 For more details: https://docs.engineering.redhat.com/x/eG5qB =
=E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>
> Pipeline: https://gitlab.com/redhat/red-hat-ci-tools/kernel/cki-internal-=
pipelines/cki-trusted-contributors/-/pipelines/390489191
>
> Check out if the issue is autotriaged in the dashboard:
>     https://datawarehouse.cki-project.org/search?q=3D390489191
>
> Hello,
>
> We ran automated tests on a recent commit from this kernel tree:
>
>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe=
/linux-block.git
>             Commit: 1983520d28d8 - Merge branch 'for-5.16/io_uring' into =
for-next
>
> The results of these automated tests are provided below.
>
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: PANICKED
>     Targeted tests: NO
>
> All kernel binaries, config files, and logs are available for download he=
re:
>
>   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?p=
refix=3Ddatawarehouse-public/2021/10/18/390489191
>
> One or more kernel tests failed:
>
>     s390x:
>      =F0=9F=92=A5 Boot test
>      =F0=9F=92=A5 Boot test
>      =F0=9F=92=A5 Boot test
>
>     ppc64le:
>      =F0=9F=92=A5 Storage blktests - srp
>      =F0=9F=92=A5 Storage block - filesystem fio test
>
>     aarch64:
>      =F0=9F=92=A5 Boot test
>      =F0=9F=92=A5 Boot test
>      =F0=9F=92=A5 Boot test
>      =F0=9F=92=A5 Boot test
>
>     x86_64:
>      =F0=9F=92=A5 Boot test
>      =F0=9F=92=A5 Boot test
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




--
Best Regards,
  Yi Zhang

