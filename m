Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43811 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936665AbeF2QU5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jun 2018 12:20:57 -0400
Date: Fri, 29 Jun 2018 09:20:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-scsi@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [V2, 2/2] scsi: avoid to hold host-wide counter of host_busy for
 scsi_mq
Message-ID: <20180629162054.GA19036@roeck-us.net>
References: <20180624140327.28146-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180624140327.28146-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

On Sun, Jun 24, 2018 at 10:03:27PM +0800, Ming Lei wrote:
> It isn't necessary to check the host depth in scsi_queue_rq() any more
> since it has been respected by blk-mq before calling scsi_queue_rq() via
> getting driver tag.
> 
> Lots of LUNs may attach to same host, and per-host IOPS may reach millions
> level, so we should avoid to this expensive atomic operations on the
> hostwide counter in IO path.
> 
> This patch implemens scsi_host_busy() via blk_mq_tagset_busy_iter() for
> reading the count of busy IOs for scsi_mq.
> 
> It is observed that IOPS is increased by 15% in IO test on scsi_debug
> (32 LUNs, 32 submit queues, 1024 can_queue, libaio/dio) in one
> dual-socket system.
> 

This patch breaks two of my qemu test builds in -next: parisc:defconfig
and arm:versatilepb-scsi:versatile_defconfig (which is versatilepb booting
from scsi disk). The symptom is the same for both: Boot stalls after scsi
bus initialization.

arm:

sym53c8xx 0000:00:0c.0: enabling device (0100 -> 0103)
sym0: <895a> rev 0x0 at pci 0000:00:0c.0 irq 66
sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi host0: sym-2.2.3
random: fast init done
[stalls]

parisc:

sym53c8xx 0000:00:00.0: enabling SERR and PARITY (0107 -> 0147)
sym0: <895a> rev 0x0 at pci 0000:00:00.0 irq 17
sym0: PA-RISC Firmware, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi host0: sym-2.2.3
random: fast init done
[stalls]

Reverting the patch fixes the problem. Bisect log is attached.

Guenter

---
# bad: [e3c7283c19cd9ba999794f38007389ac83408a78] Add linux-next specific files for 20180629
# good: [7daf201d7fe8334e2d2364d4e8ed3394ec9af819] Linux 4.18-rc2
git bisect start 'HEAD' 'v4.18-rc2'
# good: [74f0b73f82214595f9a457c71c16c5b73daaa12b] Merge remote-tracking branch 'crypto/master'
git bisect good 74f0b73f82214595f9a457c71c16c5b73daaa12b
# good: [f4f7cb745da2544fd23fec5e33782b453121abb4] Merge remote-tracking branch 'spi/for-next'
git bisect good f4f7cb745da2544fd23fec5e33782b453121abb4
# good: [11fce5f62f76bbe4fa35c17d9d968c50a2add11d] Merge remote-tracking branch 'staging/staging-next'
git bisect good 11fce5f62f76bbe4fa35c17d9d968c50a2add11d
# bad: [3b7557dfc1a37bc3e332c96e3e84c8d2606116b8] Merge remote-tracking branch 'xarray/xarray'
git bisect bad 3b7557dfc1a37bc3e332c96e3e84c8d2606116b8
# bad: [6cb742aeb685642ea6b829b06f4655df0f9b521c] Merge remote-tracking branch 'pinctrl/for-next'
git bisect bad 6cb742aeb685642ea6b829b06f4655df0f9b521c
# good: [c65be1a63f1df224c8f22d72b9ec824241ada585] scsi: core: check for equality of result byte values
git bisect good c65be1a63f1df224c8f22d72b9ec824241ada585
# bad: [f933a84d83b933d5c343e76ee6c18768c3bac0d6] Merge remote-tracking branch 'libata/for-next'
git bisect bad f933a84d83b933d5c343e76ee6c18768c3bac0d6
# bad: [bc64692916f008be1f2c0c5a7562aa826a6444aa] Merge remote-tracking branch 'scsi/for-next'
git bisect bad bc64692916f008be1f2c0c5a7562aa826a6444aa
# good: [cd5f5a2b20414c23b16b330f1ef54a941dc90d3d] Merge remote-tracking branch 'slave-dma/next'
git bisect good cd5f5a2b20414c23b16b330f1ef54a941dc90d3d
# good: [c84b023a4c1461498abf0eda54f60e2fd64a1ca2] scsi: read host_busy via scsi_host_busy()
git bisect good c84b023a4c1461498abf0eda54f60e2fd64a1ca2
# bad: [0c218e16a8501cfda30f498217b434976cb62fc5] scsi: tcmu: Don't pass KERN_ERR to pr_err
git bisect bad 0c218e16a8501cfda30f498217b434976cb62fc5
# bad: [328728630d9f2bf14b82ca30b5e47489beefe361] scsi: core: avoid host-wide host_busy counter for scsi_mq
git bisect bad 328728630d9f2bf14b82ca30b5e47489beefe361
# first bad commit: [328728630d9f2bf14b82ca30b5e47489beefe361] scsi: core: avoid host-wide host_busy counter for scsi_mq

---
Example qemu trace (with -d exec; this is repeated over and over again, with other
code - mostly timer handling - in between):

Chain 0: 0x7fffca60f8c0 [0000000000000004/00000000103fb5c4/0x40003] blk_add_timer
Chain 0: 0x7fffca6103c0 [0000000000000004/00000000103f14fc/0x40003] blk_start_request
Chain 0: 0x7fffca6105c0 [0000000000000004/00000000103f4954/0x40003] blk_queue_start_tag
Chain 0: 0x7fffca610b00 [0000000000000004/00000000104ec990/0x40003] scsi_request_fn
Trace 0: 0x7fffca610dc0 [0000000000000004/00000000104ec9a4/0x40003] scsi_request_fn
Trace 0: 0x7fffca612040 [0000000000000004/00000000104ecaf4/0x40003] scsi_request_fn
Trace 0: 0x7fffca612240 [0000000000000004/00000000104ecb04/0x40003] scsi_request_fn
Chain 0: 0x7fffca6274c0 [0000000000000004/00000000104ecb20/0x40003] scsi_request_fn
Trace 0: 0x7fffca627780 [0000000000000004/00000000104ecbdc/0x40003] scsi_request_fn
Trace 0: 0x7fffca627ec0 [0000000000000004/00000000104ecbf0/0x40003] scsi_request_fn
Trace 0: 0x7fffca619480 [0000000000000004/00000000104ebd28/0x40003] scsi_dec_host_busy
Trace 0: 0x7fffca619680 [0000000000000004/00000000104ebd38/0x40003] scsi_dec_host_busy
Chain 0: 0x7fffca628000 [0000000000000004/00000000104ecbf8/0x40003] scsi_request_fn
Trace 0: 0x7fffca628480 [0000000000000004/00000000104eca8c/0x40003] scsi_request_fn
Chain 0: 0x7fffca61ac40 [0000000000000004/00000000103f13a4/0x40003] blk_requeue_request
Chain 0: 0x7fffca61b580 [0000000000000004/00000000103f13d4/0x40003] blk_requeue_request
Trace 0: 0x7fffca61b6c0 [0000000000000004/00000000103f13d8/0x40003] blk_requeue_request
Trace 0: 0x7fffca61b8c0 [0000000000000004/00000000103f13e8/0x40003] blk_requeue_request
Trace 0: 0x7fffca61cc00 [0000000000000004/00000000103f4c0c/0x40003] blk_queue_end_tag
Trace 0: 0x7fffca61ce80 [0000000000000004/00000000103f4c28/0x40003] blk_queue_end_tag
Chain 0: 0x7fffca61d1c0 [0000000000000004/00000000103f142c/0x40003] blk_requeue_request
Chain 0: 0x7fffca5f5440 [0000000000000004/00000000103ee2d0/0x40003] __elv_add_request
Chain 0: 0x7fffca61e100 [0000000000000004/00000000103ee3b0/0x40003] elv_requeue_request
Chain 0: 0x7fffca61e400 [0000000000000004/00000000103f140c/0x40003] blk_requeue_request
Chain 0: 0x7fffca6285c0 [0000000000000004/00000000104eca98/0x40003] scsi_request_fn
Trace 0: 0x7fffca628700 [0000000000000004/00000000104eca9c/0x40003] scsi_request_fn
Trace 0: 0x7fffca628900 [0000000000000004/00000000104ecaac/0x40003] scsi_request_fn
Chain 0: 0x7fffca61fd00 [0000000000000004/00000000103ef5ec/0x40003] blk_delay_queue
Chain 0: 0x7fffca620540 [0000000000000004/00000000101d6334/0x40003] __msecs_to_jiffies
Chain 0: 0x7fffca620940 [0000000000000004/00000000103ef62c/0x40003] blk_delay_queue
