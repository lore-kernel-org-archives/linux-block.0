Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED69DC433F5
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 09:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED9B6023B
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 09:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhKEJJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:09:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229923AbhKEJJ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Nov 2021 05:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636103236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/cVnccg0mJNJhOGJ/DCnwYf+wmdwCT3s2RuzRw28rJQ=;
        b=Ei8flQmfGRqY63VJfvbYp2s4MajBmKCN1+qH/JHtajtXT2pQTvloH3ydal0Nu04QFnoprh
        oRrORvefV00nDv3iY2K41cesT+rinXlulFLnelEG0sufMeniquZIoYJLC2b/0ZHqVXdnuD
        vydo1rjpAmTFQqevm/g89rk/1DnVR5M=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-kNsbNd4TOAiw3SRcJA0j5w-1; Fri, 05 Nov 2021 05:07:15 -0400
X-MC-Unique: kNsbNd4TOAiw3SRcJA0j5w-1
Received: by mail-yb1-f199.google.com with SMTP id q7-20020a25b007000000b005c1d1377abdso12482346ybf.23
        for <linux-block@vger.kernel.org>; Fri, 05 Nov 2021 02:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/cVnccg0mJNJhOGJ/DCnwYf+wmdwCT3s2RuzRw28rJQ=;
        b=mrIPPi8VbCaTwFK4+81GYlSV1DxnrPlRMt6zPZvwGivSZCYwKvcv74I5d1AnK6hB8z
         dM1LYxWNBlaL4rlaeDuibcnB7e5X0IMdXsN2sZ+vpdSbcT4bJHFYEo95LYFFbYB2u5qy
         z3VmSHOBN+uQrB66L3dTvJOy2pKgr95bGmlCeiGtnMtxcmCFjxs1umH7idYMmbVSgvGm
         ZLPsH9V5EjoF7S1ptv+dzSOv/Ocnp9oAVcTI1q2DebIM4VY9pJYP9NkOL6W2I3prk5yo
         iANoFbXngJJkRgVJV0cby63uie4wVVM7Je5AxEqltIXAE9IfyXRBOgZiZ9pbsw3ok/xT
         z2EQ==
X-Gm-Message-State: AOAM531BfVpBGCXOdc09ErnJ+Vq7r8Gi1sOZgDxVncD7C3cWx163NQJx
        So82znrCxenWUkdsFnzAMfpF0ZXr1fhZ/rmXnJjPRT4c2N1yPjSXGnlHc9IG1bcD1hEld+qW4xn
        gatbgSPV/2oLC0+25f9ZeOgVHfgEviFXjHZRJcXk=
X-Received: by 2002:a25:8746:: with SMTP id e6mr54413831ybn.138.1636103234418;
        Fri, 05 Nov 2021 02:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0h5fUTRAfGKNjTbHs99OeovdVzGa9aVtjxVDNk/t55WZtCE+skV9XfaQGeKcnZNjLI8Q+c84ze2Ob8nVCPYM=
X-Received: by 2002:a25:8746:: with SMTP id e6mr54413772ybn.138.1636103233787;
 Fri, 05 Nov 2021 02:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <cki.ZE6BIT5CW7UTU02WGFR6@redhat.com> <CAHj4cs8vBDZEv4cnBoXiLqD4t35YAYQaze80g77Les2JC_tp0A@mail.gmail.com>
In-Reply-To: <CAHj4cs8vBDZEv4cnBoXiLqD4t35YAYQaze80g77Les2JC_tp0A@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 5 Nov 2021 17:07:01 +0800
Message-ID: <CAHj4cs8GZZXdH_mAr6joxS4rtVF=0v=WTAYnkpSoOTPqCZ1+Yg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=F0=9F=92=A5_Boot_PANICKED=3A_Waiting_for_review=3A_Test_rep?=
        =?UTF-8?Q?ort_for_kernel_5=2E15=2E0_=28block=2C_48dd8b1e=29?=
To:     linux-block <linux-block@vger.kernel.org>
Cc:     skt-results-master@redhat.com,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping
This is still reproducible with the latest linux-block/for-next.

       Kernel repo:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
            Commit: 40822287ce10 - Merge branch 'for-5.16/block' into for-n=
ext

[   11.804534] list_add corruption. next->prev should be prev
(c000000022a00140), but was c000000000440140. (next=3Dc000000022a00140).
[   11.804603] ------------[ cut here ]------------
[   11.804616] kernel BUG at lib/list_debug.c:23!
[   11.804631] Oops: Exception in kernel mode, sig: 5 [#1]
[   11.804645] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA Power=
NV
[   11.804662] Modules linked in: at24 tpm_i2c_nuvoton
powernv_flash(+) crct10dif_vpmsum regmap_i2c rtc_opal opal_prd mtd
i2c_opal ipmi_powernv ipmi_devintf ipmi_msghandler fuse zram ip_tables
xfs ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm
vmx_crypto crc32c_vpmsum i2c_core aacraid drm_panel_orientation_quirks
[   11.804762] CPU: 36 PID: 1746 Comm: (spawn) Not tainted 5.15.0 #1
[   11.804780] NIP:  c0000000009c1098 LR: c0000000009c1094 CTR: c0000000000=
cd280
[   11.804797] REGS: c000000026e56f40 TRAP: 0700   Not tainted  (5.15.0)
[   11.804813] MSR:  9000000000021033 <SF,HV,ME,IR,DR,RI,LE>  CR:
28022242  XER: 20040000
[   11.804842] CFAR: c0000000001f6b8c IRQMASK: 1
[   11.804842] GPR00: c0000000009c1094 c000000026e571e0
c0000000028aab00 0000000000000075
[   11.804842] GPR04: c0000007fe887f88 c0000007fe90cc80
c000000026e56ee0 0000000000000027
[   11.804842] GPR08: 0000000000000000 c0000007fe88adb0
00000007fc720000 0000000000000001
[   11.804842] GPR12: 0000000024022248 c0000007fffb8a00
0000000000000000 c000000022a00000
[   11.804842] GPR16: 0000000000000001 0000000000000000
0000000000000001 c00000003a6589d0
[   11.804842] GPR20: 0000000000000000 c00000003a6589d0
c00000000152e3b8 002d444552414853
[   11.804842] GPR24: c000000022a00140 c000000022a00140
c00000003a658b00 c000000022a00000
[   11.804842] GPR28: c000000022a00000 c00000003a6589d0
c000000022a1d800 c000000022a1d918
[   11.805003] NIP [c0000000009c1098] __list_add_valid+0x68/0xc0
[   11.805023] LR [c0000000009c1094] __list_add_valid+0x64/0xc0
[   11.805039] Call Trace:
[   11.805048] [c000000026e571e0] [c0000000009c1094]
__list_add_valid+0x64/0xc0 (unreliable)
[   11.805069] [c000000026e57240] [c0000000009860b0]
bfq_active_insert+0x100/0x1c0
[   11.805090] [c000000026e572a0] [c000000000987064]
bfq_activate_requeue_entity+0x294/0x480
[   11.805110] [c000000026e573a0] [c000000000987fa8]
bfq_add_bfqq_busy+0xc8/0x280
[   11.805130] [c000000026e57450] [c000000000984fa8]
bfq_insert_requests+0xcc8/0x16d0
[   11.805150] [c000000026e575c0] [c00000000094a334]
blk_mq_sched_insert_requests+0xa4/0x1d0
[   11.805171] [c000000026e57610] [c000000000941f34]
blk_mq_flush_plug_list+0x164/0x380
[   11.805191] [c000000026e576a0] [c00000000092f57c] blk_flush_plug+0x16c/0=
x1d0
[   11.805212] [c000000026e57710] [c00000000092f920] blk_finish_plug+0x50/0=
x6c
[   11.805230] [c000000026e57740] [c0000000003f81c8] read_pages+0x1e8/0x430
[   11.805248] [c000000026e577c0] [c0000000003f8648]
page_cache_ra_unbounded+0x238/0x350
[   11.805268] [c000000026e57870] [c0000000003e5f10]
filemap_get_pages+0x130/0xa30
[   11.805288] [c000000026e57990] [c0000000003e6900] filemap_read+0xf0/0x49=
0
[   11.805306] [c000000026e57ad0] [c00800000d5f39d8]
xfs_file_buffered_read+0xe0/0x120 [xfs]
[   11.805433] [c000000026e57b10] [c00800000d5f53e4]
xfs_file_read_iter+0xac/0x170 [xfs]
[   11.805554] [c000000026e57b50] [c000000000525dbc] __kernel_read+0x14c/0x=
360
[   11.805572] [c000000026e57c40] [c000000000531ea8] bprm_execve+0x248/0x7c=
0
[   11.805589] [c000000026e57d10] [c00000000053298c]
do_execveat_common+0x17c/0x250
[   11.805608] [c000000026e57d70] [c000000000532aa8] sys_execve+0x48/0x60
[   11.805625] [c000000026e57db0] [c00000000002d3e8]
system_call_exception+0x188/0x360
[   11.805646] [c000000026e57e10] [c00000000000c1e8]
system_call_vectored_common+0xe8/0x278
[   11.805668] --- interrupt: 3000 at 0x7fffb83d0d04
[   11.805682] NIP:  00007fffb83d0d04 LR: 0000000000000000 CTR: 00000000000=
00000
[   11.805699] REGS: c000000026e57e80 TRAP: 3000   Not tainted  (5.15.0)
[   11.805715] MSR:  900000000280f033
<SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48024402  XER: 00000000
[   11.807346] IRQMASK: 0
[   11.807346] GPR00: 000000000000000b 00007fffeb8d5cb0
00007fffb84f7000 0000000117263fa0
[   11.807346] GPR04: 00000001172bba40 00000001172b99c0
00007fffeb8d5cb8 00000001172f3e50
[   11.807346] GPR08: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
[   11.807346] GPR12: 0000000000000000 00007fffb71e7ed0
0000000000000000 0000000000000000
[   11.807346] GPR16: 0000000117337d04 0000000117291810
00000001172b90a0 0000000000000000
[   11.807346] GPR20: 0000000000000000 0000000114229358
00000001142229c3 0000000114229070
[   11.807346] GPR24: 00007fffeb8d5d78 000000000aba9500
0000000000000009 0000000000000001
[   11.807346] GPR28: 00007fffeb8d63d8 00000001172b90a0
0000000000004000 0000000000100000
[   11.873908] NIP [00007fffb83d0d04] 0x7fffb83d0d04
[   11.878070] LR [0000000000000000] 0x0
[   11.882230] --- interrupt: 3000
[   11.885004] Instruction dump:
[   11.887777] 41820034 38600001 38210060 4e800020 7c0802a6 3c62fec8
7ca62b78 38637828
[   11.896097] 7d455378 f8010070 4b835ab5 60000000 <0fe00000> 7c0802a6
7c641b78 3c62fec8
[   11.904418] ---[ end trace eeb6c5334a31bf7f ]---
[   12.916503]


On Thu, Nov 4, 2021 at 2:18 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> CKI observed the boot panic issue with the latest linux-block/for-next
> on aarch64/ppc64le/x86_64,  here are the logs:
>
> >        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axb=
oe/linux-block.git
> >             Commit: 48dd8b1e4917 - Merge branch 'for-5.16/drivers' into=
 for-next
>
> aarch64:
>
> [   84.347995] Unable to handle kernel paging request at virtual
> address ffff80001199a690
> [   84.349378] list_add corruption. next->prev should be prev
> (ffff000820e50140), but was ffff000801500140. (next=3Dffff000820e50140).
> [   84.355909] Mem abort info:
> [   84.367558] ------------[ cut here ]------------
> [   84.367560] kernel BUG at lib/list_debug.c:23!
> [   84.367565] Internal error: Oops - BUG: 0 [#1] SMP
> [   84.370347]   ESR =3D 0x96000047
> [   84.374951] Modules linked in:
> [   84.379385]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   84.384156]  ipmi_devintf
> [   84.387200]   SET =3D 0, FnV =3D 0
> [   84.390238]  ipmi_msghandler
> [   84.395534]   EA =3D 0, S1PTW =3D 0
> [   84.398141]  thunderx2_pmu cppc_cpufreq(+) fuse zram
> [   84.401186]   FSC =3D 0x07: level 3 translation fault
> [   84.404052]  ip_tables
> [   84.407183] Data abort info:
> [   84.412130]  xfs
> [   84.416996]   ISV =3D 0, ISS =3D 0x00000047
> [   84.419338]  ast
> [   84.422204]   CM =3D 0, WnR =3D 1
> [   84.424030]  i2c_algo_bit
> [   84.427855] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000f6fc=
f000
> [   84.429676]  drm_vram_helper
> [   84.432629] [ffff80001199a690] pgd=3D100000bffcfff003
> [   84.435235]  drm_kms_helper
> [   84.441925] , p4d=3D100000bffcfff003
> [   84.444788]  syscopyarea
> [   84.449656] , pud=3D100000bffcffe003
> [   84.452431]  sysfillrect
> [   84.455818] , pmd=3D100000bffcffa003
> [   84.458338]  uas sysimgblt crct10dif_ce fb_sys_fops cec
> [   84.461730] , pte=3D0000000000000000
> [   84.464249]  ghash_ce
> [   84.467645]
> [   84.472847]  drm_ttm_helper ttm drm usb_storage gpio_xlp i2c_xlp9xx
> [   84.486231] CPU: 106 PID: 2562 Comm: (spawn) Not tainted 5.15.0 #1
> [   84.492400] Hardware name: HPE Apollo 70             /C01_APACHE_MB
>         , BIOS L50_5.13_1.11 06/18/2019
> [   84.502126] pstate: 404000c9 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   84.509077] pc : __list_add_valid+0x54/0x90
> [   84.513253] lr : __list_add_valid+0x54/0x90
> [   84.517425] sp : ffff800027173360
> [   84.520726] x29: ffff800027173360 x28: ffff00083fae0d20 x27: ffff00082=
0e54918
> [   84.527852] x26: ffff000820e54958 x25: ffff000820e50140 x24: ffff00082=
0e50140
> [   84.534976] x23: ffff00083fae0e50 x22: ffff000820e50000 x21: ffff00082=
0e50000
> [   84.542100] x20: ffff000820e54800 x19: ffff00083fae0d20 x18: fffffffff=
fffffff
> [   84.549224] x17: 3034313035653032 x16: 3830303066666666 x15: 282076657=
2702065
> [   84.556347] x14: 6220646c756f6873 x13: 2e29303431303565 x12: 303238303=
0306666
> [   84.563471] x11: 66663d7478656e28 x10: 202e303431303035 x9 : ffff80001=
031c63c
> [   84.570595] x8 : 78656e202e6e6f69 x7 : 205d383733393433 x6 : 332e34382=
020205b
> [   84.577718] x5 : 0000000000000000 x4 : ffff009efcd493c8 x3 : ffff009ef=
cd55ab0
> [   84.584849] x2 : ffff009efcd493c8 x1 : ffff809eeb3c0000 x0 : 000000000=
0000075
> [   84.584854] Call trace:
> [   84.584856]  __list_add_valid+0x54/0x90
> [   84.584860]  bfq_active_insert+0xc8/0x140
> [
>   OK
> ] Found device [   84.602241]  bfq_update_fin_time_enqueue+0x94/0xac
>  [0;1[;39 m/d ev/ zr84.602245]  bfq_activate_requeue_entity+0x19c/0x2c0
> am0
> .
>          Starting
> Create swap on /dev/zram0
> ...
> [   84.602248]  bfq_add_bfqq_busy+0x90/0x1d0
> [   84.607518] zram0: detected capacity change from 0 to 16777216
> [   84.632359]  bfq_bfqq_handle_idle_busy_switch+0x194/0x560
> [   84.637746]  bfq_add_request+0x1c4/0x4ec
> [   84.641657]  __bfq_insert_request.isra.0+0x194/0x520
> [   84.646609]  bfq_insert_request+0x2f0/0x370
> [   84.650780]  bfq_insert_requests+0x74/0x94
> [   84.654864]  blk_mq_sched_insert_requests+0x7c/0x170
> [   84.659817]  blk_mq_flush_plug_list+0x114/0x2c0
> [   84.664336]  blk_flush_plug+0x104/0x14c
> [   84.668161]  blk_finish_plug+0x44/0x350
> [   84.671984]  read_pages+0x100/0x200
> [   84.675464]  page_cache_ra_unbounded+0x184/0x1e0
> [   84.680070]  ondemand_readahead+0x12c/0x2b0
> [   84.684242]  page_cache_sync_ra+0xf4/0xfc
> [   84.688240]  filemap_get_pages+0xa8/0x320
> [   84.692237]  filemap_read+0xa4/0x300
> [   84.695800]  generic_file_read_iter+0x100/0x194
> [   84.700318]  xfs_file_buffered_read+0xb4/0xe0 [xfs]
> [   84.705327]  xfs_file_read_iter+0xa8/0x124 [xfs]
> [   84.710031]  __kernel_read+0xf8/0x294
> [   84.713683]  kernel_read+0x74/0xbc
> [   84.717073]  search_binary_handler+0x48/0x2bc
> [   84.721419]  exec_binprm+0x58/0x1a4
> [   84.724895]  bprm_execve.part.0+0x1dc/0x25c
> [   84.729067]  bprm_execve+0x64/0xa0
> [   84.732456]  do_execveat_common.isra.0+0x160/0x1e0
> [   84.737235]  __arm64_sys_execve+0x4c/0x60
> [   84.741233]  invoke_syscall+0x50/0x120
> [   84.744973]  el0_svc_common.constprop.0+0xdc/0x100
> [   84.749752]  do_el0_svc+0x34/0xa0
> [   84.753056]  el0_svc+0x30/0xd0
> [   84.756101]  el0t_64_sync_handler+0xa4/0x130
> [   84.760359]  el0t_64_sync+0x1a4/0x1a8
> [   84.764012] Code: aa0403e3 f0006bc0 9103e000 94206b3c (d4210000)
> [   84.770094] ---[ end trace c439969081a5e3bf ]---
> [   84.774699] Kernel panic - not syncing: Oops - BUG: Fatal exception
> [   84.780953] SMP: stopping secondary CPUs
> [   85.840087] SMP: failed to stop secondary CPUs 31,60,63,71,83,98,100,1=
06-107
> [   85.847126] Kernel Offset: 0xe0000 from 0xffff800010000000
> [   85.852598] PHYS_OFFSET: 0x80000000
> [   85.856073] CPU features: 0x0,0c000943,46400840
> [   85.860592] Memory Limit: none
> [   85.863636] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal
> exception ]---
>
> ppc64le:
>
> [   23.180374] zram0: detected capacity change from 0 to 16777216
> [   23.199636] rtc-opal opal-rtc: registered as rtc0
> [   23.239554] rtc-opal opal-rtc: setting system clock to
> 2021-11-04T00:48:47 UTC (1635986927)
> [   23.246076] tpm_i2c_nuvoton 3-0057: VID: 1050 DID: FE RID: 04
> [   23.248615] ipmi device interface
> [   23.252131] ipmi-powernv ibm,opal:ipmi: IPMI message handler: Found
> new BMC (man_id: 0x002a7c, prod_id: 0x0985, dev_id: 0x20)
> [
>   OK
> ] Finished
> Create swap on /dev/zram0
> .
>          Activating swap
> Compressed Swap on /dev/zram0
> ...
> [   23.600907] list_add corruption. next->prev should be prev
> (c000000022c18140), but was c0000000006c8140. (next=3Dc000000022c18140).
> [   23.600957] ------------[ cut here ]------------
> [   23.600970] kernel BUG at lib/list_debug.c:23!
> [   23.600985] Oops: Exception in kernel mode, sig: 5 [#1]
> [   23.600998] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA Pow=
erNV
> [   23.601015] Modules linked in: regmap_i2c ipmi_powernv ipmi_devintf
> tpm_i2c_nuvoton i2c_opal ipmi_msghandler rtc_opal fuse zram ip_tables
> xfs ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea
> sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm
> vmx_crypto crc32c_vpmsum i2c_core aacraid drm_panel_orientation_quirks
> [   23.601101] CPU: 45 PID: 1829 Comm: (spawn) Not tainted 5.15.0 #1
> [   23.601119] NIP:  c0000000009c0e18 LR: c0000000009c0e14 CTR: c00000000=
00cd280
> [   23.601137] REGS: c00000002eae2f40 TRAP: 0700   Not tainted  (5.15.0)
> [   23.601153] MSR:  9000000000021033 <SF,HV,ME,IR,DR,RI,LE>  CR:
> 28022242  XER: 20040000
> [   23.601182] CFAR: c0000000001f6b8c IRQMASK: 1
> [   23.601182] GPR00: c0000000009c0e14 c00000002eae31e0
> c0000000028aab00 0000000000000075
> [   23.601182] GPR04: c0000007fee27f88 c0000007feeacc80
> c00000002eae2ee0 0000000000000027
> [   23.601182] GPR08: 0000000000000000 c0000007fee2adb0
> 00000007fccc0000 0000000000000001
> [   23.601182] GPR12: 0000000024022248 c0000007fffaec80
> 0000000000000000 c000000022c18000
> [   23.601182] GPR16: 0000000000000001 0000000000000000
> 0000000000000001 c00000005dfd08c0
> [   23.601182] GPR20: 0000000000000000 c00000005dfd08c0
> c00000000152e3b0 002d444552414853
> [   23.601182] GPR24: c000000022c18140 c000000022c18140
> c00000005dfd09f0 c000000022c18000
> [   23.601182] GPR28: c000000022c18000 c00000005dfd08c0
> c000000022c12800 c000000022c12918
> [   23.601341] NIP [c0000000009c0e18] __list_add_valid+0x68/0xc0
> [   23.601361] LR [c0000000009c0e14] __list_add_valid+0x64/0xc0
> [   23.601378] Call Trace:
> [   23.601386] [c00000002eae31e0] [c0000000009c0e14]
> __list_add_valid+0x64/0xc0 (unreliable)
> [   23.601407] [c00000002eae3240] [c000000000985e30]
> bfq_active_insert+0x100/0x1c0
> [   23.601428] [c00000002eae32a0] [c000000000986de4]
> bfq_activate_requeue_entity+0x294/0x480
> [   23.601448] [c00000002eae33a0] [c000000000987d28]
> bfq_add_bfqq_busy+0xc8/0x280
> [   23.601467] [c00000002eae3450] [c000000000984d28]
> bfq_insert_requests+0xcc8/0x16d0
> [   23.601487] [c00000002eae35c0] [c00000000094a054]
> blk_mq_sched_insert_requests+0xa4/0x1d0
> [   23.601508] [c00000002eae3610] [c000000000941d74]
> blk_mq_flush_plug_list+0x164/0x380
> [   23.601528] [c00000002eae36a0] [c00000000092f3cc] blk_flush_plug+0x16c=
/0x1d0
> [   23.601548] [c00000002eae3710] [c00000000092f770] blk_finish_plug+0x50=
/0x6c
> [   23.601566] [c00000002eae3740] [c0000000003f81c8] read_pages+0x1e8/0x4=
30
> [   23.601584] [c00000002eae37c0] [c0000000003f8648]
> page_cache_ra_unbounded+0x238/0x350
> [   23.601604] [c00000002eae3870] [c0000000003e5f10]
> filemap_get_pages+0x130/0xa30
> [   23.601624] [c00000002eae3990] [c0000000003e6900] filemap_read+0xf0/0x=
490
> [   23.601641] [c00000002eae3ad0] [c00800000e0d39d8]
> xfs_file_buffered_read+0xe0/0x120 [xfs]
> [   23.601767] [c00000002eae3b10] [c00800000e0d53e4]
> xfs_file_read_iter+0xac/0x170 [xfs]
> [   23.601895] [c00000002eae3b50] [c000000000525dbc] __kernel_read+0x14c/=
0x360
> [   23.601913] [c00000002eae3c40] [c000000000531ea8] bprm_execve+0x248/0x=
7c0
> [   23.601930] [c00000002eae3d10] [c00000000053298c]
> do_execveat_common+0x17c/0x250
> [   23.601950] [c00000002eae3d70] [c000000000532aa8] sys_execve+0x48/0x60
> [   23.601967] [c00000002eae3db0] [c00000000002d3e8]
> system_call_exception+0x188/0x360
> [   23.601988] [c00000002eae3e10] [c00000000000c1e8]
> system_call_vectored_common+0xe8/0x278
> [   23.602009] --- interrupt: 3000 at 0x7fffa3a30d04
> [   23.602023] NIP:  00007fffa3a30d04 LR: 0000000000000000 CTR: 000000000=
0000000
> [   23.602040] REGS: c00000002eae3e80 TRAP: 3000   Not tainted  (5.15.0)
> [   23.602055] MSR:  900000000280f033
> <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48044402  XER: 00000000
> [   23.602090] IRQMASK: 0
> [   23.602090] GPR00: 000000000000000b 00007fffe6939e10
> 00007fffa3b57000 00000001337610f0
> [   23.602090] GPR04: 0000000133761c40 000000013375dad0
> 00007fffe6939e18 0000000000000040
> [   23.602090] GPR08: 0000000000000000 0000000000000000
> 0000000000000000 0000000000000000
> [   23.602090] GPR12: 0000000000000000 00007fffa2847ed0
> 0000000000000000 0000000000000000
> [   23.602090] GPR16: 000000013375ea54 00000001337320e0
> 0000000133747720 0000000000000000
> [   23.602090] GPR20: 0000000000000000 0000000127ba9358
> 0000000127ba29c3 0000000127ba9070
> [   23.602090] GPR24: 00007fffe6939ed8 000000000aba9500
> 0000000000000009 0000000000000001
> [   23.602090] GPR28: 00007fffe693a538 0000000133747720
> 0000000000004000 0000000000100000
> [   23.666215] NIP [00007fffa3a30d04] 0x7fffa3a30d04
> [   23.670377] LR [0000000000000000] 0x0
> [   23.674534] --- interrupt: 3000
> [   23.677311] Instruction dump:
> [   23.680084] 41820034 38600001 38210060 4e800020 7c0802a6 3c62fec8
> 7ca62b78 38637820
> [   23.688403] 7d455378 f8010070 4b835d35 60000000 <0fe00000> 7c0802a6
> 7c641b78 3c62fec8
> [   23.695339] ---[ end trace 58123288c0bd2510 ]---
> [   24.706402]
>
> x86_64:
>
> Load Kernel Module configfs
> .
> [ [0;32[    9.270572] ipmi_si: IPMI System Interface driver
> m  OK
> ] Fin[    9.276416] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMB=
IOS
> ished
> C[    9.284127] ipmi_platform: ipmi_si: SMBIOS: io 0xca2 regsize 1
> spacing 1 irq 0
> oldplug All udev[    9.292730] ipmi_si: Adding SMBIOS-specified kcs
> state machine
>  Devices
> .
> [    9.300011] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
> [    9.300335] power_meter ACPI000D:00: Found ACPI power meter.
> [
>   OK   [[    9.312904] power_meter ACPI000D:00: Ignoring unsafe
> software power cap!
> 0m] Finished  [0[    9.313012] ipmi_si IPI0001:00: ipmi_platform: [io
> 0x0ca2] regsize 1 spacing 1 irq 0
> [    9.320961] power_meter ACPI000D:00: hwmon_device_register() is
> deprecated. Please convert the driver to use
> hwmon_device_register_with_info().
> ;1;39mFlush Journal to Persistent Storage
> .
> [    9.362525] dca service started, version 1.12.1
> [    9.368474] BUG: unable to handle page fault for address: 000000000003=
23c0
> [    9.375341] #PF: supervisor write access in kernel mode
> [    9.380556] #PF: error_code(0x0002) - not-present page
> [    9.385689] PGD 0 P4D 0
> [    9.388219] Oops: 0002 [#1] PREEMPT SMP PTI
> [    9.392397] CPU: 4 PID: 672 Comm: systemd-udevd Not tainted 5.15.0 #1
> [    9.398827] Hardware name: Supermicro Super Server/X10SRW-F, BIOS
> 3.3 10/28/2020
> [    9.406211] RIP: 0010:native_queued_spin_lock_slowpath+0x1ba/0x200
> [    9.412390] Code: ff f3 90 8b 03 85 c0 74 ee eb f6 c1 e9 12 83 e2
> 03 83 e9 01 48 c1 e2 05 48 63 c9 48 81 c2 80 23 03 00 48 03 14 cd e0
> ea 6c aa <48> 89 2a 8b 55 08 85 d2 75 09 f3 90 8b 55 08 85 d2 74 f7 48
> 8b 4d
> [    9.431127] RSP: 0018:ffffa5514066b800 EFLAGS: 00010206
> [    9.436344] RAX: 0000000000140000 RBX: ffff9800c37e8948 RCX: 000000000=
00030de
> [    9.443469] RDX: 00000000000323c0 RSI: ffffffffaa623c05 RDI: ffffffffa=
a5e7924
> [    9.450593] RBP: ffff98081fd32380 R08: ffff9800c2eb4548 R09: ffff9800c=
2eb4548
> [    9.457718] R10: 0000000000000000 R11: 0000000000000004 R12: 000000000=
0000000
> [    9.464843] R13: ffff9800c724b570 R14: 0000000000000001 R15: 000000000=
0000001
> [    9.471966] FS:  00007f8b0da31b40(0000) GS:ffff98081fd00000(0000)
> knlGS:0000000000000000
> [    9.480044] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.485781] CR2: 00000000000323c0 CR3: 0000000102144001 CR4: 000000000=
03706e0
> [    9.492905] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [    9.500030] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [    9.507153] Call Trace:
> [    9.509601]  <TASK>
> [    9.511706]  _raw_spin_lock+0x2c/0x30
> [    9.515371]  dd_bio_merge+0x38/0x80
> [    9.518866]  blk_mq_sched_bio_merge+0x4a/0x100
> [    9.523310]  blk_mq_submit_bio+0x4ef/0x6d0
> [    9.527400]  ? submit_bio_checks+0x333/0x5f0
> [    9.531672]  __submit_bio+0x8d/0xb0
> [    9.535156]  submit_bio_noacct+0xbb/0x280
> [    9.539161]  _xfs_buf_ioapply+0x283/0x3f0 [xfs]
> [    9.543807]  __xfs_buf_submit+0x62/0x1d0 [xfs]
> [    9.548339]  xfs_buf_read_map+0xec/0x250 [xfs]
> [    9.552874]  xfs_trans_read_buf_map+0xfa/0x2b0 [xfs]
> [    9.557932]  ? xfs_imap_to_bp+0x3e/0x50 [xfs]
> [    9.562379]  xfs_imap_to_bp+0x3e/0x50 [xfs]
> [    9.566645]  xfs_iget+0x2cd/0xaa0 [xfs]
> [    9.570580]  ? xfs_dir_lookup+0x17a/0x1b0 [xfs]
> [    9.575190]  xfs_lookup+0xba/0xf0 [xfs]
> [    9.579127]  xfs_vn_lookup+0x4b/0x80 [xfs]
> [    9.583319]  __lookup_slow+0x74/0x130
> [    9.586986]  walk_component+0x11b/0x190
> [    9.590825]  link_path_walk.part.0.constprop.0+0x225/0x350
> [    9.596310]  ? path_init+0x2c1/0x3f0
> [    9.599889]  path_lookupat+0x3e/0x1b0
> [    9.603546]  filename_lookup+0xbc/0x1a0
> [    9.607389]  ? strncpy_from_user+0x3f/0x130
> [    9.611572]  ? getname_flags.part.0+0x48/0x1b0
> [    9.616018]  user_path_at_empty+0x3a/0x50
> [    9.620031]  vfs_statx+0x64/0x100
> [    9.623343]  __do_sys_newfstatat+0x1e/0x40
> [    9.627436]  ? syscall_trace_enter.constprop.0+0x13d/0x1d0
> [    9.632920]  do_syscall_64+0x3b/0x90
> [    9.636497]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    9.641550] RIP: 0033:0x7f8b0e66c80e
> [    9.645122] Code: 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff
> e9 07 00 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 41 89 ca b8 06 01 00
> 00 0f 05 <3d> 00 f0 ff ff 77 0b 31 c0 c3 0f 1f 84 00 00 00 00 00 48 8b
> 15 31
> [    9.663858] RSP: 002b:00007fff1021ed98 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000106
> [    9.671416] RAX: ffffffffffffffda RBX: 00007fff1021fec8 RCX: 00007f8b0=
e66c80e
> [    9.678539] RDX: 00007fff1021edb0 RSI: 000055dcd9fad160 RDI: 00000000f=
fffff9c
> [    9.685664] RBP: 000055dcd9fad160 R08: 000055dcd9fad160 R09: 00007f8b0=
e7d12aa
> [    9.692788] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff1=
021fed0
> [    9.699914] R13: 000055dcd9f4bde0 R14: 000055dcd9f4bde0 R15: 00007f8b0=
e7d032a
> [    9.707038]  </TASK>
> [    9.709220] Modules linked in: pcc_cpufreq(+) dca acpi_cpufreq(-)
> ipmi_si(+) ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter fuse
> zram ip_tables xfs ast i2c_algo_bit drm_vram_helper drm_kms_helper cec
> crct10dif_pclmul drm_ttm_helper crc32_pclmul crc32c_intel ttm
> ghash_clmulni_intel drm mpt3sas raid_class scsi_transport_sas wmi
> [    9.738731] CR2: 00000000000323c0
> [    9.742045] ---[ end trace 568732bb01e9e18e ]---
> [    9.742045] BUG: unable to handle page fault for address: 000000000003=
2380
> [    9.805929] RIP: 0010:native_queued_spin_lock_slowpath+0x1ba/0x200
> [    9.808455] #PF: supervisor write access in kernel mode
> [    9.814627] Code: ff f3 90 8b 03 85 c0 74 ee eb f6 c1 e9 12 83 e2
> 03 83 e9 01 48 c1 e2 05 48 63 c9 48 81 c2 80 23 03 00 48 03 14 cd e0
> ea 6c aa <48> 89 2a 8b 55 08 85 d2 75 09 f3 90 8b 55 08 85 d2 74 f7 48
> 8b 4d
> [    9.819845] #PF: error_code(0x0002) - not-present page
> [    9.838582] RSP: 0018:ffffa5514066b800 EFLAGS: 00010206
> [    9.843714] PGD 0
> [    9.843714]
> [    9.843716] P4D 0
> [    9.848929] RAX: 0000000000140000 RBX: ffff9800c37e8948 RCX: 000000000=
00030de
> [    9.850940]
> [    9.850941] Oops: 0002 [#2] PREEMPT SMP PTI
> [    9.852432] RDX: 00000000000323c0 RSI: ffffffffaa623c05 RDI: ffffffffa=
a5e7924
> [    9.854442] CPU: 1 PID: 668 Comm: systemd-udevd Tainted: G      D
>         5.15.0 #1
> [    9.861566] RBP: ffff98081fd32380 R08: ffff9800c2eb4548 R09: ffff9800c=
2eb4548
> [    9.863057] Hardware name: Supermicro Super Server/X10SRW-F, BIOS
> 3.3 10/28/2020
> [    9.867234] R10: 0000000000000000 R11: 0000000000000004 R12: 000000000=
0000000
> [    9.874359] RIP: 0010:native_queued_spin_lock_slowpath+0x1ba/0x200
> [    9.882176] R13: ffff9800c724b570 R14: 0000000000000001 R15: 000000000=
0000001
> [    9.889300] Code: ff f3 90 8b 03 85 c0 74 ee eb f6 c1 e9 12 83 e2
> 03 83 e9 01 48 c1 e2 05 48 63 c9 48 81 c2 80 23 03 00 48 03 14 cd e0
> ea 6c aa <48> 89 2a 8b 55 08 85 d2 75 09 f3 90 8b 55 08 85 d2 74 f7 48
> 8b 4d
> [    9.896685] FS:  00007f8b0da31b40(0000) GS:ffff98081fd00000(0000)
> knlGS:0000000000000000
> [    9.903810] RSP: 0018:ffffa5514063b860 EFLAGS: 00010202
> [    9.909979] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.917103]
> [    9.917103] RAX: 0000000000080000 RBX: ffff9800c76c7148 RCX: 000000000=
00031da
> [    9.935840] CR2: 00000000000323c0 CR3: 0000000102144001 CR4: 000000000=
03706e0
> [    9.943918] RDX: 0000000000032380 RSI: ffffffffaa623c05 RDI: ffffffffa=
a5e7924
> [    9.949137] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [    9.954873] RBP: ffff98081fc72380 R08: ffff9800c2eb0db8 R09: ffff9800c=
2eb0db8
> [    9.956365] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [    9.963488] R10: 0000000000000000 R11: 0000000000000001 R12: 000000000=
0000000
> [    9.970612] Kernel panic - not syncing: Fatal exception
> [    9.977736] R13: ffff9800cdffee70 R14: 0000000000000004 R15: 000000000=
0000004
> [   10.018576] FS:  00007f8b0da31b40(0000) GS:ffff98081fc40000(0000)
> knlGS:0000000000000000
> [   10.026652] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   10.032390] CR2: 0000000000032380 CR3: 000000010707a001 CR4: 000000000=
03706e0
> [   10.039514] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   10.046637] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   10.053763] Call Trace:
> [   10.056208]  <TASK>
> [   10.058305]  _raw_spin_lock+0x2c/0x30
> [   10.061969]  dd_bio_merge+0x38/0x80
> [   10.065464]  blk_mq_sched_bio_merge+0x4a/0x100
> [   10.069908]  blk_mq_submit_bio+0x4ef/0x6d0
> [   10.073999]  ? submit_bio_checks+0x333/0x5f0
> [   10.078272]  __submit_bio+0x8d/0xb0
> [   10.081756]  submit_bio_noacct+0xbb/0x280
> [   10.085762]  _xfs_buf_ioapply+0x283/0x3f0 [xfs]
> [   10.090392]  __xfs_buf_submit+0x62/0x1d0 [xfs]
> [   10.094932]  xfs_buf_read_map+0xec/0x250 [xfs]
> [   10.099465]  xfs_trans_read_buf_map+0xfa/0x2b0 [xfs]
> [   10.104534]  ? xfs_imap_to_bp+0x3e/0x50 [xfs]
> [   10.108979]  xfs_imap_to_bp+0x3e/0x50 [xfs]
> [   10.113246]  xfs_iget+0x2cd/0xaa0 [xfs]
> [   10.117178]  ? xfs_dir_lookup+0x17a/0x1b0 [xfs]
> [   10.121790]  xfs_lookup+0xba/0xf0 [xfs]
> [   10.125722]  ? lockref_get_not_dead+0x39/0x90
> [   10.130074]  xfs_vn_lookup+0x4b/0x80 [xfs]
> [   10.134260]  __lookup_slow+0x74/0x130
> [   10.137928]  walk_component+0x11b/0x190
> [   10.141765]  link_path_walk.part.0.constprop.0+0x225/0x350
> [   10.147243]  ? path_init+0x2c1/0x3f0
> [   10.150813]  path_openat+0xa5/0x1010
> [   10.154386]  ? __check_object_size+0x136/0x150
> [   10.158832]  do_filp_open+0x9f/0x130
> [   10.162413]  ? __check_object_size+0x136/0x150
> [   10.166855]  ? _raw_spin_unlock+0x16/0x30
> [   10.170868]  ? alloc_fd+0xb4/0x170
> [   10.174275]  do_sys_openat2+0x7a/0x140
> [   10.178021]  __x64_sys_openat+0x45/0x70
> [   10.181861]  do_syscall_64+0x3b/0x90
> [   10.185438]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   10.190489] RIP: 0033:0x7f8b0e75e03b
> [   10.194060] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25
> 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00
> 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b
> 14 25
> [   10.212798] RSP: 002b:00007fff10220e00 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000101
> [   10.220356] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8b0=
e75e03b
> [   10.227481] RDX: 0000000000080000 RSI: 000055dcd9fad180 RDI: 00000000f=
fffff9c
> [   10.234604] RBP: 000055dcd9fad180 R08: 000055dcd9efd300 R09: 00007f8b0=
e73fa60
> [   10.241727] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0080000
> [   10.248853] R13: 000055dcd9efd300 R14: 000055dcd9fad180 R15: 000000000=
0000000
> [   10.255977]  </TASK>
> [   10.258160] Modules linked in: pcc_cpufreq(+) dca acpi_cpufreq(-)
> ipmi_si(+) ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter fuse
> zram ip_tables xfs ast i2c_algo_bit drm_vram_helper drm_kms_helper cec
> crct10dif_pclmul drm_ttm_helper crc32_pclmul crc32c_intel ttm
> ghash_clmulni_intel drm mpt3sas raid_class scsi_transport_sas wmi
> [   10.287673] CR2: 0000000000032380
> [   10.290983] ---[ end trace 568732bb01e9e18f ]---
> [   10.355969] RIP: 0010:native_queued_spin_lock_slowpath+0x1ba/0x200
> [   10.362144] Code: ff f3 90 8b 03 85 c0 74 ee eb f6 c1 e9 12 83 e2
> 03 83 e9 01 48 c1 e2 05 48 63 c9 48 81 c2 80 23 03 00 48 03 14 cd e0
> ea 6c aa <48> 89 2a 8b 55 08 85 d2 75 09 f3 90 8b 55 08 85 d2 74 f7 48
> 8b 4d
> [   10.380884] RSP: 0018:ffffa5514066b800 EFLAGS: 00010206
> [   10.386109] RAX: 0000000000140000 RBX: ffff9800c37e8948 RCX: 000000000=
00030de
> [   10.393232] RDX: 00000000000323c0 RSI: ffffffffaa623c05 RDI: ffffffffa=
a5e7924
> [   10.400356] RBP: ffff98081fd32380 R08: ffff9800c2eb4548 R09: ffff9800c=
2eb4548
> [   10.407480] R10: 0000000000000000 R11: 0000000000000004 R12: 000000000=
0000000
> [   10.414607] R13: ffff9800c724b570 R14: 0000000000000001 R15: 000000000=
0000001
> [   10.421731] FS:  00007f8b0da31b40(0000) GS:ffff98081fc40000(0000)
> knlGS:0000000000000000
> [   10.429806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   10.435545] CR2: 0000000000032380 CR3: 000000010707a001 CR4: 000000000=
03706e0
> [   10.442668] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   10.449793] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   11.139158] Shutting down cpus with NMI
> [   11.142999] Kernel Offset: 0x28000000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [   12.672482] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
>
> On Thu, Nov 4, 2021 at 1:03 PM CKI Project <cki-project@redhat.com> wrote=
:
> >
> > Hello,
> >
> > We ran automated tests on a recent commit from this kernel tree:
> >
> >        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axb=
oe/linux-block.git
> >             Commit: 48dd8b1e4917 - Merge branch 'for-5.16/drivers' into=
 for-next
> >
> > The results of these automated tests are provided below.
> >
> >     Overall result: FAILED (see details below)
> >              Merge: OK
> >            Compile: OK
> >              Tests: PANICKED
> >     Targeted tests: NO
> >
> > All kernel binaries, config files, and logs are available for download =
here:
> >
> >   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html=
?prefix=3Ddatawarehouse-public/2021/11/03/401433097
> >
> > One or more kernel tests failed:
> >
> >     s390x:
> >      =E2=9D=8C LTP - syscalls
> >
> >     ppc64le:
> >      =F0=9F=92=A5 Boot test
> >      =F0=9F=92=A5 Boot test
> >      =F0=9F=92=A5 Boot test
> >
> >     aarch64:
> >      =F0=9F=92=A5 Boot test
> >      =F0=9F=92=A5 Boot test
> >      =E2=9D=8C LTP - syscalls
> >      =F0=9F=92=A5 Boot test
> >
> >     x86_64:
> >      =F0=9F=92=A5 Boot test
> >



--=20
Best Regards,
  Yi Zhang

