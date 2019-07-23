Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05FCC7618F
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 01:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CE121BF6
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 01:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suzT5I7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfGWBfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:35:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39421 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfGWBfE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 21:35:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so26601323wmc.4;
        Mon, 22 Jul 2019 18:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WDu0Q8Zy8I4SEFXkF+YRrQxIcJj8+3bJ/5jw4b+5LR0=;
        b=suzT5I7vPT53q+kLNhpLlUqQ4Zrwexr1DejYvpoUaRo/FyDYt/W5z0FON8br3ezrET
         1zqfZWdBPL1/rpScSeBrJhRFwUwBaRh0riGDv0SP3zrZY5AkT8yr2LjjD0OKXzMR03Mp
         mb10ofho+8WtFW2yYQxH6uPKIc1tzPbhT7lJqrpuvvVxdSSKLOBJS/D0CYnzbyb3Sp/W
         9yqxkyX1GfDH39tiIvuk/ljQIjFnh8QVVjljBmlMMJUw6MdwApXKPxRIXOuGLMTHIWMb
         oFpw4aB8JUF2hLt/qnsZRbfumFQ7Lx6TJ43ydSyjTfTvM+ZG4gcowp+ClHARwweMzmKt
         QeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WDu0Q8Zy8I4SEFXkF+YRrQxIcJj8+3bJ/5jw4b+5LR0=;
        b=g1xMTIcQESpG8EGOmdRTKO8Pj8btTIViduNZpYCvqEscdxd2Mkh6c2abdrQa37ax6p
         rqxQ7ECHGuixcztRmf/5ugTDpPtQIs4K3oKeRRjUclsVCmCHlMSiw/d7iYruEs8zLKhy
         lcX5sEXgG4zhtkcAG4gtcSW6o/S1UZsBWiNaoze2esowPFKwtvURqyh2s5Jd+NtYZw75
         nMjJ7BzdcwkgWghvHkiB1GWuzfCpU2aLor2/ujejL4atE/am9QCHwDDE4TvAlsFLnHzO
         zLFoSsYwkcGSWAx7zFQEykLv3FxOD73AbHJdMOG3mzZ5n2pZzc05ekynSNDGLlLsKNIe
         2QRQ==
X-Gm-Message-State: APjAAAUYrJQo9atY3Tn/Lj13GrUdGaHIImxjuhBdljfb9SqOb1j3ml53
        gR2wXSJk6H/QOHtOK2HoapSgTgGoxENMdMoyzT8=
X-Google-Smtp-Source: APXvYqxwIe/b+TCMotDDjpN2XkdyXL0fSfbRlXj5vizLluu7MBk/b4YS9wECMXtSOuyvocpjjEHnUYWxqdclyIt3nPE=
X-Received: by 2002:a1c:a985:: with SMTP id s127mr64473129wme.163.1563845701599;
 Mon, 22 Jul 2019 18:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <1008069208.2174989.1563813991726.JavaMail.zimbra@redhat.com> <1106410976.2184883.1563817165884.JavaMail.zimbra@redhat.com>
In-Reply-To: <1106410976.2184883.1563817165884.JavaMail.zimbra@redhat.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 23 Jul 2019 09:34:48 +0800
Message-ID: <CACVXFVNRi-R2StL-evMODp=ZGSjb1QOmv0s7dieDqOwz0FLXhA@mail.gmail.com>
Subject: Re: regression: block/001 lead kernel NULL pointer from v5.3-rc1
To:     Yi Zhang <yi.zhang@redhat.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 23, 2019 at 6:31 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> With step[1], this kernel NULL pointer[2] can be triggered every time fro=
m v5.3-rc1, let me know if you need more info, thanks.
>
> [1] from blktests block/001
> #modprobe scsi-debug add_host=3D4 num_tgts=3D1 ptype=3D0
>
> [2]
> [14628.973272] run blktests block/001 at 2019-07-22 12:45:10
> [14629.017215] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [14629.018326] scsi host13: scsi_debug: version 0188 [20190125]
> [14629.018326]   dev_size_mb=3D8, opts=3D0x0, submit_queues=3D1, statisti=
cs=3D0
> [14629.024988] #PF: supervisor read access in kernel mode
> [14629.024990] #PF: error_code(0x0000) - not-present page
> [14629.024991] PGD 0 P4D 0
> [14629.024994] Oops: 0000 [#1] SMP PTI
> [14629.024999] CPU: 6 PID: 699 Comm: kworker/u25:9 Not tainted 5.3.0-rc1 =
#1
> [14629.038771] scsi host14: scsi_debug: version 0188 [20190125]
> [14629.038771]   dev_size_mb=3D8, opts=3D0x0, submit_queues=3D1, statisti=
cs=3D0
> [14629.044118] Hardware name: Dell Inc. PowerEdge R730xd/=C9=B2=EF=BF=BDP=
ow, BIOS 2.9.1 12/04/2018
> [14629.044124] Workqueue: events_unbound async_run_entry_fn
> [14629.044131] RIP: 0010:dma_direct_max_mapping_size+0x2b/0x64
> [14629.044134] Code: 1f 44 00 00 55 53 48 89 fb e8 51 13 00 00 84 c0 75 0=
a 48 c7 c0 ff ff ff ff 5b 5d c3 48 8b 83 28 02 00 00 48 8b ab 38 02 00 00 <=
48> 8b 00 48 85 c0 74 0c 48 85 ed 74 27 48 39 c5 48 0f 47 e8 48 89
> [14629.119071] RSP: 0018:ffffa98482453c40 EFLAGS: 00010202
> [14629.124899] RAX: 0000000000000000 RBX: ffff8cc96d9d1018 RCX: 000000000=
0000000
> [14629.132860] RDX: ffff8cc96d594080 RSI: 0000000000000800 RDI: ffff8cc96=
d9d1018
> [14629.140821] RBP: 0000000000000000 R08: ffff8cc977aef0e0 R09: ffff8cc80=
5c072c0
> [14629.148782] R10: 0000000000030400 R11: ffff8cc973398a00 R12: ffff8cc96=
d9d1018
> [14629.156743] R13: 00000000ffffffff R14: ffff8ccb74b42428 R15: 000000000=
0000000
> [14629.164705] FS:  0000000000000000(0000) GS:ffff8cc977ac0000(0000) knlG=
S:0000000000000000
> [14629.173734] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [14629.180142] CR2: 0000000000000000 CR3: 000000010740a006 CR4: 000000000=
01606e0
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
> [14629.294783] Modules linked in: scsi_debug sunrpc intel_rapl_msr intel_=
rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_inte=
l mgag200 drm_vram_helper i2c_algo_bit kvm ttm irqbypass drm_kms_helper crc=
t10dif_pclmul syscopyarea sysfillrect sysimgblt fb_sys_fops iTCO_wdt crc32_=
pclmul iTCO_vendor_support drm ghash_clmulni_intel dcdbas intel_cstate mxm_=
wmi intel_uncore pcspkr intel_rapl_perf lpc_ich ipmi_ssif mei_me sg mei ipm=
i_si ipmi_devintf ipmi_msghandler acpi_power_meter vfat fat xfs libcrc32c s=
d_mod ahci nvme libahci crc32c_intel nvme_core libata tg3 megaraid_sas wmi =
dm_mirror dm_region_hash dm_log dm_mod
> [14629.356675] CR2: 0000000000000000
> [14629.360381] ---[ end trace 96df6c036b903d89 ]---

It is one SCSI regression, and Christoph has posted one fix:

https://marc.info/?t=3D156378727800002&r=3D1&w=3D2


Thanks,
Ming Lei
