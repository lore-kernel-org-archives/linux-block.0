Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2A3C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 07:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53952208A3
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 07:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsS7gyYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53952208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLDHP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:15:29 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:35881 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLDHP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 02:15:29 -0500
Received: by mail-vs1-f48.google.com with SMTP id v205so9195153vsc.3
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 23:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=reG+bPwQoAN5uaMlFUioHa0nFGJOCxZYVur9n7izWPQ=;
        b=KsS7gyYHKe7dErDAsnibsBlEkv1JMjf5O2a5b2NNPPvxwwpm91XgN5Xy/0VWkqYx9W
         pVKLBb6xwlzlrcYejC1gKk5grt5setWs+GdKR6pps39oXDizDqzVxmJYVQGwWmetNNtc
         kMXfC+Q2WcsSyx+zd3Dhu1iptkXzW2sbXy8zFLGH90FAzjqLwTArJaCIZzDqejFefwP1
         U3h2Te8vv0Jo7jRAAzy1omb+WIpVdW7ip2zPAcAd4t9Wmu5/EuTYWngPnfobhTUgNjLl
         q5CilinidVuMJTWSEbuApnHH3tt+ZPk6mj+0RLha/ASPgHc9sqFX3HqW1vFLwjs1JzJA
         eEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=reG+bPwQoAN5uaMlFUioHa0nFGJOCxZYVur9n7izWPQ=;
        b=F7lXeaF7qXnbEmBi3WQb15RQK7tW9JbpybHcol7htixdBCm2KQFq9S3gtsWjhHjO2D
         UC2NZwbYpffx+aVfBeIHmzpasiMSDzYW+kxFWfu1+xGSvBRT2YPn14f/xFo2NN9z88g+
         Kw87mEeZYWDXG3pI5ClESRZM4kl96KuYYMzGsPonpa2d9r3enDZtf9qnquzC1+vluMyS
         KB+EV0+h+FdCJA8DU9Tgw5KmnIlqtmE7W6RhJpa86eo37NrI61FUhvxz4vRH2OqQG0wP
         hrt6L5FEhGrHV7n5FUMBkTfNuG8f9QJo1Taei8D2Qa1O1qloFCkLVfY7PzCjaOxUlkk1
         352A==
X-Gm-Message-State: AA+aEWYsJsCJA26aumdUxc+c5evUOxkJ4jWW/U84ihzxA6J3VCPAJadZ
        0WBfcnrwdtfbG7L+4XuLiIKLssVySLwk5EeY0qsVwbpm
X-Google-Smtp-Source: AFSGD/UhHlEp2UQQI0S9YAicoPhlUgJLBksDwTU7EzpgQvAaScISFAoeiBi+mdpTQXoTBeLBDRLUwRsXKrIFnnDCcy8=
X-Received: by 2002:a67:8a81:: with SMTP id m123mr8476216vsd.206.1543907727961;
 Mon, 03 Dec 2018 23:15:27 -0800 (PST)
MIME-Version: 1.0
From:   Andrei Vagin <avagin@gmail.com>
Date:   Mon, 3 Dec 2018 23:15:16 -0800
Message-ID: <CANaxB-z7XRAjNUiwyjj_6Mot7y7QymXqvToV-mQc6KHY+c31Xg@mail.gmail.com>
Subject: linux-next: BUG: KASAN: use-after-free in bt_iter+0x29b/0x310
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Cyrill Gorcunov <gorcunov@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We run CRIU tests on linux-next. Today we found this bug in a kernel log:

https://travis-ci.org/avagin/linux/jobs/462912976

[    2.516900] random: fast init done
[    2.591491] sd 0:0:1:0: [sda] 146800640 512-byte logical blocks:
(75.2 GB/70.0 GiB)
[    2.591688] sd 0:0:1:0: Attached scsi generic sg0 type 0
[    2.591703] sd 0:0:1:0: [sda] 4096-byte physical blocks
[    2.592085] sd 0:0:1:0: [sda] Write Protect is off
[    2.592245] sd 0:0:1:0: [sda] Mode Sense: 1f 00 00 08
[    2.592390] sd 0:0:1:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    2.597534] ==================================================================
[    2.597694] BUG: KASAN: use-after-free in bt_iter+0x29b/0x310
[    2.597813] Read of size 8 at addr ffff8881d44a1780 by task kworker/u4:0/7
[    2.597929]
[    2.598042] CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted
4.20.0-rc5-next-20181203+ #1
[    2.598170] Hardware name: Google Google Compute Engine/Google
Compute Engine, BIOS Google 01/01/2011
[    2.598308] Workqueue: events_unbound async_run_entry_fn
[    2.598424] Call Trace:
[    2.598549]  dump_stack+0x5b/0x8b
[    2.598666]  print_address_description+0x6a/0x270
[    2.598796]  ? bt_iter+0x29b/0x310
[    2.598910]  kasan_report+0x133/0x1ae
[    2.599024]  ? bt_iter+0x29b/0x310
[    2.599152]  ? bt_iter+0x29b/0x310
[    2.599285]  bt_iter+0x29b/0x310
[    2.599402]  blk_mq_queue_tag_busy_iter+0x481/0x8f0
[    2.599525]  ? blk_mq_stop_hw_queues+0x100/0x100
[    2.599644]  ? blk_mq_put_tag+0x150/0x150
[    2.599760]  ? do_raw_spin_unlock+0x54/0x220
[    2.599879]  ? blk_mq_stop_hw_queues+0x100/0x100
[    2.599998]  ? __sbitmap_get_word+0x2a/0x80
[    2.600116]  blk_mq_in_flight+0xd2/0x130
[    2.600232]  ? blk_mq_end_request+0x430/0x430
[    2.600353]  ? blk_account_io_start+0x602/0x760
[    2.600469]  ? find_held_lock+0x32/0x1c0
[    2.600597]  part_round_stats+0x11c/0x690
[    2.600715]  ? blk_get_request+0xa0/0xa0
[    2.600831]  ? lock_acquire+0xfe/0x290
[    2.600949]  blk_account_io_start+0x404/0x760
[    2.601065]  ? kvm_clock_get_cycles+0xd/0x10
[    2.601180]  ? ktime_get+0x9c/0x120
[    2.601323]  ? blk_account_io_done+0x750/0x750
[    2.601439]  ? blk_mq_get_request+0xd54/0x1720
[    2.601562]  ? dd_request_merge+0x220/0x220
[    2.601681]  blk_mq_make_request+0x825/0xf70
[    2.601808]  ? blk_mq_try_issue_directly+0x130/0x130
[    2.601925]  ? generic_make_request_checks+0xa89/0x18f0
[    2.602042]  ? blk_cleanup_queue+0x1b0/0x1b0
[    2.602158]  ? blk_dump_rq_flags+0x3b0/0x3b0
[    2.602277]  ? kthread+0x2e9/0x3a0
[    2.602392]  ? kasan_unpoison_shadow+0x35/0x40
[    2.602512]  ? kasan_kmalloc+0xa5/0xd0
[    2.602629]  generic_make_request+0x541/0xd60
[    2.602746]  ? mempool_alloc+0xf7/0x2c0
[    2.602862]  ? blk_queue_enter+0x840/0x840
[    2.602981]  ? guard_bio_eod+0x151/0x4c0
[    2.603096]  ? find_held_lock+0x32/0x1c0
[    2.603234]  ? submit_bio+0x142/0x3f0
[    2.603354]  submit_bio+0x142/0x3f0
[    2.603469]  ? lock_downgrade+0x5d0/0x5d0
[    2.603589]  ? lock_acquire+0xfe/0x290
[    2.603704]  ? generic_make_request+0xd60/0xd60
[    2.603821]  ? bvec_alloc+0x270/0x270
[    2.603937]  ? guard_bio_eod+0x169/0x4c0
[    2.604055]  submit_bh_wbc+0x4d0/0x710
[    2.604172]  ? _raw_spin_unlock+0x24/0x30
[    2.604291]  block_read_full_page+0x3e6/0x830
[    2.604408]  ? I_BDEV+0x10/0x10
[    2.604527]  ? __bread_gfp+0x1f0/0x1f0
[    2.604653]  ? add_to_page_cache_lru+0x112/0x1c0
[    2.604770]  ? add_to_page_cache_locked+0x10/0x10
[    2.604892]  ? alloc_pages_current+0xb3/0x2b0
[    2.605009]  do_read_cache_page+0x658/0x10f0
[    2.605127]  ? blkdev_writepages+0x10/0x10
[    2.605243]  ? pagecache_get_page+0x6a0/0x6a0
[    2.605361]  ? __device_add_disk+0xc9e/0xf40
[    2.605476]  ? sd_probe_async+0x42d/0x720
[    2.605596]  ? async_run_entry_fn+0xc3/0x5d0
[    2.605711]  ? process_one_work+0x96c/0x16c0
[    2.605828]  ? worker_thread+0x87/0xe80
[    2.605941]  ? kthread+0x2e9/0x3a0
[    2.606054]  ? ret_from_fork+0x35/0x40
[    2.606171]  ? __save_stack_trace+0x5e/0x100
[    2.606291]  ? deref_stack_reg+0xad/0xe0
[    2.606406]  ? __read_once_size_nocheck.constprop.6+0x10/0x10
[    2.606533]  ? depot_save_stack+0x2d9/0x460
[    2.606650]  ? fs_reclaim_release.part.90+0x5/0x20
[    2.606766]  ? find_held_lock+0x32/0x1c0
[    2.606885]  read_dev_sector+0xbb/0x380
[    2.607002]  read_lba+0x34d/0x620
[    2.607118]  ? ultrix_partition+0x7a0/0x7a0
[    2.607233]  ? kasan_unpoison_shadow+0x35/0x40
[    2.607354]  efi_partition+0x2f2/0x1690
[    2.607468]  ? get_page_from_freelist+0x7dc/0x4120
[    2.607595]  ? vzalloc+0x8c/0xb0
[    2.607708]  ? check_partition+0xe6/0x680
[    2.607826]  ? is_gpt_valid.part.5+0xd80/0xd80
[    2.607941]  ? get_page_from_freelist+0x70e/0x4120
[    2.608062]  ? string+0x14c/0x220
[    2.608178]  ? string+0x14c/0x220
[    2.608296]  ? format_decode+0x3be/0x760
[    2.608417]  ? memcpy+0x39/0x50
[    2.608536]  ? vsnprintf+0x204/0x10e0
[    2.608652]  ? pointer+0x610/0x610
[    2.608772]  ? add_part+0x2c0/0x2c0
[    2.608887]  ? vsprintf+0x10/0x10
[    2.609004]  ? is_gpt_valid.part.5+0xd80/0xd80
[    2.609120]  ? check_partition+0x2de/0x680
[    2.609234]  check_partition+0x2de/0x680
[    2.609354]  rescan_partitions+0x187/0x890
[    2.609469]  ? lock_downgrade+0x5d0/0x5d0
[    2.609591]  ? up_write+0x1d/0x150
[    2.609705]  ? bd_set_size+0x253/0x2e0
[    2.609833]  __blkdev_get+0x7bc/0x1100
[    2.609952]  ? bd_may_claim+0xc0/0xc0
[    2.610068]  ? bdget+0x385/0x450
[    2.610199]  blkdev_get+0x281/0x850
[    2.610318]  ? __blkdev_get+0x1100/0x1100
[    2.610436]  ? do_raw_spin_unlock+0x54/0x220
[    2.610561]  ? _raw_spin_unlock+0x24/0x30
[    2.610678]  ? bdget+0x385/0x450
[    2.610795]  __device_add_disk+0xc9e/0xf40
[    2.610913]  ? sd_probe_async+0x41c/0x720
[    2.611029]  ? blk_alloc_devt+0x250/0x250
[    2.611153]  ? lock_downgrade+0x5d0/0x5d0
[    2.611283]  ? rpm_idle+0x26/0x6a0
[    2.611402]  sd_probe_async+0x42d/0x720
[    2.611525]  async_run_entry_fn+0xc3/0x5d0
[    2.611643]  process_one_work+0x96c/0x16c0
[    2.611762]  ? pwq_dec_nr_in_flight+0x2c0/0x2c0
[    2.611879]  ? do_raw_spin_lock+0x120/0x290
[    2.612000]  worker_thread+0x87/0xe80
[    2.612117]  ? __kthread_parkme+0x82/0xf0
[    2.612231]  ? process_one_work+0x16c0/0x16c0
[    2.612351]  kthread+0x2e9/0x3a0
[    2.612464]  ? kthread_park+0x120/0x120
[    2.612587]  ret_from_fork+0x35/0x40
[    2.612705]
[    2.612819] Allocated by task 37:
[    2.612933]  kasan_kmalloc+0xa5/0xd0
[    2.613048]  kmem_cache_alloc+0xbf/0x1e0
[    2.613162]  mempool_init_node+0x1e2/0x540
[    2.613279]  mempool_init+0x12/0x20
[    2.613392]  bioset_init+0x438/0x630
[    2.613512]  blk_alloc_queue_node+0x112/0x6a0
[    2.613627]  blk_mq_init_queue+0x3c/0x80
[    2.613744]  scsi_mq_alloc_queue+0x3c/0x160
[    2.613860]  scsi_alloc_sdev+0x797/0xb60
[    2.613975]  scsi_probe_and_add_lun+0x830/0x2cc0
[    2.614089]  __scsi_scan_target+0x1d1/0xba0
[    2.614204]  scsi_scan_channel+0xf2/0x160
[    2.614321]  scsi_scan_host_selected+0x20b/0x2e0
[    2.614436]  do_scan_async+0x3e/0x420
[    2.614553]  async_run_entry_fn+0xc3/0x5d0
[    2.614667]  process_one_work+0x96c/0x16c0
[    2.614782]  worker_thread+0x87/0xe80
[    2.614896]  kthread+0x2e9/0x3a0
[    2.615008]  ret_from_fork+0x35/0x40
[    2.615120]
[    2.615229] Freed by task 31:
[    2.615344]  __kasan_slab_free+0x135/0x180
[    2.615458]  kmem_cache_free+0x8f/0x210
[    2.615576]  mempool_exit+0xb5/0x190
[    2.615689]  bioset_exit+0x80/0x2e0gg
[    2.615803]  __blk_release_queue+0x1ad/0x300
[    2.615918]  process_one_work+0x96c/0x16c0
[    2.616035]  worker_thread+0x87/0xe80
[    2.616147]  kthread+0x2e9/0x3a0
[    2.616260]  ret_from_fork+0x35/0x40
[    2.616376]
[    2.616487] The buggy address belongs to the object at ffff8881d44a0000
[    2.616487]  which belongs to the cache biovec-max of size 8192
[    2.616627] The buggy address is located 6016 bytes inside of
[    2.616627]  8192-byte region [ffff8881d44a0000, ffff8881d44a2000)
[    2.616765] The buggy address belongs to the page:
[    2.616887] page:ffffea0007512800 count:1 mapcount:0
mapping:ffff8881d9e21e00 index:0x0 compound_mapcount: 0
[    2.617036] flags: 0x17fff8000010200(slab|head)
[    2.617176] raw: 017fff8000010200 dead000000000100 dead000000000200
ffff8881d9e21e00
[    2.617340] raw: 0000000000000000 0000000000030003 00000001ffffffff
0000000000000000
[    2.617495] page dumped because: kasan: bad access detected
[    2.617640]
[    2.617773] Memory state around the buggy address:
[    2.617892]  ffff8881d44a1680: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    2.618025]  ffff8881d44a1700: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    2.618152] >ffff8881d44a1780: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    2.618285]                    ^
[    2.618398]  ffff8881d44a1800: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    2.618533]  ffff8881d44a1880: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    2.618659] ==================================================================
[    2.618787] Disabling lock debugging due to kernel taint
[    2.620263]  sda: sda1
[    2.622639] sd 0:0:1:0: [sda] Attached SCSI disk
[    2.634443] EXT4-fs (sda1): INFO: recovery required on readonly filesystem
[    2.634593] EXT4-fs (sda1): write access will be enabled during recovery
[    2.757455] EXT4-fs (sda1): orphan cleanup on readonly fs
[    2.763592] EXT4-fs (sda1): 24 orphan inodes deleted
[    2.763733] EXT4-fs (sda1): recovery complete
[    2.769094] EXT4-fs (sda1): mounted filesystem with ordered data
mode. Opts: (null)
[    2.769401] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
