Return-Path: <prvs=7391cfe80=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 4/5] block, scsi: Rework runtime power management
Date: Fri, 27 Jul 2018 15:09:02 +0000
Message-ID: <c1264b65598598dacafc51df34dcd09201c2c095.camel@wdc.com>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
	 <20180725222607.8854-5-bart.vanassche@wdc.com>
	 <0fe202dd-32a6-4bd1-43dd-440511ad52e4@oracle.com>
	 <b73752a1ea9356cce26e36bd8538391c5985f81a.camel@wdc.com>
	 <aa8cbdb5-826d-1481-e60b-1c27b1c02682@oracle.com>
In-Reply-To: <aa8cbdb5-826d-1481-e60b-1c27b1c02682@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-27 at 09:57 +-0800, jianchao.wang wrote:
+AD4- If q+AF8-usage+AF8-counter is not zero here, we will leave the reques=
t+AF8-queue in preempt only mode.

That's on purpose. If q+AF8-usage+AF8-counter is not zero then blk+AF8-pre+=
AF8-runtime+AF8-suspend()
will return -EBUSY. That error code will be passed to blk+AF8-post+AF8-runt=
ime+AF8-suspend()
and that will cause that function to clear QUEUE+AF8-FLAG+AF8-PREEMPT+AF8-O=
NLY.

+AD4- The request+AF8-queue should be set to preempt only mode only when we=
 confirm we could set
+AD4- rpm+AF8-status to RPM+AF8-SUSPENDING or RPM+AF8-RESUMING.

Why do you think this?

Bart.
