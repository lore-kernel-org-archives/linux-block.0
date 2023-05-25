Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5CFC77B73
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 04:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbjEYEKe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 00:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbjEYEJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 00:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350881BE1
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 21:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684987571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KdWfPWCP/qwGt+1lpx4uhH00fEwrttr6+1Jvl/MFRKM=;
        b=RlMvcXTewfiw7PqJq2RMtf5cYi8tg99gVPFgV374blLeURX1V8eVnR2QlvOH9sDBzOA91v
        xriXGdmM2IyEVr7MeRe4gBdGWxF1zIcvXBeeme1U1xaQAzc3BNbrHAE1v/JgsVdkMfbB1Y
        1UoG7jwuy4reauLkDEIVOsgRJdhJ+OI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-whSOhEYCONCPwDzvx3wZWw-1; Thu, 25 May 2023 00:06:07 -0400
X-MC-Unique: whSOhEYCONCPwDzvx3wZWw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8F36185A78B;
        Thu, 25 May 2023 04:06:06 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 826A6C154D1;
        Thu, 25 May 2023 04:06:02 +0000 (UTC)
Date:   Thu, 25 May 2023 12:05:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, mkoutny@suse.com,
        Yosry Ahmed <yosryahmed@google.com>, ming.lei@redhat.com
Subject: Re: [PATCH V2] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <ZG7epTv6P0YLEH+U@ovpn-8-21.pek2.redhat.com>
References: <20230524035150.727407-1-ming.lei@redhat.com>
 <f2c10b18-8d83-91a5-bf22-03894bf3c910@redhat.com>
 <ZG2R+jYuAZMpx49d@ovpn-8-17.pek2.redhat.com>
 <76a863b4-112e-82ae-59e4-6326fff48ffc@redhat.com>
 <bde4174a-ace4-6e2a-6536-855fb18d0890@redhat.com>
 <ZG7CJtN7ATaYZ5Ao@ovpn-8-21.pek2.redhat.com>
 <7ffbb748-46e3-44b2-388d-9199f47dc9a7@redhat.com>
 <ZG7aZF8T+I0DjNw9@ovpn-8-21.pek2.redhat.com>
 <eb88c7a5-e29d-9ab1-93db-544aeabcc90c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb88c7a5-e29d-9ab1-93db-544aeabcc90c@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 25, 2023 at 12:02:01AM -0400, Waiman Long wrote:
> 
> On 5/24/23 23:47, Ming Lei wrote:
> > On Wed, May 24, 2023 at 10:50:29PM -0400, Waiman Long wrote:
> > > On 5/24/23 22:04, Ming Lei wrote:
> > > > On Wed, May 24, 2023 at 01:28:41PM -0400, Waiman Long wrote:
> > > > > On 5/24/23 11:43, Waiman Long wrote:
> > > > > 
> > > > llist_del_all() moves all 'bis' into one local list, and bis is one percpu
> > > > variable of blkg, so in theory same bis won't be flushed at the same
> > > > time. And one bis should be touched in just one of stat flush code path
> > > > because of llist_del_all().
> > > > 
> > > > So 'bis' still can be thought as being flushed in serialized way.
> > > > 
> > > > However, blk_cgroup_bio_start() runs concurrently with blkcg_rstat_flush(),
> > > > so once bis->lqueued is cleared in blkcg_rstat_flush(), this same bis
> > > > could be added to the percpu llist and __blkcg_rstat_flush() from blkg_release()
> > > > follows. This should be the only chance for concurrent stats update.
> > > That is why I have in mind. A __blkcg_rstat_flush() can be from
> > > blkg_release() and another one from the regular cgroup_rstat_flush*().
> > But the two blkg can't be same because blkg_release() is run from rcu
> > callback.
> 
> I am not talking about the parent blkg which can have a concurrent update.
> It is probably safe at the blkg level, but the lockless list may contain
> another bisc from a blkg that is not being destroyed.
> 
> 
> > 
> > > 
> > > > But, blkg_release() is run in RCU callback, so the previous flush has
> > > > been done, but new flush can come, and other blkg's stat could be added
> > > > with same story above.
> > > > 
> > > > > One way to
> > > > > avoid that is to synchronize it by cgroup_rstat_cpu_lock. Another way is to
> > > > > use the bisc->lqueued for synchronization.
> > > > I'd avoid the external cgroup lock here.
> > > > 
> > > > > In that case, you need to move
> > > > > WRITE_ONCE(bisc->lqueued, false) in blkcg_rstat_flush() to the end after all
> > > > > the  blkcg_iostat_update() call with smp_store_release() and replace the
> > > > > READ_ONCE(bis->lqueued) check in blk_cgroup_bio_start() with
> > > > > smp_load_acquire().
> > > > This way looks doable, but I guess it still can't avoid concurrent update on parent
> > > > stat, such as when  __blkcg_rstat_flush() from blkg_release() is
> > > > in-progress, another sibling blkg's bis is added, meantime
> > > > blkcg_rstat_flush() is called.
> > > I realized that the use of cgroup_rstat_cpu_lock or the alternative was not
> > > safe enough for preventing concurrent parent blkg rstat update.
> > Indeed.
> > 
> > > > Another way is to add blkcg->stat_lock for covering __blkcg_rstat_flush(), what
> > > > do you think of this way?
> > > I am thinking of adding a raw spinlock into blkg and take it when doing
> > > blkcg_iostat_update(). This can guarantee no concurrent update to rstat
> > > data. It has to be a raw spinlock as it will be under the
> > > cgroup_rstat_cpu_lock raw spinlock.
> > We still need to be careful since both child and parent are updated
> > in the following blkcg_iostat_update().
> > 
> >                  if (parent && parent->parent)
> >                          blkcg_iostat_update(parent, &blkg->iostat.cur,
> >                                              &blkg->iostat.last);
> > 
> > But the concurrent update on parent blkg can be avoided by holding
> > parent->stat_lock only.
> 
> That is true. Perhaps we can use Yosry's suggestion of adding a helper to
> acquire and release cgroup_rstat_lock before calling __blkcg_rstat_flush().
> That will also guarantee no concurrent update.

Yeah, probably add the following API:

void cgroup_rstat_css_flush(struct cgroup_subsys_state *css)
{
    spin_lock_irq(&cgroup_rstat_lock);

    for_each_possible_cpu(cpu) {
        raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);

        raw_spin_lock_irq(cpu_lock);
        css->ss->css_rstat_flush(css, cpu);
        raw_spin_unlock_irq(cpu_lock);
    }
    spin_unlock_irq(&cgroup_rstat_lock);
}

We should make the fix as simple as possible given it needs backport
to -stable, another choice is to add global blkg_stat_lock. Which
approach is better?


Thanks, 
Ming

