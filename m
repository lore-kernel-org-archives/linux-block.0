Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180227100750.32299-1-ming.lei@redhat.com> <20180227100750.32299-9-ming.lei@redhat.com>
 <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com> <20180307052725.GB15024@ming.t460p>
 <659dc50c3814c8c5b69abb20c3cc39c8@mail.gmail.com> <20180307160509.GA10572@ming.t460p>
 <337036cc74d4a5665d68afd718382235@mail.gmail.com> <20180308011540.GA11845@ming.t460p>
 <45ba4cc7328786fd5b536362b686b5a3@mail.gmail.com> <20180308110625.GC31062@ming.t460p>
 <20180308112343.GA1906@ming.t460p>
In-Reply-To: <20180308112343.GA1906@ming.t460p>
MIME-Version: 1.0
Date: Fri, 9 Mar 2018 12:26:57 +0530
Message-ID: <8d42124a8d3afe92fee4271aeea77a83@mail.gmail.com>
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
> Sent: Thursday, March 8, 2018 4:54 PM
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
> On Thu, Mar 08, 2018 at 07:06:25PM +0800, Ming Lei wrote:
> > On Thu, Mar 08, 2018 at 03:34:31PM +0530, Kashyap Desai wrote:
> > > > -----Original Message-----
> > > > From: Ming Lei [mailto:ming.lei@redhat.com]
> > > > Sent: Thursday, March 8, 2018 6:46 AM
> > > > To: Kashyap Desai
> > > > Cc: Jens Axboe; linux-block@vger.kernel.org; Christoph Hellwig;
> > > > Mike
> > > Snitzer;
> > > > linux-scsi@vger.kernel.org; Hannes Reinecke; Arun Easi; Omar
> > > > Sandoval; Martin K . Petersen; James Bottomley; Christoph Hellwig;
> > > > Don Brace;
> > > Peter
> > > > Rivera; Laurence Oberman
> > > > Subject: Re: [PATCH V3 8/8] scsi: megaraid: improve scsi_mq
> > > > performance
> > > via
> > > > .host_tagset
> > > >
> > > > On Wed, Mar 07, 2018 at 10:58:34PM +0530, Kashyap Desai wrote:
> > > > > > >
> > > > > > > Also one observation using V3 series patch. I am seeing
> > > > > > > below Affinity mapping whereas I have only 72 logical CPUs.
> > > > > > > It means we are really not going to use all reply queues.
> > > > > > > e.a If I bind fio jobs on CPU 18-20, I am seeing only one
> > > > > > > reply queue is used and that may lead to performance drop as
well.
> > > > > >
> > > > > > If the mapping is in such shape, I guess it should be quite
> > > > > > difficult to
> > > > > figure out
> > > > > > one perfect way to solve this situation because one reply
> > > > > > queue has to
> > > > > handle
> > > > > > IOs submitted from 4~5 CPUs at average.
> > > > >
> > > > > 4.15.0-rc1 kernel has below mapping - I am not sure which commit
> > > > > id in
> > > "
> > > > > linux_4.16-rc-host-tags-v3.2" is changing the mapping of IRQ to
CPU.
> > > > > It
> > > >
> > > > I guess the mapping you posted is read from
/proc/irq/126/smp_affinity.
> > > >
> > > > If yes, no any patch in linux_4.16-rc-host-tags-v3.2 should change
> > > > IRQ
> > > affinity
> > > > code, which is done in irq_create_affinity_masks(), as you saw, no
> > > > any
> > > patch
> > > > in linux_4.16-rc-host-tags-v3.2 touches that code.
> > > >
> > > > Could you simply apply the patches in linux_4.16-rc-host-tags-v3.2
> > > against
> > > > 4.15-rc1 kernel and see any difference?
> > > >
> > > > > will be really good if we can fall back to below mapping once
again.
> > > > > Current repo linux_4.16-rc-host-tags-v3.2 is giving lots of
> > > > > random mapping of CPU - MSIx. And that will be problematic in
> > > > > performance
> > > run.
> > > > >
> > > > > As I posted earlier, latest repo will only allow us to use *18*
> > > > > reply
> > > >
> > > > Looks not see this report before, could you share us how you
> > > > conclude
> > > that?
> > > > The only patch changing reply queue is the following one:
> > > >
> > > > 	https://marc.info/?l=linux-block&m=151972611911593&w=2
> > > >
> > > > But not see any issue in this patch yet, can you recover to 72
> > > > reply
> > > queues
> > > > after reverting the patch in above link?
> > > Ming -
> > >
> > > While testing, my system went bad. I debug further and understood
> > > that affinity mapping was changed due to below commit -
> > > 84676c1f21e8ff54befe985f4f14dc1edc10046b
> > >
> > > [PATCH] genirq/affinity: assign vectors to all possible CPUs
> > >
> > > Because of above change, we end up using very less reply queue. Many
> > > reply queues on my setup was mapped to offline/not-available CPUs.
> > > This may be primary contributing to odd performance impact and it
> > > may not be truly due to V3/V4 patch series.
> >
> > Seems a good news, :-)
> >
> > >
> > > I am planning to check your V3 and V4 series after removing above
> > > commit ID (for performance impact.).
> >
> > You can run your test on a server in which all CPUs are kept as online
> > for avoiding this issue.
> >
> > Or you can apply the following patchset for avoiding this issue:
> >
> > 	https://marc.info/?l=linux-block&m=152050646332092&w=2
>
> If you want to do this way, all patches have been put into the following
> tree(V4):
>
> 	https://github.com/ming1/linux/commits/v4.16-rc-host-tags-v4

Tested above V4 commits. Now, IRQ - CPU mapping has at least one online
CPU as explained in patch " genirq/affinity: irq vector spread among
online CPUs as far as possible".
New IRQ-CPU mapping looks better.

Below is irq/cpu mapping. ( I have 0-71 online logical CPUs)
Kernel version:
Linux rhel7.3 4.16.0-rc4+ #1 SMP Thu Mar 8 10:51:56 EST 2018 x86_64 x86_64
x86_64 GNU/Linux
PCI name is 86:00.0, dump its irq affinity:
irq 218, cpu list 0,72,74,76,78
irq 219, cpu list 1,80,82,84,86
irq 220, cpu list 2,88,90,92,94
irq 221, cpu list 3,96,98,100,102
irq 222, cpu list 4,104,106,108
irq 223, cpu list 5,110,112,114
irq 224, cpu list 6,116,118,120
irq 225, cpu list 7,122,124,126
irq 226, cpu list 8,128,130,132
irq 227, cpu list 9,134,136,138
irq 228, cpu list 10,140,142,144
irq 229, cpu list 11,146,148,150
irq 230, cpu list 12,152,154,156
irq 231, cpu list 13,158,160,162
irq 232, cpu list 14,164,166,168
irq 233, cpu list 15,170,172,174
irq 234, cpu list 16,176,178,180
irq 235, cpu list 17,182,184,186
irq 236, cpu list 36,188,190,192
irq 237, cpu list 37,194,196,198
irq 238, cpu list 38,200,202,204
irq 239, cpu list 39,206,208,210
irq 240, cpu list 40,212,214,216
irq 241, cpu list 41,218,220,222
irq 242, cpu list 42,224,226,228
irq 243, cpu list 43,230,232,234
irq 244, cpu list 44,236,238,240
irq 245, cpu list 45,242,244,246
irq 246, cpu list 46,248,250,252
irq 247, cpu list 47,254,256,258
irq 248, cpu list 48,260,262,264
irq 249, cpu list 49,266,268,270
irq 250, cpu list 50,272,274,276
irq 251, cpu list 51,278,280,282
irq 252, cpu list 52,284,286,288
irq 253, cpu list 53,290,292,294
irq 254, cpu list 18,73,75,77,79
irq 255, cpu list 19,81,83,85,87
irq 256, cpu list 20,89,91,93,95
irq 257, cpu list 21,97,99,101,103
irq 258, cpu list 22,105,107,109
irq 259, cpu list 23,111,113,115
irq 260, cpu list 24,117,119,121
irq 261, cpu list 25,123,125,127
irq 262, cpu list 26,129,131,133
irq 263, cpu list 27,135,137,139
irq 264, cpu list 28,141,143,145
irq 265, cpu list 29,147,149,151
irq 266, cpu list 30,153,155,157
irq 267, cpu list 31,159,161,163
irq 268, cpu list 32,165,167,169
irq 269, cpu list 33,171,173,175
irq 270, cpu list 34,177,179,181
irq 271, cpu list 35,183,185,187
irq 272, cpu list 54,189,191,193
irq 273, cpu list 55,195,197,199
irq 274, cpu list 56,201,203,205
irq 275, cpu list 57,207,209,211
irq 276, cpu list 58,213,215,217
irq 277, cpu list 59,219,221,223
irq 278, cpu list 60,225,227,229
irq 279, cpu list 61,231,233,235
irq 280, cpu list 62,237,239,241
irq 281, cpu list 63,243,245,247
irq 282, cpu list 64,249,251,253
irq 283, cpu list 65,255,257,259
irq 284, cpu list 66,261,263,265
irq 285, cpu list 67,267,269,271
irq 286, cpu list 68,273,275,277
irq 287, cpu list 69,279,281,283
irq 288, cpu list 70,285,287,289
irq 289, cpu list 71,291,293,295

High level result on performance run is - Performance is unchanged. No
improvement and No degradation is observe using V4 series.
For this particular patch - " [PATCH V3 8/8] scsi: megaraid: improve
scsi_mq performance via .host_tagset"
We want to review performance number in our lab before commit to upstream.


Please skip this particular patch from series mainly because it is tied to
performance with no immediate improvement observed. We want to review
comprehensive result.

Regarding patch - " [PATCH V3 2/8] scsi: megaraid_sas: fix selection of
reply queue", I see one issue.  I have reply separately for that patch.
I see you have posted patch - " [PATCH V4 2/4] scsi: megaraid_sas: fix
selection of reply queue". Let me use new thread for my reply.



>
> #in reverse order
> genirq/affinity: irq vector spread among online CPUs as far as possible
> genirq/affinity: support to do irq vectors spread starting from any
vector
> genirq/affinity: move actual irq vector spread into one helper
> genirq/affinity: rename *node_to_possible_cpumask as *node_to_cpumask
> scsi: megaraid: improve scsi_mq performance via .host_tagset
> scsi: hpsa: improve scsi_mq performance via .host_tagset
> block: null_blk: introduce module parameter of 'g_host_tags'
> scsi: Add template flag 'host_tagset'
> blk-mq: introduce BLK_MQ_F_HOST_TAGS
> blk-mq: introduce 'start_tag' field to 'struct blk_mq_tags'
> scsi: avoid to hold host_busy for scsi_mq
> scsi: read host_busy via scsi_host_busy()
> scsi: introduce scsi_host_busy()
> scsi: virtio_scsi: fix IO hang caused by irq vector automatic affinity
> scsi: introduce force_blk_mq
> scsi: megaraid_sas: fix selection of reply queue
> scsi: hpsa: fix selection of reply queue
>
>
> Thanks,
> Ming
