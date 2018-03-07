Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180227100750.32299-1-ming.lei@redhat.com> <20180227100750.32299-9-ming.lei@redhat.com>
 <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com> <20180307052725.GB15024@ming.t460p>
 <659dc50c3814c8c5b69abb20c3cc39c8@mail.gmail.com> <20180307160509.GA10572@ming.t460p>
In-Reply-To: <20180307160509.GA10572@ming.t460p>
MIME-Version: 1.0
Date: Wed, 7 Mar 2018 22:58:34 +0530
Message-ID: <337036cc74d4a5665d68afd718382235@mail.gmail.com>
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

> >
> > Also one observation using V3 series patch. I am seeing below Affinity
> > mapping whereas I have only 72 logical CPUs.  It means we are really
> > not going to use all reply queues.
> > e.a If I bind fio jobs on CPU 18-20, I am seeing only one reply queue
> > is used and that may lead to performance drop as well.
>
> If the mapping is in such shape, I guess it should be quite difficult to
figure out
> one perfect way to solve this situation because one reply queue has to
handle
> IOs submitted from 4~5 CPUs at average.

4.15.0-rc1 kernel has below mapping - I am not sure which commit id in "
linux_4.16-rc-host-tags-v3.2" is changing the mapping of IRQ to CPU.  It
will be really good if we can fall back to below mapping once again.
Current repo linux_4.16-rc-host-tags-v3.2 is giving lots of random mapping
of CPU - MSIx. And that will be problematic in performance run.

As I posted earlier, latest repo will only allow us to use *18* reply
queue instead of *72*.  Lots of performance related issue can be pop up on
different setup due to inconsistency in CPU - MSIx mapping. BTW, changes
in this area is intentional @" linux_4.16-rc-host-tags-v3.2". ?

irq 218, cpu list 0
irq 219, cpu list 1
irq 220, cpu list 2
irq 221, cpu list 3
irq 222, cpu list 4
irq 223, cpu list 5
irq 224, cpu list 6
irq 225, cpu list 7
irq 226, cpu list 8
irq 227, cpu list 9
irq 228, cpu list 10
irq 229, cpu list 11
irq 230, cpu list 12
irq 231, cpu list 13
irq 232, cpu list 14
irq 233, cpu list 15
irq 234, cpu list 16
irq 235, cpu list 17
irq 236, cpu list 36
irq 237, cpu list 37
irq 238, cpu list 38
irq 239, cpu list 39
irq 240, cpu list 40
irq 241, cpu list 41
irq 242, cpu list 42
irq 243, cpu list 43
irq 244, cpu list 44
irq 245, cpu list 45
irq 246, cpu list 46
irq 247, cpu list 47
irq 248, cpu list 48
irq 249, cpu list 49
irq 250, cpu list 50
irq 251, cpu list 51
irq 252, cpu list 52
irq 253, cpu list 53
irq 254, cpu list 18
irq 255, cpu list 19
irq 256, cpu list 20
irq 257, cpu list 21
irq 258, cpu list 22
irq 259, cpu list 23
irq 260, cpu list 24
irq 261, cpu list 25
irq 262, cpu list 26
irq 263, cpu list 27
irq 264, cpu list 28
irq 265, cpu list 29
irq 266, cpu list 30
irq 267, cpu list 31
irq 268, cpu list 32
irq 269, cpu list 33
irq 270, cpu list 34
irq 271, cpu list 35
irq 272, cpu list 54
irq 273, cpu list 55
irq 274, cpu list 56
irq 275, cpu list 57
irq 276, cpu list 58
irq 277, cpu list 59
irq 278, cpu list 60
irq 279, cpu list 61
irq 280, cpu list 62
irq 281, cpu list 63
irq 282, cpu list 64
irq 283, cpu list 65
irq 284, cpu list 66
irq 285, cpu list 67
irq 286, cpu list 68
irq 287, cpu list 69
irq 288, cpu list 70
irq 289, cpu list 71


>
> The application should have the knowledge to avoid this kind of usage.
>
>
> Thanks,
> Ming
