Return-Path: <stern+5b5b8f2e@rowland.harvard.edu>
Date: Wed, 18 Jul 2018 14:46:10 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Jens Axboe <axboe@kernel.dk>
cc: Johannes Thumshirn <jthumshirn@suse.de>, Ming Lei <tom.leiming@gmail.com>,
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
In-Reply-To: <651898d4-f0ab-4bba-dacb-b5e32400fd3a@kernel.dk>
Message-ID: <Pine.LNX.4.44L0.1807181438470.1382-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 18 Jul 2018, Jens Axboe wrote:

> On 7/18/18 8:12 AM, Alan Stern wrote:
> > On Wed, 18 Jul 2018, Johannes Thumshirn wrote:
> > 
> >> On Wed, Jul 18, 2018 at 08:06:10PM +0800, Ming Lei wrote:
> >>> IMO the problem isn't related with slow or quick device, it is related with
> >>> the system, especially when it cares about power consumption, such as
> >>> mobile phone, or laptop or servers with lots of disks attached. And we know
> >>> it is often to see some fast disks shipped in laptop, such as NVMe, or other
> >>> SSD.
> >>
> >> Yes but you're only taking locally attached devices into account.
> >> This is very likely harmful on sd devices attached to a
> >> SRP/FC/iSCSI/SAS Target in a SAN environment. These can be really fast
> >> and people investing this money are likely to not like additional
> >> performance penalties. 
> > 
> > As one extra reminder...  People who care about extreme performance can 
> > perfectly well disable CONFIG_PM in their kernels.  That should remove 
> > any overhead due to runtime PM.
> 
> This is a kernel fallacy that needs to be shot down. Most folks just run
> what the distro provides, so no, they can't just turn off various kernel
> options. This is NEVER an argument that carries any weight at all for
> me. If we have the implementation, it needs to be fast enough to be on
> by default. No "well just turn off the option if you think the overhead
> is too high". Never.

I certainly agree that it needs to be fast enough to be on by default.  
That was never an issue, and it is the goal we are working toward.

But that isn't what Johannes wrote.  To rule out all improvements that
carry even the smallest runtime overhead is an extreme attitude.  It
does have its place, though -- and people who are in that place can
afford to build their own kernels with their own configurations.

> That's exactly why I didn't like the first implementation that Ming did.

Fine.  I'm happy to leave the technical details up to the two of you,
since I'm not really up to speed on this part of the kernel and Ming 
does have a keen understanding of the runtime PM implementation.  And
hopefully -- perhaps with a little outside brainstorming inspiration --
you'll be able to come up with something that is acceptable to
everyone.

Alan Stern
