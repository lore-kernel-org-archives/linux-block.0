Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0083C77B7A
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 03:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjEYDJY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 23:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYDJW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 23:09:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0022AA9
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 20:09:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51403554f1dso2879025a12.1
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 20:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684984158; x=1687576158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr021aMMqPtSG/LGxByX/UZ/DUBnIiHYLRZm/rqP1wg=;
        b=wa6na1clIhupVRa3IvqmWIoTveKZ711k04Sc8gRUUyTLMz1u4AXk+vP7pqA/4ER29f
         KNsX49+BLVn20m4yf1Y+1v+7ketvvgP41VKEn5L3us4Hqz/alPSGbKmpIf2nrlONK6PR
         4CMvFkhz+WsOfi2a3I0kGvnAjyHdWtOjSFfXFdd73qP+gwcJCQ1MRhKir+lieoOW1WRj
         afQOLc9JDDT1dqVmLcozsdGzOsd9ZhhKmjoSZw1aJ0isl2B1xP1PWdlwWVX1/p7X/ifE
         nX+auuRnEAGJb1OROhCufub11tAanBQFqZG9x59uC4xm1Hls7DBsKyFa1vOMMbFx8jWz
         BoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684984158; x=1687576158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gr021aMMqPtSG/LGxByX/UZ/DUBnIiHYLRZm/rqP1wg=;
        b=Ieih//J1VXQnjjLG2clgrUbvR0ft70O8GMPvstWhr/a11xq6sAd8P1J5fvtir+421i
         iMma1x+U4BX3zq38X9WZYhG8DhPWYLMirM3e2xAsbh4zW7gKDYInMIZStfdgYRWXy71Y
         SdaxneWh35eqDLK/SKof1vM+aX5BzwZMDVBgKYVBYtrrZPTlFwgH3AJdUD5mnuhvvSuU
         Ase4GdSb5XRf1/tmG0yFTbqorhvmtwgdMiTuh2CBIKBHkzT3wxoIiTiL5vCSC/zHu2Bt
         wcs7x9vd3Ad51PFnu4FfC+2jDpw0MN5YYd6I9bRL47+l/3GMuNWH+lxBcC1bceFkvsG6
         3iJw==
X-Gm-Message-State: AC+VfDw29dLkuGnVpjAu5Qrcy2ogaX623kCOYgYEndgVQMr3OI5M57W1
        nMxQ/Lx9Je92vmuqEcYX6HZehaYG+QsC1O6yZc2Fvhyr6GaaHX0KckLMjQ==
X-Google-Smtp-Source: ACHHUZ5YcQmO2Q6TrXNZNxCx8zmvRetQ/q6JVRu0VwHf7PgouVi0mpFINndKxOhYUqyN+y/E/vHS6EnNRGU82wsk1B4=
X-Received: by 2002:a17:906:c155:b0:96f:8666:5fc4 with SMTP id
 dp21-20020a170906c15500b0096f86665fc4mr203616ejc.50.1684984158275; Wed, 24
 May 2023 20:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230524035150.727407-1-ming.lei@redhat.com> <f2c10b18-8d83-91a5-bf22-03894bf3c910@redhat.com>
 <ZG2R+jYuAZMpx49d@ovpn-8-17.pek2.redhat.com> <76a863b4-112e-82ae-59e4-6326fff48ffc@redhat.com>
 <bde4174a-ace4-6e2a-6536-855fb18d0890@redhat.com> <ZG7CJtN7ATaYZ5Ao@ovpn-8-21.pek2.redhat.com>
 <7ffbb748-46e3-44b2-388d-9199f47dc9a7@redhat.com> <CAJD7tkYfwVSNrTibnv5BpyAfbyY0dnK0Cp-HQK_-2nxHmveAxw@mail.gmail.com>
 <9b06dceb-f26d-7faf-460c-ba554a0757ef@redhat.com>
In-Reply-To: <9b06dceb-f26d-7faf-460c-ba554a0757ef@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 24 May 2023 20:08:42 -0700
Message-ID: <CAJD7tkZjCvY8FTuRg+EM1zXaycRmpaW2em-vGuPwd4intaXFUw@mail.gmail.com>
Subject: Re: [PATCH V2] blk-cgroup: Flush stats before releasing blkcg_gq
To:     Waiman Long <longman@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 8:04=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 5/24/23 22:55, Yosry Ahmed wrote:
> > On Wed, May 24, 2023 at 7:50=E2=80=AFPM Waiman Long <longman@redhat.com=
> wrote:
> >> On 5/24/23 22:04, Ming Lei wrote:
> >>> On Wed, May 24, 2023 at 01:28:41PM -0400, Waiman Long wrote:
> >>>> On 5/24/23 11:43, Waiman Long wrote:
> >>>>> On 5/24/23 00:26, Ming Lei wrote:
> >>>>>> On Wed, May 24, 2023 at 12:19:57AM -0400, Waiman Long wrote:
> >>>>>>> On 5/23/23 23:51, Ming Lei wrote:
> >>>>>>>> As noted by Michal, the blkg_iostat_set's in the lockless list h=
old
> >>>>>>>> reference to blkg's to protect against their removal. Those blkg=
's
> >>>>>>>> hold reference to blkcg. When a cgroup is being destroyed,
> >>>>>>>> cgroup_rstat_flush() is only called at css_release_work_fn() whi=
ch
> >>>>>>>> is called when the blkcg reference count reaches 0. This circula=
r
> >>>>>>>> dependency will prevent blkcg and some blkgs from being freed af=
ter
> >>>>>>>> they are made offline.
> >>>>>>>>
> >>>>>>>> It is less a problem if the cgroup to be destroyed also has othe=
r
> >>>>>>>> controllers like memory that will call cgroup_rstat_flush() whic=
h will
> >>>>>>>> clean up the reference count. If block is the only
> >>>>>>>> controller that uses
> >>>>>>>> rstat, these offline blkcg and blkgs may never be freed leaking =
more
> >>>>>>>> and more memory over time.
> >>>>>>>>
> >>>>>>>> To prevent this potential memory leak:
> >>>>>>>>
> >>>>>>>> - flush blkcg per-cpu stats list in __blkg_release(), when no ne=
w stat
> >>>>>>>> can be added
> >>>>>>>>
> >>>>>>>> - don't grab bio->bi_blkg reference when adding the stats into b=
lkcg's
> >>>>>>>> per-cpu stat list since all stats are guaranteed to be consumed =
before
> >>>>>>>> releasing blkg instance, and grabbing blkg reference for stats w=
as the
> >>>>>>>> most fragile part of original patch
> >>>>>>>>
> >>>>>>>> Based on Waiman's patch:
> >>>>>>>>
> >>>>>>>> https://lore.kernel.org/linux-block/20221215033132.230023-3-long=
man@redhat.com/
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> >>>>>>>> Cc: Waiman Long <longman@redhat.com>
> >>>>>>>> Cc: Tejun Heo <tj@kernel.org>
> >>>>>>>> Cc: mkoutny@suse.com
> >>>>>>>> Cc: Yosry Ahmed <yosryahmed@google.com>
> >>>>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>>>>>> ---
> >>>>>>>> V2:
> >>>>>>>>       - remove kernel/cgroup change, and call blkcg_rstat_flush(=
)
> >>>>>>>>       to flush stat directly
> >>>>>>>>
> >>>>>>>>      block/blk-cgroup.c | 29 +++++++++++++++++++++--------
> >>>>>>>>      1 file changed, 21 insertions(+), 8 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> >>>>>>>> index 0ce64dd73cfe..ed0eb8896972 100644
> >>>>>>>> --- a/block/blk-cgroup.c
> >>>>>>>> +++ b/block/blk-cgroup.c
> >>>>>>>> @@ -34,6 +34,8 @@
> >>>>>>>>      #include "blk-ioprio.h"
> >>>>>>>>      #include "blk-throttle.h"
> >>>>>>>> +static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
> >>>>>>>> +
> >>>>>>>>      /*
> >>>>>>>>       * blkcg_pol_mutex protects blkcg_policy[] and policy
> >>>>>>>> [de]activation.
> >>>>>>>>       * blkcg_pol_register_mutex nests outside of it and
> >>>>>>>> synchronizes entire
> >>>>>>>> @@ -163,10 +165,21 @@ static void blkg_free(struct blkcg_gq *blk=
g)
> >>>>>>>>      static void __blkg_release(struct rcu_head *rcu)
> >>>>>>>>      {
> >>>>>>>>          struct blkcg_gq *blkg =3D container_of(rcu, struct
> >>>>>>>> blkcg_gq, rcu_head);
> >>>>>>>> +    struct blkcg *blkcg =3D blkg->blkcg;
> >>>>>>>> +    int cpu;
> >>>>>>>>      #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
> >>>>>>>>          WARN_ON(!bio_list_empty(&blkg->async_bios));
> >>>>>>>>      #endif
> >>>>>>>> +    /*
> >>>>>>>> +     * Flush all the non-empty percpu lockless lists before rel=
easing
> >>>>>>>> +     * us, given these stat belongs to us.
> >>>>>>>> +     *
> >>>>>>>> +     * cgroup locks aren't needed here since __blkcg_rstat_flus=
h just
> >>>>>>>> +     * propagates delta into blkg parent, which is live now.
> >>>>>>>> +     */
> >>>>>>>> +    for_each_possible_cpu(cpu)
> >>>>>>>> +        __blkcg_rstat_flush(blkcg, cpu);
> >>>>>>>>          /* release the blkcg and parent blkg refs this blkg
> >>>>>>>> has been holding */
> >>>>>>>>          css_put(&blkg->blkcg->css);
> >>>>>>>> @@ -951,17 +964,12 @@ static void blkcg_iostat_update(struct
> >>>>>>>> blkcg_gq *blkg, struct blkg_iostat *cur,
> >>>>>>>> u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
> >>>>>>>>      }
> >>>>>>>> -static void blkcg_rstat_flush(struct cgroup_subsys_state
> >>>>>>>> *css, int cpu)
> >>>>>>>> +static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
> >>>>>>>>      {
> >>>>>>>> -    struct blkcg *blkcg =3D css_to_blkcg(css);
> >>>>>>>>          struct llist_head *lhead =3D per_cpu_ptr(blkcg->lhead, =
cpu);
> >>>>>>>>          struct llist_node *lnode;
> >>>>>>>>          struct blkg_iostat_set *bisc, *next_bisc;
> >>>>>>>> -    /* Root-level stats are sourced from system-wide IO stats *=
/
> >>>>>>>> -    if (!cgroup_parent(css->cgroup))
> >>>>>>>> -        return;
> >>>>>>>> -
> >>>>>>>>          rcu_read_lock();
> >>>>>>>>          lnode =3D llist_del_all(lhead);
> >>>>>>>> @@ -991,13 +999,19 @@ static void blkcg_rstat_flush(struct
> >>>>>>>> cgroup_subsys_state *css, int cpu)
> >>>>>>>>              if (parent && parent->parent)
> >>>>>>>>                  blkcg_iostat_update(parent, &blkg->iostat.cur,
> >>>>>>>>                              &blkg->iostat.last);
> >>>>>>>> -        percpu_ref_put(&blkg->refcnt);
> >>>>>>>>          }
> >>>>>>>>      out:
> >>>>>>>>          rcu_read_unlock();
> >>>>>>>>      }
> >>>>>>>> +static void blkcg_rstat_flush(struct cgroup_subsys_state
> >>>>>>>> *css, int cpu)
> >>>>>>>> +{
> >>>>>>>> +    /* Root-level stats are sourced from system-wide IO stats *=
/
> >>>>>>>> +    if (cgroup_parent(css->cgroup))
> >>>>>>>> +        __blkcg_rstat_flush(css_to_blkcg(css), cpu);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>> I think it may not safe to call __blkcg_rstat_flus() directly
> >>>>>>> without taking
> >>>>>>> the cgroup_rstat_cpu_lock. That is why I added a helper to
> >>>>>>> kernel/cgroup/rstat.c in my patch to meet the locking requirement=
.
> >>>>>> All stats are removed from llist_del_all(), and the local list is
> >>>>>> iterated, then each blkg & its parent is touched in
> >>>>>> __blkcg_rstat_flus(), so
> >>>>>> can you explain it a bit why cgroup locks are needed? For protecti=
ng
> >>>>>> what?
> >>>>> You are right. The llist_del_all() call in blkcg_rstat_flush() is
> >>>>> atomic, so it is safe for concurrent execution which is what the
> >>>>> cgroup_rstat_cpu_lock protects against. That may not be the case fo=
r
> >>>>> rstat callbacks of other controllers. So I will suggest you to add =
a
> >>>>> comment to clarify that point. Other than that, you patch looks goo=
d to
> >>>>> me.
> >>>>>
> >>>>> Reviewed: Waiman Long <longman@redhat.com>
> >>>> After some more thought, I need to retract my reviewed-by tag for no=
w. There
> >>>> is a slight possibility that blkcg_iostat_update() in blkcg_rstat_fl=
ush()
> >>>> can happen concurrently which will corrupt the sequence count.
> >>> llist_del_all() moves all 'bis' into one local list, and bis is one p=
ercpu
> >>> variable of blkg, so in theory same bis won't be flushed at the same
> >>> time. And one bis should be touched in just one of stat flush code pa=
th
> >>> because of llist_del_all().
> >>>
> >>> So 'bis' still can be thought as being flushed in serialized way.
> >>>
> >>> However, blk_cgroup_bio_start() runs concurrently with blkcg_rstat_fl=
ush(),
> >>> so once bis->lqueued is cleared in blkcg_rstat_flush(), this same bis
> >>> could be added to the percpu llist and __blkcg_rstat_flush() from blk=
g_release()
> >>> follows. This should be the only chance for concurrent stats update.
> >> That is why I have in mind. A __blkcg_rstat_flush() can be from
> >> blkg_release() and another one from the regular cgroup_rstat_flush*().
> >>
> >>
> >>> But, blkg_release() is run in RCU callback, so the previous flush has
> >>> been done, but new flush can come, and other blkg's stat could be add=
ed
> >>> with same story above.
> >>>
> >>>> One way to
> >>>> avoid that is to synchronize it by cgroup_rstat_cpu_lock. Another wa=
y is to
> >>>> use the bisc->lqueued for synchronization.
> >>> I'd avoid the external cgroup lock here.
> >>>
> >>>> In that case, you need to move
> >>>> WRITE_ONCE(bisc->lqueued, false) in blkcg_rstat_flush() to the end a=
fter all
> >>>> the  blkcg_iostat_update() call with smp_store_release() and replace=
 the
> >>>> READ_ONCE(bis->lqueued) check in blk_cgroup_bio_start() with
> >>>> smp_load_acquire().
> >>> This way looks doable, but I guess it still can't avoid concurrent up=
date on parent
> >>> stat, such as when  __blkcg_rstat_flush() from blkg_release() is
> >>> in-progress, another sibling blkg's bis is added, meantime
> >>> blkcg_rstat_flush() is called.
> >> I realized that the use of cgroup_rstat_cpu_lock or the alternative wa=
s
> >> not safe enough for preventing concurrent parent blkg rstat update.
> >>> Another way is to add blkcg->stat_lock for covering __blkcg_rstat_flu=
sh(), what
> >>> do you think of this way?
> >> I am thinking of adding a raw spinlock into blkg and take it when doin=
g
> >> blkcg_iostat_update(). This can guarantee no concurrent update to rsta=
t
> >> data. It has to be a raw spinlock as it will be under the
> >> cgroup_rstat_cpu_lock raw spinlock.
> > Hi Waiman,
> >
> > I don't have context about blkcg, but isn't this exactly what
> > cgroup_rstat_lock does? Is it too expensive to just call
> > cgroup_rstat_flush () here?
>
> I have thought about that too. However, in my test, just calling
> cgroup_rstat_flush() in blkcg_destroy_blkgs() did not prevent dying
> blkcgs from increasing meaning that there are still some extra
> references blocking its removal. I haven't figured out exactly why that
> is the case. There may still be some races that we have not fully
> understood yet. On the other hand, Ming's patch is verified to not do
> that since it does not take extra blkg references. So I am leaning on
> his patch now. I just have to make sure that there is no concurrent
> rstat update.

Oh I didn't mean to change Ming's approach of not taking extra blkg
references, just replacing:

for_each_possible_cpu(cpu)
               __blkcg_rstat_flush(blkcg, cpu);

with:

cgroup_rstat_flush(blkcg->css.cgroup);

in the current patch, so that we get the protection from
cgroup_rstat_lock against concurrent rstat updates.

>
> Cheers,
> Longman
>
