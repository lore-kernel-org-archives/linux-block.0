Return-Path: <prvs=7391cfe80=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@intel.com" <keith.busch@intel.com>
CC: "hch@lst.de" <hch@lst.de>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 5/5] blk-mq: Rework blk-mq timeout handling again
Date: Fri, 27 Jul 2018 16:59:34 +0000
Message-ID: <fca08072e67fc8a8a9c9acfe130753ee7020f4fe.camel@wdc.com>
References: <20180727162042.13425-1-bart.vanassche@wdc.com>
	 <20180727162042.13425-6-bart.vanassche@wdc.com>
	 <20180727164627.GB20829@localhost.localdomain>
	 <08bd5d1c691e2c8f9950f7ebcf04716507a02675.camel@wdc.com>
	 <20180727165718.GC20829@localhost.localdomain>
In-Reply-To: <20180727165718.GC20829@localhost.localdomain>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-27 at 10:57 -0600, Keith Busch wrote:
+AD4- You skip that code if the driver returns BLK+AF8-EH+AF8-DONT+AF8-RESE=
T+AF8-TIMER.

How about applying the following patch on top of this series?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a97ab5ba9d18..aa66535604fd 100644
--- a/block/blk-mq.c
+-+-+- b/block/blk-mq.c
+AEAAQA- -854,10 +-854,10 +AEAAQA- static void blk+AF8-mq+AF8-rq+AF8-timed+=
AF8-out(struct request +ACo-req, bool reserved)
 	 +ACo- latter case, if blk+AF8-mq+AF8-complete+AF8-request() was called w=
hile
 	 +ACo- the timeout handler was in progress, ignore that call.
 	 +ACo-/
-	if (ret +AD0APQ- BLK+AF8-EH+AF8-DONT+AF8-RESET+AF8-TIMER)
-		return+ADs-
-	WARN+AF8-ON+AF8-ONCE(ret +ACEAPQ- BLK+AF8-EH+AF8-RESET+AF8-TIMER)+ADs-
-	blk+AF8-mq+AF8-add+AF8-timer(req)+ADs-
+-	if (ret +AD0APQ- BLK+AF8-EH+AF8-RESET+AF8-TIMER)
+-		blk+AF8-mq+AF8-add+AF8-timer(req)+ADs-
+-	else
+-		WARN+AF8-ON+AF8-ONCE(ret +ACEAPQ- BLK+AF8-EH+AF8-DONT+AF8-RESET+AF8-TIM=
ER)+ADs-
 again:
 	if (blk+AF8-mq+AF8-change+AF8-rq+AF8-state(req, MQ+AF8-RQ+AF8-TIMED+AF8-O=
UT, MQ+AF8-RQ+AF8-IN+AF8-FLIGHT))
 		return+ADs-

Bart.
