Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180718122843.6thmyfxb7m542h4d@linux-x5ow.site>
References: <20180713080602.31602-1-ming.lei@redhat.com> <20180713080602.31602-4-ming.lei@redhat.com>
 <20180717132411.GI13582@lst.de> <20180717153031.GA8973@ming.t460p>
 <07874eaab2d93728afe3f220cd0efa8f41d4955a.camel@wdc.com> <20180717153847.GB8973@ming.t460p>
 <3e0e3537-b37e-860f-fee3-4324c70a1deb@kernel.dk> <CACVXFVNpyOENs=F1pkiwTVfD6H9essfbcc8_-zQOrG56Fs1w=Q@mail.gmail.com>
 <20180718122843.6thmyfxb7m542h4d@linux-x5ow.site>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 18 Jul 2018 20:37:37 +0800
Message-ID: <CACVXFVOP=7R2hSPQ2YWe3aYpprpD0_iT1hYB-pRZHHMd5XNrEA@mail.gmail.com>
Subject: Re: [PATCH RFC V2 3/3] scsi_mq: enable runtime PM
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "hare@suse.de" <hare@suse.de>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 8:28 PM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> On Wed, Jul 18, 2018 at 08:06:10PM +0800, Ming Lei wrote:
>> IMO the problem isn't related with slow or quick device, it is related with
>> the system, especially when it cares about power consumption, such as
>> mobile phone, or laptop or servers with lots of disks attached. And we know
>> it is often to see some fast disks shipped in laptop, such as NVMe, or other
>> SSD.
>
> Yes but you're only taking locally attached devices into account.
> This is very likely harmful on sd devices attached to a
> SRP/FC/iSCSI/SAS Target in a SAN environment. These can be really fast
> and people investing this money are likely to not like additional
> performance penalties.

Runtime PM provides options for all these kind of cases. If you care
performance,
just keep the default setting(device is always in active). If you care power
consumption, you may run PM utility to switch runtime PM on for the
interested devices.

Definitely we are working on solutions in which runtime PM code shouldn't
introduce extra obvious cost in fast path, so no need to worry about its effect
if you never want to use that.

>
> Furthermore I'd don't know if any array vendors actually implement
> START/STOP DISK, etc..

That won't be one issue as I mentioned above.

Thanks,
Ming Lei
