Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036EFC77B72
	for <linux-block@archiver.kernel.org>; Fri, 14 Apr 2023 15:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNPFK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Apr 2023 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNPFK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2023 11:05:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4A92136
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681484660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=P2n3Dg/504CTsFv4j3fFC68/gVUlJ8C3s+EH+N39aso=;
        b=cCuPwMoM0i+HyWwqXPrNQCqmG6sa7//4f9++CPG2x0gxJs+LomQeERMi6Ix4YFnGM8Rj4W
        7Ujivurtsl8FWOs/wj1TPnWDLDNElVVo3PJ7hWHgJNnjWg5SGaCKEmtCqDxZuHSyh4TEBC
        +bQiT5o2Hzf5Rn3oiP9ZhwguuW9VSoI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-ff8dgFdOPK-LxA7cDOh5-w-1; Fri, 14 Apr 2023 11:04:19 -0400
X-MC-Unique: ff8dgFdOPK-LxA7cDOh5-w-1
Received: by mail-pg1-f200.google.com with SMTP id l65-20020a639144000000b005091ec4f2d4so8009458pge.20
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 08:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681484658; x=1684076658;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2n3Dg/504CTsFv4j3fFC68/gVUlJ8C3s+EH+N39aso=;
        b=Rx7iVvDg1j1g4gZ5VLr3J1cej/E/JJJygBsznaqECmsyR8k+etEioQdXZ1Mzs9p6cE
         VQCMGm7z6jht3t1XgO/GEZkRB4X/p9HP9fmzZqCIRoRTyEfgXe5hx4un90YCNP/+maXF
         SZkt/+BTVDOyMMXMGKLzv3Yc/eIaCdEdETXu9LiWuiilS1ukdDnalgvIPYSAsru+c5vT
         3O+tDjoJKzsdv39qnwEBOfl+fLSUWjCOhjBEzSWSMCVZGyMQbxO0LxHByhYLNxvlRy9P
         ARIif3K9lkUASSlXIau3M3n3P4i9gFdJRYcaU1pqZBVSzhDr3PHLgvU5DP1LxFsXUlZU
         +3EQ==
X-Gm-Message-State: AAQBX9e0dqONoP7EFFcUgceCTl5MhHtkE4fi4de+kXA+IVSwqLKTsOj+
        0Xa3zme6JSpsFAekgdnk2dq88JdnNBm4coYLruhgu0oTNHiFLiXnhhyfkjaa127HkFmwMFPaMqH
        d9uR3jS/nMHqoOG3s/NHbc0Vna9I62uBiHVF9FbzloyWlZToCLbx4qVk=
X-Received: by 2002:a63:fb45:0:b0:50c:bde:50c7 with SMTP id w5-20020a63fb45000000b0050c0bde50c7mr802099pgj.12.1681484657698;
        Fri, 14 Apr 2023 08:04:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y/Qvm3eXYhQuHGWzC29MZmXJ8Mf4izJB+JX/ZshJ2jLmjMt9h63L8LhtUnXzfK0VEzo6Gg6frbMA5nMppU57U=
X-Received: by 2002:a63:fb45:0:b0:50c:bde:50c7 with SMTP id
 w5-20020a63fb45000000b0050c0bde50c7mr802093pgj.12.1681484657236; Fri, 14 Apr
 2023 08:04:17 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 14 Apr 2023 23:04:05 +0800
Message-ID: <CAHj4cs9-PhuUM0ztSnCuryKkOa+tX-RGP+M=zX-UoCE5f9E6FA@mail.gmail.com>
Subject: [bug report] general protection fault at kyber_bio_merge+0x123/0x300
To:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello

Bellow panic triggered during nvme disks queue/nr_request update with
fio background, pls help check it and let me know if you need any
info/test, thanks.

commit: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=7001edb72462d95482c98739e6f51f536b000587

(gdb) l *(kyber_bio_merge+0x123)
0xffffffff820a8723 is in kyber_bio_merge (block/kyber-iosched.c:573).
568 unsigned int nr_segs)
569 {
570 struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
571 struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
572 struct kyber_hctx_data *khd = hctx->sched_data;
573 struct kyber_ctx_queue *kcq = &khd->kcqs[ctx->index_hw[hctx->type]];
574 unsigned int sched_domain = kyber_sched_domain(bio->bi_opf);
575 struct list_head *rq_list = &kcq->rq_list[sched_domain];
576 bool merged;
577

[ 8490.041684] general protection fault, probably for non-canonical
address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN NOPTI
[ 8490.053084] KASAN: null-ptr-deref in range
[0x0000000000000090-0x0000000000000097]
[ 8490.060656] CPU: 14 PID: 57468 Comm: fio Not tainted 6.3.0-rc5+ #2
[ 8490.066845] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS
2.9.3 08/05/2022
[ 8490.074419] RIP: 0010:kyber_bio_merge+0x123/0x300
[ 8490.079142] Code: 80 3c 01 00 0f 85 e8 01 00 00 4c 8b a5 50 01 00
00 48 b8 00 00 00 00 00 fc ff df 49 8d bc 24 90 00 00 00 48 89 f9 48
c1 e9 03 <80> 3c 01 00 0f 85 80 01 00 00 48 8d bd 9c 01 00 00 4d 8b a4
24 90
[ 8490.097896] RSP: 0018:ffffc900077ef668 EFLAGS: 00010216
[ 8490.103131] RAX: dffffc0000000000 RBX: ffffe8ffff6c7f00 RCX: 0000000000000012
[ 8490.110271] RDX: 0000000000000001 RSI: ffffc900077efa30 RDI: 0000000000000090
[ 8490.117411] RBP: ffff8881b0055000 R08: 0000000000000000 R09: ffff888235885e8f
[ 8490.124544] R10: ffffed1046b10bd1 R11: 0000000000000001 R12: 0000000000000000
[ 8490.131677] R13: ffffc900077efa30 R14: 0000000000008801 R15: 0000000000000002
[ 8490.138810] FS:  00007f1efa834640(0000) GS:ffff8887a1000000(0000)
knlGS:0000000000000000
[ 8490.146895] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8490.152640] CR2: 000055b13696c008 CR3: 000000012354e000 CR4: 0000000000350ee0
[ 8490.159771] Call Trace:
[ 8490.162225]  <TASK>
[ 8490.164332]  blk_mq_submit_bio+0x214/0x1600
[ 8490.168526]  ? __pfx___lock_release+0x10/0x10
[ 8490.172886]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[ 8490.177506]  ? iov_iter_extract_pages+0x229/0xca0
[ 8490.182210]  ? ktime_get+0x14e/0x180
[ 8490.185787]  ? lockdep_hardirqs_on+0x79/0x100
[ 8490.190150]  submit_bio_noacct_nocheck+0x51a/0x6a0
[ 8490.194950]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[ 8490.200262]  ? blk_partition_remap+0x2de/0x390
[ 8490.204710]  ? submit_bio_noacct+0x331/0x15f0
[ 8490.209070]  submit_bio_wait+0xfe/0x200
[ 8490.212908]  ? __pfx_submit_bio_wait+0x10/0x10
[ 8490.217356]  ? bio_iov_iter_get_pages+0x9e/0x250
[ 8490.221972]  ? bio_init+0x317/0x580
[ 8490.225466]  __blkdev_direct_IO_simple+0x3ef/0x710
[ 8490.230259]  ? __pfx___blkdev_direct_IO_simple+0x10/0x10
[ 8490.235570]  ? filemap_get_read_batch+0x3b0/0x6a0
[ 8490.240275]  ? __pfx___filemap_fdatawrite_range+0x10/0x10
[ 8490.245674]  ? __pfx_submit_bio_wait_endio+0x10/0x10
[ 8490.250646]  generic_file_direct_write+0x1d4/0x4b0
[ 8490.255443]  __generic_file_write_iter+0x165/0x420
[ 8490.260237]  blkdev_write_iter+0x358/0x7e0
[ 8490.264335]  ? __pfx_blkdev_write_iter+0x10/0x10
[ 8490.268955]  ? selinux_file_permission+0x356/0x440
[ 8490.273757]  vfs_write+0x802/0xc60
[ 8490.277170]  ? __pfx_vfs_write+0x10/0x10
[ 8490.281096]  ? __fget_files+0x1b8/0x3f0
[ 8490.284938]  __x64_sys_pwrite64+0x1a0/0x1f0
[ 8490.289128]  ? __pfx___x64_sys_pwrite64+0x10/0x10
[ 8490.293833]  ? ktime_get_coarse_real_ts64+0x130/0x170
[ 8490.298888]  do_syscall_64+0x5c/0x90
[ 8490.302465]  ? lockdep_hardirqs_on+0x79/0x100
[ 8490.306823]  ? do_syscall_64+0x69/0x90
[ 8490.310576]  ? do_syscall_64+0x69/0x90
[ 8490.314331]  ? lockdep_hardirqs_on+0x79/0x100
[ 8490.318688]  ? do_syscall_64+0x69/0x90
[ 8490.322442]  ? asm_common_interrupt+0x22/0x40
[ 8490.326800]  ? lockdep_hardirqs_on+0x79/0x100
[ 8490.331160]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 8490.336213] RIP: 0033:0x7f1f0cd3cc0f
[ 8490.339793] Code: 08 89 3c 24 48 89 4c 24 18 e8 fd ef f5 ff 4c 8b
54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 12 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 4d f0 f5 ff
48 8b
[ 8490.358538] RSP: 002b:00007f1efa833b60 EFLAGS: 00000293 ORIG_RAX:
0000000000000012
[ 8490.366103] RAX: ffffffffffffffda RBX: 00007f1eac000bc0 RCX: 00007f1f0cd3cc0f
[ 8490.373233] RDX: 0000000000001400 RSI: 00007f1eac001000 RDI: 000000000000001c
[ 8490.380366] RBP: 00007f1eac000bc0 R08: 0000000000000000 R09: 0000000000006802
[ 8490.387501] R10: 00000002080b4000 R11: 0000000000000293 R12: 00007f1f04349a70
[ 8490.394632] R13: 0000000000000001 R14: 0000000000001400 R15: 00007f1f0438e198
[ 8490.401772]  </TASK>
[ 8490.403967] Modules linked in: tls sunrpc vfat fat dm_multipath
intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd
ledtrig_audio rfkill video dell_smbios dcdbas kvm mgag200 ipmi_ssif
i2c_algo_bit dell_wmi_descriptor wmi_bmof irqbypass drm_shmem_helper
rapl pcspkr drm_kms_helper syscopyarea sysfillrect sysimgblt acpi_ipmi
ptdma i2c_piix4 k10temp ipmi_si ipmi_devintf ipmi_msghandler
acpi_power_meter acpi_cpufreq drm fuse xfs libcrc32c sd_mod sg
crct10dif_pclmul crc32_pclmul crc32c_intel nvme ghash_clmulni_intel
ahci libahci mpt3sas nvme_core tg3 libata nvme_common ccp raid_class
t10_pi scsi_transport_sas wmi sp5100_tco dm_mirror dm_region_hash
dm_log dm_mod
[ 8490.463207] general protection fault, probably for non-canonical
address 0xdffffc0000000012: 0000 [#2] PREEMPT SMP KASAN NOPTI
[ 8490.463385] ---[ end trace 0000000000000000 ]---


--
Best Regards,
  Yi Zhang

