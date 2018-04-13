Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:39508 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753112AbeDMCBT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Apr 2018 22:01:19 -0400
From: tang.junhui@zte.com.cn
To: colyli@suse.de
Cc: kent.overstreet@gmail.com, mlyle@lyle.org,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Re: [PATCH 4/4] bcache: fix I/O significant decline while backenddevices registering
Date: Fri, 13 Apr 2018 10:01:17 +0800
Message-Id: <1523584877-32293-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Coly,

> On 2018/4/12 2:38 PM, tang.junhui@zte.com.cn wrote:
> > From: Tang Junhui <tang.junhui@zte.com.cn>
> > 
> > I attached several backend devices in the same cache set, and produced lots
> > of dirty data by running small rand I/O writes in a long time, then I
> > continue run I/O in the others cached devices, and stopped a cached device,
> > after a mean while, I register the stopped device again, I see the running
> > I/O in the others cached devices dropped significantly, sometimes even
> > jumps to zero.
> > 
> > In currently code, bcache would traverse each keys and btree node to count
> > the dirty data under read locker, and the writes threads can not get the
> > btree write locker, and when there is a lot of keys and btree node in the
> > registering device, it would last several seconds, so the write I/Os in
> > others cached device are blocked and declined significantly.
> > 
> > In this patch, when a device registering to a ache set, which exist others
> > cached devices with running I/Os, we get the amount of dirty data of the
> > device in an incremental way, and do not block other cached devices all the
> > time.
> > 
> > Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
> > ---
> >  drivers/md/bcache/writeback.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
> > index 56a3788..2467d3a 100644
> > --- a/drivers/md/bcache/writeback.c
> > +++ b/drivers/md/bcache/writeback.c
> > @@ -488,10 +488,14 @@ static int bch_writeback_thread(void *arg)
> >  }
> >  
> 
> Hi Junhui,
> 
> >  /* Init */
> > +#define INIT_KEYS_MIN            500000
> > +#define INIT_KEYS_SLEEP_TIME        100
> >  
> 
> How about renaming the above macros to something like
> INIT_KEYS_WAIT_COUNTER and INIT_KEYS_SLEEP_MS ?
> 
> Also I suggested to rename io_inflight in previous patch review comments.
> 
> For rested part of this patch looks good to me.
> 
> Reviewed-by: Coly Li <colyli@suse.de>
> 

Tanks for your reveiw, I will modify the issue you mentioned 
and send a V2 patch later.

> 
> >  struct sectors_dirty_init {
> >      struct btree_op    op;
> >      unsigned    inode;
> > +    size_t        count;
> > +    struct bkey    start;
> >  };
> >  
> >  static int sectors_dirty_init_fn(struct btree_op *_op, struct btree *b,
> > @@ -506,18 +510,38 @@ static int sectors_dirty_init_fn(struct btree_op *_op, struct btree *b,
> >          bcache_dev_sectors_dirty_add(b->c, KEY_INODE(k),
> >                           KEY_START(k), KEY_SIZE(k));
> >  
> > +    op->count++;
> > +    if (atomic_read(&b->c->io_inflight) &&
> > +       !(op->count % INIT_KEYS_MIN)) {
> > +        bkey_copy_key(&op->start, k);
> > +        return -EAGAIN;
> > +    }
> > +
> >      return MAP_CONTINUE;
> >  }
> >  
> >  void bch_sectors_dirty_init(struct bcache_device *d)
> >  {
> >      struct sectors_dirty_init op;
> > +    int ret;
> >  
> >      bch_btree_op_init(&op.op, -1);
> >      op.inode = d->id;
> > +    op.count = 0;
> > +    op.start = KEY(op.inode, 0, 0);
> >  
> > -    bch_btree_map_keys(&op.op, d->c, &KEY(op.inode, 0, 0),
> > +    do {
> > +        ret = bch_btree_map_keys(&op.op, d->c, &op.start,
> >                 sectors_dirty_init_fn, 0);
> > +        if (ret == -EAGAIN)
> > +            schedule_timeout_interruptible(
> > +                msecs_to_jiffies(INIT_KEYS_SLEEP_TIME));
> > +        else if (ret < 0) {
> > +            pr_warn("sectors dirty init failed, ret=%d!", ret);
> > +            break;
> > +        }
> > +    } while (ret == -EAGAIN);
> > +
> >  }
> >  
> >  void bch_cached_dev_writeback_init(struct cached_dev *dc)
> > 

Thanks.
Tang Junhui
