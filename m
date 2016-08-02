Return-Path: <jinpu.wang@profitbricks.com>
MIME-Version: 1.0
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Tue, 2 Aug 2016 15:58:01 +0200
Message-ID: <CAMGffEmw8ako59nAkDfpHWH06xAngkKR0YYpxF24LwZMjA9P2g@mail.gmail.com>
Subject: [BUG] Deadlock in blk_mq_register_disk error path
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens,

I found in blk_mq_register_disk, we blk_mq_disable_hotplug which in
turn mutex_lock(&all_q_mutex);
  queue_for_each_hw_ctx(q, hctx, i) {
                ret =3D blk_mq_register_hctx(hctx);
                if (ret)
                        break; /// if about error out, we will call
unregister below
        }

        if (ret)
                blk_mq_unregister_disk(disk);

In blk_mq_unregister_disk, we will try to disable_hotplug again, which
leads to dead lock.

Did I miss anything?

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Best Regards,

Jack Wang

Linux Kernel Developer Storage
ProfitBricks GmbH  The IaaS-Company.
