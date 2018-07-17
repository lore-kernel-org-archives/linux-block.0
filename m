Return-Path: <prvs=72995191e=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "jthumshirn@suse.de" <jthumshirn@suse.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "hare@suse.de" <hare@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC V2 3/3] scsi_mq: enable runtime PM
Date: Tue, 17 Jul 2018 15:34:35 +0000
Message-ID: <07874eaab2d93728afe3f220cd0efa8f41d4955a.camel@wdc.com>
References: <20180713080602.31602-1-ming.lei@redhat.com>
	 <20180713080602.31602-4-ming.lei@redhat.com>
	 <20180717132411.GI13582@lst.de> <20180717153031.GA8973@ming.t460p>
In-Reply-To: <20180717153031.GA8973@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-07-17 at 23:30 +-0800, Ming Lei wrote:
+AD4- On Tue, Jul 17, 2018 at 03:24:11PM +-0200, Christoph Hellwig wrote:
+AD4- +AD4- On Fri, Jul 13, 2018 at 04:06:02PM +-0800, Ming Lei wrote:
+AD4- +AD4- +AD4- Usually SCSI supports runtime PM, so pass BLK+AF8-MQ+AF8-=
F+AF8-SUPPORT+AF8-RPM to blk-mq
+AD4- +AD4- +AD4- core for enabling block runtime PM.
+AD4- +AD4-=20
+AD4- +AD4- I still think enabling this unconditionally for any SCSI device=
 was
+AD4- +AD4- a mistake, and it is even more so for blk-mq.
+AD4- +AD4-=20
+AD4- +AD4- Please only opt in for ufs, ATA first, adding others if wanted =
by
+AD4- +AD4- maintainers.
+AD4-=20
+AD4- No, this way will cause regression because runtime PM works for
+AD4- all sd/sr device actually, and it isn't related with scsi host.

For which SCSI devices other than ufs and ATA do we need PM support?

Bart.
