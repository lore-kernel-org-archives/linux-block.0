Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F66DC77B7E
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 03:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjEYDss (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 23:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYDss (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 23:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA968E2
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 20:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684986479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=etkOMWwDzGspqIBq+f6hjv7Xo+LSWOkdM+no29HpUBA=;
        b=LUH8RwNz9++Ki9xFkHXHcD4PUl1F8mASYY1xVC07rgC4qF+tJkdMc/r95E6IBsMr3ubQkP
        ib0Wsd0UfW5b9X31V/K0dzJxkopMz8RUx4PrGcBcd3i9kPwNlEENGdlvwZF74gKaoxdfTd
        tO+9h9lXqnin45jyWVZJw85xjWbAUmw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-iNiXVJmNOPmtIpTahOHBHw-1; Wed, 24 May 2023 23:47:58 -0400
X-MC-Unique: iNiXVJmNOPmtIpTahOHBHw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE57885A5BA;
        Thu, 25 May 2023 03:47:57 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D4F2482060;
        Thu, 25 May 2023 03:47:52 +0000 (UTC)
Date:   Thu, 25 May 2023 11:47:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, mkoutny@suse.com,
        Yosry Ahmed <yosryahmed@google.com>, ming.lei@redhat.com
Subject: Re: [PATCH V2] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <ZG7aZF8T+I0DjNw9@ovpn-8-21.pek2.redhat.com>
References: <20230524035150.727407-1-ming.lei@redhat.com>
 <f2c10b18-8d83-91a5-bf22-03894bf3c910@redhat.com>
 <ZG2R+jYuAZMpx49d@ovpn-8-17.pek2.redhat.com>
 <76a863b4-112e-82ae-59e4-6326fff48ffc@redhat.com>
 <bde4174a-ace4-6e2a-6536-855fb18d0890@redhat.com>
 <ZG7CJtN7ATaYZ5Ao@ovpn-8-21.pek2.redhat.com>
 <7ffbb748-46e3-44b2-388d-9199f47dc9a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ffbb748-46e3-44b2-388d-9199f47dc9a7@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 10:50:29PM -0400, Waiman Long wrote:
> On 5/24/23 22:04, Ming Lei wrote:
> > On Wed, May 24, 2023 at 01:28:41PM -0400, Waiman Long wrote:
> > > On 5/24/23 11:43, Waiman Long wrote:
> > > > On 5/24/23 00:26, Ming Lei wrote:
> > > > > On Wed, May 24, 2023 at 12:19:57AM -0400, Waiman Long wrote:
> > > > > > On 5/23/23 23:51, Ming Lei wrote:
> > > > > > > As noted by Michal, the blkg_iostat_set's in the lockless list hold
> > > > > > > reference to blkg's to protect against their removal. Those blkg's
> > > > > > > hold reference to blkcg. When a cgroup is being destroyed,
> > > > > > > cgroup_rstat_flush() is only called at css_release_work_fn() which
> > > > > > > is called when the blkcg reference count reaches 0. This circular
> > > > > > > dependency will prevent blkcg and some blkgs from being freed after
> > > > > > > they are made offline.
> > > > > > > 
> > > > > > > It is less a problem if the cgroup to be destroyed also has other
> > > > > > > controllers like memory that will call cgroup_rstat_flush() which will
> > > > > > > clean up the reference count. If block is the only
> > > > > > > controller that uses
> > > > > > > rstat, these offline blkcg and blkgs may never be freed leaking more
> > > > > > > and more memory over time.
> > > > > > > 
> > > > > > > To prevent this potential memory leak:
> > > > > > > 
> > > > > > > - flush blkcg per-cpu stats list in __blkg_release(), when no new stat
> > > > > > > can be added
> > > > > > > 
> > > > > > > - don't grab bio->bi_blkg reference when adding the stats into blkcg's
> > > > > > > per-cpu stat list since all stats are guaranteed to be consumed before
> > > > > > > releasing blkg instance, and grabbing blkg reference for stats was the
> > > > > > > most fragile part of original patch
> > > > > > > 
> > > > > > > Based on Waiman's patch:
> > > > > > > 
> > > > > > > https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redhat.com/
> > > > > > > 
> > > > > > > 
> > > > > > > Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> > > > > > > Cc: Waiman Long <longman@redhat.com>
> > > > > > > Cc: Tejun Heo <tj@kernel.org>
> > > > > > > Cc: mkoutny@suse.com
> > > > > > > Cc: Yosry Ahmed <yosryahmed@google.com>
> > > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > > ---
> > > > > > > V2:
> > > > > > >      - remove kernel/cgroup change, and call blkcg_rstat_flush()
> > > > > > >      to flush stat directly
> > > > > > > 
> > > > > > >     block/blk-cgroup.c | 29 +++++++++++++++++++++--------
> > > > > > >     1 file changed, 21 insertions(+), 8 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > > > > > > index 0ce64dd73cfe..ed0eb8896972 100644
> > > > > > > --- a/block/blk-cgroup.c
> > > > > > > +++ b/block/blk-cgroup.c
> > > > > > > @@ -34,6 +34,8 @@
> > > > > > >     #include "blk-ioprio.h"
> > > > > > >     #include "blk-throttle.h"
> > > > > > > +static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
> > > > > > > +
> > > > > > >     /*
> > > > > > >      * blkcg_pol_mutex protects blkcg_policy[] and policy
> > > > > > > [de]activation.
> > > > > > >      * blkcg_pol_register_mutex nests outside of it and
> > > > > > > synchronizes entire
> > > > > > > @@ -163,10 +165,21 @@ static void blkg_free(struct blkcg_gq *blkg)
> > > > > > >     static void __blkg_release(struct rcu_head *rcu)
> > > > > > >     {
> > > > > > >         struct blkcg_gq *blkg = container_of(rcu, struct
> > > > > > > blkcg_gq, rcu_head);
> > > > > > > +    struct blkcg *blkcg = blkg->blkcg;
> > > > > > > +    int cpu;
> > > > > > >     #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
> > > > > > >         WARN_ON(!bio_list_empty(&blkg->async_bios));
> > > > > > >     #endif
> > > > > > > +    /*
> > > > > > > +     * Flush all the non-empty percpu lockless lists before releasing
> > > > > > > +     * us, given these stat belongs to us.
> > > > > > > +     *
> > > > > > > +     * cgroup locks aren't needed here since __blkcg_rstat_flush just
> > > > > > > +     * propagates delta into blkg parent, which is live now.
> > > > > > > +     */
> > > > > > > +    for_each_possible_cpu(cpu)
> > > > > > > +        __blkcg_rstat_flush(blkcg, cpu);
> > > > > > >         /* release the blkcg and parent blkg refs this blkg
> > > > > > > has been holding */
> > > > > > >         css_put(&blkg->blkcg->css);
> > > > > > > @@ -951,17 +964,12 @@ static void blkcg_iostat_update(struct
> > > > > > > blkcg_gq *blkg, struct blkg_iostat *cur,
> > > > > > > u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
> > > > > > >     }
> > > > > > > -static void blkcg_rstat_flush(struct cgroup_subsys_state
> > > > > > > *css, int cpu)
> > > > > > > +static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
> > > > > > >     {
> > > > > > > -    struct blkcg *blkcg = css_to_blkcg(css);
> > > > > > >         struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
> > > > > > >         struct llist_node *lnode;
> > > > > > >         struct blkg_iostat_set *bisc, *next_bisc;
> > > > > > > -    /* Root-level stats are sourced from system-wide IO stats */
> > > > > > > -    if (!cgroup_parent(css->cgroup))
> > > > > > > -        return;
> > > > > > > -
> > > > > > >         rcu_read_lock();
> > > > > > >         lnode = llist_del_all(lhead);
> > > > > > > @@ -991,13 +999,19 @@ static void blkcg_rstat_flush(struct
> > > > > > > cgroup_subsys_state *css, int cpu)
> > > > > > >             if (parent && parent->parent)
> > > > > > >                 blkcg_iostat_update(parent, &blkg->iostat.cur,
> > > > > > >                             &blkg->iostat.last);
> > > > > > > -        percpu_ref_put(&blkg->refcnt);
> > > > > > >         }
> > > > > > >     out:
> > > > > > >         rcu_read_unlock();
> > > > > > >     }
> > > > > > > +static void blkcg_rstat_flush(struct cgroup_subsys_state
> > > > > > > *css, int cpu)
> > > > > > > +{
> > > > > > > +    /* Root-level stats are sourced from system-wide IO stats */
> > > > > > > +    if (cgroup_parent(css->cgroup))
> > > > > > > +        __blkcg_rstat_flush(css_to_blkcg(css), cpu);
> > > > > > > +}
> > > > > > > +
> > > > > > I think it may not safe to call __blkcg_rstat_flus() directly
> > > > > > without taking
> > > > > > the cgroup_rstat_cpu_lock. That is why I added a helper to
> > > > > > kernel/cgroup/rstat.c in my patch to meet the locking requirement.
> > > > > All stats are removed from llist_del_all(), and the local list is
> > > > > iterated, then each blkg & its parent is touched in
> > > > > __blkcg_rstat_flus(), so
> > > > > can you explain it a bit why cgroup locks are needed? For protecting
> > > > > what?
> > > > You are right. The llist_del_all() call in blkcg_rstat_flush() is
> > > > atomic, so it is safe for concurrent execution which is what the
> > > > cgroup_rstat_cpu_lock protects against. That may not be the case for
> > > > rstat callbacks of other controllers. So I will suggest you to add a
> > > > comment to clarify that point. Other than that, you patch looks good to
> > > > me.
> > > > 
> > > > Reviewed: Waiman Long <longman@redhat.com>
> > > After some more thought, I need to retract my reviewed-by tag for now. There
> > > is a slight possibility that blkcg_iostat_update() in blkcg_rstat_flush()
> > > can happen concurrently which will corrupt the sequence count.
> > llist_del_all() moves all 'bis' into one local list, and bis is one percpu
> > variable of blkg, so in theory same bis won't be flushed at the same
> > time. And one bis should be touched in just one of stat flush code path
> > because of llist_del_all().
> > 
> > So 'bis' still can be thought as being flushed in serialized way.
> > 
> > However, blk_cgroup_bio_start() runs concurrently with blkcg_rstat_flush(),
> > so once bis->lqueued is cleared in blkcg_rstat_flush(), this same bis
> > could be added to the percpu llist and __blkcg_rstat_flush() from blkg_release()
> > follows. This should be the only chance for concurrent stats update.
> 
> That is why I have in mind. A __blkcg_rstat_flush() can be from
> blkg_release() and another one from the regular cgroup_rstat_flush*().

But the two blkg can't be same because blkg_release() is run from rcu
callback.

> 
> 
> > 
> > But, blkg_release() is run in RCU callback, so the previous flush has
> > been done, but new flush can come, and other blkg's stat could be added
> > with same story above.
> > 
> > > One way to
> > > avoid that is to synchronize it by cgroup_rstat_cpu_lock. Another way is to
> > > use the bisc->lqueued for synchronization.
> > I'd avoid the external cgroup lock here.
> > 
> > > In that case, you need to move
> > > WRITE_ONCE(bisc->lqueued, false) in blkcg_rstat_flush() to the end after all
> > > the  blkcg_iostat_update() call with smp_store_release() and replace the
> > > READ_ONCE(bis->lqueued) check in blk_cgroup_bio_start() with
> > > smp_load_acquire().
> > This way looks doable, but I guess it still can't avoid concurrent update on parent
> > stat, such as when  __blkcg_rstat_flush() from blkg_release() is
> > in-progress, another sibling blkg's bis is added, meantime
> > blkcg_rstat_flush() is called.
> I realized that the use of cgroup_rstat_cpu_lock or the alternative was not
> safe enough for preventing concurrent parent blkg rstat update.

Indeed.

> > 
> > Another way is to add blkcg->stat_lock for covering __blkcg_rstat_flush(), what
> > do you think of this way?
> 
> I am thinking of adding a raw spinlock into blkg and take it when doing
> blkcg_iostat_update(). This can guarantee no concurrent update to rstat
> data. It has to be a raw spinlock as it will be under the
> cgroup_rstat_cpu_lock raw spinlock.

We still need to be careful since both child and parent are updated
in the following blkcg_iostat_update().

                if (parent && parent->parent)
                        blkcg_iostat_update(parent, &blkg->iostat.cur,
                                            &blkg->iostat.last);

But the concurrent update on parent blkg can be avoided by holding
parent->stat_lock only.


thanks,
Ming

