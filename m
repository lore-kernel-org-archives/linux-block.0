Return-Path: <prvs=746b4d33f=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v3 5/9] block, scsi: Rework runtime power management
Date: Fri, 3 Aug 2018 16:16:21 +0000
Message-ID: <a8bcea80d535fd59db9ee8d1576301ef1aefa296.camel@wdc.com>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
	 <20180802182944.14442-6-bart.vanassche@wdc.com>
	 <20180802235027.GA16047@ming.t460p>
In-Reply-To: <20180802235027.GA16047@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-08-03 at 07:50 +-0800, Ming Lei wrote:
+AD4- I am not sure if using PREEMPT+AF8-ONLY can work well for runtime PM,=
 there
+AD4- are lots of users which depends on blk+AF8-freeze+AF8-queue() for mak=
ing sure
+AD4- there isn't any in-flight requests.

Please elaborate +ACI-lots of other users+ACI-. The only use I have found i=
n the
kernel tree of that flag of which I think that it is not related to power
management is in ide+AF8-prep+AF8-sense(). All other uses of the RQF+AF8-PR=
EEMPT /
BLK+AF8-MQ+AF8-REQ+AF8-PREEMPT / QUEUE+AF8-FLAG+AF8-PREEMPT+AF8-ONLY flags =
I found are IMHO related
to power management:
+ACo- generic+AF8-ide+AF8-resume()
+ACo- +AF8AXw-scsi+AF8-execute()
+ACo- scsi+AF8-device+AF8-quiesce() / scsi+AF8-device+AF8-resume()

However, we may have to modify +AF8AXw-scsi+AF8-execute() such that only re=
quests
that are related to power management are submitted with the
BLK+AF8-MQ+AF8-REQ+AF8-PREEMPT flag set. I don't think that all +AF8AXw-scs=
i+AF8-execute() callers
need that flag.

+AD4- But now PREEMPT+AF8-ONLY opens one door for preempt-req during the bi=
g
+AD4- window, so this way may break current uses of blk+AF8-freeze+AF8-queu=
e().

The power management core serializes runtime power management against suspe=
nd,
resume and hibernation so I think it is safe to use the PREEMPT+AF8-ONLY fl=
ag for
runtime power management although it is already used for suspend, resume an=
d
hibernation.

Bart.
