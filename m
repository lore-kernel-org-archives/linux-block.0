Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180227100750.32299-1-ming.lei@redhat.com> <20180227100750.32299-9-ming.lei@redhat.com>
 <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com> <20180307052725.GB15024@ming.t460p>
 <659dc50c3814c8c5b69abb20c3cc39c8@mail.gmail.com> <20180307160509.GA10572@ming.t460p>
 <337036cc74d4a5665d68afd718382235@mail.gmail.com> <20180308011540.GA11845@ming.t460p>
In-Reply-To: <20180308011540.GA11845@ming.t460p>
MIME-Version: 1.0
Date: Thu, 8 Mar 2018 15:34:31 +0530
Message-ID: <45ba4cc7328786fd5b536362b686b5a3@mail.gmail.com>
Subject: RE: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance via .host_tagset
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@redhat.com>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Arun Easi <arun.easi@cavium.com>, Omar Sandoval <osandov@fb.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>, Christoph Hellwig <hch@lst.de>,
	Don Brace <don.brace@microsemi.com>, Peter Rivera <peter.rivera@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

> -----Original Message-----
> From: Ming Lei [mailto:ming.lei@redhat.com]
> Sent: Thursday, March 8, 2018 6:46 AM
> To: Kashyap Desai
> Cc: Jens Axboe; linux-block@vger.kernel.org; Christoph Hellwig; Mike
Snitzer;
> linux-scsi@vger.kernel.org; Hannes Reinecke; Arun Easi; Omar Sandoval;
> Martin K . Petersen; James Bottomley; Christoph Hellwig; Don Brace;
Peter
> Rivera; Laurence Oberman
> Subject: Re: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance
via
> .host_tagset
>
> On Wed, Mar 07, 2018 at 10:58:34PM +0530, Kashyap Desai wrote:
> > > >
> > > > Also one observation using V3 series patch. I am seeing below
> > > > Affinity mapping whereas I have only 72 logical CPUs.  It means we
> > > > are really not going to use all reply queues.
> > > > e.a If I bind fio jobs on CPU 18-20, I am seeing only one reply
> > > > queue is used and that may lead to performance drop as well.
> > >
> > > If the mapping is in such shape, I guess it should be quite
> > > difficult to
> > figure out
> > > one perfect way to solve this situation because one reply queue has
> > > to
> > handle
> > > IOs submitted from 4~5 CPUs at average.
> >
> > 4.15.0-rc1 kernel has below mapping - I am not sure which commit id in
"
> > linux_4.16-rc-host-tags-v3.2" is changing the mapping of IRQ to CPU.
> > It
>
> I guess the mapping you posted is read from /proc/irq/126/smp_affinity.
>
> If yes, no any patch in linux_4.16-rc-host-tags-v3.2 should change IRQ
affinity
> code, which is done in irq_create_affinity_masks(), as you saw, no any
patch
> in linux_4.16-rc-host-tags-v3.2 touches that code.
>
> Could you simply apply the patches in linux_4.16-rc-host-tags-v3.2
against
> 4.15-rc1 kernel and see any difference?
>
> > will be really good if we can fall back to below mapping once again.
> > Current repo linux_4.16-rc-host-tags-v3.2 is giving lots of random
> > mapping of CPU - MSIx. And that will be problematic in performance
run.
> >
> > As I posted earlier, latest repo will only allow us to use *18* reply
>
> Looks not see this report before, could you share us how you conclude
that?
> The only patch changing reply queue is the following one:
>
> 	https://marc.info/?l=linux-block&m=151972611911593&w=2
>
> But not see any issue in this patch yet, can you recover to 72 reply
queues
> after reverting the patch in above link?
Ming -

While testing, my system went bad. I debug further and understood that
affinity mapping was changed due to below commit -
84676c1f21e8ff54befe985f4f14dc1edc10046b

[PATCH] genirq/affinity: assign vectors to all possible CPUs

Because of above change, we end up using very less reply queue. Many reply
queues on my setup was mapped to offline/not-available CPUs. This may be
primary contributing to odd performance impact and it may not be truly due
to V3/V4 patch series.

I am planning to check your V3 and V4 series after removing above commit
ID (for performance impact.).

It is good if we spread possible CPUs (instead of online cpus) to all irq
vectors  considering -  We should have at least *one* online CPU mapped to
the vector.

>
> > queue instead of *72*.  Lots of performance related issue can be pop
> > up on different setup due to inconsistency in CPU - MSIx mapping. BTW,
> > changes in this area is intentional @" linux_4.16-rc-host-tags-v3.2".
?
>
> As you mentioned in the following link, you didn't see big performance
drop
> with linux_4.16-rc-host-tags-v3.2, right?
>
> 	https://marc.info/?l=linux-block&m=151982993810092&w=2
>
>
> Thanks,
> Ming
