Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH v2 4/5] scsi: Add scsi_restart_hctx()
To: Christoph Hellwig <hch@lst.de>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com>
 <20170403232228.11208-5-bart.vanassche@sandisk.com>
 <20170404064252.GD9168@lst.de>
 <BY1PR0401MB15322BB999F894A46F40AE5E810B0@BY1PR0401MB1532.namprd04.prod.outlook.com>
 <20170405062020.GA26389@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Hannes Reinecke <hare@suse.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <13fab5b9-eb6c-3cba-78cd-ec86cd7b5e4a@sandisk.com>
Date: Wed, 5 Apr 2017 10:36:35 -0700
MIME-Version: 1.0
In-Reply-To: <20170405062020.GA26389@lst.de>
Content-Type: text/plain; charset="windows-1252"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 04/04/2017 11:20 PM, Christoph Hellwig wrote:
> On Tue, Apr 04, 2017 at 03:56:34PM +0000, Bart Van Assche wrote:
>>> This looks like generic block layer code, why is it in SCSI?
>>
>> That's an excellent question. I assume that you are fine with moving
>> this code to the block layer?
> 
> Yes.  In fact I wonder if we need the blk_mq_ops method at all now
> that you're using RCU locking and don't need the scsi host_lock.

Hello Christoph,

My plan is to remove the new blk_mq_ops method again before I post v3 of
this patch series.

Bart.
