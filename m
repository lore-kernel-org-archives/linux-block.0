Return-Path: <ming.lei@redhat.com>
Date: Wed, 27 Sep 2017 06:47:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/7] Make suspend and resume safe for md-on-SCSI
Message-ID: <20170926224756.GB8050@ming.t460p>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
 <20170926091539.GF518@ming.t460p>
 <1506436145.3787.15.camel@wdc.com>
 <20170926145404.GB31449@ming.t460p>
 <1506457074.3063.22.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506457074.3063.22.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 26, 2017 at 08:17:59PM +0000, Bart Van Assche wrote:
> On Tue, 2017-09-26 at 22:54 +0800, Ming Lei wrote:
> > On Tue, Sep 26, 2017 at 02:29:06PM +0000, Bart Van Assche wrote:
> > > On Tue, 2017-09-26 at 17:15 +0800, Ming Lei wrote:
> > > > No, if you only address issue on MD device, that is definitely not
> > > > alternative of my patchset.
> > > 
> > > A clarification: my patch series not only fixes suspend and resume for md-on-SCSI
> > > but also for all other scenario's in which resume locks up due to no tag being
> > > available when the SCSI core tries to execute a power management command.> 
> > I do care about if this patchset can fix non-MD cases, like
> > btrfs/raid, or transport_spi, both are real reports. Could you
> > make sure if your patchset can cover this non-MD devices?
> 
> Yes, I'm sure this patch series covers non-MD devices.
> 
> It is easy to see that this patch series also covers SCSI parallel domain
> validation.

Now I don't believe this patchset can do that, see my comment on your
patch 5:

https://www.mail-archive.com/linux-block@vger.kernel.org/msg13624.html

More worse, your patch introduces a new I/O hang inside SCSI quiesce.

> 
> Regarding BTRFS RAID: you should know that filesystems are responsible for
> implementing freeze / thaw support themselves. I think a filesystem must
> surround metadata operations by sb_start_write() / sb_end_write() and that
> it optionally can provide freeze_super / thaw_super callbacks in
> struct super_operations. In the BTRFS changelog there are several fixes
> with regard to freeze / thaw so I think this aspect of BTRFS has been tested.
> 
> Bart.

-- 
Ming
