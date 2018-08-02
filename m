Return-Path: <prvs=7457c2e9b=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Date: Thu, 2 Aug 2018 15:52:00 +0000
Message-ID: <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
	 <20180731045805.GE15701@ming.t460p>
	 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
	 <20180731061616.GF15701@ming.t460p>
	 <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
	 <20180801085841.GA27962@ming.t460p>
In-Reply-To: <20180801085841.GA27962@ming.t460p>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-08-01 at 16:58 +-0800, Ming Lei wrote:
+AD4- On Wed, Aug 01, 2018 at 10:17:30AM +-0800, jianchao.wang wrote:
+AD4- +AD4- However, due to the limits in hctx+AF8-may+AF8-queue, q+AF8-b s=
till cannot get the
+AD4- +AD4- tags. The RR restart also will not wake up q+AF8-a.
+AD4- +AD4- This is unfair for q+AF8-a.
+AD4- +AD4-=20
+AD4- +AD4- When we remove RR restart fashion, at least, the q+AF8-a will b=
e waked up by
+AD4- +AD4- the hctx restart.
+AD4- +AD4- Is this the improvement of fairness you said in driver tag allo=
cation ?
+AD4-=20
+AD4- I mean the fairness is totally covered by the general tag allocation
+AD4- algorithm now, which is sort of FIFO style because of waitqueue, but =
RR
+AD4- restart wakes up queue in the order of request queue.

>From sbitmap.h:

+ACM-define SBQ+AF8-WAIT+AF8-QUEUES 8

What do you think is the effect of your patch if more than eight LUNs are
active and the SCSI queue is full?

Thanks,

Bart.
