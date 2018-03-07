Return-Path: <kashyap.desai@broadcom.com>
From: Kashyap Desai <kashyap.desai@broadcom.com>
References: <20180227100750.32299-1-ming.lei@redhat.com> <20180227100750.32299-9-ming.lei@redhat.com>
 <8113cfe7e8db7060db920ab29e230a89@mail.gmail.com> <20180307052725.GB15024@ming.t460p>
In-Reply-To: <20180307052725.GB15024@ming.t460p>
MIME-Version: 1.0
Date: Wed, 7 Mar 2018 20:31:31 +0530
Message-ID: <659dc50c3814c8c5b69abb20c3cc39c8@mail.gmail.com>
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
> Sent: Wednesday, March 7, 2018 10:58 AM
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
> On Wed, Feb 28, 2018 at 08:28:48PM +0530, Kashyap Desai wrote:
> > Ming -
> >
> > Quick testing on my setup -  Performance slightly degraded (4-5%
> > drop)for megaraid_sas driver with this patch. (From 1610K IOPS it goes
> > to 1544K) I confirm that after applying this patch, we have #queue =
#numa
> node.
> >
> > ls -l
> >
>
/sys/devices/pci0000:80/0000:80:02.0/0000:83:00.0/host10/target10:2:23/10:
> > 2:23:0/block/sdy/mq
> > total 0
> > drwxr-xr-x. 18 root root 0 Feb 28 09:53 0 drwxr-xr-x. 18 root root 0
> > Feb 28 09:53 1
> >
> >
> > I would suggest to skip megaraid_sas driver changes using
> > shared_tagset until and unless there is obvious gain. If overall
> > interface of using shared_tagset is commit in kernel tree, we will
> > investigate (megaraid_sas
> > driver) in future about real benefit of using it.
>
> Hi Kashyap,
>
> Now I have put patches for removing operating on scsi_host->host_busy in
> V4[1], especially which are done in the following 3 patches:
>
> 	9221638b9bc9 scsi: avoid to hold host_busy for scsi_mq
> 	1ffc8c0ffbe4 scsi: read host_busy via scsi_host_busy()
> 	e453d3983243 scsi: introduce scsi_host_busy()
>
>
> Could you run your test on V4 and see if IOPS can be improved on
> megaraid_sas?
>
>
> [1] https://github.com/ming1/linux/commits/v4.16-rc-host-tags-v4

I will be doing testing soon.

BTW - Performance impact is due below patch only -
"[PATCH V3 8/8] scsi: megaraid: improve scsi_mq performance via
.host_tagset"

Below patch is really needed -
"[PATCH V3 2/8] scsi: megaraid_sas: fix selection of reply queue"

I am currently doing review on my setup.  I think above patch is fixing
real issue of performance (for megaraid_sas) as driver may not be sending
IO to optimal reply queue.
Having CPU to MSIx mapping will solve that. Megaraid_sas driver always
create max MSIx as min (online CPU, # MSIx HW support).
I will do more review and testing for that particular patch as well.

Also one observation using V3 series patch. I am seeing below Affinity
mapping whereas I have only 72 logical CPUs.  It means we are really not
going to use all reply queues.
e.a If I bind fio jobs on CPU 18-20, I am seeing only one reply queue is
used and that may lead to performance drop as well.

PCI name is 86:00.0, dump its irq affinity:
irq 218, cpu list 0-2,36-37
irq 219, cpu list 3-5,39-40
irq 220, cpu list 6-8,42-43
irq 221, cpu list 9-11,45-46
irq 222, cpu list 12-13,48-49
irq 223, cpu list 14-15,50-51
irq 224, cpu list 16-17,52-53
irq 225, cpu list 38,41,44,47
irq 226, cpu list 72,74,76,78
irq 227, cpu list 80,82,84,86
irq 228, cpu list 88,90,92,94
irq 229, cpu list 96,98,100,102
irq 230, cpu list 104,106,108,110
irq 231, cpu list 112,114,116,118
irq 232, cpu list 120,122,124,126
irq 233, cpu list 128,130,132,134
irq 234, cpu list 136,138,140,142
irq 235, cpu list 144,146,148,150
irq 236, cpu list 152,154,156,158
irq 237, cpu list 160,162,164,166
irq 238, cpu list 168,170,172,174
irq 239, cpu list 176,178,180,182
irq 240, cpu list 184,186,188,190
irq 241, cpu list 192,194,196,198
irq 242, cpu list 200,202,204,206
irq 243, cpu list 208,210,212,214
irq 244, cpu list 216,218,220,222
irq 245, cpu list 224,226,228,230
irq 246, cpu list 232,234,236,238
irq 247, cpu list 240,242,244,246
irq 248, cpu list 248,250,252,254
irq 249, cpu list 256,258,260,262
irq 250, cpu list 264,266,268,270
irq 251, cpu list 272,274,276,278
irq 252, cpu list 280,282,284,286
irq 253, cpu list 288,290,292,294
irq 254, cpu list 18-20,54-55
irq 255, cpu list 21-23,57-58
irq 256, cpu list 24-26,60-61
irq 257, cpu list 27-29,63-64
irq 258, cpu list 30-31,66-67
irq 259, cpu list 32-33,68-69
irq 260, cpu list 34-35,70-71
irq 261, cpu list 56,59,62,65
irq 262, cpu list 73,75,77,79
irq 263, cpu list 81,83,85,87
irq 264, cpu list 89,91,93,95
irq 265, cpu list 97,99,101,103
irq 266, cpu list 105,107,109,111
irq 267, cpu list 113,115,117,119
irq 268, cpu list 121,123,125,127
irq 269, cpu list 129,131,133,135
irq 270, cpu list 137,139,141,143
irq 271, cpu list 145,147,149,151
irq 272, cpu list 153,155,157,159
irq 273, cpu list 161,163,165,167
irq 274, cpu list 169,171,173,175
irq 275, cpu list 177,179,181,183
irq 276, cpu list 185,187,189,191
irq 277, cpu list 193,195,197,199
irq 278, cpu list 201,203,205,207
irq 279, cpu list 209,211,213,215
irq 280, cpu list 217,219,221,223
irq 281, cpu list 225,227,229,231
irq 282, cpu list 233,235,237,239
irq 283, cpu list 241,243,245,247
irq 284, cpu list 249,251,253,255
irq 285, cpu list 257,259,261,263
irq 286, cpu list 265,267,269,271
irq 287, cpu list 273,275,277,279
irq 288, cpu list 281,283,285,287
irq 289, cpu list 289,291,293,295


>
> Thanks,
> Ming
