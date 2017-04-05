Return-Path: <hch@lst.de>
Date: Wed, 5 Apr 2017 08:20:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 4/5] scsi: Add scsi_restart_hctx()
Message-ID: <20170405062020.GA26389@lst.de>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com> <20170403232228.11208-5-bart.vanassche@sandisk.com> <20170404064252.GD9168@lst.de> <BY1PR0401MB15322BB999F894A46F40AE5E810B0@BY1PR0401MB1532.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BY1PR0401MB15322BB999F894A46F40AE5E810B0@BY1PR0401MB1532.namprd04.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 04, 2017 at 03:56:34PM +0000, Bart Van Assche wrote:
> > This looks like generic block layer code, why is it in SCSI?
> 
> Hello Christoph,
> 
> That's an excellent question. I assume that you are fine with moving
> this code to the block layer?

Yes.  In fact I wonder if we need the blk_mq_ops method at all now
that you're using RCU locking and don't need the scsi host_lock.
