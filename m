Return-Path: <jinpu.wang@profitbricks.com>
MIME-Version: 1.0
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Wed, 19 Sep 2018 11:26:00 +0200
Message-ID: <CAMGffEkdA_d6y6us4tz7AKc0Qwv4jqDqJ63QywG5_wMmGj+ozw@mail.gmail.com>
Subject: [BUG]kmemleak in cfq_get_queue+0x213
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi,

I notice following kmemleak warning on 4.14.65 when running blktests
unreferenced object 0xffff88031d34f7c0 (size 240):
  comm "kworker/0:1", pid 18344, jiffies 4301519574 (age 3716.610s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 51 f9 bc 02 88 ff ff  .........Q......
    d0 f7 34 1d 03 88 ff ff 00 00 00 00 00 00 00 00  ..4.............
  backtrace:
    [<ffffffffa56adfc3>] cfq_get_queue+0x213/0x530
    [<ffffffffa56b103f>] cfq_set_request+0x43f/0x550
    [<ffffffffa5669400>] get_request+0xe20/0xfc0
    [<ffffffffa5669691>] blk_get_request+0xf1/0x1a0
    [<ffffffffc04032ea>] scsi_execute+0x4a/0x390 [scsi_mod]
    [<ffffffffc0403c9b>] scsi_test_unit_ready+0x8b/0x130 [scsi_mod]
    [<ffffffffc0344f29>] sd_check_events+0x1c9/0x2e0 [sd_mod]
    [<ffffffffa568c7dc>] disk_check_events+0x8c/0x1f0
    [<ffffffffa50c31f0>] process_one_work+0x350/0x8e0
    [<ffffffffa50c3819>] worker_thread+0x99/0x720
    [<ffffffffa50cd173>] kthread+0x1c3/0x210
    [<ffffffffa5e001ca>] ret_from_fork+0x3a/0x50
    [<ffffffffffffffff>] 0xffffffffffffffff

cfq_get_queue+0x213 point to       line 3838   cfqq =3D
kmem_cache_alloc_node(cfq_pool,    in cfq-scheduler.c

Looks we're leaking cfq_queue in some case.

Does anyone see the leak before?

Thanks!
--=20
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
