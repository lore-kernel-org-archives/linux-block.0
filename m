Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C28C48BE0
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 14:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F32613B3
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 14:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhFKO4C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jun 2021 10:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230508AbhFKO4B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jun 2021 10:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623423243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZ0mkLfxqbAlmYA4PCrkc2VpWu9kWutnzi5rh5WYtQc=;
        b=Q4DGh7RkAFBZeeq+qAK6r0o+60cef6LFdTOec19HNcFU82WcDQOtul+gVNIJBpya4ZTzf5
        NeC0V3iP1MUScr2OkIiouBWqMqQtQ60kWBvI1NXvghTijZGJXq49ugwa7hmCKY2oEb/Bbt
        qlUDrxrVJ8c6th0zgdi1HPuNrbsgly4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-q9AubjfkNmGph56a7hyOdA-1; Fri, 11 Jun 2021 10:54:02 -0400
X-MC-Unique: q9AubjfkNmGph56a7hyOdA-1
Received: by mail-oo1-f72.google.com with SMTP id r4-20020a4ab5040000b02902446eb55473so1609031ooo.20
        for <linux-block@vger.kernel.org>; Fri, 11 Jun 2021 07:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FZ0mkLfxqbAlmYA4PCrkc2VpWu9kWutnzi5rh5WYtQc=;
        b=FdHej6kJ9lgi5ekvrGP8FDdH9v6GPR8v581InbtxiVCiPTCtSMcb/BqyhEmEuzctp8
         hgcPhL20Idn7uVAl6qMhmDmO7bmARc06TGwsHl9hRRQ2+1MxusQT/qwekQlm2JAOVNnf
         0HBR+33SaGSEtSDLdjD1O1V7MarOWFznL7kfgzwWTsKVuBQAT4aYKwpdls+dCidB1GSi
         C0MAqqapwGKjsmK3kitJgCKfI0bYcu/j8/d5zMefZTVx5U+kNd9pjM4AHt0XsLmg1AaQ
         x7KNBhaOlgdKkHy/bA794yvbZo++2LLrWXRECZ2AhLvNqDHXalzl69AV8Gaxe5v3Wik4
         Kksw==
X-Gm-Message-State: AOAM531LG4dRZdaChsCNVuJ5aiLhMI6wkKy8TtO7lkgngXwtFKjUSAiO
        5w++EXHwJS0lzuaN0pvARgS1/Rq52vAbrPKekxQblxzTQvvVQRG1TLyj4ml0uXktuzmEw+NXrDD
        ThxieezHJidDVPmHC/PgdoQUyuP+mhGDnRA5r/J8=
X-Received: by 2002:aca:d805:: with SMTP id p5mr2741471oig.60.1623423241117;
        Fri, 11 Jun 2021 07:54:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHiypYDxovR3hC76Y+xcE4BA8fqsC54FmTnAHFsLrmEwtyogVe8LQr3+U1mxN3B/WpfE2SpVdShAhdY/4z1Vw=
X-Received: by 2002:aca:d805:: with SMTP id p5mr2741458oig.60.1623423240865;
 Fri, 11 Jun 2021 07:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <cki.E86DF238D7.9O8UH9EIX2@redhat.com>
In-Reply-To: <cki.E86DF238D7.9O8UH9EIX2@redhat.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Fri, 11 Jun 2021 16:53:49 +0200
Message-ID: <CA+QYu4rt45KUJB9+XBwojMTmedfFYr06H0XBLKiKAnQJFYUCDw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=F0=9F=92=A5_PANICKED=3A_Test_report_for_kernel_5=2E13=2E0=2Drc3?=
        =?UTF-8?Q?_=28block=2C_314e07c7=29?=
To:     CKI Project <cki-project@redhat.com>
Cc:     skt-results-master@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Xiong Zhou <xzhou@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>, Li Wang <liwang@redhat.com>,
        Jeff Bastian <jbastian@redhat.com>,
        Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

We are sending this report regarding the kernel oops on ppc64le during
"CIFS Connectathon" test.

https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-pu=
blic/2021/06/01/312989200/build_ppc64le_redhat%3A1309223508/tests/10078627_=
ppc64le_1_console.log

We are sending this to the block tree as we hit this problem only when
testing a kernel from this tree. We are not able to easily reproduce
it either (So far we've seen this only twice).

[10904.818294] CIFS: Attempting to mount
\\ibm-p9z-16-lp1.lab.eng.bos.redhat.com\testuser
[10905.210957] BUG: Unable to handle kernel data access on write at
0x99a0978ccb2c73a5
[10905.210972] Faulting instruction address: 0xc0000000004a9d60
[10905.210978] Oops: Kernel access of bad area, sig: 11 [#1]
[10905.210983] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSerie=
s
[10905.210991] Modules linked in: md4 cmac cifs libdes libarc4
dns_resolver nls_utf8 isofs kvm_pr kvm snd_seq_dummy dummy veth minix
binfmt_misc can_raw can nfsv3 nfs_acl nfs lockd grace fscache netfs
rds tun brd overlay exfat vfat fat loop n_gsm pps_ldisc ppp_synctty
mkiss ax25 ppp_async ppp_generic serport slcan slip slhc snd_hrtimer
snd_seq snd_seq_device sctp ip6_udp_tunnel udp_tunnel snd_timer snd
soundcore authenc pcrypt crypto_user sha3_generic n_hdlc bonding tls
rfkill sunrpc ibmveth pseries_rng crct10dif_vpmsum drm
drm_panel_orientation_quirks fuse i2c_core zram ip_tables xfs ibmvscsi
scsi_transport_srp vmx_crypto crc32c_vpmsum [last unloaded:
ltp_insmod01]
[10905.211103] CPU: 0 PID: 398969 Comm: grepconf.sh Tainted: G
  OE     5.13.0-rc3 #1
[10905.211111] NIP:  c0000000004a9d60 LR: c0000000004a9e94 CTR: 00000000000=
00000
[10905.211117] REGS: c0000000187e36b0 TRAP: 0380   Tainted: G
 OE      (5.13.0-rc3)
[10905.211124] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
84000200  XER: 00000000
[10905.211138] CFAR: c0000000004a9c60 IRQMASK: 0
[10905.211138] GPR00: 146b53b1bb405e6b c0000000187e3950
c000000001e30e00 0000000000000000
[10905.211138] GPR04: 0000000000000dc0 00000000000f1cc0
0000000000be01c0 c0000007ff793f30
[10905.211138] GPR08: 0000000000000008 99a0978ccb2c739d
c0000000017e3f30 c0000000190a7c00
[10905.211138] GPR12: c0000000190a7c78 c000000002070000
0000000000000000 0000000000000000
[10905.211138] GPR16: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
[10905.211138] GPR20: 0000000000000000 00007fffe215fb15
c00000000e90ed00 ffffffffffffffff
[10905.211138] GPR24: 0000000010014261 0000000000000000
c000000001e689b8 c00000000084c804
[10905.211138] GPR28: 0000000000000dc0 0000000000000000
0000000000000001 c000000007013e00
[10905.211215] NIP [c0000000004a9d60] kmem_cache_alloc+0x190/0x480
[10905.211225] LR [c0000000004a9e94] kmem_cache_alloc+0x2c4/0x480
[10905.211232] Call Trace:
[10905.211242] [c0000000187e3950] [c0000000004a9e84]
kmem_cache_alloc+0x2b4/0x480 (unreliable)
[10905.211251] [c0000000187e39c0] [c00000000084c804]
security_file_alloc+0x44/0xf0
[10905.211261] [c0000000187e3a00] [c000000000504738] __alloc_file+0x78/0x13=
0
[10905.211269] [c0000000187e3a40] [c000000000504e58] alloc_empty_file+0x78/=
0x170
[10905.211278] [c0000000187e3ac0] [c00000000051b318] path_openat+0x58/0x12d=
0
[10905.211287] [c0000000187e3bd0] [c00000000051f070] do_filp_open+0x90/0x14=
0
[10905.211295] [c0000000187e3cf0] [c0000000004ff0e8] do_sys_openat2+0xf8/0x=
1f0
[10905.211303] [c0000000187e3d60] [c0000000004ff460] sys_openat+0x60/0xc0
[10905.211310] [c0000000187e3db0] [c00000000002c394]
system_call_exception+0x104/0x2c0
[10905.211319] [c0000000187e3e10] [c00000000000d45c]
system_call_common+0xec/0x278
[10905.211327] --- interrupt: c00 at 0x7fffbca93150

Bruno

On Fri, Jun 11, 2021 at 4:47 PM CKI Project <cki-project@redhat.com> wrote:
>
>
> Hello,
>
> We ran automated tests on a recent commit from this kernel tree:
>
>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe=
/linux-block.git
>             Commit: 314e07c78aef - Merge branch 'for-5.14/block' into for=
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
refix=3Ddatawarehouse-public/2021/06/01/312989200
>
> One or more kernel tests failed:
>
>     ppc64le:
>       CIFS Connectathon
>       Boot test
>
>     aarch64:
>       stress: stress-ng
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
>         stress: stress-ng
>
>     Host 2:
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
>   ppc64le:
>     Host 1:
>        =E2=9C=85 Boot test
>        =E2=9C=85 LTP
>         CIFS Connectathon
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest suites
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory: fork_mem
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility)
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>
>     Host 2:
>        =E2=9D=8C Boot test
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
>
>   s390x:
>     Host 1:
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
>     Host 2:
>        =E2=9C=85 Boot test
>        =E2=9C=85 xfstests - ext4
>        =E2=9C=85 xfstests - xfs
>        =E2=9C=85 Storage: swraid mdadm raid_module test
>         =E2=9C=85 xfstests - btrfs
>         =E2=9C=85 Storage blktests
>         =E2=9C=85 Storage nvme - tcp
>         =E2=9C=85 stress: stress-ng
>
>   x86_64:
>     Host 1:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Storage SAN device stress - lpfc driver
>
>     Host 2:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Storage SAN device stress - mpt3sas_gen1
>
>     Host 3:
>        =E2=9C=85 Boot test
>        =E2=9C=85 xfstests - ext4
>        =E2=9C=85 xfstests - xfs
>        =E2=9C=85 xfstests - nfsv4.2
>        =E2=9C=85 storage: software RAID testing
>        =E2=9C=85 Storage: swraid mdadm raid_module test
>         =E2=9C=85 xfstests - btrfs
>         =E2=9D=8C xfstests - cifsv3.11
>         =E2=9C=85 Storage blktests
>         =E2=9C=85 Storage block - filesystem fio test
>         =E2=9C=85 Storage block - queue scheduler test
>         =E2=9C=85 Storage nvme - tcp
>         =E2=9C=85 Storage: lvm device-mapper test
>         =E2=9C=85 stress: stress-ng
>
>     Host 4:
>        =E2=9C=85 Boot test
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
>         =E2=9C=85 xarray-idr-radixtree-test
>
>     Host 5:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Storage SAN device stress - qedf driver
>
>     Host 6:
>        =E2=9C=85 Boot test
>        =E2=9C=85 Storage SAN device stress - qla2xxx driver
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

