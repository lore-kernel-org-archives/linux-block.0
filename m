Return-Path: <jthumshirn@suse.de>
Date: Thu, 19 Jul 2018 16:43:57 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>,
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
Message-ID: <20180719144357.xqdnr7tsw7gplz3h@linux-x5ow.site>
References: <20180719064124.fsi6au7x3vd2g7md@linux-x5ow.site>
 <Pine.LNX.4.44L0.1807191033200.1491-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.44L0.1807191033200.1491-100000@iolanthe.rowland.org>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 19, 2018 at 10:35:39AM -0400, Alan Stern wrote:
> On Thu, 19 Jul 2018, Johannes Thumshirn wrote:
> 
> The performance affect of runtime PM ought to be less than 1%.  If it
> is larger, we'll figure out a different approach.

OK, let's see then.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
