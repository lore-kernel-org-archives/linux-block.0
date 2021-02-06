Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CE1C433DB
	for <linux-block@archiver.kernel.org>; Sat,  6 Feb 2021 03:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3B964F99
	for <linux-block@archiver.kernel.org>; Sat,  6 Feb 2021 03:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhBFDQw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:16:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231899AbhBFDJx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Feb 2021 22:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612580904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3P9g5lDtMznIBfONiKLC2zb/uvdx0T8SU9E4UtFW63U=;
        b=ejDYtbMrc7XheRaPfohQ86gUysl6FvVd+2nVokoVXz4a2u7Qx7qx+/dCrOPf1KSVlH9PyH
        4EROwzUD8uosZfLDFLsQHbiYPFoZ7mEFNeGYn64FA7e9UCOtKDTRzaIOdfZIpL46sa/dyG
        Y5jY54dz1eUVs4ArlhwH/ZhwM4e9DZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-MiGIyjWCMAaCfpxD1BRL6g-1; Fri, 05 Feb 2021 22:08:21 -0500
X-MC-Unique: MiGIyjWCMAaCfpxD1BRL6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E5E1804023;
        Sat,  6 Feb 2021 03:08:20 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F19460C9C;
        Sat,  6 Feb 2021 03:08:19 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id CD06D4A7C6;
        Sat,  6 Feb 2021 03:08:18 +0000 (UTC)
Date:   Fri, 5 Feb 2021 22:08:18 -0500 (EST)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>
Cc:     axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
Message-ID: <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
In-Reply-To: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
Subject: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.68.5.41, 10.4.195.22]
Thread-Topic: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
Thread-Index: 2tBd7/Jehsbeb/mKAfYcWAj9LaDbog==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

We found this kernel NULL pointer issue with latest linux-block/for-next an=
d it's 100% reproduced, let me know if you need more info/testing, thanks=
=20

Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-bl=
ock.git
Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next

Reproducer: blktests nvme-tcp/012


[  124.458121] run blktests nvme/012 at 2021-02-05 21:53:34=20
[  125.525568] BUG: kernel NULL pointer dereference, address: 0000000000000=
008=20
[  125.532524] #PF: supervisor read access in kernel mode=20
[  125.537665] #PF: error_code(0x0000) - not-present page=20
[  125.542803] PGD 0 P4D 0 =20
[  125.545343] Oops: 0000 [#1] SMP NOPTI=20
[  125.549009] CPU: 15 PID: 12069 Comm: kworker/15:2H Tainted: G S        I=
       5.11.0-rc6+ #1=20
[  125.557528] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.0 =
11/12/2020=20
[  125.565093] Workqueue: kblockd blk_mq_run_work_fn=20
[  125.569797] RIP: 0010:nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]=20
[  125.575544] Code: 8b 75 68 44 8b 45 28 44 8b 7d 30 49 89 d4 48 c1 e2 04 =
4c 01 f2 45 89 fb 44 89 c7 85 ff 74 4d 44 89 e0 44 8b 55 10 48 c1 e0 04 <41=
> 8b 5c 06 08 45 0f b6 ca 89 d8 44 29 d8 39 f8 0f 47 c7 41 83 e9=20
[  125.594290] RSP: 0018:ffffbd084447bd18 EFLAGS: 00010246=20
[  125.599515] RAX: 0000000000000000 RBX: ffffa0bba9f3ce80 RCX: 00000000000=
00000=20
[  125.606648] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000020=
00000=20
[  125.613781] RBP: ffffa0ba8ac6fec0 R08: 0000000002000000 R09: 00000000000=
00000=20
[  125.620914] R10: 0000000002800809 R11: 0000000000000000 R12: 00000000000=
00000=20
[  125.628045] R13: ffffa0bba9f3cf90 R14: 0000000000000000 R15: 00000000000=
00000=20
[  125.635178] FS:  0000000000000000(0000) GS:ffffa0c9ff9c0000(0000) knlGS:=
0000000000000000=20
[  125.643264] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
[  125.649009] CR2: 0000000000000008 CR3: 00000001c9c6c005 CR4: 00000000007=
706e0=20
[  125.656142] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000=20
[  125.663274] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400=20
[  125.670407] PKRU: 55555554=20
[  125.673119] Call Trace:=20
[  125.675575]  nvme_tcp_queue_rq+0xef/0x330 [nvme_tcp]=20
[  125.680537]  blk_mq_dispatch_rq_list+0x11c/0x7c0=20
[  125.685157]  ? blk_mq_flush_busy_ctxs+0xf6/0x110=20
[  125.689775]  __blk_mq_sched_dispatch_requests+0x12b/0x170=20
[  125.695175]  blk_mq_sched_dispatch_requests+0x30/0x60=20
[  125.700227]  __blk_mq_run_hw_queue+0x2b/0x60=20
[  125.704500]  process_one_work+0x1cb/0x360=20
[  125.708513]  ? process_one_work+0x360/0x360=20
[  125.712699]  worker_thread+0x30/0x370=20
[  125.716365]  ? process_one_work+0x360/0x360=20
[  125.720550]  kthread+0x116/0x130=20
[  125.723782]  ? kthread_park+0x80/0x80=20
[  125.727448]  ret_from_fork+0x1f/0x30=20
[  125.731028] Modules linked in: nvme_tcp nvme_fabrics nvmet_tcp nvmet loo=
p nvme nvme_core rfkill sunrpc vfat fat dm_multipath intel_rapl_msr intel_r=
apl_common isst_if_common skx_edac x86_pkg_temp_thermal intel_powerclamp co=
retemp kvm_intel kvm ipmi_ssif mgag200 i2c_algo_bit drm_kms_helper irqbypas=
s iTCO_wdt crct10dif_pclmul iTCO_vendor_support syscopyarea crc32_pclmul sy=
sfillrect sysimgblt ghash_clmulni_intel fb_sys_fops dcdbas rapl drm intel_c=
state acpi_ipmi ipmi_si mei_me dell_smbios intel_uncore i2c_i801 mei dax_pm=
em_compat wmi_bmof dell_wmi_descriptor ipmi_devintf device_dax intel_pch_th=
ermal pcspkr i2c_smbus lpc_ich ipmi_msghandler dax_pmem_core acpi_power_met=
er ip_tables xfs libcrc32c nd_pmem nd_btt sd_mod t10_pi sg ahci libahci lib=
ata tg3 megaraid_sas crc32c_intel nfit wmi libnvdimm dm_mirror dm_region_ha=
sh dm_log dm_mod [last unloaded: nvmet]=20
[  125.806140] CR2: 0000000000000008=20
[  125.809467] ---[ end trace 312795dd33fab339 ]---=20
[  125.824717] RIP: 0010:nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]=20
[  125.830465] Code: 8b 75 68 44 8b 45 28 44 8b 7d 30 49 89 d4 48 c1 e2 04 =
4c 01 f2 45 89 fb 44 89 c7 85 ff 74 4d 44 89 e0 44 8b 55 10 48 c1 e0 04 <41=
> 8b 5c 06 08 45 0f b6 ca 89 d8 44 29 d8 39 f8 0f 47 c7 41 83 e9=20
[  125.849212] RSP: 0018:ffffbd084447bd18 EFLAGS: 00010246=20
[  125.854436] RAX: 0000000000000000 RBX: ffffa0bba9f3ce80 RCX: 00000000000=
00000=20
[  125.861560] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00000000020=
00000=20
[  125.868692] RBP: ffffa0ba8ac6fec0 R08: 0000000002000000 R09: 00000000000=
00000=20
[  125.875817] R10: 0000000002800809 R11: 0000000000000000 R12: 00000000000=
00000=20
[  125.882948] R13: ffffa0bba9f3cf90 R14: 0000000000000000 R15: 00000000000=
00000=20
[  125.890072] FS:  0000000000000000(0000) GS:ffffa0c9ff9c0000(0000) knlGS:=
0000000000000000=20
[  125.898158] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
[  125.903897] CR2: 0000000000000008 CR3: 00000001c9c6c005 CR4: 00000000007=
706e0=20
[  125.911029] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000=20
[  125.918160] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400=20
[  125.925292] PKRU: 55555554=20
[  125.927998] Kernel panic - not syncing: Fatal exception=20
[  126.309099] Kernel Offset: 0x2d400000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)=20
[  126.330633] ---[ end Kernel panic - not syncing: Fatal exception ]---=20

Best Regards,
  Yi Zhang


----- Original Message -----
From: "CKI Project" <cki-project@redhat.com>
To: axboe@kernel.dk
Cc: "Yi Zhang" <yizhan@redhat.com>
Sent: Saturday, February 6, 2021 7:36:43 AM
Subject: =E2=9C=85 PASS: Test report for kernel 5.11.0-rc6 (block)


Hello,

We ran automated tests on a recent commit from this kernel tree:

       Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/l=
inux-block.git
            Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into fo=
r-next

The results of these automated tests are provided below.

    Overall result: PASSED
             Merge: OK
           Compile: OK
             Tests: OK

All kernel binaries, config files, and logs are available for download here=
:

  https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?pre=
fix=3Ddatawarehouse-public/2021/02/05/623209

Please reply to this email if you have any questions about the tests that w=
e
ran or if you have any suggestions on how to make future tests more effecti=
ve.

        ,-.   ,-.
       ( C ) ( K )  Continuous
        `-',-.`-'   Kernel
          ( I )     Integration
           `-'
___________________________________________________________________________=
___

Compile testing
---------------

We compiled the kernel for 4 architectures:

    aarch64:
      make options: make  -j30 INSTALL_MOD_STRIP=3D1 targz-pkg

    ppc64le:
      make options: make  -j30 INSTALL_MOD_STRIP=3D1 targz-pkg

    s390x:
      make options: make  -j30 INSTALL_MOD_STRIP=3D1 targz-pkg

    x86_64:
      make options: make  -j30 INSTALL_MOD_STRIP=3D1 targz-pkg



Hardware testing
----------------
We booted each kernel and ran the following tests:

  aarch64:
    Host 1:
       =E2=9C=85 Boot test
       =E2=9C=85 ACPI table test
       =E2=9C=85 LTP
       =E2=9C=85 Loopdev Sanity
       =E2=9C=85 Memory: fork_mem
       =E2=9C=85 Memory function: memfd_create
       =E2=9C=85 AMTU (Abstract Machine Test Utility)
       =E2=9C=85 storage: SCSI VPD
       =F0=9F=9A=A7 =E2=9C=85 CIFS Connectathon
       =F0=9F=9A=A7 =E2=9C=85 POSIX pjd-fstest suites
       =F0=9F=9A=A7 =E2=9C=85 Ethernet drivers sanity

    Host 2:
       =E2=9C=85 Boot test
       =E2=9C=85 storage: software RAID testing
       =F0=9F=9A=A7 =E2=9C=85 xfstests - ext4
       =F0=9F=9A=A7 =E2=9C=85 xfstests - xfs
       =F0=9F=9A=A7 =E2=9C=85 xfstests - btrfs
       =F0=9F=9A=A7 =E2=9C=85 Storage blktests
       =F0=9F=9A=A7 =E2=9C=85 Storage block - filesystem fio test
       =F0=9F=9A=A7 =E2=9C=85 Storage block - queue scheduler test
       =F0=9F=9A=A7 =F0=9F=92=A5 Storage nvme - tcp
       =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_=
module test
       =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng

  ppc64le:
    Host 1:

       =E2=9A=A1 Internal infrastructure issues prevented one or more tests=
 (marked
       with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architecture.
       This is not the fault of the kernel that was tested.

       =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
       =E2=9A=A1=E2=9A=A1=E2=9A=A1 LTP
       =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
       =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory: fork_mem
       =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
       =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility)
       =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 CIFS Connectathon
       =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest suites
       =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity

    Host 2:
       =E2=9C=85 Boot test
       =E2=9C=85 storage: software RAID testing
       =F0=9F=9A=A7 =E2=9C=85 xfstests - ext4
       =F0=9F=9A=A7 =E2=9C=85 xfstests - xfs
       =F0=9F=9A=A7 =E2=9C=85 xfstests - btrfs
       =F0=9F=9A=A7 =E2=9C=85 Storage blktests
       =F0=9F=9A=A7 =E2=9C=85 Storage block - filesystem fio test
       =F0=9F=9A=A7 =E2=9C=85 Storage block - queue scheduler test
       =F0=9F=9A=A7 =F0=9F=92=A5 Storage nvme - tcp
       =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_=
module test

    Host 3:
       =E2=9C=85 Boot test
       =E2=9C=85 LTP
       =E2=9C=85 Loopdev Sanity
       =E2=9C=85 Memory: fork_mem
       =E2=9C=85 Memory function: memfd_create
       =E2=9C=85 AMTU (Abstract Machine Test Utility)
       =F0=9F=9A=A7 =E2=9C=85 CIFS Connectathon
       =F0=9F=9A=A7 =E2=9C=85 POSIX pjd-fstest suites
       =F0=9F=9A=A7 =E2=9C=85 Ethernet drivers sanity

  s390x:
    Host 1:

       =E2=9A=A1 Internal infrastructure issues prevented one or more tests=
 (marked
       with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architecture.
       This is not the fault of the kernel that was tested.

       =E2=9C=85 Boot test
       =F0=9F=9A=A7 =E2=9C=85 Storage blktests
       =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
       =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_=
module test
       =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng

    Host 2:
       =E2=9C=85 Boot test
       =E2=9C=85 LTP
       =E2=9C=85 Loopdev Sanity
       =E2=9C=85 Memory: fork_mem
       =E2=9C=85 Memory function: memfd_create
       =E2=9C=85 AMTU (Abstract Machine Test Utility)
       =F0=9F=9A=A7 =E2=9C=85 CIFS Connectathon
       =F0=9F=9A=A7 =E2=9C=85 POSIX pjd-fstest suites
       =F0=9F=9A=A7 =E2=9C=85 Ethernet drivers sanity

  x86_64:
    Host 1:
       =E2=9C=85 Boot test
       =E2=9C=85 Storage SAN device stress - qedf driver

    Host 2:
       =E2=9C=85 Boot test
       =E2=9C=85 Storage SAN device stress - qla2xxx driver

    Host 3:
       =E2=9C=85 Boot test
       =E2=9C=85 storage: software RAID testing
       =F0=9F=9A=A7 =E2=9C=85 xfstests - ext4
       =F0=9F=9A=A7 =E2=9C=85 xfstests - xfs
       =F0=9F=9A=A7 =E2=9C=85 xfstests - btrfs
       =F0=9F=9A=A7 =E2=9C=85 xfstests - nfsv4.2
       =F0=9F=9A=A7 =E2=9C=85 xfstests - cifsv3.11
       =F0=9F=9A=A7 =E2=9C=85 Storage blktests
       =F0=9F=9A=A7 =E2=9C=85 Storage block - filesystem fio test
       =F0=9F=9A=A7 =E2=9C=85 Storage block - queue scheduler test
       =F0=9F=9A=A7 =F0=9F=92=A5 Storage nvme - tcp
       =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_=
module test
       =F0=9F=9A=A7 =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng

    Host 4:
       =E2=9C=85 Boot test
       =E2=9C=85 Storage SAN device stress - mpt3sas_gen1

    Host 5:
       =E2=9C=85 Boot test
       =E2=9C=85 ACPI table test
       =E2=9C=85 LTP
       =E2=9C=85 Loopdev Sanity
       =E2=9C=85 Memory: fork_mem
       =E2=9C=85 Memory function: memfd_create
       =E2=9C=85 AMTU (Abstract Machine Test Utility)
       =E2=9C=85 storage: SCSI VPD
       =F0=9F=9A=A7 =E2=9C=85 CIFS Connectathon
       =F0=9F=9A=A7 =E2=9C=85 POSIX pjd-fstest suites
       =F0=9F=9A=A7 =E2=9C=85 Ethernet drivers sanity

    Host 6:
       =E2=9C=85 Boot test
       =E2=9C=85 Storage SAN device stress - lpfc driver

  Test sources: https://gitlab.com/cki-project/kernel-tests
    =F0=9F=92=9A Pull requests are welcome for new tests or improvements to=
 existing tests!

Aborted tests
-------------
Tests that didn't complete running successfully are marked with =E2=9A=A1=
=E2=9A=A1=E2=9A=A1.
If this was caused by an infrastructure issue, we try to mark that
explicitly in the report.

Waived tests
------------
If the test run included waived tests, they are marked with =F0=9F=9A=A7. S=
uch tests are
executed but their results are not taken into account. Tests are waived whe=
n
their results are not reliable enough, e.g. when they're just introduced or=
 are
being fixed.

Testing timeout
---------------
We aim to provide a report within reasonable timeframe. Tests that haven't
finished running yet are marked with =E2=8F=B1.

