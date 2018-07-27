Return-Path: <keith.busch@intel.com>
Date: Fri, 27 Jul 2018 11:58:21 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH 5/5] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180727175821.GE20829@localhost.localdomain>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
 <20180727162042.13425-6-bart.vanassche@wdc.com>
 <20180727164627.GB20829@localhost.localdomain>
 <08bd5d1c691e2c8f9950f7ebcf04716507a02675.camel@wdc.com>
 <20180727165718.GC20829@localhost.localdomain>
 <fca08072e67fc8a8a9c9acfe130753ee7020f4fe.camel@wdc.com>
 <20180727170433.GD20829@localhost.localdomain>
 <717d1320da3341988ccaa1995b278e0d645a0178.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <717d1320da3341988ccaa1995b278e0d645a0178.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 27, 2018 at 05:14:18PM +0000, Bart Van Assche wrote:
> On Fri, 2018-07-27 at 11:04 -0600, Keith Busch wrote:
> > On Fri, Jul 27, 2018 at 04:59:34PM +0000, Bart Van Assche wrote:
> > > On Fri, 2018-07-27 at 10:57 -0600, Keith Busch wrote:
> > > > You skip that code if the driver returns BLK_EH_DONT_RESET_TIMER.
> > > 
> > > How about applying the following patch on top of this series?
> > 
> > That works for me if you, but it breaks scsi again when
> > scmd_eh_abort_handler completes the command a second time.
> 
> How about introducing a new request queue flag that chooses between the
> behavior with or without the patch in my previous e-mail? I don't think that
> it is possible to come up with a single implementation that covers the needs
> of NVMe and SCSI without introducing such a flag. If a SCSI request times out
> then request ownership is transferred from the LLD to the error handler. For
> the NVMe driver however there is no such transfer of ownership.

Instead of PATCH 1/5, how about creating a new timeout return code like
"BLK_EH_DONT_COMPLETE"?
