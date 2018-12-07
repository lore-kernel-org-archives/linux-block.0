Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AB3C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76712082D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 18:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76712082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLGSsf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:48:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeLGSsf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 13:48:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9EF481E05;
        Fri,  7 Dec 2018 18:48:34 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3A5F60851;
        Fri,  7 Dec 2018 18:48:33 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCHSET v5] Support for polled aio
References: <20181204233729.26776-1-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 07 Dec 2018 13:48:33 -0500
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk> (Jens Axboe's message of
        "Tue, 4 Dec 2018 16:37:03 -0700")
Message-ID: <x49muphrx4u.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 07 Dec 2018 18:48:34 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Jens,

Jens Axboe <axboe@kernel.dk> writes:

> You can also find the patches in my aio-poll branch:
>
> http://git.kernel.dk/cgit/linux-block/log/?h=aio-poll
>
> or by cloning:
>
> git://git.kernel.dk/linux-block aio-poll

I made an xfs file system on a partition of an nvme device.  I created a
1 GB file on that file system, and then ran the test program you
provided.  It immediately spewed the following:

[  139.533754] BUG: Bad page state in process aio-ring  pfn:5f394f2
[  139.539763] page:ffffde6a3ce53c80 count:-38 mapcount:1 mapping:0000000000000000 index:0x1
[  139.547942] flags: 0x57ffffc0000000()
[  139.551607] raw: 0057ffffc0000000 dead000000000100 dead000000000200 0000000000000000
[  139.559346] raw: 0000000000000001 0000000000000000 ffffffda00000000 0000000000000000
[  139.567085] page dumped because: nonzero _refcount
[  139.571876] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 tun bridge stp llc devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod intel_rapl skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm irqbypass vfat fat ipmi_ssif crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore intel_rapl_perf iTCO_wdt iTCO_vendor_support ipmi_si mei_me pcspkr ipmi_devintf dax_pmem sg i2c_i801 lpc_ich mei device_dax ipmi_msghandler ioatdma wmi acpi_pad acpi_power_meter dca ip_tables xfs libcrc32c nd_pmem nd_btt sd_mod sr_mod cdrom ast i2c_algo_bit drm_kms_helper syscopyarea crc32c_intel sysfillrect sysimgblt i40e fb_sys_fops ttm drm nvme ahci nvme_core libahci libata nfit libnvdimm
[  139.649936] CPU: 46 PID: 13137 Comm: aio-ring Not tainted 4.20.0-rc5+ #1
[  139.656635] Hardware name: Intel Corporation ...
[  139.667062] Call Trace:
[  139.669522]  dump_stack+0x46/0x5b
[  139.672845]  bad_page+0xf5/0x10f
[  139.676080]  free_pcppages_bulk+0x588/0x5d0
[  139.680271]  free_unref_page_list+0xfc/0x170
[  139.684545]  release_pages+0x103/0x4a0
[  139.688293]  __pagevec_release+0x2b/0x30
[  139.692223]  invalidate_inode_pages2_range+0x3ea/0x560
[  139.697360]  ? pagevec_lookup_range_tag+0x24/0x30
[  139.702068]  ? __filemap_fdatawait_range+0x87/0x150
[  139.706951]  iomap_dio_rw+0x1de/0x3b0
[  139.710622]  ? current_time+0x4f/0x90
[  139.714288]  ? atime_needs_update+0x6c/0xd0
[  139.718474]  ? down_read+0xe/0x30
[  139.721821]  xfs_file_dio_aio_read+0x65/0xe0 [xfs]
[  139.726633]  xfs_file_read_iter+0xba/0xd0 [xfs]
[  139.731172]  aio_read+0x13e/0x1b0
[  139.734499]  ? iomap_dio_complete+0x98/0x150
[  139.738778]  ? put_aio_ring_file.isra.26+0x70/0x70
[  139.743568]  ? iomap_dio_complete_work+0x17/0x30
[  139.748188]  ? iomap_dio_bio_end_io+0x160/0x180
[  139.752720]  ? kmem_cache_alloc+0x170/0x1c0
[  139.756907]  __io_submit_one+0x3e0/0xa10
[  139.760832]  aio_ring_submit+0xcf/0x1a0
[  139.764675]  ? do_page_fault+0x2d/0x120
[  139.768512]  ? aio_iopoll_getevents+0x1cf/0x220
[  139.773042]  __x64_sys_io_ring_enter+0xf8/0x160
[  139.777578]  do_syscall_64+0x55/0x1a0
[  139.781243]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  139.786294] RIP: 0033:0x7f3ea04511c9
[  139.789873] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 dc 2c 00 f7 d8 64 89 01 48
[  139.808620] RSP: 002b:00007f3ea0357e28 EFLAGS: 00000246 ORIG_RAX: 0000000000000150
[  139.816185] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f3ea04511c9
[  139.823317] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00007f3ea0d63000
[  139.830448] RBP: 0000000000000000 R08: 0000000300000000 R09: 0000000300000000
[  139.837581] R10: 0000000000000003 R11: 0000000000000246 R12: 00000000025ea080
[  139.844714] R13: 00000000025ea000 R14: 0000000000602120 R15: 0000000000000001
[  139.851848] Disabling lock debugging due to kernel taint

Followed by this:

[  163.724474] watchdog: BUG: soft lockup - CPU#46 stuck for 22s! [aio-ring:13137]
[  163.731786] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 tun bridge stp llc devlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod intel_rapl skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm irqbypass vfat fat ipmi_ssif crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate intel_uncore intel_rapl_perf iTCO_wdt iTCO_vendor_support ipmi_si mei_me pcspkr ipmi_devintf dax_pmem sg i2c_i801 lpc_ich mei device_dax ipmi_msghandler ioatdma wmi acpi_pad acpi_power_meter dca ip_tables xfs libcrc32c nd_pmem nd_btt sd_mod sr_mod cdrom ast i2c_algo_bit drm_kms_helper syscopyarea crc32c_intel sysfillrect sysimgblt i40e fb_sys_fops ttm drm nvme ahci nvme_core libahci libata nfit libnvdimm
[  163.809847] CPU: 46 PID: 13137 Comm: aio-ring Tainted: G    B             4.20.0-rc5+ #1
[  163.817931] Hardware name: Intel Corporation ...
[  163.828358] RIP: 0010:nvme_poll+0x7/0x1d0 [nvme]
[  163.832975] Code: 4c 89 d7 e8 2b cb f8 d1 49 89 c2 e9 4d ff ff ff 8b 73 24 e9 77 ff ff ff 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 <41> 56 41 55 41 54 55 53 48 8b 9f c8 00 00 00 0f b7 43 78 0f b6 53
[  163.851718] RSP: 0018:ffffa89d4872bdc0 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
[  163.859287] RAX: ffffffffc0479640 RBX: ffff8f03f85d9e00 RCX: 00000000ffffffff
[  163.866420] RDX: ffff8f03f50fec00 RSI: 00000000000f0210 RDI: ffff8f52f790d800
[  163.873550] RBP: 0000000000000001 R08: 00000000ffffffff R09: ffff8f52f1f0a580
[  163.880682] R10: 0000000000000200 R11: 0000000000000001 R12: 0000000000000000
[  163.887817] R13: ffff8f03f85d9e00 R14: ffff8f03e8bb5ee0 R15: ffff8f52f790d800
[  163.894948] FS:  00007f3ea0358700(0000) GS:ffff8f52ff580000(0000) knlGS:0000000000000000
[  163.903035] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.908779] CR2: 00007f3ea0d63000 CR3: 0000005f2a070006 CR4: 00000000007606e0
[  163.915913] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  163.923044] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  163.930178] PKRU: 55555554
[  163.932888] Call Trace:
[  163.935347]  blk_poll+0x268/0x360
[  163.938678]  aio_iopoll_getevents+0x174/0x220
[  163.943037]  __aio_iopoll_check+0x4a/0x70
[  163.947053]  __x64_sys_io_ring_enter+0x121/0x160
[  163.951673]  do_syscall_64+0x55/0x1a0
[  163.955350]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  163.960405] RIP: 0033:0x7f3ea04511c9
[  163.963985] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 dc 2c 00 f7 d8 64 89 01 48
[  163.982728] RSP: 002b:00007f3ea0357e28 EFLAGS: 00000246 ORIG_RAX: 0000000000000150
[  163.990298] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f3ea04511c9
[  163.997429] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00007f3ea0d63000
[  164.004562] RBP: 0000000000000001 R08: 0000000300000000 R09: 0000000300000000
[  164.011693] R10: 0000000000000003 R11: 0000000000000246 R12: 00000000025ea040
[  164.018828] R13: 00000000025ea000 R14: 0000000000602120 R15: 0000000000000001

and the process is unkillable and eating ~100% cpu.

Let me know if you need any more info.

-Jeff
