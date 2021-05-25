Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C180C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 16:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5644861423
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 16:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhEYQ1q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 12:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232200AbhEYQ1n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 12:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621959973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=km1d6UeV1sA5Yb4fhthLLLoo8NFFD+0MsK0TngONGes=;
        b=AwEih/6fJHHxYczqCLYzFRIQalm4GpEF5nRJ01QB/1ohIvyrMuC1qDu+ps0Si6tvMQ27D7
        xfH1yoChbTqR34BjP6HT2K08f9gExZ4wMmMrV2LSG24A0Cp/ueZARR/LG7tcl1NsEp3rXj
        U5ONsjlDB8enRxOUlHgf16Raxkf6e+Q=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-aRX0T3m-M6e3PXde4sikEQ-1; Tue, 25 May 2021 12:26:09 -0400
X-MC-Unique: aRX0T3m-M6e3PXde4sikEQ-1
Received: by mail-ot1-f72.google.com with SMTP id x2-20020a9d62820000b02902e4ff743c4cso22120101otk.8
        for <linux-block@vger.kernel.org>; Tue, 25 May 2021 09:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=km1d6UeV1sA5Yb4fhthLLLoo8NFFD+0MsK0TngONGes=;
        b=DfJ9778ltRLiH/Kq7hvjASMJuJsZigOQL5vw3Cwd77tjvZQh6LLvFiIMDamGW6+QC/
         DZe53oo3HV2XQ3akXzNlAEy6e1AcAy8gE6PT1DYf1HZxktOrGjffdWqBIzSitgoPUmRw
         IrlsMufLPXtC8cvxX2q9s0RVEaynrNw2ZBoE9kNSO0zIjuO/cfB8dhMSQO7LBgpTWi83
         zkQbAzskzJUr3Gl/epD9uFqEFrOQ/zGz2Kt/3J3XbzafDvwA3md+Qj1qvZR3frIEh7Kv
         b1DgTVGmtxSuCsHH6VMM8ToVOwFMqiAqd1J87Md8KyVdWev4SZEFoeDQg1M2ixcr4WGZ
         8y3w==
X-Gm-Message-State: AOAM5309jqx5InLF2Ay77SbLOo3HWZYNPEmc6q/2fauozjGcg/2lIPyW
        2x4e8aDhq+Xc0u7pmsQCCbpJq23tZNQBxZxigsMhklcMlRwy2bFFQ4ckeOIlhC6Ir2lOMFQsTD6
        kJGMsOwiG3dx6HH3kPFFy+rVZTaA/bmQy+LhTvIg=
X-Received: by 2002:a9d:4046:: with SMTP id o6mr23742614oti.189.1621959968059;
        Tue, 25 May 2021 09:26:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKXlzSRYaJwgE1qGPhmUXmSIKD8HUXBiDDv514MXGNy5Plv/m8reDQbYlS52pZtuacLcCmDVZfXt4cu64TyEA=
X-Received: by 2002:a9d:4046:: with SMTP id o6mr23742567oti.189.1621959967684;
 Tue, 25 May 2021 09:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <cki.604EE92203.WD3M81N7Z7@redhat.com>
In-Reply-To: <cki.604EE92203.WD3M81N7Z7@redhat.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 25 May 2021 18:25:56 +0200
Message-ID: <CA+QYu4pKEvqhP+uukKikhaCJY8ksJ=xkLbN3G=YCU7F6P0S=Wg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=F0=9F=92=A5_PANICKED=3A_Test_report_for_kernel_5=2E13=2E0=2Drc3?=
        =?UTF-8?Q?_=28block=2C_cae7e156=29?=
To:     CKI Project <cki-project@redhat.com>
Cc:     skt-results-master@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Li Wang <liwang@redhat.com>,
        Jeff Bastian <jbastian@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Jan Stancek <jstancek@redhat.com>, Yi Zhang <yizhan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

we hit a kernel panic on ppc64le. We hit this only once, but would
like to let you know ASAP. In case we hit this panic again we let you
know.

The console log is:
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-pu=
blic/2021/05/24/308514234/build_ppc64le_redhat%3A1288671967/tests/10038550_=
ppc64le_1_console.log

[10264.732114] restraintd[843]: ** Installing dependencies
[-- MARK -- Mon May 24 16:50:00 2021]
[10281.612099] BUG: Unable to handle kernel data access on read at
0x302d6d766b2d3870
[10281.612613] Faulting instruction address: 0xc0000000004d39b8
[10281.612809] Oops: Kernel access of bad area, sig: 11 [#1]
[10281.612923] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSerie=
s
[10281.613172] Modules linked in: md4 cmac cifs libdes libarc4
dns_resolver nls_utf8 isofs kvm_pr kvm snd_seq_dummy dummy veth minix
binfmt_misc can_raw can nfsv3 nfs_acl nfs lockd grace fscache netfs
rds tun brd overlay exfat vfat fat loop n_gsm pps_ldisc ppp_synctty
mkiss ax25 ppp_async ppp_generic serport slcan slip slhc snd_hrtimer
snd_seq snd_seq_device sctp ip6_udp_tunnel udp_tunnel snd_timer snd
soundcore authenc pcrypt crypto_user sha3_generic n_hdlc rfkill sunrpc
joydev pseries_rng virtio_net net_failover failover virtio_balloon
virtio_console crct10dif_vpmsum drm drm_panel_orientation_quirks
i2c_core fuse zram ip_tables xfs vmx_crypto crc32c_vpmsum virtio_blk
[last unloaded: ltp_insmod01]
[10281.615858] CPU: 10 PID: 420920 Comm: dnf Tainted: G           OE
  5.13.0-rc3 #1
[10281.616024] NIP:  c0000000004d39b8 LR: c0000000004d39b8 CTR: c0000000003=
feda0
[10281.616186] REGS: c000000034f0b4e0 TRAP: 0380   Tainted: G
 OE      (5.13.0-rc3)
[10281.616368] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
44224444  XER: 20000000
[10281.616570] CFAR: c0000000004d38a8 IRQMASK: 1
[10281.616570] GPR00: c0000000004d39b8 c000000034f0b780
c000000001e30e00 0000000000000001
[10281.616570] GPR04: 0000000000000000 00000000c0000000
0000000000000001 000000000000000a
[10281.616570] GPR08: 00000000bddb0000 0000000000000000
000000000006e12c c008000001a36898
[10281.616570] GPR12: c0000000003feda0 c00000003fff1a80
0000000000000003 c00000000ac0fe40
[10281.616570] GPR16: 0000000000000000 0000000000200000
0000000000008000 0000000000000000
[10281.616570] GPR20: 0000000000000000 ffffffffffffffff
c000000097a5e800 c00000000b7e4400
[10281.616570] GPR24: 302d6d766b2d3870 c000000003010c00
c00c00000025e940 0000000000000000
[10281.616570] GPR28: 0000000000000001 0000000000000808
302d6d766b2d3870 c0000000bf58e780
[10281.617956] NIP [c0000000004d39b8] refill_obj_stock+0x68/0x180
[10281.618215] LR [c0000000004d39b8] refill_obj_stock+0x68/0x180
[10281.618354] Call Trace:
[10281.618418] [c000000034f0b780] [c0000000004d39b8]
refill_obj_stock+0x68/0x180 (unreliable)
[10281.618611] [c000000034f0b7d0] [c0000000004a6694] kfree+0x454/0x5c0
[10281.618752] [c000000034f0b840] [c0000000003fee04] kvfree+0x64/0x80
[10281.618901] [c000000034f0b870] [c0080000019f74b8]
xfs_log_commit_cil+0x170/0xa70 [xfs]
[10281.619316] [c000000034f0b980] [c0080000019ed718]
__xfs_trans_commit+0xb0/0x3a0 [xfs]
[10281.619595] [c000000034f0b9e0] [c0080000019dd76c]
xfs_rename+0x8a4/0xbb0 [xfs]
[10281.619876] [c000000034f0bae0] [c0080000019d4534]
xfs_vn_rename+0xec/0x1a0 [xfs]
[10281.620169] [c000000034f0bb60] [c00000000051cbb0] vfs_rename+0x620/0xa70
[10281.620340] [c000000034f0bc40] [c00000000051ff0c] do_renameat2+0x40c/0x6=
00
[10281.620491] [c000000034f0bd80] [c0000000005202a0] sys_rename+0x60/0x80
[10281.620629] [c000000034f0bdb0] [c00000000002c394]
system_call_exception+0x104/0x2c0
[10281.620796] [c000000034f0be10] [c00000000000d45c]
system_call_common+0xec/0x278
[10281.620964] --- interrupt: c00 at 0x7fff9dbd4e90
[10281.621077] NIP:  00007fff9dbd4e90 LR: 00007fff9b7100b4 CTR: 00000000000=
00000
[10281.621239] REGS: c000000034f0be80 TRAP: 0c00   Tainted: G
 OE      (5.13.0-rc3)
[10281.621406] MSR:  800000000280f033
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28284880  XER: 00000000
[10281.621629] IRQMASK: 0
[10281.621629] GPR00: 0000000000000026 00007fffdda0fd10
00007fff9dd87100 000001000261bf70
[10281.621629] GPR04: 000001000597eae0 0000000000000000
0000000000000000 0000000000000000
[10281.621629] GPR08: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
[10281.621629] GPR12: 0000000000000000 00007fff9e22c300
00007fff9b76d1a8 0000000000000000
[10281.621629] GPR16: 00007fff9b76d940 00000100058f9510
00000100033ade20 00007fff9b76da20
[10281.621629] GPR20: 0000010004250c10 00007fff9b76f418
ffffffffffff7fed 000001000427a810
[10281.621629] GPR24: 000001000597eae0 0000000000000000
00007fff9b76a610 ffffffffffffffff
[10281.621629] GPR28: 0000000000000001 000001000261bf70
000001000597eae0 00007fffdda0fd90
[10281.622973] NIP [00007fff9dbd4e90] 0x7fff9dbd4e90
[10281.623088] LR [00007fff9b7100b4] 0x7fff9b7100b4
[10281.623200] --- interrupt: c00
[10281.623282] Instruction dump:
[10281.623366] 9b8d0938 e92d0030 3fe2ff9b 3bffd980 7fff4a14 e93f0010
7c291800 418200bc
[10281.623539] fbc10040 7c7e1b78 7fe3fb78 4bfffe65 <e93e0000> 712a0003
408200f0 886d0938
[10281.623741] ---[ end trace cf4f01c868f7fdda ]---
[10281.626122]
[10281.637432] ------------[ cut here ]------------
[10281.637597] WARNING: CPU: 10 PID: 420920 at fs/xfs/xfs_aops.c:491
xfs_vm_writepages+0x108/0x150 [xfs]
[10281.638007] Modules linked in: md4 cmac cifs libdes libarc4
dns_resolver nls_utf8 isofs kvm_pr kvm snd_seq_dummy dummy veth minix
binfmt_misc can_raw can nfsv3 nfs_acl nfs lockd grace fscache netfs
rds tun brd overlay exfat vfat fat loop n_gsm pps_ldisc ppp_synctty
mkiss ax25 ppp_async ppp_generic serport slcan slip slhc snd_hrtimer
snd_seq snd_seq_device sctp ip6_udp_tunnel udp_tunnel snd_timer snd
soundcore authenc pcrypt crypto_user sha3_generic n_hdlc rfkill sunrpc
joydev pseries_rng virtio_net net_failover failover virtio_balloon
virtio_console crct10dif_vpmsum drm drm_panel_orientation_quirks
i2c_core fuse zram ip_tables xfs vmx_crypto crc32c_vpmsum virtio_blk
[last unloaded: ltp_insmod01]
[10281.639397] CPU: 10 PID: 420920 Comm: dnf Tainted: G      D    OE
  5.13.0-rc3 #1
[10281.639566] NIP:  c0080000019b1d30 LR: c0080000019b1c68 CTR: 00000000000=
00000
[10281.639737] REGS: c000000034f0ad20 TRAP: 0700   Tainted: G      D
 OE      (5.13.0-rc3)
[10281.639903] MSR:  800000000282b033
<SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 84222220  XER: 20000000
[10281.640122] CFAR: c0080000019b1c78 IRQMASK: 0
[10281.640122] GPR00: 0000000000000004 c000000034f0afc0
c008000001a70b00 c000000034f0aff0
[10281.640122] GPR04: 0000000000000000 0000000000000000
c000000034f0b050 0000000000000000
[10281.640122] GPR08: 00000000000000ff c00000005e0ec700
0000000000000000 c008000001a36618
[10281.640122] GPR12: c0000000000b7d48 c00000003fff1a80
0000000000000003 c00000000ac0fe40
[10281.640122] GPR16: 0000000000000000 0000000000200000
0000000000008000 0000000000000000
[10281.640122] GPR20: 0000000000000000 ffffffffffffffff
c000000097a5e800 c00000000b7e4400
[10281.640122] GPR24: 302d6d766b2d3870 c000000003010c00
0000000000000000 c00000007b925f40
[10281.640122] GPR28: c000000010e03bd0 c000000034f0b100
c000000053df8298 c000000053df8298
[10281.641614] NIP [c0080000019b1d30] xfs_vm_writepages+0x108/0x150 [xfs]
[10281.641876] LR [c0080000019b1c68] xfs_vm_writepages+0x40/0x150 [xfs]
[10281.642117] Call Trace:
[10281.642177] [c000000034f0afc0] [c000000034f0b070]
0xc000000034f0b070 (unreliable)
[10281.642344] [c000000034f0b070] [c0000000003d9564] do_writepages+0x54/0x1=
40
[10281.642495] [c000000034f0b0e0] [c0000000003cad68]
__filemap_fdatawrite_range+0x108/0x180
[10281.642669] [c000000034f0b180] [c0080000019daddc]
xfs_release+0x254/0x340 [xfs]
[10281.643007] [c000000034f0b1d0] [c0080000019c06bc]
xfs_file_release+0x24/0x40 [xfs]
[10281.643366] [c000000034f0b1f0] [c0000000005049b0] __fput+0xc0/0x340
[10281.643508] [c000000034f0b240] [c000000000180974] task_work_run+0xf4/0x1=
70
[10281.643654] [c000000034f0b290] [c000000000154824] do_exit+0x424/0xca0
[10281.643802] [c000000034f0b350] [c0000000000261d0] oops_end+0x1b0/0x1e0
[10281.643955] [c000000034f0b3d0] [c000000000089ddc]
__bad_page_fault+0x174/0x198
[10281.644129] [c000000034f0b440] [c00000000009299c] do_bad_slb_fault+0x9c/=
0x170
[10281.644299] [c000000034f0b470] [c000000000008c08]
data_access_slb_common_virt+0x198/0x1a0
[10281.644469] --- interrupt: 380 at refill_obj_stock+0x68/0x180
[10281.644609] NIP:  c0000000004d39b8 LR: c0000000004d39b8 CTR: c0000000003=
feda0
[10281.644781] REGS: c000000034f0b4e0 TRAP: 0380   Tainted: G      D
 OE      (5.13.0-rc3)
[10281.644993] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
44224444  XER: 20000000
[10281.645191] CFAR: c0000000004d38a8 IRQMASK: 1
[10281.645191] GPR00: c0000000004d39b8 c000000034f0b780
c000000001e30e00 0000000000000001
[10281.645191] GPR04: 0000000000000000 00000000c0000000
0000000000000001 000000000000000a
[10281.645191] GPR08: 00000000bddb0000 0000000000000000
000000000006e12c c008000001a36898
[10281.645191] GPR12: c0000000003feda0 c00000003fff1a80
0000000000000003 c00000000ac0fe40
[10281.645191] GPR16: 0000000000000000 0000000000200000
0000000000008000 0000000000000000
[10281.645191] GPR20: 0000000000000000 ffffffffffffffff
c000000097a5e800 c00000000b7e4400
[10281.645191] GPR24: 302d6d766b2d3870 c000000003010c00
c00c00000025e940 0000000000000000
[10281.645191] GPR28: 0000000000000001 0000000000000808
302d6d766b2d3870 c0000000bf58e780
[10281.648552] NIP [c0000000004d39b8] refill_obj_stock+0x68/0x180
[10281.648693] LR [c0000000004d39b8] refill_obj_stock+0x68/0x180
[10281.648835] --- interrupt: 380
[10281.648921] [c000000034f0b7d0] [c0000000004a6694] kfree+0x454/0x5c0
[10281.649064] [c000000034f0b840] [c0000000003fee04] kvfree+0x64/0x80
[10281.649205] [c000000034f0b870] [c0080000019f74b8]
xfs_log_commit_cil+0x170/0xa70 [xfs]
[10281.649524] [c000000034f0b980] [c0080000019ed718]
__xfs_trans_commit+0xb0/0x3a0 [xfs]
[10281.649812] [c000000034f0b9e0] [c0080000019dd76c]
xfs_rename+0x8a4/0xbb0 [xfs]
[10281.650147] [c000000034f0bae0] [c0080000019d4534]
xfs_vn_rename+0xec/0x1a0 [xfs]
[10281.650496] [c000000034f0bb60] [c00000000051cbb0] vfs_rename+0x620/0xa70
[10281.650640] [c000000034f0bc40] [c00000000051ff0c] do_renameat2+0x40c/0x6=
00
[10281.650784] [c000000034f0bd80] [c0000000005202a0] sys_rename+0x60/0x80
[10281.650933] [c000000034f0bdb0] [c00000000002c394]
system_call_exception+0x104/0x2c0
[10281.651101] [c000000034f0be10] [c00000000000d45c]
system_call_common+0xec/0x278
[10281.651269] --- interrupt: c00 at 0x7fff9dbd4e90
[10281.651435] NIP:  00007fff9dbd4e90 LR: 00007fff9b7100b4 CTR: 00000000000=
00000
[10281.651602] REGS: c000000034f0be80 TRAP: 0c00   Tainted: G      D
 OE      (5.13.0-rc3)
[10281.651773] MSR:  800000000280f033
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28284880  XER: 00000000
[10281.651979] IRQMASK: 0
[10281.651979] GPR00: 0000000000000026 00007fffdda0fd10
00007fff9dd87100 000001000261bf70
[10281.651979] GPR04: 000001000597eae0 0000000000000000
0000000000000000 0000000000000000
[10281.651979] GPR08: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
[10281.651979] GPR12: 0000000000000000 00007fff9e22c300
00007fff9b76d1a8 0000000000000000
[10281.651979] GPR16: 00007fff9b76d940 00000100058f9510
00000100033ade20 00007fff9b76da20
[10281.651979] GPR20: 0000010004250c10 00007fff9b76f418
ffffffffffff7fed 000001000427a810
[10281.651979] GPR24: 000001000597eae0 0000000000000000
00007fff9b76a610 ffffffffffffffff
[10281.651979] GPR28: 0000000000000001 000001000261bf70
000001000597eae0 00007fffdda0fd90
[10281.653338] NIP [00007fff9dbd4e90] 0x7fff9dbd4e90
[10281.653455] LR [00007fff9b7100b4] 0x7fff9b7100b4
[10281.653566] --- interrupt: c00
[10281.653648] Instruction dump:
[10281.653741] eb81ffe0 eba1ffe8 ebe1fff8 7c0803a6 4e800020 60000000
60000000 60420000
[10281.653920] 48085119 e8410018 4bffffac 60420000 <0fe00000> 382100b0
38600000 e8010010
[10281.654102] ---[ end trace cf4f01c868f7fddb ]---


On Tue, May 25, 2021 at 6:21 PM CKI Project <cki-project@redhat.com> wrote:
>
>
> Hello,
>
> We ran automated tests on a recent commit from this kernel tree:
>
>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe=
/linux-block.git
>             Commit: cae7e156d77e - Merge branch 'for-5.14/drivers' into f=
or-next
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
refix=3Ddatawarehouse-public/2021/05/24/308514234
>
> One or more kernel tests failed:
>
>     ppc64le:
>       Memory function: memfd_create
>
>     aarch64:
>      =E2=9D=8C LTP
>       Storage blktests
>
>     x86_64:
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
>        =E2=9C=85 ACPI table test
>        =E2=9D=8C LTP
>        =E2=9C=85 CIFS Connectathon
>        =E2=9C=85 POSIX pjd-fstest suites
>        =E2=9C=85 Loopdev Sanity
>        =E2=9C=85 Memory: fork_mem
>        =E2=9C=85 Memory function: memfd_create
>        =E2=9C=85 AMTU (Abstract Machine Test Utility)
>        =E2=9C=85 Ethernet drivers sanity
>        =E2=9C=85 storage: SCSI VPD
>         =E2=9C=85 xarray-idr-radixtree-test
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
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - ext4
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: software RAID testing
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_module test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - filesystem fio test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - queue scheduler test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: lvm device-mapper test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>     Host 3:
>        =E2=9C=85 Boot test
>        =E2=9C=85 xfstests - ext4
>        =E2=9C=85 xfstests - xfs
>        =E2=9C=85 storage: software RAID testing
>        =E2=9C=85 Storage: swraid mdadm raid_module test
>         =E2=9C=85 xfstests - btrfs
>         Storage blktests
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - filesystem fio test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - queue scheduler test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: lvm device-mapper test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>   ppc64le:
>     Host 1:
>        =E2=9C=85 Boot test
>        =E2=9C=85 xfstests - ext4
>        =E2=9C=85 xfstests - xfs
>        =E2=9C=85 storage: software RAID testing
>        =E2=9C=85 Storage: swraid mdadm raid_module test
>         =E2=9C=85 xfstests - btrfs
>         =E2=9C=85 Storage blktests
>         =E2=9C=85 Storage block - filesystem fio test
>         =E2=9C=85 Storage block - queue scheduler test
>         =E2=9C=85 Storage nvme - tcp
>         =E2=9C=85 Storage: lvm device-mapper test
>
>     Host 2:
>        =E2=9C=85 Boot test
>        =E2=9C=85 LTP
>        =E2=9C=85 CIFS Connectathon
>        =E2=9C=85 POSIX pjd-fstest suites
>        =E2=9C=85 Loopdev Sanity
>        =E2=9C=85 Memory: fork_mem
>         Memory function: memfd_create
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility)
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>
>   s390x:
>     Host 1:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9C=85 Boot test
>        =E2=9C=85 Storage: swraid mdadm raid_module test
>         =E2=9C=85 Storage blktests
>         =E2=9C=85 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>     Host 2:
>        =E2=9C=85 Boot test
>        =E2=9C=85 LTP
>        =E2=9C=85 CIFS Connectathon
>        =E2=9C=85 POSIX pjd-fstest suites
>        =E2=9C=85 Loopdev Sanity
>        =E2=9C=85 Memory: fork_mem
>        =E2=9C=85 Memory function: memfd_create
>        =E2=9C=85 AMTU (Abstract Machine Test Utility)
>        =E2=9C=85 Ethernet drivers sanity
>         =E2=9D=8C xarray-idr-radixtree-test
>
>   x86_64:
>     Host 1:
>        =E2=9C=85 Boot test
>        =E2=9C=85 ACPI table test
>        =E2=9D=8C LTP
>        =E2=9C=85 CIFS Connectathon
>        =E2=9C=85 POSIX pjd-fstest suites
>        =E2=9C=85 Loopdev Sanity
>        =E2=9C=85 Memory: fork_mem
>        =E2=9C=85 Memory function: memfd_create
>        =E2=9C=85 AMTU (Abstract Machine Test Utility)
>        =E2=9C=85 Ethernet drivers sanity
>        =E2=9C=85 storage: SCSI VPD
>         =E2=9C=85 xarray-idr-radixtree-test
>
>     Host 2:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Storage SAN device stress - lpfc driver
>
>     Host 3:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Storage SAN device stress - mpt3sas_gen1
>
>     Host 4:
>        =E2=9C=85 Boot test
>        =E2=9C=85 xfstests - ext4
>        =E2=9C=85 xfstests - xfs
>        =E2=9C=85 xfstests - nfsv4.2
>        =E2=9C=85 storage: software RAID testing
>        =E2=9C=85 Storage: swraid mdadm raid_module test
>         =E2=9C=85 xfstests - btrfs
>         =E2=9C=85 xfstests - cifsv3.11
>         =E2=9C=85 Storage blktests
>         =E2=9C=85 Storage block - filesystem fio test
>         =E2=9C=85 Storage block - queue scheduler test
>         =E2=9D=8C Storage nvme - tcp
>         =E2=9C=85 Storage: lvm device-mapper test
>         =E2=9D=8C stress: stress-ng
>
>     Host 5:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Storage SAN device stress - qla2xxx driver
>
>     Host 6:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Storage SAN device stress - qedf driver
>
>   Test sources: https://gitlab.com/cki-project/kernel-tests
>     Pull requests are welcome for new tests or improvements to existing t=
ests!
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
> If the test run included waived tests, they are marked with . Such tests =
are
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
>

