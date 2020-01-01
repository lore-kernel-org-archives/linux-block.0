Return-Path: <SRS0=IQ6F=2W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE65C2D0DE
	for <linux-block@archiver.kernel.org>; Wed,  1 Jan 2020 02:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561782072C
	for <linux-block@archiver.kernel.org>; Wed,  1 Jan 2020 02:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAau3f6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgAACeN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Dec 2019 21:34:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50565 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgAACeN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Dec 2019 21:34:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so2910880wmb.0;
        Tue, 31 Dec 2019 18:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NKtIy+dylNRO9AzfP0HNmqRXpFCWrksWEu6St2/HkO8=;
        b=lAau3f6LJNhlVNj9YhWGemXXRTC++aiGPDtAGOuPXRkQY0rOgC+mmQEroCczc5749p
         hapfDP75XPHoeh9Ms4M3QwYsSflfa5IXpJEMCm/4KyCetdJl87gyPfP7IyZYTH8Gje2F
         SZ8mqgBYwo8U6rHOMDwhWwj3a7CqrLJ/7BYK4XZh8ofYHjYcrIT6TVIICO5iQU54u11P
         ib+UW9XNn37Eysg/nALZXYpI9rFMy9T5Ah/uVeouvJh5hVM1K060ODNCB1hDta9LxhRz
         AeVm7+6ywjx8MPA9wILQcscYJrIVkRKmd9dztnpztgcMYVjRrLhX+Et5s++f2ALn5CCF
         GbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NKtIy+dylNRO9AzfP0HNmqRXpFCWrksWEu6St2/HkO8=;
        b=Si0oi1orSPLglk5RAm1sIxJDHVaWm3PDL7ddURptlADTrCy+3yN+7SSMl3Z2aPxxbN
         1aijBhxA2U7P7IUICC+zX89sQDkBHHJ4WmJN0pKFf3j6xChd9l/ZVq041plg6gc6SFCz
         TsVFEGSq8km4UYwPrFC6I0qpPlivRA2xwqdZsmGWgAsueA/KcCSe05fwVyjxuAnJzICq
         SG0ndRsO5jN7qJFRwKMfK5OviyOJ5zy3md6758p0KiTfoUUoEhIspEO//7L7tQ2ODkD6
         ZOOhJxUTe+5XK9wWvIZXorwTNaGEyDRux0iKBlKOYJER9rlGKt9YtVIrp/sauOfKBDTF
         YDJA==
X-Gm-Message-State: APjAAAVuo+a9kIJVMYtFAqu1bNzTG0n1X/ApH6PWthW0J295sMkZ2dBv
        I1vHqXbwP5a+sNpBbWTUS4TOukQky/710Vh+Rpk=
X-Google-Smtp-Source: APXvYqz+ACxSsrs5HxK+WphBaEOllov1twF9S703xhav07Fb73FfajhZyE18cC+9bJbGd069tEZwZCgoyy+idvNgvmY=
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr7141337wmj.175.1577846050794;
 Tue, 31 Dec 2019 18:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20191231110945.10857-1-yuyufen@huawei.com> <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
 <20191231231158.GW13449@paulmck-ThinkPad-P72>
In-Reply-To: <20191231231158.GW13449@paulmck-ThinkPad-P72>
From:   htbegin <hotforest@gmail.com>
Date:   Wed, 1 Jan 2020 10:33:59 +0800
Message-ID: <CANUnq3aSSyMcPZWj98iNza2VhLOpOUP49tPCChoiz0ghbaGjoQ@mail.gmail.com>
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part deleted
To:     paulmck@kernel.org
Cc:     Hou Tao <houtao1@huawei.com>, Yufen Yu <yuyufen@huawei.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com,
        hch@lst.de, zhengchuan@huawei.com, yi.zhang@huawei.com,
        joel@joelfernandes.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Paul,

Paul E. McKenney <paulmck@kernel.org> =E4=BA=8E2020=E5=B9=B41=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=887:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Dec 31, 2019 at 10:55:47PM +0800, Hou Tao wrote:
> > Hi,
> >
> > On 2019/12/31 19:09, Yufen Yu wrote:
> > > When delete partition executes concurrently with IOs issue,
> > > it may cause use-after-free on part in disk_map_sector_rcu()
> > > as following:
> > snip
> >
> > >
> > > diff --git a/block/genhd.c b/block/genhd.c
> > > index ff6268970ddc..39fa8999905f 100644
> > > --- a/block/genhd.c
> > > +++ b/block/genhd.c
> > > @@ -293,7 +293,23 @@ struct hd_struct *disk_map_sector_rcu(struct gen=
disk *disk, sector_t sector)
> > >             part =3D rcu_dereference(ptbl->part[i]);
> > >
> > >             if (part && sector_in_part(part, sector)) {
> > snip
> >
> > >                     rcu_assign_pointer(ptbl->last_lookup, part);
> > > +                   part =3D rcu_dereference(ptbl->part[i]);
> > > +                   if (part =3D=3D NULL) {
> > > +                           rcu_assign_pointer(ptbl->last_lookup, NUL=
L);
> > > +                           break;
> > > +                   }
> > >                     return part;
> > >             }
> > >     }
> >
> > Not ensure whether the re-read can handle the following case or not:
> >
> > process A                                 process B                    =
      process C
> >
> > disk_map_sector_rcu():                    delete_partition():          =
     disk_map_sector_rcu():
> >
> > rcu_read_lock
> >
> >   // need to iterate partition table
> >   part[i] !=3D NULL   (1)                   part[i] =3D NULL (2)
> >                                           smp_mb()
> >                                           last_lookup =3D NULL (3)
> >                                           call_rcu()  (4)
> >     last_lookup =3D part[i] (5)
> >
> >
> >                                                                        =
      rcu_read_lock()
> >                                                                        =
      read last_lookup return part[i] (6)
> >                                                                        =
      sector_in_part() is OK (7)
> >                                                                        =
      return part[i] (8)
>
> Just for the record...
>
> Use of RCU needs to ensure that readers cannot access the to-be-freed
> structure -before- invoking call_rcu().  Which does look to happen here
> with the "last_lookup =3D NULL".

But the last_lookup pointer may be reassigned a to-be-freed pointer (namely
part[i]) as show in process A, and I think the RCU read section starts afte=
r
the call of call_rcu() may read the reassigned pointer and use it, right ?

> But in addition, the callback needs to
> get access to the to-be-freed structure via some sideband (usually the
> structure passed to call_rcu()), not from the reader-accessible structure=
.
>
Er, could you clarify the meaning of "reader-accessible structure" ? Do you
mean "reader-writable structure" like last_lookup ? In the case, the callba=
ck
does access the to-be-freed struct by the embedded "rcu_work".

> Or am I misinterpreting this sequence of events?
>
Ah, I over simplify the procedures happened in process B. Does the followin=
g
diagram make it clearer ?

process A                           process B                     process C

disk_map_sector_rcu():              delete_partition():
disk_map_sector_rcu():

rcu_read_lock

  // iterate part table
  part[i] !=3D NULL   (1)
                                    deleted =3D part[i]
                                    part[i] =3D NULL (2)
                                    smp_mb()
                                    last_lookup =3D NULL (3)

                                    percpu_ref_kill(deleted)
                                      // last ref
                                      __delete_partition (4)
                                        queue_rcu_work
    // re-assign last_lookup
    last_lookup =3D part[i] (5)



rcu_read_lock()
                                                                  //
hit last_lookup
                                                                  read
last_lookup returns part[i] (6)

sector_in_part() is OK (7)
                                                                  will
return part[i] (8)

rcu_read_unlock()

  // found part[i] is NULL
  // reassign last_lookup
  last_lookup =3D NULL
  will return part0

  rcu_read_unlock
                                    // RCU callback
                                    delete_partition_work_fn
                                      free deleted
                                                                   //
use-after-free ?

hd_struct_try_get
Regards,
Tao


>                                                         Thanx, Paul
>
> >   part[i] =3D=3D NULL (9)
> >       last_lookup =3D NULL (10)
> >   rcu_read_unlock() (11)
> >                                            one RCU grace period complet=
es
> >                                            __delete_partition() (12)
> >                                            free hd_partition (13)
> >                                                                        =
      // use-after-free
> >                                                                        =
      hd_struct_try_get(part[i])  (14)
> >
> > * the number in the parenthesis is the sequence of events.
> >
> > Maybe RCU experts can shed some light on this problem, so cc +paulmck@k=
ernel.org, +joel@joelfernandes.org and +RCU maillist.
> >
> > If the above case is possible, maybe we can fix the problem by pinning =
last_lookup through increasing its ref-count
> > (the following patch is only compile tested):
> >
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 6e8543ca6912..179e0056fae1 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -279,7 +279,14 @@ struct hd_struct *disk_map_sector_rcu(struct gendi=
sk *disk, sector_t sector)
> >               part =3D rcu_dereference(ptbl->part[i]);
> >
> >               if (part && sector_in_part(part, sector)) {
> > -                     rcu_assign_pointer(ptbl->last_lookup, part);
> > +                     struct hd_struct *old;
> > +
> > +                     if (!hd_struct_try_get(part))
> > +                             break;
> > +
> > +                     old =3D xchg(&ptbl->last_lookup, part);
> > +                     if (old)
> > +                             hd_struct_put(old);
> >                       return part;
> >               }
> >       }
> > @@ -1231,7 +1238,11 @@ static void disk_replace_part_tbl(struct gendisk=
 *disk,
> >       rcu_assign_pointer(disk->part_tbl, new_ptbl);
> >
> >       if (old_ptbl) {
> > -             rcu_assign_pointer(old_ptbl->last_lookup, NULL);
> > +             struct hd_struct *part;
> > +
> > +             part =3D xchg(&old_ptbl->last_lookup, NULL);
> > +             if (part)
> > +                     hd_struct_put(part);
> >               kfree_rcu(old_ptbl, rcu_head);
> >       }
> >  }
> > diff --git a/block/partition-generic.c b/block/partition-generic.c
> > index 98d60a59b843..441c1c591c04 100644
> > --- a/block/partition-generic.c
> > +++ b/block/partition-generic.c
> > @@ -285,7 +285,8 @@ void delete_partition(struct gendisk *disk, int par=
tno)
> >               return;
> >
> >       rcu_assign_pointer(ptbl->part[partno], NULL);
> > -     rcu_assign_pointer(ptbl->last_lookup, NULL);
> > +     if (cmpxchg(&ptbl->last_lookup, part, NULL) =3D=3D part)
> > +             hd_struct_put(part);
> >       kobject_put(part->holder_dir);
> >       device_del(part_to_dev(part));
> >
> > --
> > 2.22.0
> >
> > Regards,
> > Tao
> >
> >
> > > diff --git a/block/partition-generic.c b/block/partition-generic.c
> > > index 1d20c9cf213f..1e0065ed6f02 100644
> > > --- a/block/partition-generic.c
> > > +++ b/block/partition-generic.c
> > > @@ -284,6 +284,13 @@ void delete_partition(struct gendisk *disk, int =
partno)
> > >             return;
> > >
> > >     rcu_assign_pointer(ptbl->part[partno], NULL);
> > > +   /*
> > > +    * Without the memory barrier, disk_map_sector_rcu()
> > > +    * may read the old value after overwriting the
> > > +    * last_lookup. Then it can not clear last_lookup,
> > > +    * which may cause use-after-free.
> > > +    */
> > > +   smp_mb();
> > >     rcu_assign_pointer(ptbl->last_lookup, NULL);
> > >     kobject_put(part->holder_dir);
> > >     device_del(part_to_dev(part));
> > >
> >
