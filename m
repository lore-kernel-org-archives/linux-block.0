Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A818FC433E2
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 17:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD562072A
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 17:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ikJPxsaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgICRKp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:10:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47863 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728129AbgICRKo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Sep 2020 13:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599153041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x82qsCBL7H72agL/GNpad7C/AebVPK9IR1S1EgqezhM=;
        b=ikJPxsawgOUS1vDDFqzQEZ/U7/Ma+vIzRt5wPpaFDZFLT9NBSbvmOZzJ5dh8r4ukQeUBzH
        VMFpdqsWp/Li3BLPItFSDn4q+inuGiP6Ju5O2Ts639e2C1CDJHx0tt3QRXD7eBVNhfDZUG
        NO3gaxQoEYaCn7SR1RKpZGRlcMHjjf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-sb8vXdwRMDmtxxZR-uUpXA-1; Thu, 03 Sep 2020 13:10:39 -0400
X-MC-Unique: sb8vXdwRMDmtxxZR-uUpXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6229B10082EB;
        Thu,  3 Sep 2020 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-153.rdu2.redhat.com [10.10.112.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D924159;
        Thu,  3 Sep 2020 17:10:31 +0000 (UTC)
Subject: =?UTF-8?Q?Re=3a_=f0=9f=92=a5_PANICKED=3a_Test_report_for_kernel_5?=
 =?UTF-8?Q?=2e9=2e0-rc3-020ad03=2ecki_=28block=29?=
To:     CKI Project <cki-project@redhat.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Changhui Zhong <czhong@redhat.com>
References: <cki.538AE6A321.BMB0X5ZYG5@redhat.com>
From:   Rachel Sibley <rasibley@redhat.com>
Message-ID: <0f92c40e-b234-896c-0810-af36ee95e259@redhat.com>
Date:   Thu, 3 Sep 2020 13:10:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cki.538AE6A321.BMB0X5ZYG5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 9/3/20 1:07 PM, CKI Project wrote:
> 
> Hello,
> 
> We ran automated tests on a recent commit from this kernel tree:
> 
>         Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>              Commit: 020ad0333b03 - Merge branch 'for-5.10/block' into for-next
> 
> The results of these automated tests are provided below.
> 
>      Overall result: FAILED (see details below)
>               Merge: OK
>             Compile: OK
>               Tests: PANICKED
> 
> All kernel binaries, config files, and logs are available for download here:
> 
>    https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/09/02/613166
> 
> One or more kernel tests failed:
> 
>      ppc64le:
>       💥 storage: software RAID testing
> 
>      aarch64:
>       💥 storage: software RAID testing
> 
>      x86_64:
>       💥 storage: software RAID testing

Hello,

We're seeing a panic for all non s390x arches triggered by swraid test. Seems to be reproducible
for all succeeding pipelines after this one, and we haven't yet seen it in mainline or yesterday's
block tree results.

Thank you,
Rachel

https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/09/02/613166/build_aarch64_redhat%3A968098/tests/8757835_aarch64_3_console.log

[ 8394.609219] Internal error: Oops: 96000004 [#1] SMP
[ 8394.614070] Modules linked in: raid0 loop raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx dm_log_writes dm_flakey 
rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache rfkill sunrpc vfat fat xgene_hwmon xgene_enet at803x mdio_xgene xgene_rng 
xgene_edac mailbox_xgene_slimpro drm ip_tables xfs sdhci_of_arasan sdhci_pltfm i2c_xgene_slimpro crct10dif_ce sdhci gpio_dwapb cqhci xhci_plat_hcd 
gpio_xgene_sb gpio_keys aes_neon_bs
[ 8394.654298] CPU: 3 PID: 471427 Comm: kworker/3:2 Kdump: loaded Not tainted 5.9.0-rc3-020ad03.cki #1
[ 8394.663299] Hardware name: AppliedMicro X-Gene Mustang Board/X-Gene Mustang Board, BIOS 3.06.25 Oct 17 2016
[ 8394.672999] Workqueue: md_misc mddev_delayed_delete
[ 8394.677853] pstate: 40400085 (nZcv daIf +PAN -UAO BTYPE=--)
[ 8394.683399] pc : percpu_ref_exit+0x5c/0xc8
[ 8394.687473] lr : percpu_ref_exit+0x20/0xc8
[ 8394.691547] sp : ffff800019f33d00
[ 8394.694843] x29: ffff800019f33d00 x28: 0000000000000000
[ 8394.700129] x27: ffff0003c63ae000 x26: ffff8000120b6228
[ 8394.705414] x25: 0000000000000001 x24: ffff0003d8322a80
[ 8394.710698] x23: 0000000000000000 x22: 0000000000000000
[ 8394.715983] x21: 0000000000000000 x20: ffff8000121d2000
[ 8394.721266] x19: ffff0003d8322af0 x18: 0000000000000000
[ 8394.726550] x17: 0000000000000000 x16: 0000000000000000
[ 8394.731834] x15: 0000000000000007 x14: 0000000000000003
[ 8394.737119] x13: 0000000000000000 x12: ffff0003888a1978
[ 8394.742403] x11: ffff0003888a1918 x10: 0000000000000001
[ 8394.747688] x9 : 0000000000000000 x8 : 0000000000000000
[ 8394.752972] x7 : 0000000000000400 x6 : 0000000000000001
[ 8394.758257] x5 : ffff800010423030 x4 : ffff8000121d2e40
[ 8394.763540] x3 : 0000000000000000 x2 : 0000000000000000
[ 8394.768825] x1 : 0000000000000000 x0 : 0000000000000000
[ 8394.774110] Call trace:
[ 8394.776544]  percpu_ref_exit+0x5c/0xc8
[ 8394.780273]  md_free+0x64/0xa0
[ 8394.783311]  kobject_put+0x7c/0x218
[ 8394.786781]  mddev_delayed_delete+0x3c/0x50
[ 8394.790944]  process_one_work+0x1c4/0x450
[ 8394.794932]  worker_thread+0x164/0x4a8
[ 8394.798662]  kthread+0xf4/0x120
[ 8394.801787]  ret_from_fork+0x10/0x18
[ 8394.805344] Code: 2a0403e0 350002c0 a9400262 52800001 (f9400000)
[ 8394.811407] ---[ end trace 481cab6e1ad73da1 ]---


> 
> We hope that these logs can help you find the problem quickly. For the full
> detail on our testing procedures, please scroll to the bottom of this message.
> 
> Please reply to this email if you have any questions about the tests that we
> ran or if you have any suggestions on how to make future tests more effective.
> 
>          ,-.   ,-.
>         ( C ) ( K )  Continuous
>          `-',-.`-'   Kernel
>            ( I )     Integration
>             `-'
> ______________________________________________________________________________
> 
> Compile testing
> ---------------
> 
> We compiled the kernel for 4 architectures:
> 
>      aarch64:
>        make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>      ppc64le:
>        make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>      s390x:
>        make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>      x86_64:
>        make options: make -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
> 
> 
> Hardware testing
> ----------------
> We booted each kernel and ran the following tests:
> 
>    aarch64:
>      Host 1:
>         ✅ Boot test
>         ✅ ACPI table test
>         ✅ LTP
>         ✅ Loopdev Sanity
>         ✅ Memory function: memfd_create
>         ✅ AMTU (Abstract Machine Test Utility)
>         ✅ Ethernet drivers sanity
>         ✅ storage: SCSI VPD
>         🚧 ✅ CIFS Connectathon
>         🚧 ✅ POSIX pjd-fstest suites
> 
>      Host 2:
> 
>         ⚡ Internal infrastructure issues prevented one or more tests (marked
>         with ⚡⚡⚡) from running on this architecture.
>         This is not the fault of the kernel that was tested.
> 
>         ⚡⚡⚡ Boot test
>         ⚡⚡⚡ xfstests - ext4
>         ⚡⚡⚡ xfstests - xfs
>         ⚡⚡⚡ storage: software RAID testing
>         ⚡⚡⚡ stress: stress-ng
>         🚧 ⚡⚡⚡ xfstests - btrfs
>         🚧 ⚡⚡⚡ Storage blktests
> 
>      Host 3:
>         ✅ Boot test
>         ✅ xfstests - ext4
>         ✅ xfstests - xfs
>         💥 storage: software RAID testing
>         ⚡⚡⚡ stress: stress-ng
>         🚧 ⚡⚡⚡ xfstests - btrfs
>         🚧 ⚡⚡⚡ Storage blktests
> 
>    ppc64le:
>      Host 1:
>         ✅ Boot test
>         🚧 ✅ kdump - sysrq-c
> 
>      Host 2:
>         ✅ Boot test
>         ✅ xfstests - ext4
>         ✅ xfstests - xfs
>         💥 storage: software RAID testing
>         🚧 ⚡⚡⚡ xfstests - btrfs
>         🚧 ⚡⚡⚡ Storage blktests
> 
>      Host 3:
> 
>         ⚡ Internal infrastructure issues prevented one or more tests (marked
>         with ⚡⚡⚡) from running on this architecture.
>         This is not the fault of the kernel that was tested.
> 
>         ✅ Boot test
>         ⚡⚡⚡ LTP
>         ⚡⚡⚡ Loopdev Sanity
>         ⚡⚡⚡ Memory function: memfd_create
>         ⚡⚡⚡ AMTU (Abstract Machine Test Utility)
>         ⚡⚡⚡ Ethernet drivers sanity
>         🚧 ⚡⚡⚡ CIFS Connectathon
>         🚧 ⚡⚡⚡ POSIX pjd-fstest suites
> 
>    s390x:
>      Host 1:
>         ✅ Boot test
>         ✅ stress: stress-ng
>         🚧 ✅ Storage blktests
> 
>      Host 2:
>         ✅ Boot test
>         ✅ LTP
>         ✅ Loopdev Sanity
>         ✅ Memory function: memfd_create
>         ✅ AMTU (Abstract Machine Test Utility)
>         ✅ Ethernet drivers sanity
>         🚧 ✅ CIFS Connectathon
>         🚧 ✅ POSIX pjd-fstest suites
> 
>    x86_64:
>      Host 1:
>         ✅ Boot test
>         ✅ Storage SAN device stress - qedf driver
> 
>      Host 2:
>         ⏱  Boot test
>         ⏱  Storage SAN device stress - mpt3sas_gen1
> 
>      Host 3:
>         ✅ Boot test
>         ✅ xfstests - ext4
>         ✅ xfstests - xfs
>         💥 storage: software RAID testing
>         ⚡⚡⚡ stress: stress-ng
>         🚧 ⚡⚡⚡ xfstests - btrfs
>         🚧 ⚡⚡⚡ Storage blktests
> 
>      Host 4:
>         ✅ Boot test
>         ✅ Storage SAN device stress - lpfc driver
> 
>      Host 5:
>         ✅ Boot test
>         🚧 ✅ kdump - sysrq-c
> 
>      Host 6:
>         ✅ Boot test
>         ✅ ACPI table test
>         ✅ LTP
>         ✅ Loopdev Sanity
>         ✅ Memory function: memfd_create
>         ✅ AMTU (Abstract Machine Test Utility)
>         ✅ Ethernet drivers sanity
>         ✅ kernel-rt: rt_migrate_test
>         ✅ kernel-rt: rteval
>         ✅ kernel-rt: sched_deadline
>         ✅ kernel-rt: smidetect
>         ✅ storage: SCSI VPD
>         🚧 ✅ CIFS Connectathon
>         🚧 ✅ POSIX pjd-fstest suites
> 
>      Host 7:
>         ✅ Boot test
>         ✅ kdump - sysrq-c - megaraid_sas
> 
>      Host 8:
>         ✅ Boot test
>         ✅ Storage SAN device stress - qla2xxx driver
> 
>      Host 9:
>         ⏱  Boot test
>         ⏱  kdump - sysrq-c - mpt3sas_gen1
> 
>    Test sources: https://gitlab.com/cki-project/kernel-tests
>      💚 Pull requests are welcome for new tests or improvements to existing tests!
> 
> Aborted tests
> -------------
> Tests that didn't complete running successfully are marked with ⚡⚡⚡.
> If this was caused by an infrastructure issue, we try to mark that
> explicitly in the report.
> 
> Waived tests
> ------------
> If the test run included waived tests, they are marked with 🚧. Such tests are
> executed but their results are not taken into account. Tests are waived when
> their results are not reliable enough, e.g. when they're just introduced or are
> being fixed.
> 
> Testing timeout
> ---------------
> We aim to provide a report within reasonable timeframe. Tests that haven't
> finished running yet are marked with ⏱.
> 
> 

