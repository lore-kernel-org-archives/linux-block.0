Return-Path: <shli@kernel.org>
Date: Tue, 25 Jul 2017 15:24:08 -0700
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@infradead.org
Subject: [BUG] nvme driver crash
Message-ID: <20170725222408.fq2fncwtid3fhvqh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Disable CONIFG_SMP, kernel crashes at boot time, here is the log.

[    9.593590] nvme 0000:00:03.0: can't allocate MSI-X affinity masks for 1 vectors
[    9.595189] ==================================================================
[    9.595834] BUG: KASAN: null-ptr-deref in blk_mq_init_queue+0x1c/0x70
[    9.596010] Read of size 4 at addr 0000000000000020 by task kworker/u2:0/5
[    9.596010]
[    9.596010] CPU: 0 PID: 5 Comm: kworker/u2:0 Not tainted 4.13.0-rc1+ #1
[    9.596010] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.1-5.el7_3.3 04/01/2014
[    9.596010] Workqueue: nvme-wq nvme_scan_work
[    9.596010] Call Trace:
[    9.596010]  dump_stack+0x19/0x24
[    9.596010]  kasan_report+0xe8/0x350
[    9.596010]  __asan_load4+0x78/0x80
[    9.596010]  blk_mq_init_queue+0x1c/0x70
[    9.596010]  nvme_validate_ns+0x17c/0x620
[    9.596010]  ? nvme_revalidate_disk+0xf0/0xf0
[    9.596010]  ? nvme_submit_sync_cmd+0x30/0x30
