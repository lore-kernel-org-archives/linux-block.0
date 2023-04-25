Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C6FC77B61
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 03:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjDYDQt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 23:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjDYDQq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 23:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B91A8
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 20:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682392564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yWs1OP/+uwU20bEy43deFdnOxzky0mI62coGr5xwJ/U=;
        b=HMzVZXMqBiummQjPv38GlNGMabklivwZmsqoCWL24BtBMJYRFoFSF02ycQbdK7S3+wGoWd
        LcybOFXsCK48AgHFAVP+Qz8weVHciWz9vdpdvO94msBiKFEPkaiz4nbZGvKvIV70h5nN8v
        DFhy57P5dfUu7RhrXz0xOOrPOJ/iiMs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-zR2gJBvbM4ax1h4YTqP9Rw-1; Mon, 24 Apr 2023 23:16:02 -0400
X-MC-Unique: zR2gJBvbM4ax1h4YTqP9Rw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-505149e1a4eso12630012a12.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 20:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682392561; x=1684984561;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWs1OP/+uwU20bEy43deFdnOxzky0mI62coGr5xwJ/U=;
        b=jtSRXAVGMBpbVh7WUPVpHMLsaFubfx9tJy4jsFbaL+lRxWrLO0B+iyfQqVEc6rdlnS
         aA4B5WPlGIYu4vrKX7TdCR5BrKfMlzYZHx35N9QXYSkQ7eSaVo+ee6KZD02GD8Z1/sZd
         E0B74sQDqwSYAOqfzj7uP8q+JL9WGQQ0QfquMyrTcGdCWdISCS/umITnUTuA5oGQjm/x
         NA2IA1tVK13nPQo2jfEIbacZ0MpMy+NPRuup/h89qjA5CwByITPBMXRndbjUmnFpwg7i
         PeprTW1FzZzbf0TAQF86fagMy/0JD/a8Hnol5CJOQQdV/0Kr+I4RSiUUbMK+ejLETElD
         BCbw==
X-Gm-Message-State: AAQBX9dufM2ap4eaFtkInGSk3SF6k16Wu6L4khz9s1z9wOAJD+jm1Qrm
        K2AQYyyfXos15bbko7EDNv4JpepKYz0CJlFyEaos6E1eVkDI0Wd8u9hoLfR1vWjuyBgkmxefY4o
        a5aKC/n96cfbLqRumnwwEjfzZ5AVe5oO3NDfzqVsgr11cW9H9ZysD
X-Received: by 2002:aa7:cc12:0:b0:4fc:d331:515 with SMTP id q18-20020aa7cc12000000b004fcd3310515mr13856725edt.5.1682392560961;
        Mon, 24 Apr 2023 20:16:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350YexVwaYaB8MuTvAq/gAtnI9VjMk5iWE4p9Oxr7/23dKJx5z0O3EogzNQGlgpnn3N+vWooh0UrS3uVG8Zedw4s=
X-Received: by 2002:aa7:cc12:0:b0:4fc:d331:515 with SMTP id
 q18-20020aa7cc12000000b004fcd3310515mr13856715edt.5.1682392560648; Mon, 24
 Apr 2023 20:16:00 -0700 (PDT)
MIME-Version: 1.0
From:   Changhui Zhong <czhong@redhat.com>
Date:   Tue, 25 Apr 2023 11:15:49 +0800
Message-ID: <CAGVVp+Xk025Sv-GJDRKcnhaQe0e2TonDK9zwGhWxX2KWd017+g@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 7 PID: 4059 at fs/proc/generic.c:718 remove_proc_entry+0x192/0x1a0
To:     linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Below issue was triggered in blktests/001 test,please help check it.
branch: for-6.4/block
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

[  304.049316] ------------[ cut here ]------------
[  304.050033] remove_proc_entry: removing non-empty directory
'scsi/scsi_debug', leaking at least '12'
[  304.050569] WARNING: CPU: 7 PID: 4059 at fs/proc/generic.c:718
remove_proc_entry+0x192/0x1a0
[  304.051434] Modules linked in: scsi_debug(-) sr_mod cdrom tls
rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache
netfs rfkill sunrpc vfat fat dm_multipath intel_rapl_msr
intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel iTCO_wdt kvm ipmi_ssif iTCO_vendor_support mgag200
irqbypass rapl i2c_algo_bit drm_shmem_helper intel_cstate
drm_kms_helper intel_uncore acpi_ipmi pcspkr i2c_i801 hpilo sysc
nvme_common wmi t10_pi dm_mirror dm_region_hash dm_log dm_mod
[  304.554164] CPU: 7 PID: 4059 Comm: modprobe Kdump: loaded Not
tainted 6.3.0-rc2+ #1
[  304.554913] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360
Gen9, BIOS P89 05/21/2018
[  304.555367] RIP: 0010:remove_proc_entry+0x192/0x1a0
[  304.555980] Code: c7 48 08 99 a3 48 85 c0 48 8d 90 78 ff ff ff 48
0f 45 c2 48 8b 55 78 4c 8b 80 a0 00 00 00 48 8b 92 a0 00 00 00 e8 ae
41 c3 ff <0f> 0b e9 43 ff ff ff e8 82 84 77 00 66 90 90 90 90 90 90 90
90 90
[  304.557349] RSP: 0018:ffffbf48c10e3cb8 EFLAGS: 00010286
[  304.557637] RAX: 0000000000000000 RBX: ffff97d6010db000 RCX: 0000000000000027
[  304.558372] RDX: ffff97d96fbdf848 RSI: 0000000000000001 RDI: ffff97d96fbdf840
[  304.559132] RBP: ffff97d60e0c5540 R08: 0000000000000000 R09: 00000000ffff7fff
[  304.559923] R10: ffffbf48c10e3b58 R11: ffffffffa3fe65a8 R12: ffff97d60e0c55c0
[  304.560696] R13: 0000000000000000 R14: 0000000000000080 R15: 0000000000000000
[  304.561453] FS:  00007fd886f41740(0000) GS:ffff97d96fbc0000(0000)
knlGS:0000000000000000
[  304.561863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  304.562565] CR2: 0000560f888dcf50 CR3: 000000010a292002 CR4: 00000000001706e0
[  304.563341] Call Trace:
[  304.563483]  <TASK>
[  304.563968]  scsi_proc_hostdir_rm+0x76/0xc0
[  304.564186]  scsi_host_dev_release+0x37/0xe0
[  304.564816]  device_release[  305.065325]  device_unregister+0x13/0x60
[  305.065593]  sdebug_do_remove_host+0xd1/0x100 [scsi_debug]
[  305.066010]  scsi_debug_exit+0x1d/0x410 [scsi_debug]
[  305.066318]  __do_sys_delete_module.constprop.0+0x17a/0x2f0
[  305.066610]  ? __call_rcu_common.constprop.0+0x114/0x2c0
[  305.066907]  ? syscall_trace_enter.constprop.0+0x126/0x1a0
[  305.067177]  do_syscall_64+0x5c/0x90
[  305.067451]  ? exit_to_user_mode_prepare+0xb6/0x100
[  305.068084]  ? syscall_exit_to_user_mode+0x12/0x30
[  305.068769]  ? do_syscall_64+0x69/0x90
[  305.069002]  ? do_syscall_64+0x69/0x90
[  305.069196]  ? do_syscall_64+0x69/0x90
[  305.069424]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  305.069679] RIP: 0033:0x7fd88663f5ab
[  305.069872] Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89
01 48
[  305.071130] RSP: 002b:00007ffd1d293e48 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[  305.071939] RAX: ffffffffffffffda RBX: 000055b2d5e0bd50 RCX: 00007fd88663f5ab
[  305.072728] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055b2d5e0bdb8
[  305.073496] RBP: 000055b2d5e0bd50 R08: 0000000000000000 R09: 0000000000000000
[  305.074254] R10: 00007fd88679eac0 R11: 0000000000000206 R12: 000055b2d5e0bdb8
[  305.075016] R13: 0000000000000000 R14: 000055b2d5e0bdb8 R15: 00007ffd1d296178
[  305.075803]  </TASK>
[  305.075950] ---[ end trace 0000000000000000 ]---

 --
Best Regards,
Changhui Zhong

