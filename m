Return-Path: <prvs=7391cfe80=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@intel.com" <keith.busch@intel.com>
CC: "hch@lst.de" <hch@lst.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 5/5] blk-mq: Rework blk-mq timeout handling again
Date: Fri, 27 Jul 2018 16:51:05 +0000
Message-ID: <08bd5d1c691e2c8f9950f7ebcf04716507a02675.camel@wdc.com>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
	 <20180727162042.13425-6-bart.vanassche@wdc.com>
	 <20180727164627.GB20829@localhost.localdomain>
In-Reply-To: <20180727164627.GB20829@localhost.localdomain>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-27 at 10:46 -0600, Keith Busch wrote:
+AD4- On Fri, Jul 27, 2018 at 09:20:42AM -0700, Bart Van Assche wrote:
+AD4- +AD4- +-	ret +AD0- req-+AD4-q-+AD4-mq+AF8-ops-+AD4-timeout(req, reser=
ved)+ADs-
+AD4- +AD4- +-	/+ACo-
+AD4- +AD4- +-	 +ACo- BLK+AF8-EH+AF8-DONT+AF8-RESET+AF8-TIMER means that th=
e block driver either
+AD4- +AD4- +-	 +ACo- completed the request or still owns the request and w=
ill
+AD4- +AD4- +-	 +ACo- continue processing the timeout asynchronously. In th=
e
+AD4- +AD4- +-	 +ACo- latter case, if blk+AF8-mq+AF8-complete+AF8-request()=
 was called while
+AD4- +AD4- +-	 +ACo- the timeout handler was in progress, ignore that call=
.
+AD4- +AD4- +-	 +ACo-/
+AD4- +AD4- +-	if (ret +AD0APQ- BLK+AF8-EH+AF8-DONT+AF8-RESET+AF8-TIMER)
+AD4- +AD4- +-		return+ADs-
+AD4-=20
+AD4- This is how completions get lost.

The new approach for handling completions that occur while the .timeout()
callback in progress is as follows:
+ACo- blk+AF8-mq+AF8-complete+AF8-request() executes the following code:
       if (blk+AF8-mq+AF8-change+AF8-rq+AF8-state(rq, MQ+AF8-RQ+AF8-TIMED+A=
F8-OUT, MQ+AF8-RQ+AF8-COMPLETE))
               return+ADs-
+ACo- blk+AF8-mq+AF8-rq+AF8-timed+AF8-out() executes the following code:
       if (blk+AF8-mq+AF8-rq+AF8-state(req) +AD0APQ- MQ+AF8-RQ+AF8-COMPLETE=
) +AHs-
               +AF8AXw-blk+AF8-mq+AF8-complete+AF8-request(req)+ADs-
               return+ADs-
       +AH0-

As one can see +AF8AXw-blk+AF8-mq+AF8-complete+AF8-request() gets called if=
 this race occurs.

Bart.
