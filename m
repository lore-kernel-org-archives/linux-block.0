Return-Path: <SRS0=IQ6F=2W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A96C2D0DE
	for <linux-block@archiver.kernel.org>; Wed,  1 Jan 2020 03:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEE520722
	for <linux-block@archiver.kernel.org>; Wed,  1 Jan 2020 03:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3gIVjYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgAADkQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Dec 2019 22:40:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45288 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgAADkQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Dec 2019 22:40:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so36317426wrj.12;
        Tue, 31 Dec 2019 19:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1me1gHKTWIwuRXaIZ3pqOKWLwjeEXwgvuSKCL+ApIbQ=;
        b=q3gIVjYEPGX40m+Eu6gvrLAXZqdo13VfQDhaDywGmNbyth4X5W8pNOEArsO2mP5Mbq
         0HpmQatkkrJv+pEFT5ZSyDlXb851hYqDJJsUP+hFI5gmM0NBKXrSLq0WF+9MXhHroTrZ
         xjyNYNht5YeES6kHQ1yuW3qpw+cqRE6VPfeeAZseTCt3sTHcPhUxxJa/kHH5kOPHuQPs
         ZFya+6Vco+o6QXyCrgBt88BTgnpZDRKO6I/94QkiaHcHF09sqZbXrreNU+CJ0XTPFSdI
         7e9ceUPc3UXifmOpzPRgeipvRTHxunPpAbiUXlQT5+W6HxLV4IJFDRbaJmYDUVfB1HJw
         Iv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1me1gHKTWIwuRXaIZ3pqOKWLwjeEXwgvuSKCL+ApIbQ=;
        b=Xj2/TvNMbzNBRMJz3pW68yaZIv26eshRffxmiiRv4ShJV/tnirIrUnN5I371acsyHr
         g37VLRnlJSz17V4QCS+VCjGwoGBIPwKwKjcIiZWHg3pu26LpiAWmtBDpWccfLcyTzt4K
         Cwchc/d/fx3QfD8ASKxszi9LVoZ4CV3UfZ1izOSb6LRsQN+OuHNImoD4nV4Bw6jT/SXf
         KfISptjd628vZkj0SiA9MKCTLXLNxSY5TFjcCJPT4nqpbZ7GTicSshVpKaT7BNwYVXzF
         o45IY+aM2bFlMawV8D1YbaWZ9wqvawV+SJXz29U9halS2DBFi+7LNE/VDNd7eVYkytOY
         iHyA==
X-Gm-Message-State: APjAAAXEjGCp8auQWHwccfMKLw9tcf+BPSCsgPR+4nXUNE1t8kDjR6Vu
        dZe4KZX6dRgC4QwW5OfAvZS4dN1Pg8zTIENDnOs=
X-Google-Smtp-Source: APXvYqwtYLO9IkK5DCLYHvoXXv/gDJMrle1QnpEGmYZbaAhM7IVSE7r1LLkxIqo6iMt6y87SqAXEEZ/Hh6Cf7Im87iw=
X-Received: by 2002:adf:c74f:: with SMTP id b15mr74514526wrh.272.1577850013160;
 Tue, 31 Dec 2019 19:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20191231110945.10857-1-yuyufen@huawei.com> <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
 <20191231231158.GW13449@paulmck-ThinkPad-P72> <CANUnq3aSSyMcPZWj98iNza2VhLOpOUP49tPCChoiz0ghbaGjoQ@mail.gmail.com>
In-Reply-To: <CANUnq3aSSyMcPZWj98iNza2VhLOpOUP49tPCChoiz0ghbaGjoQ@mail.gmail.com>
From:   htbegin <hotforest@gmail.com>
Date:   Wed, 1 Jan 2020 11:39:59 +0800
Message-ID: <CANUnq3aN0ihDknGoYCH1bnjktoCGPh5239-pPc+ELHHZ5b=8kA@mail.gmail.com>
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

Sorry, it seems that i miss-formatted the diagram, so I resend it here:

process A                    process B            process C

disk_map_sector_rcu():       delete_partition():  disk_map_sector_rcu():

rcu_read_lock

  // iterate part table
  part[i] !=3D NULL  (1)

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
                                                  // is it possible ?
                                                  last_lookup is part[i] (6=
)
                                                  sector_in_part() is OK (7=
)
                                                  will return part[i] (8)
                                                  rcu_read_unlock()

  // found part[i] is NULL
  // reassign last_lookup
  last_lookup =3D NULL
  will return part0
  rcu_read_unlock

                               // RCU callback
                               delete_partition_work_fn
                                 free deleted
                                                       // use-after-free ?
                                                       hd_struct_try_get

On Wed, Jan 1, 2020 at 10:33 AM htbegin <hotforest@gmail.com> wrote:
>
> Hi Paul,
>
> Paul E. McKenney <paulmck@kernel.org> =E4=BA=8E2020=E5=B9=B41=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=887:13=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On Tue, Dec 31, 2019 at 10:55:47PM +0800, Hou Tao wrote:
> > > Hi,
> > >
> > > On 2019/12/31 19:09, Yufen Yu wrote:
> > > > When delete partition executes concurrently with IOs issue,
> > > > it may cause use-after-free on part in disk_map_sector_rcu()
> > > > as following:
> > > snip
> > >
> > > >
> > > > diff --git a/block/genhd.c b/block/genhd.c
> > > > index ff6268970ddc..39fa8999905f 100644
> > > > --- a/block/genhd.c
> > > > +++ b/block/genhd.c
> > > > @@ -293,7 +293,23 @@ struct hd_struct *disk_map_sector_rcu(struct g=
endisk *disk, sector_t sector)
> > > >             part =3D rcu_dereference(ptbl->part[i]);
> > > >
> > > >             if (part && sector_in_part(part, sector)) {
> > > snip
> > >
> > > >                     rcu_assign_pointer(ptbl->last_lookup, part);
> > > > +                   part =3D rcu_dereference(ptbl->part[i]);
> > > > +                   if (part =3D=3D NULL) {
> > > > +                           rcu_assign_pointer(ptbl->last_lookup, N=
ULL);
> > > > +                           break;
> > > > +                   }
> > > >                     return part;
> > > >             }
> > > >     }
> > >
> > > Not ensure whether the re-read can handle the following case or not:
> > >
> > > process A                                 process B                  =
        process C
> > >
> > > disk_map_sector_rcu():                    delete_partition():        =
       disk_map_sector_rcu():
> > >
> > > rcu_read_lock
> > >
> > >   // need to iterate partition table
> > >   part[i] !=3D NULL   (1)                   part[i] =3D NULL (2)
> > >                                           smp_mb()
> > >                                           last_lookup =3D NULL (3)
> > >                                           call_rcu()  (4)
> > >     last_lookup =3D part[i] (5)
> > >
> > >
> > >                                                                      =
        rcu_read_lock()
> > >                                                                      =
        read last_lookup return part[i] (6)
> > >                                                                      =
        sector_in_part() is OK (7)
> > >                                                                      =
        return part[i] (8)
> >
> > Just for the record...
> >
> > Use of RCU needs to ensure that readers cannot access the to-be-freed
> > structure -before- invoking call_rcu().  Which does look to happen here
> > with the "last_lookup =3D NULL".
>
> But the last_lookup pointer may be reassigned a to-be-freed pointer (name=
ly
> part[i]) as show in process A, and I think the RCU read section starts af=
ter
> the call of call_rcu() may read the reassigned pointer and use it, right =
?
>
> > But in addition, the callback needs to
> > get access to the to-be-freed structure via some sideband (usually the
> > structure passed to call_rcu()), not from the reader-accessible structu=
re.
> >
> Er, could you clarify the meaning of "reader-accessible structure" ? Do y=
ou
> mean "reader-writable structure" like last_lookup ? In the case, the call=
back
> does access the to-be-freed struct by the embedded "rcu_work".
>
> > Or am I misinterpreting this sequence of events?
> >
> Ah, I over simplify the procedures happened in process B. Does the follow=
ing
> diagram make it clearer ?
>
> process A                           process B                     process=
 C
>
> disk_map_sector_rcu():              delete_partition():
> disk_map_sector_rcu():
>
> rcu_read_lock
>
>   // iterate part table
>   part[i] !=3D NULL   (1)
>                                     deleted =3D part[i]
>                                     part[i] =3D NULL (2)
>                                     smp_mb()
>                                     last_lookup =3D NULL (3)
>
>                                     percpu_ref_kill(deleted)
>                                       // last ref
>                                       __delete_partition (4)
>                                         queue_rcu_work
>     // re-assign last_lookup
>     last_lookup =3D part[i] (5)
>
>
>
> rcu_read_lock()
>                                                                   //
> hit last_lookup
>                                                                   read
> last_lookup returns part[i] (6)
>
> sector_in_part() is OK (7)
>                                                                   will
> return part[i] (8)
>
> rcu_read_unlock()
>
>   // found part[i] is NULL
>   // reassign last_lookup
>   last_lookup =3D NULL
>   will return part0
>
>   rcu_read_unlock
>                                     // RCU callback
>                                     delete_partition_work_fn
>                                       free deleted
>                                                                    //
> use-after-free ?
>
> hd_struct_try_get
> Regards,
> Tao
>
>
> >                                                         Thanx, Paul
> >
> > >   part[i] =3D=3D NULL (9)
> > >       last_lookup =3D NULL (10)
> > >   rcu_read_unlock() (11)
> > >                                            one RCU grace period compl=
etes
> > >                                            __delete_partition() (12)
> > >                                            free hd_partition (13)
> > >                                                                      =
        // use-after-free
> > >                                                                      =
        hd_struct_try_get(part[i])  (14)
> > >
> > > * the number in the parenthesis is the sequence of events.
> > >
> > > Maybe RCU experts can shed some light on this problem, so cc +paulmck=
@kernel.org, +joel@joelfernandes.org and +RCU maillist.
> > >
> > > If the above case is possible, maybe we can fix the problem by pinnin=
g last_lookup through increasing its ref-count
> > > (the following patch is only compile tested):
> > >
> > > diff --git a/block/genhd.c b/block/genhd.c
> > > index 6e8543ca6912..179e0056fae1 100644
> > > --- a/block/genhd.c
> > > +++ b/block/genhd.c
> > > @@ -279,7 +279,14 @@ struct hd_struct *disk_map_sector_rcu(struct gen=
disk *disk, sector_t sector)
> > >               part =3D rcu_dereference(ptbl->part[i]);
> > >
> > >               if (part && sector_in_part(part, sector)) {
> > > -                     rcu_assign_pointer(ptbl->last_lookup, part);
> > > +                     struct hd_struct *old;
> > > +
> > > +                     if (!hd_struct_try_get(part))
> > > +                             break;
> > > +
> > > +                     old =3D xchg(&ptbl->last_lookup, part);
> > > +                     if (old)
> > > +                             hd_struct_put(old);
> > >                       return part;
> > >               }
> > >       }
> > > @@ -1231,7 +1238,11 @@ static void disk_replace_part_tbl(struct gendi=
sk *disk,
> > >       rcu_assign_pointer(disk->part_tbl, new_ptbl);
> > >
> > >       if (old_ptbl) {
> > > -             rcu_assign_pointer(old_ptbl->last_lookup, NULL);
> > > +             struct hd_struct *part;
> > > +
> > > +             part =3D xchg(&old_ptbl->last_lookup, NULL);
> > > +             if (part)
> > > +                     hd_struct_put(part);
> > >               kfree_rcu(old_ptbl, rcu_head);
> > >       }
> > >  }
> > > diff --git a/block/partition-generic.c b/block/partition-generic.c
> > > index 98d60a59b843..441c1c591c04 100644
> > > --- a/block/partition-generic.c
> > > +++ b/block/partition-generic.c
> > > @@ -285,7 +285,8 @@ void delete_partition(struct gendisk *disk, int p=
artno)
> > >               return;
> > >
> > >       rcu_assign_pointer(ptbl->part[partno], NULL);
> > > -     rcu_assign_pointer(ptbl->last_lookup, NULL);
> > > +     if (cmpxchg(&ptbl->last_lookup, part, NULL) =3D=3D part)
> > > +             hd_struct_put(part);
> > >       kobject_put(part->holder_dir);
> > >       device_del(part_to_dev(part));
> > >
> > > --
> > > 2.22.0
> > >
> > > Regards,
> > > Tao
> > >
> > >
> > > > diff --git a/block/partition-generic.c b/block/partition-generic.c
> > > > index 1d20c9cf213f..1e0065ed6f02 100644
> > > > --- a/block/partition-generic.c
> > > > +++ b/block/partition-generic.c
> > > > @@ -284,6 +284,13 @@ void delete_partition(struct gendisk *disk, in=
t partno)
> > > >             return;
> > > >
> > > >     rcu_assign_pointer(ptbl->part[partno], NULL);
> > > > +   /*
> > > > +    * Without the memory barrier, disk_map_sector_rcu()
> > > > +    * may read the old value after overwriting the
> > > > +    * last_lookup. Then it can not clear last_lookup,
> > > > +    * which may cause use-after-free.
> > > > +    */
> > > > +   smp_mb();
> > > >     rcu_assign_pointer(ptbl->last_lookup, NULL);
> > > >     kobject_put(part->holder_dir);
> > > >     device_del(part_to_dev(part));
> > > >
> > >
