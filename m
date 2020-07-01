Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1C0C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 16:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F19220842
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 16:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7pmYmt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbgGAQhi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:37:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24573 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731394AbgGAQhi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 12:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593621456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HC9mmo3XzSvYAlgqcTy8mrCukx3HmiZQjg/Amm+IIlo=;
        b=P7pmYmt1LHtad5jFjItP0pMqV3Dwdx1gaOEQNQKUIMa4rHqjJxVH2krqMh8F+8XOX8+kFo
        y2vHd7Ozd56TR4U3rTQJzahHYhfNFF8omgNXddOWE8dtR1AyZlVypNNTIsTBvTk2ObJvuo
        H0CasLx7CKapolZ9+0bKVRKtD5n4tUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-MqKKnYMUPw2HG_ZpL_x4zg-1; Wed, 01 Jul 2020 12:37:14 -0400
X-MC-Unique: MqKKnYMUPw2HG_ZpL_x4zg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 585DC804002;
        Wed,  1 Jul 2020 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-114-207.rdu2.redhat.com [10.10.114.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51D1079220;
        Wed,  1 Jul 2020 16:37:07 +0000 (UTC)
Subject: =?UTF-8?Q?Re=3a_=f0=9f=92=a5_PANICKED=3a_Test_report_for_kernel_5?=
 =?UTF-8?Q?=2e8=2e0-rc2-c698ae9=2ecki_=28block=29?=
To:     CKI Project <cki-project@redhat.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Xiong Zhou <xzhou@redhat.com>
References: <cki.6F69C04B6D.Z70BF8WNV2@redhat.com>
From:   Rachel Sibley <rasibley@redhat.com>
Message-ID: <8388a5c5-e5b9-e17b-1522-cf742bb23ad9@redhat.com>
Date:   Wed, 1 Jul 2020 12:37:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cki.6F69C04B6D.Z70BF8WNV2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, we're seeing multiple panics across all arches, I included a snippet of the call trace for both
xfstests and boot test.

You should be able to inspect in more detail by viewing the console.log under each build/tests directory:
https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/06/30/609250

Thanks,
Rachel

On 7/1/20 9:06 AM, CKI Project wrote:
> 
> Hello,
> 
> We ran automated tests on a recent commit from this kernel tree:
> 
>         Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>              Commit: c698ae90fb5e - Merge branch 'for-5.9/block' into for-next
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
>    https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/06/30/609250
> 
> One or more kernel tests failed:
> 
>      s390x:
>       ❌ Boot test
>       ❌ Boot test
>       ❌ Boot test
> 
>      ppc64le:
>       ❌ Boot test
>       ❌ Boot test
>       💥 xfstests - ext4

https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/06/30/609250/build_ppc64le_redhat%3A926155/tests/8501352/ppc64le_3_console.log

[  890.198174] run fstests generic/040 at 2020-06-30 12:03:02
[  891.055910] BUG: Unable to handle kernel instruction fetch (NULL pointer?)
[  891.055942] Faulting instruction address: 0x00000000
[  891.055956] Oops: Kernel access of bad area, sig: 11 [#1]
[  891.055969] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[  891.055982] Modules linked in: dm_flakey rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache rfkill joydev i40e at24 sunrpc ses 
enclosure scsi_transport_sas regmap_i2c ofpart powernv_flash mtd crct10dif_vpmsum ipmi_powernv ipmi_devintf opal_prd ipmi_msghandler rtc_opal i2c_opal 
ip_tables xfs libcrc32c ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea vmx_crypto sysfillrect sysimgblt crc32c_vpmsum fb_sys_fops 
drm_ttm_helper ttm drm i2c_core aacraid drm_panel_orientation_quirks
[  891.056077] CPU: 25 PID: 84211 Comm: systemd-udevd Kdump: loaded Not tainted 5.8.0-rc2-c698ae9.cki #1
[  891.056095] NIP:  0000000000000000 LR: c00000000070eef0 CTR: 0000000000000000
[  891.056110] REGS: c0000007c25474e0 TRAP: 0400   Not tainted  (5.8.0-rc2-c698ae9.cki)
[  891.056125] MSR:  9000000040009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24488248  XER: 20040000
[  891.056145] CFAR: c00000000070eeec IRQMASK: 0
[  891.056145] GPR00: c00000000070f050 c0000007c2547770 c000000001cb7f00 c0000002b6059af8
[  891.056145] GPR04: 0000000000000000 c0000007dcf6f000 c0000002b6059af8 0000000000000000
[  891.056145] GPR08: 00000007fc940000 c000000001c97d78 0000000000000000 0000000000000000
[  891.056145] GPR12: 0000000000000000 c0000007fffe2e00 c0000007c2344400 0000000000000000
[  891.056145] GPR16: 0000000000000000 00007fffc9b7cb50 c0000007c2344400 0000000000000000
[  891.056145] GPR20: c0000002b307bdd8 0000000000000000 c0000007c2547ca8 c0000007dcf6f000
[  891.056145] GPR24: 000000000000000c 000000000000000a c0000007c2547790 0000000000000001
[  891.056145] GPR28: 0000000000000000 0000000000000000 00000000ffffffff c0000002b6059af8
[  891.056260] NIP [0000000000000000] 0x0
[  891.056272] LR [c00000000070eef0] submit_bio_noacct+0x2f0/0x5c0
[  891.056285] Call Trace:
[  891.056294] [c0000007c2547770] [c00000000070f050] submit_bio_noacct+0x450/0x5c0 (unreliable)
[  891.056312] [c0000007c2547800] [c00000000070f228] submit_bio+0x68/0x2d0
[  891.056328] [c0000007c25478c0] [c000000000505fe8] mpage_readahead+0x1c8/0x290
[  891.056345] [c0000007c25479a0] [c0000000004fd6f8] blkdev_readahead+0x28/0x40
[  891.056362] [c0000007c25479c0] [c000000000383980] read_pages+0xb0/0x4a0
[  891.056376] [c0000007c2547a40] [c000000000384474] page_cache_readahead_unbounded+0x244/0x300
[  891.056395] [c0000007c2547b00] [c00000000037445c] generic_file_buffered_read+0x9bc/0x1120
[  891.056411] [c0000007c2547c50] [c0000000004fddc0] blkdev_read_iter+0x50/0x80
[  891.056428] [c0000007c2547c70] [c000000000493c64] new_sync_read+0x124/0x1a0
[  891.056443] [c0000007c2547d10] [c000000000496e30] vfs_read+0x100/0x200
[  891.056471] [c0000007c2547d70] [c000000000497368] ksys_read+0x78/0x130
[  891.056487] [c0000007c2547dc0] [c000000000030564] system_call_exception+0xe4/0x170
[  891.056504] [c0000007c2547e20] [c00000000000ca70] system_call_common+0xf0/0x278
[  891.056518] Instruction dump:
[  891.056529] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[  891.056545] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[  891.056564] ---[ end trace 14197a45ec121b51 ]---
> 
>      aarch64:
>       💥 Boot test
>       💥 xfstests - ext4
> 
>      x86_64:
>       💥 Boot test
>       💥 xfstests - ext4
>       💥 Boot test
>       💥 Boot test
>       💥 Boot test

https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/06/30/609250/build_x86_64_redhat%3A926153/tests/8501344/x86_64_6_console.log

[   12.160102] Call Trace:
[   12.162838]  submit_bio_noacct+0x1f4/0x3d0
[   12.167414]  mpage_readahead+0x159/0x1b0
[   12.171795]  ? __blkdev_direct_IO_simple+0x2b0/0x2b0
[   12.177337]  read_pages+0x5d/0x300
[   12.181132]  page_cache_readahead_unbounded+0x1aa/0x230
[   12.186965]  force_page_cache_readahead+0xda/0x140
[   12.192313]  generic_file_buffered_read+0x647/0xc00
[   12.197761]  new_sync_read+0x102/0x180
[   12.201946]  vfs_read+0x9d/0x150
[   12.205549]  ksys_read+0x4f/0xc0
[   12.209153]  do_syscall_64+0x4d/0x90
[   12.213145]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   12.218781] RIP: 0033:0x7f263ae70542
[   12.222767] Code: Bad RIP value.
[   12.226367] RSP: 002b:00007fff55c02f38 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   12.234817] RAX: ffffffffffffffda RBX: 0000557dff1219e8 RCX: 00007f263ae70542
[   12.242780] RDX: 0000000000000040 RSI: 0000557dff1219f8 RDI: 0000000000000006
[   12.250742] RBP: 0000557dff1170c0 R08: 0000557dff1219d0 R09: 00007f263af41a40
[   12.258705] R10: 0000000000000010 R11: 0000000000000246 R12: 00000003bfff0000
[   12.266668] R13: 0000000000000040 R14: 0000557dff1219d0 R15: 0000557dff117110
[   12.274631] Modules linked in: mgag200 drm_vram_helper drm_kms_helper lpfc drm_ttm_helper ttm crct10dif_pclmul crc32_pclmul crc32c_intel nvmet_fc 
drm nvmet ghash_clmulni_intel nvme_fc nvme_fabrics i2c_algo_bit nvme_core scsi_transport_fc wmi scsi_dh_alua scsi_dh_rdac scsi_dh_emc
[   12.302196] CR2: 0000000000000000
[   12.305931] ---[ end trace 4b2a7525c30bbc3f ]---

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
>        make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>      ppc64le:
>        make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>      s390x:
>        make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
>      x86_64:
>        make options: -j30 INSTALL_MOD_STRIP=1 targz-pkg
> 
> 
> 
> Hardware testing
> ----------------
> We booted each kernel and ran the following tests:
> 
>    aarch64:
>      Host 1:
>         ❌ Boot test
>         ⚡⚡⚡ LTP
>         ⚡⚡⚡ Loopdev Sanity
>         ⚡⚡⚡ Memory function: memfd_create
>         ⚡⚡⚡ AMTU (Abstract Machine Test Utility)
>         ⚡⚡⚡ Ethernet drivers sanity
>         ⚡⚡⚡ storage: SCSI VPD
>         🚧 ⚡⚡⚡ CIFS Connectathon
>         🚧 ⚡⚡⚡ POSIX pjd-fstest suites
> 
>      Host 2:
>         ✅ Boot test
>         💥 xfstests - ext4
>         ⚡⚡⚡ xfstests - xfs
>         ⚡⚡⚡ storage: software RAID testing
>         ⚡⚡⚡ stress: stress-ng
>         🚧 ⚡⚡⚡ Storage blktests
> 
>    ppc64le:
>      Host 1:
>         ❌ Boot test
>         🚧 ⚡⚡⚡ kdump - sysrq-c
> 
>      Host 2:
>         ❌ Boot test
>         ⚡⚡⚡ LTP
>         ⚡⚡⚡ Loopdev Sanity
>         ⚡⚡⚡ Memory function: memfd_create
>         ⚡⚡⚡ AMTU (Abstract Machine Test Utility)
>         ⚡⚡⚡ Ethernet drivers sanity
>         🚧 ⚡⚡⚡ CIFS Connectathon
>         🚧 ⚡⚡⚡ POSIX pjd-fstest suites
> 
>      Host 3:
>         ✅ Boot test
>         💥 xfstests - ext4
>         ⚡⚡⚡ xfstests - xfs
>         ⚡⚡⚡ storage: software RAID testing
>         🚧 ⚡⚡⚡ Storage blktests
> 
>    s390x:
>      Host 1:
>         ❌ Boot test
>         ⚡⚡⚡ LTP
>         ⚡⚡⚡ Loopdev Sanity
>         ⚡⚡⚡ Memory function: memfd_create
>         ⚡⚡⚡ Ethernet drivers sanity
>         🚧 ⚡⚡⚡ CIFS Connectathon
>         🚧 ⚡⚡⚡ POSIX pjd-fstest suites
> 
>      Host 2:
>         ❌ Boot test
>         ⚡⚡⚡ stress: stress-ng
>         🚧 ⚡⚡⚡ Storage blktests
> 
>      Host 3:
>         ❌ Boot test
>         🚧 ⚡⚡⚡ kdump - sysrq-c
> 
>    x86_64:
>      Host 1:
> 
>         ⚡ Internal infrastructure issues prevented one or more tests (marked
>         with ⚡⚡⚡) from running on this architecture.
>         This is not the fault of the kernel that was tested.
> 
>         ⚡⚡⚡ Boot test
>         🚧 ⚡⚡⚡ kdump - sysrq-c - mpt3sas_gen1
> 
>      Host 2:
>         💥 Boot test
>         ⚡⚡⚡ Storage SAN device stress - lpfc driver
> 
>      Host 3:
> 
>         ⚡ Internal infrastructure issues prevented one or more tests (marked
>         with ⚡⚡⚡) from running on this architecture.
>         This is not the fault of the kernel that was tested.
> 
>         ⚡⚡⚡ Boot test
>         🚧 ⚡⚡⚡ kdump - sysrq-c
> 
>      Host 4:
>         ✅ Boot test
>         💥 xfstests - ext4
>         ⚡⚡⚡ xfstests - xfs
>         ⚡⚡⚡ storage: software RAID testing
>         ⚡⚡⚡ stress: stress-ng
>         🚧 ⚡⚡⚡ Storage blktests
> 
>      Host 5:
> 
>         ⚡ Internal infrastructure issues prevented one or more tests (marked
>         with ⚡⚡⚡) from running on this architecture.
>         This is not the fault of the kernel that was tested.
> 
>         ⚡⚡⚡ Boot test
>         ⚡⚡⚡ kdump - sysrq-c - megaraid_sas
> 
>      Host 6:
>         💥 Boot test
>         ⚡⚡⚡ LTP
>         ⚡⚡⚡ Loopdev Sanity
>         ⚡⚡⚡ Memory function: memfd_create
>         ⚡⚡⚡ AMTU (Abstract Machine Test Utility)
>         ⚡⚡⚡ Ethernet drivers sanity
>         ⚡⚡⚡ storage: SCSI VPD
>         🚧 ⚡⚡⚡ CIFS Connectathon
>         🚧 ⚡⚡⚡ POSIX pjd-fstest suites
> 
>      Host 7:
>         💥 Boot test
>         ⚡⚡⚡ Storage SAN device stress - qla2xxx driver
> 
>      Host 8:
>         💥 Boot test
>         ⚡⚡⚡ Storage SAN device stress - qedf driver
> 
>      Host 9:
>         ⏱  Boot test
>         ⏱  Storage SAN device stress - mpt3sas_gen1
> 
>    Test sources: https://github.com/CKI-project/tests-beaker
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

