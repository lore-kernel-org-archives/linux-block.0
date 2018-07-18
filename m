Return-Path: <prvs=730b8c8b8=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "keith.busch@linux.intel.com" <keith.busch@linux.intel.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "jianchao.w.wang@oracle.com"
	<jianchao.w.wang@oracle.com>, "keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [RFC PATCH] blk-mq: move timeout handling from queue to tagset
Date: Wed, 18 Jul 2018 18:34:07 +0000
Message-ID: <adbe32bb3da7b0d405a57a176888be40f76581cb.camel@wdc.com>
References: <20180718170018.31395-1-keith.busch@intel.com>
	 <11f7a7aff754b9bb0e4243ac4502319f376378c3.camel@wdc.com>
	 <20180718174534.GC30873@localhost.localdomain>
In-Reply-To: <20180718174534.GC30873@localhost.localdomain>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-07-18 at 11:45 -0600, Keith Busch wrote:
+AD4- On Wed, Jul 18, 2018 at 05:18:45PM +-0000, Bart Van Assche wrote:
+AD4- +AD4- On Wed, 2018-07-18 at 11:00 -0600, Keith Busch wrote:
+AD4- +AD4- +AD4- -	cancel+AF8-work+AF8-sync(+ACY-q-+AD4-timeout+AF8-work)+=
ADs-
+AD4- +AD4- +AD4- -
+AD4- +AD4- +AD4-  	if (q-+AD4-mq+AF8-ops) +AHs-
+AD4- +AD4- +AD4-  		struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx+ADs-
+AD4- +AD4- +AD4-  		int i+ADs-
+AD4- +AD4- +AD4- +AEAAQA- -415,6 +-412,8 +AEAAQA- void blk+AF8-sync+AF8-qu=
eue(struct request+AF8-queue +ACo-q)
+AD4- +AD4- +AD4-  		queue+AF8-for+AF8-each+AF8-hw+AF8-ctx(q, hctx, i)
+AD4- +AD4- +AD4-  			cancel+AF8-delayed+AF8-work+AF8-sync(+ACY-hctx-+AD4-r=
un+AF8-work)+ADs-
+AD4- +AD4- +AD4-  	+AH0- else +AHs-
+AD4- +AD4- +AD4- +-		del+AF8-timer+AF8-sync(+ACY-q-+AD4-timeout)+ADs-
+AD4- +AD4- +AD4- +-		cancel+AF8-work+AF8-sync(+ACY-q-+AD4-timeout+AF8-work=
)+ADs-
+AD4- +AD4- +AD4-  		cancel+AF8-delayed+AF8-work+AF8-sync(+ACY-q-+AD4-delay=
+AF8-work)+ADs-
+AD4- +AD4- +AD4-  	+AH0-
+AD4- +AD4- +AD4-  +AH0-
+AD4- +AD4-=20
+AD4- +AD4- What is the impact of this change on the md driver, which is th=
e only driver
+AD4- +AD4- that calls blk+AF8-sync+AF8-queue() directly? What will happen =
if timeout processing
+AD4- +AD4- happens concurrently with or after blk+AF8-sync+AF8-queue() has=
 returned?
+AD4-=20
+AD4- That's a make+AF8-request+AF8-fn stacking driver, right? There should=
 be
+AD4- no impact in that case, since the change above affects only mq.
+AD4-=20
+AD4- I'm actually a little puzzled why md calls blk+AF8-sync+AF8-queue. Ar=
e the
+AD4- queue timers ever used for bio-based drivers?

Hello Keith,

For all md drivers that I verified calling md+AF8-make+AF8-request() trigge=
rs one or
more generic+AF8-make+AF8-request() calls for the underlying devices. So it=
's not
clear to me why the md driver calls blk+AF8-sync+AF8-queue().

Bart.=
