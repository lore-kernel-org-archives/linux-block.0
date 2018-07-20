Return-Path: <keith.busch@linux.intel.com>
Date: Fri, 20 Jul 2018 10:23:21 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 2/2] scsi: set timed out out mq requests to complete
Message-ID: <20180720162321.GG4093@localhost.localdomain>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
 <1073d0d2902327970c4e28a4c7c97a21fd8885c8.camel@wdc.com>
 <20180720155646.GE4093@localhost.localdomain>
 <2b01f0a8d5864b2563573d46ce5b4ec5f593f538.camel@wdc.com>
 <20180720161240.GF4093@localhost.localdomain>
 <092dd4f2dae0cc533018c9fb829a50b4cbb6cb0b.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <092dd4f2dae0cc533018c9fb829a50b4cbb6cb0b.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 20, 2018 at 04:20:01PM +0000, Bart Van Assche wrote:
> On Fri, 2018-07-20 at 10:12 -0600, Keith Busch wrote:
> > On Fri, Jul 20, 2018 at 04:03:18PM +0000, Bart Van Assche wrote:
> > > On Fri, 2018-07-20 at 09:56 -0600, Keith Busch wrote:
> > > > SCSI is the only block driver that wants this behavior. Moving it back
> > > > to generic where it used to be breaks other block drivers.
> > > 
> > > That's new to me. What would break in the NVMe driver if the above change would be
> > > present in the block layer?
> > 
> > This is what causes the block layer to lose completions, and most drivers
> > don't want the kernel to lose their completions.
> 
> Hello Keith,
> 
> Have you considered to introduce a fourth state for block layer requests to
> avoid that completions that occur while a timeout handler is in progress get
> lost? That would avoid that completions get lost not only for the NVMe driver
> but also for SCSI drivers. See e.g. the MQ_RQ_TIMED_OUT state in
> https://www.mail-archive.com/linux-block@vger.kernel.org/msg22196.html

Yes, I've considered that, and I really want to use it, but scsi may
still reference a freed request in scmd_eh_abort_handler that way.
