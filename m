Return-Path: <stern+5b5b8f2e@rowland.harvard.edu>
Date: Wed, 18 Jul 2018 11:01:52 -0400 (EDT)
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
In-Reply-To: <20180718141852.i3aermgwhmvxwjx7@linux-x5ow.site>
Message-ID: <Pine.LNX.4.44L0.1807181058440.31764-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 18 Jul 2018, Johannes Thumshirn wrote:

> On Wed, Jul 18, 2018 at 10:12:37AM -0400, Alan Stern wrote:
> > As one extra reminder...  People who care about extreme performance can 
> > perfectly well disable CONFIG_PM in their kernels.  That should remove 
> > any overhead due to runtime PM.
> 
> Yes but how likely is this for people who are running their data
> center with a distribution kernel.

Strictly speaking, that's a nonsense question.  People who run 
distribution kernels are 100% unlikely to change the kernel 
configuration, by definition.

That's not the point.  If people really care about getting the utmost 
performance, to the extent that they resent the minimal overhead 
required for runtime PM, then they should not be running distribution 
kernels in the first place.

Alan Stern
