Return-Path: <ming.lei@redhat.com>
Date: Tue, 26 Sep 2017 22:54:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v4 0/7] Make suspend and resume safe for md-on-SCSI
Message-ID: <20170926145404.GB31449@ming.t460p>
References: <20170925202924.16603-1-bart.vanassche@wdc.com>
 <20170926091539.GF518@ming.t460p>
 <1506436145.3787.15.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506436145.3787.15.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 26, 2017 at 02:29:06PM +0000, Bart Van Assche wrote:
> On Tue, 2017-09-26 at 17:15 +0800, Ming Lei wrote:
> > No, if you only address issue on MD device, that is definitely not
> > alternative of my patchset.
> 
> A clarification: my patch series not only fixes suspend and resume for md-on-SCSI
> but also for all other scenario's in which resume locks up due to no tag being

I do care about if this patchset can fix non-MD cases, like
btrfs/raid, or transport_spi, both are real reports. Could you
make sure if your patchset can cover this non-MD devices?

> available when the SCSI core tries to execute a power management command.

Firstly your cover letter title is 'Make suspend and resume safe for md-on-SCSI',
that makes me a bit nervous since it is for md-on-SCSI.

Secondly if your changes on block/SCSI can work on both MD and non-MD, why is
MD so special to be dealt with by the 1st MD patch? Can we remove it from this
patchset? I am pretty sure that my patchset needn't any MD specific change.

-- 
Ming
