Return-Path: <decui@microsoft.com>
From: Dexuan Cui <decui@microsoft.com>
To: Hannes Reinecke <hare@suse.com>, Bart Van Assche
	<Bart.VanAssche@sandisk.com>, "hare@suse.de" <hare@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jth@kernel.org" <jth@kernel.org>
Subject: RE: [PATCH] genhd: Do not hold event lock when scheduling workqueue
 elements
Date: Tue, 7 Feb 2017 02:23:06 +0000
Message-ID: <MWHPR03MB26699D4657FB67A535972208BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
References: <1484732896-22941-1-git-send-email-hare@suse.de>
 <1485822639.2669.16.camel@sandisk.com>
 <532c55c4-15da-d2f9-401c-36bc4343756b@suse.com>
 <MWHPR03MB2669B8A45A07846AF0A06E46BF4F0@MWHPR03MB2669.namprd03.prod.outlook.com>
In-Reply-To: <MWHPR03MB2669B8A45A07846AF0A06E46BF4F0@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

> From: linux-block-owner@vger.kernel.org [mailto:linux-block-
> owner@vger.kernel.org] On Behalf Of Dexuan Cui
> Sent: Friday, February 3, 2017 20:23
> To: Hannes Reinecke <hare@suse.com>; Bart Van Assche
> <Bart.VanAssche@sandisk.com>; hare@suse.de; axboe@kernel.dk
> Cc: hch@lst.de; linux-kernel@vger.kernel.org; linux-block@vger.kernel.org=
;
> jth@kernel.org
> Subject: RE: [PATCH] genhd: Do not hold event lock when scheduling workqu=
eue
> elements
>=20
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > owner@vger.kernel.org] On Behalf Of Hannes Reinecke
> > Sent: Wednesday, February 1, 2017 00:15
> > To: Bart Van Assche <Bart.VanAssche@sandisk.com>; hare@suse.de;
> > axboe@kernel.dk
> > Cc: hch@lst.de; linux-kernel@vger.kernel.org; linux-block@vger.kernel.o=
rg;
> > jth@kernel.org
> > Subject: Re: [PATCH] genhd: Do not hold event lock when scheduling
> workqueue
> > elements
> >
> > On 01/31/2017 01:31 AM, Bart Van Assche wrote:
> > > On Wed, 2017-01-18 at 10:48 +0100, Hannes Reinecke wrote:
> > >> @@ -1488,26 +1487,13 @@ static unsigned long
> > disk_events_poll_jiffies(struct gendisk *disk)
> > >>  void disk_block_events(struct gendisk *disk)
> > >>  {
> > >>         struct disk_events *ev =3D disk->ev;
> > >> -       unsigned long flags;
> > >> -       bool cancel;
> > >>
> > >>         if (!ev)
> > >>                 return;
> > >>
> > >> -       /*
> > >> -        * Outer mutex ensures that the first blocker completes canc=
eling
> > >> -        * the event work before further blockers are allowed to fin=
ish.
> > >> -        */
> > >> -       mutex_lock(&ev->block_mutex);
> > >> -
> > >> -       spin_lock_irqsave(&ev->lock, flags);
> > >> -       cancel =3D !ev->block++;
> > >> -       spin_unlock_irqrestore(&ev->lock, flags);
> > >> -
> > >> -       if (cancel)
> > >> +       if (atomic_inc_return(&ev->block) =3D=3D 1)
> > >>                 cancel_delayed_work_sync(&disk->ev->dwork);
> > >>
> > >> -       mutex_unlock(&ev->block_mutex);
> > >>  }
> > >
> > > Hello Hannes,
> > >
> > > I have already encountered a few times a deadlock that was caused by =
the
> > > event checking code so I agree with you that it would be a big step f=
orward
> > > if such deadlocks wouldn't occur anymore. However, this patch realize=
s a
> > > change that has not been described in the patch description, namely t=
hat
> > > disk_block_events() calls are no longer serialized. Are you sure it i=
s safe
> > > to drop the serialization of disk_block_events() calls?
> > >
> > Well, this whole synchronization stuff it a bit weird; I so totally fai=
l
> > to see the rationale for it.
> > But anyway, once we've converted ev->block to atomics I _think_ the
> > mutex_lock can remain; will be checking.
> >
> > Cheers,
> >
> > Hannes
> > --
>=20
> Hi, I think I got the same calltrace with today's linux-next (next-201702=
03).
>=20
> The issue happened every time when my Linux virtual machine booted and
> Hannes's patch could NOT help.
>=20
> The calltrace is pasted below.
>=20
> -- Dexuan
=20
Any news on this thread?

The issue is still blocking Linux from booting up normally in my test. :-(

Have we identified the faulty patch?
If so, at least I can try to revert it to boot up.

Thanks,
-- Dexuan
