Return-Path: <prvs=73255fbda=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@linux.intel.com" <keith.busch@linux.intel.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, "keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 2/2] scsi: set timed out out mq requests to complete
Date: Fri, 20 Jul 2018 16:03:18 +0000
Message-ID: <2b01f0a8d5864b2563573d46ce5b4ec5f593f538.camel@wdc.com>
References: <20180719212618.2406-1-keith.busch@intel.com>
	 <20180719212618.2406-2-keith.busch@intel.com>
	 <1073d0d2902327970c4e28a4c7c97a21fd8885c8.camel@wdc.com>
	 <20180720155646.GE4093@localhost.localdomain>
In-Reply-To: <20180720155646.GE4093@localhost.localdomain>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-20 at 09:56 -0600, Keith Busch wrote:
+AD4- On Fri, Jul 20, 2018 at 03:12:59PM +-0000, Bart Van Assche wrote:
+AD4- +AD4- On Thu, 2018-07-19 at 15:26 -0600, Keith Busch wrote:
+AD4- +AD4- +AD4- diff --git a/drivers/scsi/scsi+AF8-error.c b/drivers/scsi=
/scsi+AF8-error.c
+AD4- +AD4- +AD4- index 8932ae81a15a..86ee10b2c775 100644
+AD4- +AD4- +AD4- --- a/drivers/scsi/scsi+AF8-error.c
+AD4- +AD4- +AD4- +-+-+- b/drivers/scsi/scsi+AF8-error.c
+AD4- +AD4- +AD4- +AEAAQA- -286,6 +-286,9 +AEAAQA- enum blk+AF8-eh+AF8-time=
r+AF8-return scsi+AF8-times+AF8-out(struct request +ACo-req)
+AD4- +AD4- +AD4-  	enum blk+AF8-eh+AF8-timer+AF8-return rtn +AD0- BLK+AF8-=
EH+AF8-DONE+ADs-
+AD4- +AD4- +AD4-  	struct Scsi+AF8-Host +ACo-host +AD0- scmd-+AD4-device-+=
AD4-host+ADs-
+AD4- +AD4- +AD4- =20
+AD4- +AD4- +AD4- +-	if (req-+AD4-q-+AD4-mq+AF8-ops +ACYAJg- blk+AF8-mq+AF8=
-mark+AF8-complete(req))
+AD4- +AD4- +AD4- +-		return rtn+ADs-
+AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4-  	trace+AF8-scsi+AF8-dispatch+AF8-cmd+AF8-timeout(scmd)+A=
Ds-
+AD4- +AD4- +AD4-  	scsi+AF8-log+AF8-completion(scmd, TIMEOUT+AF8-ERROR)+AD=
s-
+AD4- +AD4- +AD4- =20
+AD4- +AD4- +AD4- +AEAAQA- -300,7 +-303,8 +AEAAQA- enum blk+AF8-eh+AF8-time=
r+AF8-return scsi+AF8-times+AF8-out(struct request +ACo-req)
+AD4- +AD4- +AD4-  			set+AF8-host+AF8-byte(scmd, DID+AF8-TIME+AF8-OUT)+ADs=
-
+AD4- +AD4- +AD4-  			scsi+AF8-eh+AF8-scmd+AF8-add(scmd)+ADs-
+AD4- +AD4- +AD4-  		+AH0-
+AD4- +AD4- +AD4- -	+AH0-
+AD4- +AD4- +AD4- +-	+AH0- else if (req-+AD4-q-+AD4-mq+AF8-ops)
+AD4- +AD4- +AD4- +-		WRITE+AF8-ONCE(req-+AD4-state, MQ+AF8-RQ+AF8-IN+AF8-F=
LIGHT)+ADs-
+AD4- +AD4- +AD4- =20
+AD4- +AD4- +AD4-  	return rtn+ADs-
+AD4- +AD4- +AD4-  +AH0-
+AD4- +AD4-=20
+AD4- +AD4- Modifying the completion state and req-+AD4-state from the SCSI=
 core are layering
+AD4- +AD4- violations. Have you considered to move the above changes into =
blk+AF8-mq+AF8-rq+AF8-timed+AF8-out()?
+AD4- +AD4- An additional benefit of that approach is that the req-+AD4-q-+=
AD4-mq+AF8-ops checks can be
+AD4- +AD4- left out.
+AD4-=20
+AD4- SCSI is the only block driver that wants this behavior. Moving it bac=
k
+AD4- to generic where it used to be breaks other block drivers.

That's new to me. What would break in the NVMe driver if the above change w=
ould be
present in the block layer?

Thanks,

Bart.
