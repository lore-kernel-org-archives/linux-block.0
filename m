Return-Path: <stern+5b5b8f2e@rowland.harvard.edu>
Date: Wed, 18 Jul 2018 10:12:37 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Johannes Thumshirn <jthumshirn@suse.de>
cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
    Ming Lei <ming.lei@redhat.com>, Bart Van Assche <Bart.VanAssche@wdc.com>,
    "hch@lst.de" <hch@lst.de>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
    "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
    "hare@suse.de" <hare@suse.de>,
    "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
    "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
    "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
    "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
    "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC V2 3/3] scsi_mq: enable runtime PM
In-Reply-To: <20180718122843.6thmyfxb7m542h4d@linux-x5ow.site>
Message-ID: <Pine.LNX.4.44L0.1807181010390.29549-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 18 Jul 2018, Johannes Thumshirn wrote:

> On Wed, Jul 18, 2018 at 08:06:10PM +0800, Ming Lei wrote:
> > IMO the problem isn't related with slow or quick device, it is related with
> > the system, especially when it cares about power consumption, such as
> > mobile phone, or laptop or servers with lots of disks attached. And we know
> > it is often to see some fast disks shipped in laptop, such as NVMe, or other
> > SSD.
> 
> Yes but you're only taking locally attached devices into account.
> This is very likely harmful on sd devices attached to a
> SRP/FC/iSCSI/SAS Target in a SAN environment. These can be really fast
> and people investing this money are likely to not like additional
> performance penalties. 

As one extra reminder...  People who care about extreme performance can 
perfectly well disable CONFIG_PM in their kernels.  That should remove 
any overhead due to runtime PM.

Alan Stern
