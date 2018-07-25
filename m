Return-Path: <prvs=737f04b27=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCHv2 2/2] scsi: set timed out out mq requests to complete
Date: Wed, 25 Jul 2018 15:52:17 +0000
Message-ID: <bd7fe6618616db1c2de80386d1a916d86bccbcfd.camel@wdc.com>
References: <20180723143751.10843-1-keith.busch@intel.com>
	 <20180723143751.10843-2-keith.busch@intel.com>
In-Reply-To: <20180723143751.10843-2-keith.busch@intel.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-07-23 at 08:37 -0600, Keith Busch wrote:
+AD4- diff --git a/drivers/scsi/scsi+AF8-error.c b/drivers/scsi/scsi+AF8-er=
ror.c
+AD4- index 8932ae81a15a..2715cdaa669c 100644
+AD4- --- a/drivers/scsi/scsi+AF8-error.c
+AD4- +-+-+- b/drivers/scsi/scsi+AF8-error.c
+AD4- +AEAAQA- -296,6 +-296,20 +AEAAQA- enum blk+AF8-eh+AF8-timer+AF8-retur=
n scsi+AF8-times+AF8-out(struct request +ACo-req)
+AD4-  		rtn +AD0- host-+AD4-hostt-+AD4-eh+AF8-timed+AF8-out(scmd)+ADs-
+AD4- =20
+AD4-  	if (rtn +AD0APQ- BLK+AF8-EH+AF8-DONE) +AHs-
+AD4- +-		/+ACo-
+AD4- +-		 +ACo- For blk-mq, we must set the request state to complete now
+AD4- +-		 +ACo- before sending the request to the scsi error handler. This
+AD4- +-		 +ACo- will prevent a use-after-free in the event the LLD manages
+AD4- +-		 +ACo- to complete the request before the error handler finishes
+AD4- +-		 +ACo- processing this timed out request.
+AD4- +-		 +ACo-
+AD4- +-		 +ACo- If the request was already completed, then the LLD beat th=
e
+AD4- +-		 +ACo- time out handler from transferring the request to the scsi
+AD4- +-		 +ACo- error handler. In that case we can return immediately as n=
o
+AD4- +-		 +ACo- further action is required.
+AD4- +-		 +ACo-/
+AD4- +-		if (req-+AD4-q-+AD4-mq+AF8-ops +ACYAJg- +ACE-blk+AF8-mq+AF8-mark+=
AF8-complete(req))
+AD4- +-			return rtn+ADs-
+AD4-  		if (scsi+AF8-abort+AF8-command(scmd) +ACEAPQ- SUCCESS) +AHs-
+AD4-  			set+AF8-host+AF8-byte(scmd, DID+AF8-TIME+AF8-OUT)+ADs-
+AD4-  			scsi+AF8-eh+AF8-scmd+AF8-add(scmd)+ADs-

Hello Keith,

What will happen if a completion occurs after scsi+AF8-times+AF8-out() has =
started and
before or during the host-+AD4-hostt-+AD4-eh+AF8-timed+AF8-out()? Can that =
cause a use-after-free
in .eh+AF8-timed+AF8-out()? Can that cause .eh+AF8-timed+AF8-out() to retur=
n BLK+AF8-EH+AF8-RESET+AF8-TIMER
when it should return BLK+AF8-EH+AF8-DONE? Can that cause blk+AF8-mq+AF8-rq=
+AF8-timed+AF8-out() to call
blk+AF8-add+AF8-timer() when that function shouldn't be called?

Thanks,

Bart.
