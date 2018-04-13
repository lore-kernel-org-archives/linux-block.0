Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:41340 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbeDMBBL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Apr 2018 21:01:11 -0400
From: tang.junhui@zte.com.cn
To: colyli@suse.de
Cc: kent.overstreet@gmail.com, mlyle@lyle.org,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Re: [PATCH] bcache: simplify the calculation of the total amount of flash dirty data
Date: Fri, 13 Apr 2018 09:01:08 +0800
Message-Id: <1523581268-17311-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Coly,

> On 2018/4/12 3:21 PM, tang.junhui@zte.com.cn wrote:
> > From: Tang Junhui <tang.junhui@zte.com.cn>
> > 
> > Currently we calculate the total amount of flash only devices dirty data
> > by adding the dirty data of each flash only device under registering
> > locker. It is very inefficient.
> > 
> > In this patch, we add a member flash_dev_dirty_sectors in struct cache_set
> > to record the total amount of flash only devices dirty data in real time,
> > so we didn't need to calculate the total amount of dirty data any more.
> > 
> > Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
> 
> Hi Junhui,
> 
> The patch looks good to me, you have my
>     Reviewed-by: Coly Li <colyli@suse.de>
> 

Thanks for your review.

> Thanks.
> 
> Coly Li
> 
> > ---
> >  drivers/md/bcache/bcache.h    |  1 +
> >  drivers/md/bcache/super.c     |  2 ++
> >  drivers/md/bcache/writeback.c |  5 ++++-
> >  drivers/md/bcache/writeback.h | 19 -------------------
> >  4 files changed, 7 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> > index 843877e..cdbd596 100644
> > --- a/drivers/md/bcache/bcache.h
> > +++ b/drivers/md/bcache/bcache.h
> > @@ -490,6 +490,7 @@ struct cache_set {
> >      struct bcache_device    **devices;
> >      struct list_head    cached_devs;
> >      uint64_t        cached_dev_sectors;
> > +    atomic_long_t        flash_dev_dirty_sectors;
> >      struct closure        caching;
> >  
> >      struct closure        sb_write;
> > diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> > index b4d2892..772520e 100644
> > --- a/drivers/md/bcache/super.c
> > +++ b/drivers/md/bcache/super.c
> > @@ -1208,6 +1208,8 @@ static void flash_dev_free(struct closure *cl)
> >  {
> >      struct bcache_device *d = container_of(cl, struct bcache_device, cl);
> >      mutex_lock(&bch_register_lock);
> > +    atomic_long_sub(bcache_dev_sectors_dirty(d),
> > +            &d->c->flash_dev_dirty_sectors);
> >      bcache_device_free(d);
> >      mutex_unlock(&bch_register_lock);
> >      kobject_put(&d->kobj);
> > diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
> > index 56a3788..ec50d76 100644
> > --- a/drivers/md/bcache/writeback.c
> > +++ b/drivers/md/bcache/writeback.c
> > @@ -23,7 +23,7 @@ static void __update_writeback_rate(struct cached_dev *dc)
> >  {
> >      struct cache_set *c = dc->disk.c;
> >      uint64_t cache_sectors = c->nbuckets * c->sb.bucket_size -
> > -                bcache_flash_devs_sectors_dirty(c);
> > +                atomic_long_read(&c->flash_dev_dirty_sectors);
> >      uint64_t cache_dirty_target =
> >          div_u64(cache_sectors * dc->writeback_percent, 100);
> >      int64_t target = div64_u64(cache_dirty_target * bdev_sectors(dc->bdev),
> > @@ -314,6 +314,9 @@ void bcache_dev_sectors_dirty_add(struct cache_set *c, unsigned inode,
> >      if (!d)
> >          return;
> >  
> > +    if (UUID_FLASH_ONLY(&c->uuids[inode]))
> > +        atomic_long_add(nr_sectors, &c->flash_dev_dirty_sectors);
> > +
> >      stripe = offset_to_stripe(d, offset);
> >      stripe_offset = offset & (d->stripe_size - 1);
> >  
> > diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
> > index a9e3ffb..1a7eacf 100644
> > --- a/drivers/md/bcache/writeback.h
> > +++ b/drivers/md/bcache/writeback.h
> > @@ -15,25 +15,6 @@ static inline uint64_t bcache_dev_sectors_dirty(struct bcache_device *d)
> >      return ret;
> >  }
> >  
> > -static inline uint64_t  bcache_flash_devs_sectors_dirty(struct cache_set *c)
> > -{
> > -    uint64_t i, ret = 0;
> > -
> > -    mutex_lock(&bch_register_lock);
> > -
> > -    for (i = 0; i < c->nr_uuids; i++) {
> > -        struct bcache_device *d = c->devices[i];
> > -
> > -        if (!d || !UUID_FLASH_ONLY(&c->uuids[i]))
> > -            continue;
> > -       ret += bcache_dev_sectors_dirty(d);
> > -    }
> > -
> > -    mutex_unlock(&bch_register_lock);
> > -
> > -    return ret;
> > -}
> > -
> >  static inline unsigned offset_to_stripe(struct bcache_device *d,
> >                      uint64_t offset)
> >  {
> > 

Thanks.
Tang Junhui
