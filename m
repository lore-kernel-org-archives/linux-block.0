Return-Path: <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2 v6] mmc: block: Convert RPMB to a character device
To: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Paolo Valente <paolo.valente@linaro.org>,
 Avri Altman <Avri.Altman@sandisk.com>,
 Tomas Winkler <tomas.winkler@intel.com>
References: <20170920080201.32438-1-linus.walleij@linaro.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <b4a75994-1556-56ac-499c-8527988ee70f@intel.com>
Date: Wed, 27 Sep 2017 14:35:36 +0300
MIME-Version: 1.0
In-Reply-To: <20170920080201.32438-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>


BUG when removing, fixed by reverting this patch.

[  346.548512] mmc1: card 0001 removed
[  346.552782] BUG: unable to handle kernel NULL pointer dereference at 0000000000000070
[  346.561539] IP: kernfs_find_ns+0xe/0xc0
[  346.565822] PGD 179dc5067 P4D 179dc5067 PUD 171106067 PMD 0 
[  346.572152] Oops: 0000 [#1] SMP
[  346.575657] Modules linked in:
[  346.579069] CPU: 0 PID: 1393 Comm: sh Not tainted 4.14.0-rc1-00034-g5aa83fb178e3 #1528
[  346.587914] task: ffff899d3a3327c0 task.stack: ffff9e6600888000
[  346.594530] RIP: 0010:kernfs_find_ns+0xe/0xc0
[  346.599395] RSP: 0000:ffff9e660088ba28 EFLAGS: 00010246
[  346.605229] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  346.613199] RDX: 0000000000000000 RSI: ffffffff90cab2c1 RDI: 0000000000000000
[  346.621168] RBP: ffff9e660088ba48 R08: 0000000000000000 R09: 000000018040003d
[  346.629139] R10: ffff9e660088ba68 R11: ffff899d3b080e00 R12: ffffffff90cab2c1
[  346.637107] R13: 0000000000000000 R14: ffff899d310b04a8 R15: ffff899d39cdcd70
[  346.645079] FS:  0000000000000000(0000) GS:ffff899d3fc00000(0063) knlGS:00000000f7f2d690
[  346.654118] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  346.660536] CR2: 0000000000000070 CR3: 0000000171173000 CR4: 00000000003406f0
[  346.668504] Call Trace:
[  346.671237]  kernfs_find_and_get_ns+0x2c/0x50
[  346.676106]  sysfs_unmerge_group+0x18/0x60
[  346.680683]  dpm_sysfs_remove+0x1d/0x60
[  346.684969]  device_del+0xef/0x2e0
[  346.688765]  ? cdev_del+0x22/0x30
[  346.692470]  mmc_blk_remove_parts.isra.28+0x6c/0xf0
[  346.697919]  mmc_blk_remove+0x27/0x190
[  346.702106]  mmc_bus_remove+0x18/0x20
[  346.706197]  device_release_driver_internal+0x142/0x200
[  346.712036]  device_release_driver+0xd/0x10
[  346.716709]  bus_remove_device+0xdb/0x120
[  346.721188]  device_del+0x1c3/0x2e0
[  346.725083]  mmc_remove_card+0x5b/0xc0
[  346.729270]  mmc_remove+0x14/0x30
[  346.732974]  mmc_stop_host+0xef/0x1a0
[  346.737065]  mmc_remove_host+0x15/0x40
