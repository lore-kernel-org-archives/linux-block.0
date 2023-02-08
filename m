Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448F5C636CC
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 05:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBHF6C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 00:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBHF6B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 00:58:01 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2221457C2
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 21:57:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VbAFffs_1675835864;
Received: from 30.97.56.244(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VbAFffs_1675835864)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 13:57:44 +0800
Message-ID: <fcd7fec3-d8f0-f04b-f7eb-10e2d583bfe6@linux.alibaba.com>
Date:   Wed, 8 Feb 2023 13:57:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] block: ublk: improve handling device deletion
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20230207150700.545530-1-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230207150700.545530-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/2/7 23:07, Ming Lei wrote:
> Inside ublk_ctrl_del_dev(), when the device is removed, we wait
> until the device number is freed with holding global lock of
> ublk_ctl_mutex, this way isn't friendly from user viewpoint:
> 
> 1) if device is in-use, the current delete command hangs in
> ublk_ctrl_del_dev(), and user can't break from the handling
> because wait_event() is used
> 
> 2) global lock is held, so any new device can't be added and
> other old devices can't be removed.
> 
> Improve the deleting handling by the following way, suggested by
> Nadav:
> 
> 1) wait without holding the global lock
> 
> 2) replace wait_event() with wait_event_interruptible()
> 
> Reported-by: Nadav Amit <nadav.amit@gmail.com>
> Suggested-by: Nadav Amit <nadav.amit@gmail.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hi Ming,

I tried this patch. And the folloing NPE bug was trigged by:

(0) dd if=/dev/zero of=/root/img bs=4096 count=1024768
(1) ublk add -t loop -f /root/img
(2) mkdir -p /root/ublk
(3) mount /dev/ublkb0 /root/ublk
(4) echo "hello" > /root/ublk
(5) ./ublk del -n 0

So I delete the ublk device while it is mounting as
an ext4 filesystem. I think ublk should handle this
by (1) returning -EBUSY or (2) blocking incoming IO.

[  119.115252] EXT4-fs (ublkb0): recovery complete
[  119.115379] EXT4-fs (ublkb0): mounted filesystem c12f15a9-6cb3-44b4-ae39-cbb91e8fd7b8 with ordered data mode. Quota mode: none.
[  144.400128] BUG: kernel NULL pointer dereference, address: 0000000000000038
[  144.400189] #PF: supervisor read access in kernel mode
[  144.400228] #PF: error_code(0x0000) - not-present page
[  144.400266] PGD 105abc067 P4D 105abc067 PUD 1c331b067 PMD 0 
[  144.400312] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  144.400348] CPU: 24 PID: 2388 Comm: node Kdump: loaded Tainted: G            E      6.2.0-rc6+ #2
[  144.400412] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 9e9f1cc 04/01/2014
[  144.400469] RIP: 0010:bio_associate_blkg_from_css+0xe2/0x320
[  144.400515] Code: 03 75 65 65 48 ff 00 e8 dc 44 b9 ff e8 d7 44 b9 ff eb 3e 48 8b 45 08 48 8b 80 48 03 00 00 48 8b 98 a0 02 00 00 e8 be f3 b8 ff <48> 8b 43 38 a8 03 0f 85 0b 02 00 00 65 48 ff 00 e8 a9 44 b9 ff 48
[  144.400643] RSP: 0018:ffffb819c1f7f9f0 EFLAGS: 00010202
[  144.400682] RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000c00
[  144.400734] RDX: ffff95b54bf0df40 RSI: ffffffffb0186a80 RDI: ffff95b511fc3800
[  144.400785] RBP: ffff95b511fc3800 R08: ffff95b511fc3800 R09: 0000000000003000
[  144.400837] R10: ffff95f2fffd5000 R11: 0000000000038e80 R12: 0000000000000000
[  144.400889] R13: 0000000000000c00 R14: ffff95b9027a7080 R15: ffffffffb0186038
[  144.400941] FS:  00007f3f789f8640(0000) GS:ffff95f203400000(0000) knlGS:0000000000000000
[  144.400999] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  144.401042] CR2: 0000000000000038 CR3: 00000001f84be004 CR4: 00000000007706e0
[  144.401094] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  144.401146] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  144.401198] PKRU: 55555554
[  144.401220] Call Trace:
[  144.401241]  <TASK>
[  144.401262]  bio_associate_blkg+0x2c/0x60
[  144.401294]  bio_alloc_bioset+0x17f/0x560
[  144.401327]  ? __getblk_gfp+0xbf/0xd0
[  144.401357]  submit_bh_wbc+0x9b/0x130
[  144.401396]  ext4_read_bh_lock+0x3d/0x60
[  144.401430]  ext4_bread_batch+0xee/0x170
[  144.401466]  __ext4_find_entry+0x147/0x3e0
[  144.401499]  ? d_alloc+0x87/0xa0
[  144.401527]  ? preempt_count_add+0x51/0xa0
[  144.401563]  ext4_lookup.part.0+0x48/0x1a0
[  144.401596]  __lookup_slow+0x72/0x120
[  144.401627]  walk_component+0xe5/0x160
[  144.401657]  path_lookupat+0x6e/0x1c0
[  144.401687]  filename_lookup+0xc0/0x1b0
[  144.401718]  ? schedule+0x6b/0xe0
[  144.401747]  ? futex_wait_queue+0x64/0x90
[  144.401781]  vfs_statx+0x7d/0x150
[  144.401809]  do_statx+0x31/0x60
[  144.401836]  ? __check_object_size.part.0+0x47/0xd0
[  144.401873]  ? strncpy_from_user+0x52/0x150
[  144.402059]  ? getname_flags.part.0+0x48/0x1b0
[  144.402226]  __x64_sys_statx+0x68/0x90
[  144.402387]  do_syscall_64+0x3c/0x90
[  144.402553]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  144.402717] RIP: 0033:0x7f3f7c23ee5d
[  144.402868] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[  144.403253] RSP: 002b:00007f3f789f7b78 EFLAGS: 00000246 ORIG_RAX: 000000000000014c
[  144.403445] RAX: ffffffffffffffda RBX: 00000000061f6a68 RCX: 00007f3f7c23ee5d
[  144.403633] RDX: 0000000000000100 RSI: 00000000060aba90 RDI: 00000000ffffff9c
[  144.403815] RBP: 00007f3f789f7b80 R08: 00007f3f789f7b90 R09: 00007f3f789f7ca0
[  144.403996] R10: 0000000000000fff R11: 0000000000000246 R12: 00007f3f789f8548
[  144.404174] R13: 00000000061f6b48 R14: 00007f3f7c29f550 R15: 00000000061f6b48
[  144.404349]  </TASK>
[  144.404496] Modules linked in: ublk_drv(E) tcp_diag(E) inet_diag(E) rfkill(E) mousedev(E) intel_rapl_msr(E) intel_rapl_common(E) nfit(E) intel_powerclamp(E) rapl(E) psmouse(E) i2c_piix4(E) virtio_console(E) virtio_balloon(E) pcspkr(E) fuse(E) ip_tables(E) xfs(E) libcrc32c(E) cirrus(E) drm_shmem_helper(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) ghash_clmulni_intel(E) virtio_net(E) drm(E) net_failover(E) serio_raw(E) failover(E) i2c_core(E)
[  144.405467] CR2: 0000000000000038

