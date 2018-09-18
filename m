Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39925 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeIRRLR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 13:11:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so1440730lji.6
        for <linux-block@vger.kernel.org>; Tue, 18 Sep 2018 04:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180917052939.4776-1-hlitz@ucsc.edu> <20180917052939.4776-7-hlitz@ucsc.edu>
In-Reply-To: <20180917052939.4776-7-hlitz@ucsc.edu>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Tue, 18 Sep 2018 13:38:50 +0200
Message-ID: <CANr-nt2AL8FP3PCic6g=B+2QgFCqwnatE-SWBX9yMRz5EN388Q@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] lightnvm: pblk: Integrate RAIL
To: hlitz@ucsc.edu
Cc: linux-block@vger.kernel.org, Javier Gonzalez <javier@cnexlabs.com>,
        Matias Bjorling <mb@lightnvm.io>, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 17, 2018 at 7:30 AM Heiner Litz <hlitz@ucsc.edu> wrote:
>
> Integrate Redundant Array of Independent Luns (RAIL) into lightnvm. RAIL
> enforces low tail read latency by guaranteeing that reads are never
> serialized behind writes and erases to the same LUN. Whenever LUNs serve a
> high latency operation, reads are performed by recomputing the original
> utilizing redundant parity information.
> Rail trades-off read latency for capacity (redundancy) which, however, can
> be leveraged for fault tolerance.
>
> On FIO, with the kyber scheduler set to a target read latency of 500us,
> RAIL reduces tail latency percentiles (us) as follows:
>
>        Avg    90%    99%     99.9%  99.95%  99.99%
>        pblk   90     1000    2200   3000    6000
>        RAIL   85     100     250    400     500
>
> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> ---
>  drivers/lightnvm/Kconfig      | 10 ++++++++++
>  drivers/lightnvm/Makefile     |  1 +
>  drivers/lightnvm/pblk-core.c  | 36 ++++++++++++++++++++++++++++++++++-
>  drivers/lightnvm/pblk-init.c  | 17 +++++++++++++++++
>  drivers/lightnvm/pblk-rail.c  |  1 +
>  drivers/lightnvm/pblk-rb.c    |  6 ++++++
>  drivers/lightnvm/pblk-read.c  |  9 +++++++++
>  drivers/lightnvm/pblk-write.c |  9 +++++++++
>  drivers/lightnvm/pblk.h       |  5 +++++
>  9 files changed, 93 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> index a872cd720967..165d5a29acc3 100644
> --- a/drivers/lightnvm/Kconfig
> +++ b/drivers/lightnvm/Kconfig
> @@ -35,6 +35,16 @@ config NVM_PBLK_DEBUG
>           vocal error messages, and extra tracking fields in the pblk sysfs
>           entries.
>
> +config NVM_PBLK_RAIL
> +       bool "Pblk RAIL Support"
> +       default n
> +       help
> +         Enables RAIL for pblk. RAIL enforces tail read latency guarantees by
> +        eliminiating reads being serialized behind writes to the same LUN.
> +        RAIL partitions LUNs into strides and enforces that only one LUN per
> +        stride is written at a time. Reads can bypass busy LUNs by recompting
> +        requested data using parity redundancy.
> +
>  endif # NVM_PBLK_DEBUG

Having a compile-time option forces the user (or even worse,
distribution provider) to pick the rail- OR non-rail version of pblk.
It's also a pain having to re-compile and re-provision the kernel when testing.

I see no reason why this should not be dynamically handled within pblk
(rail on/off and stride width could be supplied via the create ioctl)
One would want to configure stride-width to fit a given workload in any case.

nvm_ioctl_create_extended has 16 reserved bits, so we have room for
adding RAIL parameters.

>
>  endif # NVM
> diff --git a/drivers/lightnvm/Makefile b/drivers/lightnvm/Makefile
> index 97d9d7c71550..92f4376428cc 100644
> --- a/drivers/lightnvm/Makefile
> +++ b/drivers/lightnvm/Makefile
> @@ -5,6 +5,7 @@
>
>  obj-$(CONFIG_NVM)              := core.o
>  obj-$(CONFIG_NVM_PBLK)         += pblk.o
> +obj-$(CONFIG_NVM_PBLK_RAIL)    += pblk-rail.o
>  pblk-y                         := pblk-init.o pblk-core.o pblk-rb.o \
>                                    pblk-write.o pblk-cache.o pblk-read.o \
>                                    pblk-gc.o pblk-recovery.o pblk-map.o \
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index a31bf359f905..ca74d7763fa9 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -113,6 +113,12 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
>  {
>         struct pblk *pblk = rqd->private;
>
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
> +
> +       pblk_up_chunk(pblk, ppa_list[0]);
> +#endif
> +
>         __pblk_end_io_erase(pblk, rqd);
>         mempool_free(rqd, &pblk->e_rq_pool);
>  }
> @@ -940,7 +946,11 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
>         /* The write thread schedules erases so that it minimizes disturbances
>          * with writes. Thus, there is no need to take the LUN semaphore.
>          */
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       ret = pblk_submit_io_sync_sem(pblk, &rqd);
> +#else
>         ret = pblk_submit_io_sync(pblk, &rqd);
> +#endif
>         rqd.private = pblk;
>         __pblk_end_io_erase(pblk, &rqd);
>
> @@ -1754,7 +1764,11 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
>         /* The write thread schedules erases so that it minimizes disturbances
>          * with writes. Thus, there is no need to take the LUN semaphore.
>          */
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       err = pblk_submit_io_sem(pblk, rqd);
> +#else
>         err = pblk_submit_io(pblk, rqd);
> +#endif
>         if (err) {
>                 struct nvm_tgt_dev *dev = pblk->dev;
>                 struct nvm_geo *geo = &dev->geo;
> @@ -1909,6 +1923,10 @@ void pblk_line_close_ws(struct work_struct *work)
>         if (w_err_gc->has_write_err)
>                 pblk_save_lba_list(pblk, line);
>
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       pblk_rail_line_close(pblk, line);
> +#endif
> +
>         pblk_line_close(pblk, line);
>         mempool_free(line_ws, &pblk->gen_ws_pool);
>  }
> @@ -1938,8 +1956,12 @@ static void __pblk_down_chunk(struct pblk *pblk, int pos)
>          * Only send one inflight I/O per LUN. Since we map at a page
>          * granurality, all ppas in the I/O will map to the same LUN
>          */
> -
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       (void)rlun;
> +       ret = pblk_rail_down_stride(pblk, pos, msecs_to_jiffies(30000));
> +#else
>         ret = down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
> +#endif
>         if (ret == -ETIME || ret == -EINTR)
>                 pblk_err(pblk, "taking lun semaphore timed out: err %d\n",
>                                 -ret);
> @@ -1978,7 +2000,13 @@ void pblk_up_chunk(struct pblk *pblk, struct ppa_addr ppa)
>         int pos = pblk_ppa_to_pos(geo, ppa);
>
>         rlun = &pblk->luns[pos];
> +
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       pblk_rail_up_stride(pblk, pos);
> +#else
>         up(&rlun->wr_sem);
> +#endif
> +
>  }
>
>  void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap)
> @@ -1991,7 +2019,13 @@ void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap)
>
>         while ((bit = find_next_bit(lun_bitmap, num_lun, bit + 1)) < num_lun) {
>                 rlun = &pblk->luns[bit];
> +
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +               pblk_rail_up_stride(pblk, bit);
> +#else
>                 up(&rlun->wr_sem);
> +#endif
> +
>         }
>  }
>
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 2b9c6ebd9fac..3e8255c8873f 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1050,6 +1050,7 @@ static int pblk_lines_init(struct pblk *pblk)
>         kfree(pblk->lines);
>  fail_free_chunk_meta:
>         kfree(chunk_meta);
> +
>  fail_free_luns:
>         kfree(pblk->luns);
>  fail_free_meta:
> @@ -1108,6 +1109,11 @@ static void pblk_tear_down(struct pblk *pblk, bool graceful)
>                 __pblk_pipeline_flush(pblk);
>         __pblk_pipeline_stop(pblk);
>         pblk_writer_stop(pblk);
> +
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       pblk_rail_free(pblk);
> +#endif
> +
>         pblk_rb_sync_l2p(&pblk->rwb);
>         pblk_rl_free(&pblk->rl);
>
> @@ -1226,6 +1232,12 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>                 goto fail_stop_writer;
>         }
>
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       ret = pblk_rail_init(pblk);
> +       if (ret)
> +               goto fail_free_gc;
> +#endif
> +
>         /* inherit the size from the underlying device */
>         blk_queue_logical_block_size(tqueue, queue_physical_block_size(bqueue));
>         blk_queue_max_hw_sectors(tqueue, queue_max_hw_sectors(bqueue));
> @@ -1249,6 +1261,11 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>
>         return pblk;
>
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +fail_free_gc:
> +       pblk_gc_exit(pblk, false);
> +#endif
> +
>  fail_stop_writer:
>         pblk_writer_stop(pblk);
>  fail_free_l2p:
> diff --git a/drivers/lightnvm/pblk-rail.c b/drivers/lightnvm/pblk-rail.c
> index a48ed31a0ba9..619ff9689d29 100644
> --- a/drivers/lightnvm/pblk-rail.c
> +++ b/drivers/lightnvm/pblk-rail.c
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) 2018 Heiner Litz
>   * Initial release: Heiner Litz <hlitz@ucsc.edu>
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index a7648e12f54f..b04462479fe3 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -389,8 +389,14 @@ static int __pblk_rb_may_write(struct pblk_rb *rb, unsigned int nr_entries,
>         sync = READ_ONCE(rb->sync);
>         mem = READ_ONCE(rb->mem);
>
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       if (pblk_rb_ring_space(rb, mem, sync, rb->nr_entries) <
> +           nr_entries + pblk_rail_rb_delay(rb))
> +               return 0;
> +#else
>         if (pblk_rb_ring_space(rb, mem, sync, rb->nr_entries) < nr_entries)
>                 return 0;
> +#endif
>
>         if (pblk_rb_update_l2p(rb, nr_entries, mem, sync))
>                 return 0;
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 67d44caefff4..a3f33503f60c 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -472,6 +472,15 @@ int pblk_submit_read(struct pblk *pblk, struct bio *bio)
>                 return NVM_IO_DONE;
>         }
>
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       ret = pblk_rail_read_bio(pblk, rqd, blba, read_bitmap, bio_init_idx,
> +                                &bio);
> +       if (ret == NVM_IO_OK)
> +               return ret;
> +       if (ret == NVM_IO_ERR)
> +               goto fail_end_io;
> +#endif
> +
>         /* All sectors are to be read from the device */
>         if (bitmap_empty(read_bitmap, rqd->nr_ppas)) {
>                 struct bio *int_bio = NULL;
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 6eba38b83acd..db42184cfba3 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -469,6 +469,11 @@ static inline bool pblk_valid_meta_ppa(struct pblk *pblk,
>                                 test_bit(pos_opt, data_line->blk_bitmap))
>                 return true;
>
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       if (unlikely(pblk_rail_meta_distance(data_line)))
> +               data_line->meta_distance--;
> +#endif
> +
>         if (unlikely(pblk_ppa_comp(ppa_opt, ppa)))
>                 data_line->meta_distance--;
>
> @@ -571,6 +576,10 @@ static int pblk_submit_write(struct pblk *pblk)
>         unsigned long pos;
>         unsigned int resubmit;
>
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       pblk_rail_submit_write(pblk);
> +#endif
> +
>         spin_lock(&pblk->resubmit_lock);
>         resubmit = !list_empty(&pblk->resubmit_list);
>         spin_unlock(&pblk->resubmit_lock);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 01fe4362b27e..9742524f74ea 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -758,6 +758,11 @@ struct pblk {
>         struct pblk_gc gc;
>
>         pblk_map_page_fn *map_page;
> +
> +#ifdef CONFIG_NVM_PBLK_RAIL
> +       struct pblk_rail rail;
> +#endif
> +
>  };
>
>  struct pblk_line_ws {
> --
> 2.17.1
>
