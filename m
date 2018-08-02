Return-Path: <prvs=7457c2e9b=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "stern@rowland.harvard.edu"
	<stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 4/5] block, scsi: Rework runtime power management
Date: Thu, 2 Aug 2018 18:00:42 +0000
Message-ID: <ef33bbeda3acb0548ebaa77530edbf910c49dbe8.camel@wdc.com>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
	 <20180725222607.8854-5-bart.vanassche@wdc.com>
	 <0fe202dd-32a6-4bd1-43dd-440511ad52e4@oracle.com>
	 <b73752a1ea9356cce26e36bd8538391c5985f81a.camel@wdc.com>
	 <aa8cbdb5-826d-1481-e60b-1c27b1c02682@oracle.com>
	 <c1264b65598598dacafc51df34dcd09201c2c095.camel@wdc.com>
	 <c1e71057-0245-f1bd-5adb-c9f706230da6@oracle.com>
In-Reply-To: <c1e71057-0245-f1bd-5adb-c9f706230da6@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-07-30 at 09:56 +-0800, jianchao.wang wrote:
+AD4- static int sdev+AF8-runtime+AF8-suspend(struct device +ACo-dev)
+AD4- +AHs-
+AD4- 	const struct dev+AF8-pm+AF8-ops +ACo-pm +AD0- dev-+AD4-driver ? dev-=
+AD4-driver-+AD4-pm : NULL+ADs-
+AD4- 	struct scsi+AF8-device +ACo-sdev +AD0- to+AF8-scsi+AF8-device(dev)+A=
Ds-
+AD4- 	int err +AD0- 0+ADs-
+AD4-=20
+AD4- 	err +AD0- blk+AF8-pre+AF8-runtime+AF8-suspend(sdev-+AD4-request+AF8-=
queue)+ADs-
+AD4- 	if (err)
+AD4- 		return err+ADs-
+AD4- 	if (pm +ACYAJg- pm-+AD4-runtime+AF8-suspend)
+AD4- 		err +AD0- pm-+AD4-runtime+AF8-suspend(dev)+ADs-
+AD4- 	blk+AF8-post+AF8-runtime+AF8-suspend(sdev-+AD4-request+AF8-queue, er=
r)+ADs-
+AD4-=20
+AD4- 	return err+ADs-
+AD4- +AH0-
+AD4-=20
+AD4- If blk+AF8-pre+AF8-runtime+AF8-suspend returns -EBUSY, blk+AF8-post+A=
F8-runtime+AF8-suspend will not be invoked.

Right, I will fix this.

+AD4- +AD4- +AD4- The request+AF8-queue should be set to preempt only mode =
only when we confirm we could set
+AD4- +AD4- +AD4- rpm+AF8-status to RPM+AF8-SUSPENDING or RPM+AF8-RESUMING.
+AD4- +AD4-=20
+AD4- +AD4- Why do you think this?
+AD4-=20
+AD4- https://marc.info/?l+AD0-linux-scsi+ACY-m+AD0-133727953625963+ACY-w+A=
D0-2
+AD4- +ACI-
+AD4- If q-+AD4-rpm+AF8-status is RPM+AF8-SUSPENDED, they shouldn't do anyt=
hing -- act as though the queue is
+AD4- empty.  If q-+AD4-rpm+AF8-status is RPM+AF8-SUSPENDING or RPM+AF8-RES=
UMING, they should hand over the request
+AD4- only if it has the REQ+AF8-PM flag set.
+AD4- +ACI-

I think the blk+AF8-pre+AF8-runtime+AF8-suspend() callers guarantee that q-=
+AD4-rpm+AF8-status +AD0APQ- RPM+AF8-ACTIVE
before blk+AF8-pre+AF8-runtime+AF8-suspend() is called. I will add a WARN+A=
F8-ON+AF8-ONCE() statement that
verifies that.

+AD4- In additon, if we set the preempt only here unconditionally, the norm=
al IO will be blocked
+AD4- during the blk+AF8-pre+AF8-runtime+AF8-suspend. In your patch, q+AF8-=
usage+AF8-counter will be switched to atomic mode,
+AD4- this could cost some time. Is it really OK ?

I will see what I can do about this.

Bart.
