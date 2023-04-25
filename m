Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8707BC7618E
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 02:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDYCiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 22:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDYCiK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 22:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C5A65A4
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 19:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682390241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=TA7qEXO/96lb68i7eAKDjsi2N6zzLvJ2qvsi8iBjwB8=;
        b=WphO6n960e5ooYREwzqX4xI1Nz2I4kguXksdHBQ5HQ6WiQ64FHm79lWUQFD0Un8uFzpzq5
        O7iRyRogdysVTyRPwAyqmp9ydX3A8PeatYuuDOhOgSh4/+vceFDII7Ejc8wJIwrICVU7N9
        1qJrUjO8a/anLUm7KKZTfY6WdxBww18=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-GKeVFD4KNpO5pze7q2b_NQ-1; Mon, 24 Apr 2023 22:37:19 -0400
X-MC-Unique: GKeVFD4KNpO5pze7q2b_NQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a341efd9aso576466466b.0
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 19:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682390237; x=1684982237;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TA7qEXO/96lb68i7eAKDjsi2N6zzLvJ2qvsi8iBjwB8=;
        b=LO/jdRjw+BNK3uYQwAYlM/9bK1SyOux7SkMASbFx7qxtvupUAfyRVCaeuriBuM01FT
         LCqtR3RyHlgeDQ9UFZ9IkzURKTXrFHUaXZKu9PNAGyGKpfELz0sJwjA84kJK+etb8YOm
         LCAQh5Ib1QFBilouG/zaqAPEMbPvP52nDGw0dj/2Zm/bBla5KIgLdnTC0PxyD915hW7e
         TaAO8wpj/Bgx57dRfrf/ZVBNN4WtvrjNCf5Y4YAPyBJi58VNDU1MxMc2gasRiXQwyj5t
         jqLygoGXeaUUfEMQwKc3bcYEwrRa2fvRti9Oa10WAhRD1PFv5xpog58P+WSG/Wg7lzaY
         PNaQ==
X-Gm-Message-State: AAQBX9eV61bugNWSGXieP8roFSFqpKbwRhX60G1MmUmKQdXet/Kea6mo
        fUVBIMm7NVYYNar4kJGdy03AoGBwmOCj1Tm/d6stOHXiAAOpZxjEF2AlmSaJSHJgRbPkos0hkM/
        t0UlY0hpVINE9O+b6/mHg1K/BkWcKFlsY79fiNmhDTyxUa+zuIPqv
X-Received: by 2002:a17:906:cc5b:b0:94e:c43f:316b with SMTP id mm27-20020a170906cc5b00b0094ec43f316bmr11626338ejb.19.1682390237662;
        Mon, 24 Apr 2023 19:37:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350b9PcvjJJb89Byeyh5qKM83g3fUtfPCA8fxIA14hcnNEfDSFed56EVOQqWj7EGUPA/KHXV7CDrnDkVnG5plHgA=
X-Received: by 2002:a17:906:cc5b:b0:94e:c43f:316b with SMTP id
 mm27-20020a170906cc5b00b0094ec43f316bmr11626328ejb.19.1682390237221; Mon, 24
 Apr 2023 19:37:17 -0700 (PDT)
MIME-Version: 1.0
From:   Changhui Zhong <czhong@redhat.com>
Date:   Tue, 25 Apr 2023 10:37:05 +0800
Message-ID: <CAGVVp+XSpFsjfzSNxLiK9SFnLvLB-W7bPHk7tySkkX95BM5BoQ@mail.gmail.com>
Subject: [bug report] BUG: kernel NULL pointer dereference, address: 00000000000000fc
To:     linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Below issue was triggered in my test,it caused system panic ,please
help check it.
branch: for-6.4/block
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
sgdisk -n 0:0:+100MiB /dev/md0
cat /proc/partitions
mdadm -S /dev/md0
mdadm -A /dev/md0 /dev/sda /dev/sdb
cat /proc/partitions


[   34.219123] BUG: kernel NULL pointer dereference, address: 00000000000000fc
[   34.219507] #PF: supervisor read access in kernel mode
[   34.219784] #PF: error_code(0x0000) - not-present page
[   34.220039] PGD 0 P4D 0
[   34.220176] Oops: 0000 [#1] PREEMPT SMP PTI
[   34.220374] CPU: 8 PID: 1956 Comm: systemd-udevd Kdump: loaded Not
tainted 6.3.0-rc2+ #1
[   34.220787] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
Gen9, BIOS P89 05/21/2018
[   34.221188] RIP: 0010:blk_mq_sched_bio_merge+0x6d/0xf0
[   34.221491] Code: 55 10 89 c0 49 8b 6c 24 38 48 03 2c c5 00 4b c4
8f b8 02 00 00 00 f7 c2 00 00 80 00 75 07 31 c0 84 d2 0f 94 c0 48 8b
54 c5 50 <0f> b7 82 fc 00 00 00 f6 82 a8 00 00 00 01 74 53 48 c1 e0 04
4c 8d
[   34.222801] RSP: 0018:ffffbf5542f8f960 EFLAGS: 00010246
[   34.223076] RAX: 0000000000000001 RBX: ffff9ac4a2a7be70 RCX: 0000000000004000
[   34.223799] RDX: 0000000000000000 RSI: ffff9ac4a03b4d80 RDI: ffff9ac4a2a7be70
[   34.224538] RBP: ffff9ac7efc00000 R08: 0000000000001000 R09: ffff9ac4830a6cd0
[   34.225306] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9ac4a2a7be70
[   34.226477] R13: ffff9ac4a03b4d80 R14: 0000000000000001 R15: 00000000000063f0
[   34.227244] FS:  00007f9266a35540(0000) GS:ffff9ac7efc00000(0000)
knlGS:0000000000000000
[   34.227695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.228396] CR2: 00000000000000fc CR3: 0000000117e8a004 CR4: 00000000001706e0
[   34.229173] Call Trace:
[   34.229330]  <TASK>
[   34.229824]  blk_mq_submit_bio+0xdd/0x460
[   34.230034]  submit_bio_noacct_nocheck+0x124/0x1f0
[   34.230667]  mpage_readahead+0xe4/0x120
[   34.230885]  ? __pfx_blkdev_get_block+0x10/0x10
[   34.231503]  read_pages+0x5b/0x220
[   34.232073]  page_cache_ra_unbounded+0x137/0x180
[   34.232702]  force_page_cache_ra+0xc5/0xf0
[   34.232918]  filemap_get_pages+0xf9/0x360
[   34.233124]  ? path_init+0x3b6/0x400
[   34.233328]  filemap_read+0xc5/0x320
[   34.233603]  ? filename_lookup+0xcf/0x1d0
[   34.233806]  ? avc_has_perm+0x48/0xd0
[   34.261+0xaf/0x170
[   34.334144]  vfs_read+0x204/0x2d0
[   34.334715]  ksys_read+0x5f/0xe0
[   34.335281]  do_syscall_64+0x5c/0x90
[   34.335528]  ? blkdev_llseek+0x4c/0x60
[   34.335757]  ? syscall_exit_work+0x103/0x130
[   34.336467]  ? syscall_exit_to_user_mode+0x12/0x30
[   34.337118]  ? do_syscall_64+0x69/0x90
[   34.337326]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   34.337589] RIP: 0033:0x7f9266d3eaf2
[   34.337795] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ca 0c 08 00 e8 65
ea 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75
10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
54 24
[   34.339088] RSP: 002b:00007fff48f06508 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[   34.339875] RAX: ffffffffffffffda RBX: 00005614ca035af8 RCX: 00007f9266d3eaf2
[   34.340619] RDX: 0000000000000040 RSI: 00005614ca035b08 RDI: 000000000000000d
[   34.341355] RBP: 00005614c9fae4d0 R08: 0000000000000000 R09: 0000000000000000
[   34.342129] R10: 0000000000000008 R11: 0000000000000246 R12:
000000000solver nfs lockd grace fscache netfs rfkill sunrpc
intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
intel_powerclamp coretemp vfat kvm_intel fat kvm irqbypass ipmi_ssif
iTCO_wdt iTCO_vendor_support mgag200 rapl i2c_algo_bit intel_cstate
drm_shmem_helper i2c_i801 intel_uncore pcspkr drm_kms_helper i2c_smbus
syscopyarea sysfillrect lpc_ich sysimgblt hpilo acpi_ipmi ioatdma dca
ipmi_si ipmi_devintf ipmi_msghandler acpi_tad acpi_power_meter drm
fuse xfs libcrc32c sd_mod sg crct10dif_pclmul ahci crc32_pclmul nvme
libahci crc32c_intel ghash_clmulni_intel libata nvme_core tg3 hpwdt
nvme_common hpsa t10_pi wmi scsi_transport_sas dm_mirror
dm_region_hash dm_log dm_mod
[   34.846155] CR2: 00000000000000fc

--
Best Regards,
Changhui Zhong

