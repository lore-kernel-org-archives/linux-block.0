Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1538607089.205649.36.camel@acm.org>
Subject: Re: [PATCH] blk-mq-debugfs: Also show requests that have not yet
 been started
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>, "martin.petersen@oracle.com"
	 <martin.petersen@oracle.com>, "hare@suse.com" <hare@suse.com>,
	"ming.lei@redhat.com"
	 <ming.lei@redhat.com>
Date: Wed, 03 Oct 2018 15:51:29 -0700
In-Reply-To: <06b58979-0496-c583-2c00-ccdbd10e0aa9@kernel.dk>
References: <20180112215207.17852-1-bart.vanassche@wdc.com>
	 <78a60ddb-7e5f-3dac-2024-390e17da02f8@kernel.dk>
	 <1515794417.2396.72.camel@wdc.com>
	 <9ae89a07-7ade-f0c6-cc54-ed56bcc4d5cf@kernel.dk>
	 <1515795074.2396.75.camel@wdc.com> <1538602937.205649.29.camel@acm.org>
	 <06b58979-0496-c583-2c00-ccdbd10e0aa9@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-10-03 at 16:12 -0600, Jens Axboe wrote:
+AD4 On 10/3/18 3:42 PM, Bart Van Assche wrote:
+AD4 +AD4 On Fri, 2018-01-12 at 22:11 +-0000, Bart Van Assche wrote:
+AD4 +AD4 +AD4  /+ACo
+AD4 +AD4 +AD4 +- +ACo Show +ACI-busy+ACI requests - these are the requests owned by the block driver.
+AD4 +AD4 +AD4 +- +ACo The test list+AF8-empty(+ACY-rq-+AD4-queuelist) is used to figure out whether or not
+AD4 +AD4 +AD4 +- +ACo a request is owned by the block driver. That test works because the block
+AD4 +AD4 +AD4 +- +ACo layer core uses list+AF8-del+AF8-init() consistently to remove a request from one
+AD4 +AD4 +AD4 +- +ACo of the request lists.
+AD4 +AD4 +AD4 +- +ACo
+AD4 +AD4 +AD4   +ACo Note: the state of a request may change while this function is in progress,
+AD4 +AD4 +AD4   +ACo e.g. due to a concurrent blk+AF8-mq+AF8-finish+AF8-request() call.
+AD4 +AD4 +AD4   +ACo-/
+AD4 +AD4 +AD4 +AEAAQA -402,7 +-408,7 +AEAAQA static void hctx+AF8-show+AF8-busy+AF8-rq(struct request +ACo-rq, void +ACo-data, bool reserved)
+AD4 +AD4 +AD4  	const struct show+AF8-busy+AF8-params +ACo-params +AD0 data+ADs
+AD4 +AD4 +AD4  
+AD4 +AD4 +AD4  	if (blk+AF8-mq+AF8-map+AF8-queue(rq-+AD4-q, rq-+AD4-mq+AF8-ctx-+AD4-cpu) +AD0APQ params-+AD4-hctx +ACYAJg
+AD4 +AD4 +AD4 -	    blk+AF8-mq+AF8-rq+AF8-state(rq) +ACEAPQ MQ+AF8-RQ+AF8-IDLE)
+AD4 +AD4 +AD4 +-	    list+AF8-empty(+ACY-rq-+AD4-queuelist))
+AD4 +AD4 +AD4  		+AF8AXw-blk+AF8-mq+AF8-debugfs+AF8-rq+AF8-show(params-+AD4-m,
+AD4 +AD4 +AD4  					 list+AF8-entry+AF8-rq(+ACY-rq-+AD4-queuelist))+ADs
+AD4 +AD4 +AD4  +AH0
+AD4 +AD4 
+AD4 +AD4 Hello Jens,
+AD4 +AD4 
+AD4 +AD4 Can you share your opinion about the above patch?
+AD4 
+AD4 I just convince myself that the list check is super useful. The request
+AD4 could be on any number of lists, either not yet seen by the driver, or
+AD4 maybe sitting in dispatch. You're only going to be finding these
+AD4 requests if the tag is allocated, which means that it's already in some
+AD4 sort of non-idle state.
+AD4 
+AD4 So enlighten me why we need the list check at all? Wouldn't it be better
+AD4 to simply remove it, and ensure that the debug print includes things
+AD4 like list state, rq state, etc?

Hello Jens,

I have tried to leave the list+AF8-empty() check out but if I do that then
requests that have the state +ACI-idle+ACI (allocated but not yet started) also
show up. I think these should be left out from the output produced by
reading the +ACI-busy+ACI attribute because such requests are not interesting
when analyzing an I/O lockup:

nullb0/hctx1/busy:00000000abe67123 +AHs.op+AD0-READ, .cmd+AF8-flags+AD0, .rq+AF8-flags+AD0-IO+AF8-STAT+AHw-STATS, .s
tate+AD0-idle, .tag+AD0-63, .internal+AF8-tag+AD0--1+AH0

Thanks,

Bart.
