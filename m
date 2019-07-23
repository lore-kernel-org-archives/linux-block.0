Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA424C76190
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA452239D
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfGWCQp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:16:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfGWCQp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 22:16:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AE7C30821A0;
        Tue, 23 Jul 2019 02:16:44 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D49319C7F;
        Tue, 23 Jul 2019 02:16:44 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4FE4D1800206;
        Tue, 23 Jul 2019 02:16:44 +0000 (UTC)
Date:   Mon, 22 Jul 2019 22:16:43 -0400 (EDT)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     bvanassche@acm.org, Ming Lei <tom.leiming@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Message-ID: <106171790.2354723.1563848203959.JavaMail.zimbra@redhat.com>
In-Reply-To: <CACVXFVNRi-R2StL-evMODp=ZGSjb1QOmv0s7dieDqOwz0FLXhA@mail.gmail.com>
References: <1008069208.2174989.1563813991726.JavaMail.zimbra@redhat.com> <1106410976.2184883.1563817165884.JavaMail.zimbra@redhat.com> <CACVXFVNRi-R2StL-evMODp=ZGSjb1QOmv0s7dieDqOwz0FLXhA@mail.gmail.com>
Subject: Re: regression: block/001 lead kernel NULL pointer from v5.3-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.68.5.41, 10.4.195.6]
Thread-Topic: regression: block/001 lead kernel NULL pointer from v5.3-rc1
Thread-Index: HwCvxGQerH1RRku2sLuDpmDSxOVzKw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 23 Jul 2019 02:16:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming/Bart
I just tried the patch and the issue was fixed, thanks for the info.

Best Regards,
  Yi Zhang


----- Original Message -----
From: "Ming Lei" <tom.leiming@gmail.com>
To: "Yi Zhang" <yi.zhang@redhat.com>, "Linux SCSI List" <linux-scsi@vger.kernel.org>
Cc: "linux-block" <linux-block@vger.kernel.org>
Sent: Tuesday, July 23, 2019 9:34:48 AM
Subject: Re: regression: block/001 lead kernel NULL pointer from v5.3-rc1

On Tue, Jul 23, 2019 at 6:31 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> With step[1], this kernel NULL pointer[2] can be triggered every time from v5.3-rc1, let me know if you need more info, thanks.
>
> [1] from blktests block/001
> #modprobe scsi-debug add_host=4 num_tgts=1 ptype=0
>
> [2]
> [14628.973272] run blktests block/001 at 2019-07-22 12:45:10
> [14629.017215] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [14629.018326] scsi host13: scsi_debug: version 0188 [20190125]
> [14629.018326]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [14629.024988] #PF: supervisor read access in kernel mode
> [14629.024990] #PF: error_code(0x0000) - not-present page
> [14629.024991] PGD 0 P4D 0
> [14629.024994] Oops: 0000 [#1] SMP PTI
> [14629.024999] CPU: 6 PID: 699 Comm: kworker/u25:9 Not tainted 5.3.0-rc1 #1
> [14629.038771] scsi host14: scsi_debug: version 0188 [20190125]
> [14629.038771]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [14629.044118] Hardware name: Dell Inc. PowerEdge R730xd/ɲ�Pow, BIOS 2.9.1 12/04/2018
> [14629.044124] Workqueue: events_unbound async_run_entry_fn
> [14629.044131] RIP: 0010:dma_direct_max_mapping_size+0x2b/0x64
> [14629.044134] Code: 1f 44 00 00 55 53 48 89 fb e8 51 13 00 00 84 c0 75 0a 48 c7 c0 ff ff ff ff 5b 5d c3 48 8b 83 28 02 00 00 48 8b ab 38 02 00 00 <48> 8b 00 48 85 c0 74 0c 48 85 ed 74 27 48 39 c5 48 0f 47 e8 48 89
> [14629.119071] RSP: 0018:ffffa98482453c40 EFLAGS: 00010202
> [14629.124899] RAX: 0000000000000000 RBX: ffff8cc96d9d1018 RCX: 0000000000000000
> [14629.132860] RDX: ffff8cc96d594080 RSI: 0000000000000800 RDI: ffff8cc96d9d1018
> [14629.140821] RBP: 0000000000000000 R08: ffff8cc977aef0e0 R09: ffff8cc805c072c0
> [14629.148782] R10: 0000000000030400 R11: ffff8cc973398a00 R12: ffff8cc96d9d1018
> [14629.156743] R13: 00000000ffffffff R14: ffff8ccb74b42428 R15: 0000000000000000
> [14629.164705] FS:  0000000000000000(0000) GS:ffff8cc977ac0000(0000) knlGS:0000000000000000
> [14629.173734] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14629.180142] CR2: 0000000000000000 CR3: 000000010740a006 CR4: 00000000001606e0
> [14629.188103] Call Trace:
> [14629.190836]  __scsi_init_queue+0x75/0x140
> [14629.195309]  scsi_mq_alloc_queue+0x3a/0x50
> [14629.199877]  scsi_alloc_sdev+0x1d1/0x290
> [14629.204253]  scsi_probe_and_add_lun+0x487/0xe20
> [14629.209311]  ? mutex_lock+0xe/0x30
> [14629.213115]  ? ata_tdev_release+0x10/0x10 [libata]
> [14629.218462]  ? attribute_container_add_device+0x55/0x120
> [14629.224389]  __scsi_scan_target+0xec/0x5b0
> [14629.228960]  ? __switch_to_asm+0x40/0x70
> [14629.233335]  ? __switch_to_asm+0x34/0x70
> [14629.237710]  ? __switch_to_asm+0x40/0x70
> [14629.242085]  ? __switch_to_asm+0x40/0x70
> [14629.246460]  ? __switch_to_asm+0x34/0x70
> [14629.250836]  scsi_scan_channel+0x5a/0x80
> [14629.255212]  scsi_scan_host_selected+0xdb/0x110
> [14629.260267]  do_scan_async+0x17/0x150
> [14629.264352]  async_run_entry_fn+0x39/0x160
> [14629.268923]  process_one_work+0x1a1/0x360
> [14629.273394]  worker_thread+0x30/0x380
> [14629.277477]  ? process_one_work+0x360/0x360
> [14629.282143]  kthread+0x10c/0x130
> [14629.285741]  ? kthread_create_on_node+0x60/0x60
> [14629.290795]  ret_from_fork+0x35/0x40
> [14629.294783] Modules linked in: scsi_debug sunrpc intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel mgag200 drm_vram_helper i2c_algo_bit kvm ttm irqbypass drm_kms_helper crct10dif_pclmul syscopyarea sysfillrect sysimgblt fb_sys_fops iTCO_wdt crc32_pclmul iTCO_vendor_support drm ghash_clmulni_intel dcdbas intel_cstate mxm_wmi intel_uncore pcspkr intel_rapl_perf lpc_ich ipmi_ssif mei_me sg mei ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter vfat fat xfs libcrc32c sd_mod ahci nvme libahci crc32c_intel nvme_core libata tg3 megaraid_sas wmi dm_mirror dm_region_hash dm_log dm_mod
> [14629.356675] CR2: 0000000000000000
> [14629.360381] ---[ end trace 96df6c036b903d89 ]---

It is one SCSI regression, and Christoph has posted one fix:

https://marc.info/?t=156378727800002&r=1&w=2


Thanks,
Ming Lei
