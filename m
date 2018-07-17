Return-Path: <stern+5b5b8f2e@rowland.harvard.edu>
Date: Tue, 17 Jul 2018 16:54:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "hch@lst.de" <hch@lst.de>
cc: Ming Lei <ming.lei@redhat.com>, Bart Van Assche <Bart.VanAssche@wdc.com>,
    "jthumshirn@suse.de" <jthumshirn@suse.de>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
    "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
    "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
    "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
    "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
    "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
    "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
    "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC V2 3/3] scsi_mq: enable runtime PM
In-Reply-To: <20180717195008.GA28809@lst.de>
Message-ID: <Pine.LNX.4.44L0.1807171651480.1344-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Tue, 17 Jul 2018, hch@lst.de wrote:

> On Tue, Jul 17, 2018 at 11:38:53PM +0800, Ming Lei wrote:
> > As I said, it is any sd/sr device, which can be put down by runtime PM
> > via START_STOP command if it isn't used for a while.
> 
> And in which case do we care that this happens?

Consider a low-power system (e.g., embedded applications, tablet 
computer, etc.) using a USB flash drive.  Consider a high-power system 
with lots of disk drives that consume a lot of power while they are 
running but not while they are stopped.

It's safe to assume that if the kernel can provide a capability like 
this for users, some people will take advantage of it.

Alan Stern
