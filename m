Return-Path: <hch@lst.de>
Date: Tue, 17 Jul 2018 21:50:08 +0200
From: "hch@lst.de" <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC V2 3/3] scsi_mq: enable runtime PM
Message-ID: <20180717195008.GA28809@lst.de>
References: <20180713080602.31602-1-ming.lei@redhat.com> <20180713080602.31602-4-ming.lei@redhat.com> <20180717132411.GI13582@lst.de> <20180717153031.GA8973@ming.t460p> <07874eaab2d93728afe3f220cd0efa8f41d4955a.camel@wdc.com> <20180717153847.GB8973@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180717153847.GB8973@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 17, 2018 at 11:38:53PM +0800, Ming Lei wrote:
> As I said, it is any sd/sr device, which can be put down by runtime PM
> via START_STOP command if it isn't used for a while.

And in which case do we care that this happens?
