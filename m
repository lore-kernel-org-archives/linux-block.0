Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537976305.35256.4.camel@acm.org>
Subject: Re: [PATCH v2] block: fix deadline elevator drain for zoned block
 devices
From: Bart Van Assche <bvanassche@acm.org>
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Wed, 26 Sep 2018 08:38:25 -0700
In-Reply-To: <20180926073037.29563-1-damien.lemoal@wdc.com>
References: <20180926073037.29563-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-09-26 at 16:30 +-0900, Damien Le Moal wrote:
+AD4 diff --git a/block/elevator.c b/block/elevator.c
+AD4 index 6a06b5d040e5..8cd81fd6339a 100644
+AD4 --- a/block/elevator.c
+AD4 +-+-+- b/block/elevator.c
+AD4 +AEAAQA -609,7 +-609,7 +AEAAQA void elv+AF8-drain+AF8-elevator(struct request+AF8-queue +ACo-q)
+AD4  
+AD4  	while (e-+AD4-type-+AD4-ops.sq.elevator+AF8-dispatch+AF8-fn(q, 1))
+AD4  		+ADs
+AD4 -	if (q-+AD4-nr+AF8-sorted +ACYAJg printed+-+- +ADw 10) +AHs
+AD4 +-	if (q-+AD4-nr+AF8-sorted +ACYAJg printed+-+- +ADw 10 +ACYAJg +ACE-blk+AF8-queue+AF8-is+AF8-zoned(q)) +AHs
+AD4  		printk(KERN+AF8-ERR +ACIAJQ-s: forced dispatching is broken +ACI
+AD4  		       +ACI(nr+AF8-sorted+AD0AJQ-u), please report this+AFw-n+ACI,
+AD4  		       q-+AD4-elevator-+AD4-type-+AD4-elevator+AF8-name, q-+AD4-nr+AF8-sorted)+ADs

It seems wrong to me to perform the blk+AF8-queue+AF8-is+AF8-zoned() check after having
incremented the +ACI-printed+ACI variable. Shouldn't that check be performed before
incrementing the +ACI-printed+ACI variable to avoid that +ACI-printed+ACI gets incremented
if we know that we are not going to report the error message?

Thanks,

Bart.
