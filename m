Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4118C433B4
	for <linux-block@archiver.kernel.org>; Sun, 25 Apr 2021 07:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AEAA61425
	for <linux-block@archiver.kernel.org>; Sun, 25 Apr 2021 07:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhDYHhP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Apr 2021 03:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhDYHhP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Apr 2021 03:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619336195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7zscxHfNqseJyCRR7YIcDIsuvaKltnuBOf9unE1sIjc=;
        b=QVRIJQWNgD9HPtLASaT2Sgq6FC4L8JWou5y9j3MGuFjvA5lOiyHneyUh871UPfi5BZViql
        tBafw/V83OaebyNa1avdDHINocwq/Umm+f5mD9C/+ap+nqDVUtpHQeIx5LpPDL8px1A0qC
        ARnIME3eAQnQHLUoWO05BGPQcnFkf2c=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-H5C6-djqOcGAphbiQMV05A-1; Sun, 25 Apr 2021 03:36:33 -0400
X-MC-Unique: H5C6-djqOcGAphbiQMV05A-1
Received: by mail-yb1-f199.google.com with SMTP id v63-20020a252f420000b02904ecfc17c803so18661731ybv.18
        for <linux-block@vger.kernel.org>; Sun, 25 Apr 2021 00:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zscxHfNqseJyCRR7YIcDIsuvaKltnuBOf9unE1sIjc=;
        b=jOi5XJlOAl9Tv9A9abpPsHnPhx4weoN7PcF9Q3RLepZlBvl/6UibD/c+2BCsp4U8XC
         a2n4HO56oB2oKWFj7aQxYIOZC86oa1ZkbYLx1Kw9jg2BnS/bWBTgD/3Vb6yZxItygwdu
         Iw4VbDHA2pp9HNzyJ34ZaUuAjWYlCca7vMA4hB+Wfff8YpTYqIuH37dkaqOh56UQ7Lwf
         T/xeZ4JcshupkZYSERz2mM12S7LmKoFaKmV6rrZsQZ8SIjFay2rpto3PLeJyzdZJmXES
         bqwIyuwcecTcCjbDMhkxUm+GUFdWB/J2sj4LliOXv9i53jQv1Sc2Tg73BAGGkX8p9dcC
         oZow==
X-Gm-Message-State: AOAM533OblyszeFYSbOwSsl6lV04+knyz008UE3x8PzZj6JRZ7XUmjJq
        6i8vQ22lNNw775QWiTb8AS64LYKv2xSkC02/4BxyttSLrGW1X90W2zaTVPosKe27k9p0F1nlyde
        bIyeoCOZPDYpQLJKbxUqT4lSyT8ze8sLR2SkaaA0=
X-Received: by 2002:a25:5087:: with SMTP id e129mr16517882ybb.133.1619336192442;
        Sun, 25 Apr 2021 00:36:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSCTJWf3fPTI4LPIBhFbh29J1+HhsTBuxrHnYSXk518eWFj89G8Lz33vVQ2TTOA4d8SwhhyaiziDlocLvgSCA=
X-Received: by 2002:a25:5087:: with SMTP id e129mr16517860ybb.133.1619336192174;
 Sun, 25 Apr 2021 00:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210425043020.30065-1-bvanassche@acm.org>
In-Reply-To: <20210425043020.30065-1-bvanassche@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Sun, 25 Apr 2021 15:36:21 +0800
Message-ID: <CAHj4cs9-SF114EnWCY1XQL2SGM5-WFYAeGzJTP4X5kmVQtnt6w@mail.gmail.com>
Subject: Re: [PATCH v2] block: Improve limiting the bio size
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Tested-by: Yi Zhang <yi.zhang@redhat.com>

This fixed the boot issue yesterday I found with the latest
linux-block/for-next on my R640 server.
[    2.511716] BUG: kernel NULL pointer dereference, address: 0000000000000370
[    2.518677] #PF: supervisor read access in kernel mode
[    2.523817] #PF: error_code(0x0000) - not-present page
[    2.528956] PGD 0 P4D 0
[    2.531494] Oops: 0000 [#1] SMP NOPTI
[    2.535160] CPU: 3 PID: 202 Comm: kworker/u64:31 Tainted: G
 I       5.12.0-rc8.e62a826b235f+ #4
[    2.544632] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.10.0 11/12/2020
[    2.552199] Workqueue: events_unbound async_run_entry_fn
[    2.557510] RIP: 0010:bio_add_hw_page+0x4f/0x180
[    2.562131] Code: 87 f7 00 00 00 0f b7 46 60 45 89 c4 89 cd 49 89
d5 48 89 f3 49 89 fe 66 85 c0 75 5f 66 39 43 62 0f 86 d6 00 00 00 48
8b 53 08 <48> 8b 92 70 03 00 00 48 8b 52 50 8b 92 08 04 00 00 29 ea 39
53 28
[    2.580876] RSP: 0018:ffffbe3300bebba0 EFLAGS: 00010202
[    2.586103] RAX: 0000000000000000 RBX: ffff99d941442b40 RCX: 0000000000000024
[    2.593234] RDX: 0000000000000000 RSI: ffff99d941442b40 RDI: ffff99d9d02b4dd0
[    2.600366] RBP: 0000000000000024 R08: 0000000000000500 R09: 0000000000000200
[    2.600630] usb 1-14.1: new high-speed USB device number 3 using xhci_hcd
[    2.607498] R10: 0000000000000024 R11: ffff99d9414442cf R12: 0000000000000500
[    2.607499] R13: ffffe05744131400 R14: ffff99d9d02b4dd0 R15: 0000000000000024
[    2.607500] FS:  0000000000000000(0000) GS:ffff99e87fac0000(0000)
knlGS:0000000000000000
[    2.607501] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.642364] CR2: 0000000000000370 CR3: 0000000132654006 CR4: 00000000007706e0
[    2.649496] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.656629] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.663761] PKRU: 55555554
[    2.666473] Call Trace:
[    2.668928]  bio_add_pc_page+0x30/0x50
[    2.672679]  blk_rq_map_kern+0x135/0x3e0
[    2.676604]  __scsi_execute+0x222/0x260
[    2.680444]  scsi_probe_and_add_lun+0x181/0xde0
[    2.684978]  __scsi_scan_target+0xec/0x5a0
[    2.689077]  scsi_scan_channel+0x5a/0x80
[    2.689728] usb 1-14.1: New USB device found, idVendor=1604,
idProduct=10c0, bcdDevice= 0.00
[    2.693001]  scsi_scan_host_selected+0xdb/0x110
[    2.701435] usb 1-14.1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    2.705966]  do_scan_async+0x17/0x150
[    2.705969]  async_run_entry_fn+0x39/0x160
[    2.713895] hub 1-14.1:1.0: USB hub found
[    2.717025]  process_one_work+0x1cb/0x360
[    2.721183] hub 1-14.1:1.0: 4 ports detected
[    2.725136]  ? process_one_work+0x360/0x360
[    2.725137]  worker_thread+0x30/0x370
[    2.725139]  ? process_one_work+0x360/0x360
[    2.745433]  kthread+0x116/0x130
[    2.748666]  ? kthread_park+0x80/0x80
[    2.752331]  ret_from_fork+0x1f/0x30
[    2.755911] Modules linked in: ahci libahci libata tg3 megaraid_sas
crc32c_intel nfit(+) wmi libnvdimm dm_mirror dm_region_hash dm_log
dm_mod
[    2.768590] CR2: 0000000000000370
[    2.771918] ---[ end trace 82a57816a20834cf ]---
[    2.801594] RIP: 0010:bio_add_hw_page+0x4f/0x180
[    2.801606] usb 1-14.4: new high-speed USB device number 4 using xhci_hcd
[    2.806221] Code: 87 f7 00 00 00 0f b7 46 60 45 89 c4 89 cd 49 89
d5 48 89 f3 49 89 fe 66 85 c0 75 5f 66 39 43 62 0f 86 d6 00 00 00 48
8b 53 08 <48> 8b 92 70 03 00 00 48 8b 52 50 8b 92 08 04 00 00 29 ea 39
53 28
[    2.806223] RSP: 0018:ffffbe3300bebba0 EFLAGS: 00010202
[    2.836977] RAX: 0000000000000000 RBX: ffff99d941442b40 RCX: 0000000000000024
[    2.844107] RDX: 0000000000000000 RSI: ffff99d941442b40 RDI: ffff99d9d02b4dd0
[    2.851232] RBP: 0000000000000024 R08: 0000000000000500 R09: 0000000000000200
[    2.858363] R10: 0000000000000024 R11: ffff99d9414442cf R12: 0000000000000500
[    2.865497] R13: ffffe05744131400 R14: ffff99d9d02b4dd0 R15: 0000000000000024
[    2.872629] FS:  0000000000000000(0000) GS:ffff99e87fac0000(0000)
knlGS:0000000000000000
[    2.880715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.886461] CR2: 0000000000000370 CR3: 0000000132654006 CR4: 00000000007706e0
[    2.888731] usb 1-14.4: New USB device found, idVendor=1604,
idProduct=10c0, bcdDevice= 0.00
[    2.893595] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.893596] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.893597] PKRU: 55555554
[    2.893597] Kernel panic - not syncing: Fatal exception
[    2.902027] usb 1-14.4: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    2.916293] Kernel Offset: 0x36800000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    2.965941] ---[ end Kernel panic - not syncing: Fatal exception ]---

On Sun, Apr 25, 2021 at 12:30 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> bio_max_size() may get called before device_add_disk() and hence needs to
> check whether or not the block device pointer is NULL. Additionally, more
> code needs to be modified than __bio_try_merge_page() to limit the bio size
> to bio_max_size().
>
> This patch prevents that bio_max_size() triggers the following kernel
> crash during a SCSI LUN scan:
>
> BUG: KASAN: null-ptr-deref in bio_add_hw_page+0xa6/0x310
> Read of size 8 at addr 00000000000005a8 by task kworker/u16:0/7
> Workqueue: events_unbound async_run_entry_fn
> Call Trace:
>  show_stack+0x52/0x58
>  dump_stack+0x9d/0xcf
>  kasan_report.cold+0x4b/0x50
>  __asan_load8+0x69/0x90
>  bio_add_hw_page+0xa6/0x310
>  bio_add_pc_page+0xaa/0xe0
>  bio_map_kern+0xdc/0x1a0
>  blk_rq_map_kern+0xcd/0x2d0
>  __scsi_execute+0x9a/0x290 [scsi_mod]
>  scsi_probe_lun.constprop.0+0x17c/0x660 [scsi_mod]
>  scsi_probe_and_add_lun+0x178/0x750 [scsi_mod]
>  __scsi_add_device+0x18c/0x1a0 [scsi_mod]
>  ata_scsi_scan_host+0xe5/0x260 [libata]
>  async_port_probe+0x94/0xb0 [libata]
>  async_run_entry_fn+0x7d/0x2d0
>  process_one_work+0x582/0xac0
>  worker_thread+0x8f/0x5a0
>  kthread+0x222/0x250
>  ret_from_fork+0x1f/0x30
>
> This patch also fixes the following kernel warning:
>
> WARNING: CPU: 1 PID: 15449 at block/bio.c:1034
> __bio_iov_iter_get_pages+0x324/0x350
> Call Trace:
>  bio_iov_iter_get_pages+0x6c/0x360
>  __blkdev_direct_IO_simple+0x291/0x580
>  blkdev_direct_IO+0xb5/0xc0
>  generic_file_direct_write+0x10d/0x290
>  __generic_file_write_iter+0x120/0x290
>  blkdev_write_iter+0x16e/0x280
>  new_sync_write+0x268/0x380
>  vfs_write+0x3e0/0x4f0
>  ksys_write+0xd9/0x180
>  __x64_sys_write+0x43/0x50
>  do_syscall_64+0x32/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Changheun Lee <nanich.lee@samsung.com>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Fixes: 15050b63567c ("bio: limit bio max size")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/bio.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> Changes compared to v1: included a fix for direct I/O.
>
> diff --git a/block/bio.c b/block/bio.c
> index d718c63b3533..221dc56ba22f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -257,9 +257,9 @@ EXPORT_SYMBOL(bio_init);
>
>  unsigned int bio_max_size(struct bio *bio)
>  {
> -       struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +       struct block_device *bdev = bio->bi_bdev;
>
> -       return q->limits.bio_max_bytes;
> +       return bdev ? bdev->bd_disk->queue->limits.bio_max_bytes : UINT_MAX;
>  }
>
>  /**
> @@ -1002,6 +1002,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  {
>         unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
>         unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> +       unsigned int bytes_left = bio_max_size(bio) - bio->bi_iter.bi_size;
>         struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>         struct page **pages = (struct page **)bv;
>         bool same_page = false;
> @@ -1017,7 +1018,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>         BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
>         pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
>
> -       size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> +       size = iov_iter_get_pages(iter, pages, bytes_left, nr_pages,
> +                                 &offset);
>         if (unlikely(size <= 0))
>                 return size ? size : -EFAULT;
>
>

