Return-Path: <SRS0=QLrH=OY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8333C43387
	for <linux-block@archiver.kernel.org>; Sat, 15 Dec 2018 04:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36FE2080F
	for <linux-block@archiver.kernel.org>; Sat, 15 Dec 2018 04:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeLOEIn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 23:08:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:41822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728260AbeLOEIn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 23:08:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A302AF68;
        Sat, 15 Dec 2018 04:08:38 +0000 (UTC)
Subject: Re: [PATCH v2] bcache: set max writeback rate when I/O request is
 idle
To:     Michael Lyle <mlyle@lyle.org>
Cc:     linux-bcache <linux-bcache@vger.kernel.org>,
        linux-block@vger.kernel.org, stable <stable@vger.kernel.org>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
References: <20180724040310.1590-1-colyli@suse.de>
 <CAJ+L6qcyR2nqdTJAPwi_hKx+BtDjzX+K0guJJK7xLtBU0w64eg@mail.gmail.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8046b547-d59d-2764-90f9-27698b1011f7@suse.de>
Date:   Sat, 15 Dec 2018 12:07:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ+L6qcyR2nqdTJAPwi_hKx+BtDjzX+K0guJJK7xLtBU0w64eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/15/18 2:10 AM, Michael Lyle wrote:
> Coly--
> 
> Apologies for the late reply on this.  I just noticed it based on Greg's
> comment about stable.
> 
> When I wrote the previous "accelerate writeback" patchset, my first
> attempt was very much like this.  I believe it was asked (by you?)
> whether it would impact the latency of front-end I/O because of deep
> backing device queues when a new request comes in.
> 
> Won't this cause lots of requests to be pending to backing, so if there
> is intermittent front-end I/O they'll have to wait for the device? 
> That's why I previous had it set to only complete one writeback at a
> time, to bound the impact on latency-- based on that review feedback.

Hi Mike,

This patch is a much more conservative effort. It sets a high writeback
rate only when all attached bcache device are idled for quite many
seconds. In this situation, the cache set is really quite and spared.

Commit b1092c9af9ed ("bcache: allow quick writeback when backing idle")
just looks at single bcache device. If there are I/Os for other bcache
device on the cache set, and a single bcache device is idle, a faster
writeback rate for this single idle bcache device will happen, I/O to
read dirty data on cache for writeback will have negative impact to I/O
requests of other bcache devices.

Therefore I give up a specific faster writeback, to make sure the
latency of front end I/O in general.

Thanks.

Coly Li



> On Mon, Jul 23, 2018 at 9:03 PM Coly Li <colyli@suse.de
> <mailto:colyli@suse.de>> wrote:
> 
>     Commit b1092c9af9ed ("bcache: allow quick writeback when backing idle")
>     allows the writeback rate to be faster if there is no I/O request on a
>     bcache device. It works well if there is only one bcache device attached
>     to the cache set. If there are many bcache devices attached to a cache
>     set, it may introduce performance regression because multiple faster
>     writeback threads of the idle bcache devices will compete the btree
>     level
>     locks with the bcache device who have I/O requests coming.
> 
>     This patch fixes the above issue by only permitting fast writebac when
>     all bcache devices attached on the cache set are idle. And if one of the
>     bcache devices has new I/O request coming, minimized all writeback
>     throughput immediately and let PI controller __update_writeback_rate()
>     to decide the upcoming writeback rate for each bcache device.
> 
>     Also when all bcache devices are idle, limited wrieback rate to a small
>     number is wast of thoughput, especially when backing devices are slower
>     non-rotation devices (e.g. SATA SSD). This patch sets a max writeback
>     rate for each backing device if the whole cache set is idle. A faster
>     writeback rate in idle time means new I/Os may have more available space
>     for dirty data, and people may observe a better write performance then.
> 
>     Please note bcache may change its cache mode in run time, and this patch
>     still works if the cache mode is switched from writeback mode and there
>     is still dirty data on cache.
> 
>     Fixes: Commit b1092c9af9ed ("bcache: allow quick writeback when
>     backing idle")
>     Cc: stable@vger.kernel.org <mailto:stable@vger.kernel.org> #4.16+
>     Signed-off-by: Coly Li <colyli@suse.de <mailto:colyli@suse.de>>
>     Tested-by: Kai Krakow <kai@kaishome.de <mailto:kai@kaishome.de>>
>     Cc: Michael Lyle <mlyle@lyle.org <mailto:mlyle@lyle.org>>
>     Cc: Stefan Priebe <s.priebe@profihost.ag <mailto:s.priebe@profihost.ag>>
>     ---
>     Channgelog:
>     v2, Fix a deadlock reported by Stefan Priebe.
>     v1, Initial version.
> 
>      drivers/md/bcache/bcache.h    |  11 ++--
>      drivers/md/bcache/request.c   |  51 ++++++++++++++-
>      drivers/md/bcache/super.c     |   1 +
>      drivers/md/bcache/sysfs.c     |  14 +++--
>      drivers/md/bcache/util.c      |   2 +-
>      drivers/md/bcache/util.h      |   2 +-
>      drivers/md/bcache/writeback.c | 115 ++++++++++++++++++++++++++--------
>      7 files changed, 155 insertions(+), 41 deletions(-)
> 
>     diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
>     index d6bf294f3907..469ab1a955e0 100644
>     --- a/drivers/md/bcache/bcache.h
>     +++ b/drivers/md/bcache/bcache.h
>     @@ -328,13 +328,6 @@ struct cached_dev {
>              */
>             atomic_t                has_dirty;
> 
>     -       /*
>     -        * Set to zero by things that touch the backing volume-- except
>     -        * writeback.  Incremented by writeback.  Used to determine
>     when to
>     -        * accelerate idle writeback.
>     -        */
>     -       atomic_t                backing_idle;
>     -
>             struct bch_ratelimit    writeback_rate;
>             struct delayed_work     writeback_rate_update;
> 
>     @@ -514,6 +507,8 @@ struct cache_set {
>             struct cache_accounting accounting;
> 
>             unsigned long           flags;
>     +       atomic_t                idle_counter;
>     +       atomic_t                at_max_writeback_rate;
> 
>             struct cache_sb         sb;
> 
>     @@ -523,6 +518,8 @@ struct cache_set {
> 
>             struct bcache_device    **devices;
>             unsigned                devices_max_used;
>     +       /* See set_at_max_writeback_rate() for how it is used */
>     +       unsigned                previous_dirty_dc_nr;
>             struct list_head        cached_devs;
>             uint64_t                cached_dev_sectors;
>             struct closure          caching;
>     diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
>     index ae67f5fa8047..1af3d96abfa5 100644
>     --- a/drivers/md/bcache/request.c
>     +++ b/drivers/md/bcache/request.c
>     @@ -1104,6 +1104,43 @@ static void detached_dev_do_request(struct
>     bcache_device *d, struct bio *bio)
> 
>      /* Cached devices - read & write stuff */
> 
>     +static void quit_max_writeback_rate(struct cache_set *c,
>     +                                   struct cached_dev *this_dc)
>     +{
>     +       int i;
>     +       struct bcache_device *d;
>     +       struct cached_dev *dc;
>     +
>     +       /*
>     +        * If bch_register_lock is acquired by other attach/detach
>     operations,
>     +        * waiting here will increase I/O request latency for
>     seconds or more.
>     +        * To avoid such situation, only writeback rate of current
>     cached device
>     +        * is set to 1, and __update_write_back() will decide
>     writeback rate
>     +        * of other cached devices (remember c->idle_counter is 0 now).
>     +        */
>     +       if (mutex_trylock(&bch_register_lock)){
>     +               for (i = 0; i < c->devices_max_used; i++) {
>     +                       if (!c->devices[i])
>     +                               continue;
>     +
>     +                       if (UUID_FLASH_ONLY(&c->uuids[i]))
>     +                               continue;
>     +
>     +                       d = c->devices[i];
>     +                       dc = container_of(d, struct cached_dev, disk);
>     +                       /*
>     +                        * set writeback rate to default minimum value,
>     +                        * then let update_writeback_rate() to
>     decide the
>     +                        * upcoming rate.
>     +                        */
>     +                       atomic64_set(&dc->writeback_rate.rate, 1);
>     +               }
>     +
>     +               mutex_unlock(&bch_register_lock);
>     +       } else
>     +               atomic64_set(&this_dc->writeback_rate.rate, 1);
>     +}
>     +
>      static blk_qc_t cached_dev_make_request(struct request_queue *q,
>                                             struct bio *bio)
>      {
>     @@ -1119,7 +1156,19 @@ static blk_qc_t
>     cached_dev_make_request(struct request_queue *q,
>                     return BLK_QC_T_NONE;
>             }
> 
>     -       atomic_set(&dc->backing_idle, 0);
>     +       if (d->c) {
>     +               atomic_set(&d->c->idle_counter, 0);
>     +               /*
>     +                * If at_max_writeback_rate of cache set is true and
>     new I/O
>     +                * comes, quit max writeback rate of all cached devices
>     +                * attached to this cache set, and set
>     at_max_writeback_rate
>     +                * to false.
>     +                */
>     +               if
>     (unlikely(atomic_read(&d->c->at_max_writeback_rate) == 1)) {
>     +                       atomic_set(&d->c->at_max_writeback_rate, 0);
>     +                       quit_max_writeback_rate(d->c, dc);
>     +               }
>     +       }
>             generic_start_io_acct(q, rw, bio_sectors(bio), &d->disk->part0);
> 
>             bio_set_dev(bio, dc->bdev);
>     diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>     index fa4058e43202..fa532d9f9353 100644
>     --- a/drivers/md/bcache/super.c
>     +++ b/drivers/md/bcache/super.c
>     @@ -1687,6 +1687,7 @@ struct cache_set *bch_cache_set_alloc(struct
>     cache_sb *sb)
>             c->block_bits           = ilog2(sb->block_size);
>             c->nr_uuids             = bucket_bytes(c) / sizeof(struct
>     uuid_entry);
>             c->devices_max_used     = 0;
>     +       c->previous_dirty_dc_nr = 0;
>             c->btree_pages          = bucket_pages(c);
>             if (c->btree_pages > BTREE_MAX_PAGES)
>                     c->btree_pages = max_t(int, c->btree_pages / 4,
>     diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
>     index 225b15aa0340..d719021bff81 100644
>     --- a/drivers/md/bcache/sysfs.c
>     +++ b/drivers/md/bcache/sysfs.c
>     @@ -170,7 +170,8 @@ SHOW(__bch_cached_dev)
>             var_printf(writeback_running,   "%i");
>             var_print(writeback_delay);
>             var_print(writeback_percent);
>     -       sysfs_hprint(writeback_rate,    dc->writeback_rate.rate << 9);
>     +       sysfs_hprint(writeback_rate,
>     +                    atomic64_read(&dc->writeback_rate.rate) << 9);
>             sysfs_hprint(io_errors,         atomic_read(&dc->io_errors));
>             sysfs_printf(io_error_limit,    "%i", dc->error_limit);
>             sysfs_printf(io_disable,        "%i", dc->io_disable);
>     @@ -188,7 +189,8 @@ SHOW(__bch_cached_dev)
>                     char change[20];
>                     s64 next_io;
> 
>     -               bch_hprint(rate,        dc->writeback_rate.rate << 9);
>     +               bch_hprint(rate,
>     +                          atomic64_read(&dc->writeback_rate.rate)
>     << 9);
>                     bch_hprint(dirty,     
>      bcache_dev_sectors_dirty(&dc->disk) << 9);
>                     bch_hprint(target,      dc->writeback_rate_target << 9);
>                    
>     bch_hprint(proportional,dc->writeback_rate_proportional << 9);
>     @@ -255,8 +257,12 @@ STORE(__cached_dev)
> 
>             sysfs_strtoul_clamp(writeback_percent,
>     dc->writeback_percent, 0, 40);
> 
>     -       sysfs_strtoul_clamp(writeback_rate,
>     -                           dc->writeback_rate.rate, 1, INT_MAX);
>     +       if (attr == &sysfs_writeback_rate) {
>     +               int v;
>     +
>     +               sysfs_strtoul_clamp(writeback_rate, v, 1, INT_MAX);
>     +               atomic64_set(&dc->writeback_rate.rate, v);
>     +       }
> 
>             sysfs_strtoul_clamp(writeback_rate_update_seconds,
>                                 dc->writeback_rate_update_seconds,
>     diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
>     index fc479b026d6d..84f90c3d996d 100644
>     --- a/drivers/md/bcache/util.c
>     +++ b/drivers/md/bcache/util.c
>     @@ -200,7 +200,7 @@ uint64_t bch_next_delay(struct bch_ratelimit *d,
>     uint64_t done)
>      {
>             uint64_t now = local_clock();
> 
>     -       d->next += div_u64(done * NSEC_PER_SEC, d->rate);
>     +       d->next += div_u64(done * NSEC_PER_SEC,
>     atomic64_read(&d->rate));
> 
>             /* Bound the time.  Don't let us fall further than 2 seconds
>     behind
>              * (this prevents unnecessary backlog that would make it
>     impossible
>     diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
>     index cced87f8eb27..7e17f32ab563 100644
>     --- a/drivers/md/bcache/util.h
>     +++ b/drivers/md/bcache/util.h
>     @@ -442,7 +442,7 @@ struct bch_ratelimit {
>              * Rate at which we want to do work, in units per second
>              * The units here correspond to the units passed to
>     bch_next_delay()
>              */
>     -       uint32_t                rate;
>     +       atomic64_t              rate;
>      };
> 
>      static inline void bch_ratelimit_reset(struct bch_ratelimit *d)
>     diff --git a/drivers/md/bcache/writeback.c
>     b/drivers/md/bcache/writeback.c
>     index ad45ebe1a74b..11ffadc3cf8f 100644
>     --- a/drivers/md/bcache/writeback.c
>     +++ b/drivers/md/bcache/writeback.c
>     @@ -49,6 +49,80 @@ static uint64_t __calc_target_rate(struct
>     cached_dev *dc)
>             return (cache_dirty_target * bdev_share) >>
>     WRITEBACK_SHARE_SHIFT;
>      }
> 
>     +static bool set_at_max_writeback_rate(struct cache_set *c,
>     +                                     struct cached_dev *dc)
>     +{
>     +       int i, dirty_dc_nr = 0;
>     +       struct bcache_device *d;
>     +
>     +       /*
>     +        * bch_register_lock is acquired in
>     cached_dev_detach_finish() before
>     +        * calling cancel_writeback_rate_update_dwork() to stop the
>     delayed
>     +        * kworker writeback_rate_update (where the context we are
>     for now).
>     +        * Therefore call mutex_lock() here may introduce deadlock
>     when shut
>     +        * down the bcache device.
>     +        * c->previous_dirty_dc_nr is used to record previous calculated
>     +        * dirty_dc_nr when mutex_trylock() last time succeeded. Then if
>     +        * mutex_trylock() failed here, use c->previous_dirty_dc_nr
>     as dirty
>     +        * cached device number. Of cause it might be inaccurate,
>     but a few more
>     +        * or less loop before setting c->at_max_writeback_rate is
>     much better
>     +        * then a deadlock here.
>     +        */
>     +       if (mutex_trylock(&bch_register_lock)) {
>     +               for (i = 0; i < c->devices_max_used; i++) {
>     +                       if (!c->devices[i])
>     +                               continue;
>     +                       if (UUID_FLASH_ONLY(&c->uuids[i]))
>     +                               continue;
>     +                       d = c->devices[i];
>     +                       dc = container_of(d, struct cached_dev, disk);
>     +                       if (atomic_read(&dc->has_dirty))
>     +                               dirty_dc_nr++;
>     +               }
>     +               c->previous_dirty_dc_nr = dirty_dc_nr;
>     +
>     +               mutex_unlock(&bch_register_lock);
>     +       } else
>     +               dirty_dc_nr = c->previous_dirty_dc_nr;
>     +
>     +       /*
>     +        * Idle_counter is increased everytime when
>     update_writeback_rate()
>     +        * is rescheduled in. If all backing devices attached to the
>     same
>     +        * cache set has same dc->writeback_rate_update_seconds
>     value, it
>     +        * is about 10 rounds of update_writeback_rate() is called
>     on each
>     +        * backing device, then the code will fall through at set 1 to
>     +        * c->at_max_writeback_rate, and a max wrteback rate to each
>     +        * dc->writeback_rate.rate. This is not very accurate but
>     works well
>     +        * to make sure the whole cache set has no new I/O coming before
>     +        * writeback rate is set to a max number.
>     +        */
>     +       if (atomic_inc_return(&c->idle_counter) < dirty_dc_nr * 10)
>     +               return false;
>     +
>     +       if (atomic_read(&c->at_max_writeback_rate) != 1)
>     +               atomic_set(&c->at_max_writeback_rate, 1);
>     +
>     +
>     +       atomic64_set(&dc->writeback_rate.rate, INT_MAX);
>     +
>     +       /* keep writeback_rate_target as existing value */
>     +       dc->writeback_rate_proportional = 0;
>     +       dc->writeback_rate_integral_scaled = 0;
>     +       dc->writeback_rate_change = 0;
>     +
>     +       /*
>     +        * Check c->idle_counter and c->at_max_writeback_rate
>     agagain in case
>     +        * new I/O arrives during before set_at_max_writeback_rate()
>     returns.
>     +        * Then the writeback rate is set to 1, and its new value
>     should be
>     +        * decided via __update_writeback_rate().
>     +        */
>     +       if (atomic_read(&c->idle_counter) < dirty_dc_nr * 10 ||
>     +           !atomic_read(&c->at_max_writeback_rate))
>     +               return false;
>     +
>     +       return true;
>     +}
>     +
>      static void __update_writeback_rate(struct cached_dev *dc)
>      {
>             /*
>     @@ -104,8 +178,9 @@ static void __update_writeback_rate(struct
>     cached_dev *dc)
> 
>             dc->writeback_rate_proportional = proportional_scaled;
>             dc->writeback_rate_integral_scaled = integral_scaled;
>     -       dc->writeback_rate_change = new_rate - dc->writeback_rate.rate;
>     -       dc->writeback_rate.rate = new_rate;
>     +       dc->writeback_rate_change = new_rate -
>     +                       atomic64_read(&dc->writeback_rate.rate);
>     +       atomic64_set(&dc->writeback_rate.rate, new_rate);
>             dc->writeback_rate_target = target;
>      }
> 
>     @@ -138,9 +213,16 @@ static void update_writeback_rate(struct
>     work_struct *work)
> 
>             down_read(&dc->writeback_lock);
> 
>     -       if (atomic_read(&dc->has_dirty) &&
>     -           dc->writeback_percent)
>     -               __update_writeback_rate(dc);
>     +       if (atomic_read(&dc->has_dirty) && dc->writeback_percent) {
>     +               /*
>     +                * If the whole cache set is idle,
>     set_at_max_writeback_rate()
>     +                * will set writeback rate to a max number. Then it is
>     +                * unncessary to update writeback rate for an idle
>     cache set
>     +                * in maximum writeback rate number(s).
>     +                */
>     +               if (!set_at_max_writeback_rate(c, dc))
>     +                       __update_writeback_rate(dc);
>     +       }
> 
>             up_read(&dc->writeback_lock);
> 
>     @@ -422,27 +504,6 @@ static void read_dirty(struct cached_dev *dc)
> 
>                     delay = writeback_delay(dc, size);
> 
>     -               /* If the control system would wait for at least half a
>     -                * second, and there's been no reqs hitting the
>     backing disk
>     -                * for awhile: use an alternate mode where we have
>     at most
>     -                * one contiguous set of writebacks in flight at a
>     time.  If
>     -                * someone wants to do IO it will be quick, as it
>     will only
>     -                * have to contend with one operation in flight, and
>     we'll
>     -                * be round-tripping data to the backing disk as
>     quickly as
>     -                * it can accept it.
>     -                */
>     -               if (delay >= HZ / 2) {
>     -                       /* 3 means at least 1.5 seconds, up to 7.5 if we
>     -                        * have slowed way down.
>     -                        */
>     -                       if (atomic_inc_return(&dc->backing_idle) >= 3) {
>     -                               /* Wait for current I/Os to finish */
>     -                               closure_sync(&cl);
>     -                               /* And immediately launch a new set. */
>     -                               delay = 0;
>     -                       }
>     -               }
>     -
>                     while (!kthread_should_stop() &&
>                            !test_bit(CACHE_SET_IO_DISABLE,
>     &dc->disk.c->flags) &&
>                            delay) {
>     @@ -715,7 +776,7 @@ void bch_cached_dev_writeback_init(struct
>     cached_dev *dc)
>             dc->writeback_running           = true;
>             dc->writeback_percent           = 10;
>             dc->writeback_delay             = 30;
>     -       dc->writeback_rate.rate         = 1024;
>     +       atomic64_set(&dc->writeback_rate.rate, 1024);
>             dc->writeback_rate_minimum      = 8;
> 
>             dc->writeback_rate_update_seconds =
>     WRITEBACK_RATE_UPDATE_SECS_DEFAULT;
>     -- 
>     2.17.1
> 

