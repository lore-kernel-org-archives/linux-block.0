Return-Path: <prvs=7319e9ae6=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "keith.busch@linux.intel.com"
	<keith.busch@linux.intel.com>
CC: "keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Date: Thu, 19 Jul 2018 16:04:46 +0000
Message-ID: <7239f833438701fb6ce21d819bc7042af1bc1f8a.camel@wdc.com>
References: <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
	 <20180713184712.GA19419@localhost.localdomain>
	 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
	 <20180713235807.GA19967@localhost.localdomain>
	 <20180718195650.GA20336@lst.de>
	 <20180718205321.GA32160@localhost.localdomain>
	 <c67f3da64914a436bc76f3ec0bc261ee6178cd14.camel@wdc.com>
	 <20180718211711.GB32160@localhost.localdomain>
	 <20180719131903.GB13129@lst.de>
	 <20180719145931.GF32160@localhost.localdomain>
	 <20180719155616.GG32160@localhost.localdomain>
In-Reply-To: <20180719155616.GG32160@localhost.localdomain>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-07-19 at 09:56 -0600, Keith Busch wrote:
+AD4- Even some scsi drivers are susceptible to losing their requests with =
the
+AD4- reverted behavior: take virtio-scsi for example, which returns RESET+=
AF8-TIMER
+AD4- from it's timeout handler. With the behavior everyone seems to want,
+AD4- a natural completion at or around the same time is lost forever becau=
se
+AD4- it was blocked from completion with no way to recover.

The patch I had posted handles a completion that occurs while a timeout is
being handled properly. From https://www.mail-archive.com/linux-block+AEA-v=
ger.kernel.org/msg22196.html:

 void blk+AF8-mq+AF8-complete+AF8-request(struct request +ACo-rq)
+AFs- ... +AF0-
+-               if (blk+AF8-mq+AF8-change+AF8-rq+AF8-state(rq, MQ+AF8-RQ+A=
F8-IN+AF8-FLIGHT,
+-                                          MQ+AF8-RQ+AF8-COMPLETE)) +AHs-
+-                       +AF8AXw-blk+AF8-mq+AF8-complete+AF8-request(rq)+AD=
s-
+-                       break+ADs-
+-               +AH0-
+-               if (blk+AF8-mq+AF8-change+AF8-rq+AF8-state(rq, MQ+AF8-RQ+A=
F8-TIMED+AF8-OUT, MQ+AF8-RQ+AF8-COMPLETE))
+-                       break+ADs-
+AFs- ... +AF0-
+AEAAQA- -838,25 +-838,42 +AEAAQA- static void blk+AF8-mq+AF8-rq+AF8-timed+=
AF8-out(struct request +ACo-req, bool reserved)
+AFs- ... +AF0-
        case BLK+AF8-EH+AF8-RESET+AF8-TIMER:
+AFs- ... +AF0-
+-                       if (blk+AF8-mq+AF8-rq+AF8-state(req) +AD0APQ- MQ+A=
F8-RQ+AF8-COMPLETE) +AHs-
+-                               +AF8AXw-blk+AF8-mq+AF8-complete+AF8-reques=
t(req)+ADs-
+-                               break+ADs-
+-                       +AH0-

Bart.=
