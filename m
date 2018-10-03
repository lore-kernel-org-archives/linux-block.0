Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1538602937.205649.29.camel@acm.org>
Subject: Re: [PATCH] blk-mq-debugfs: Also show requests that have not yet
 been started
From: Bart Van Assche <bvanassche@acm.org>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org"
	 <linux-block@vger.kernel.org>, "martin.petersen@oracle.com"
	 <martin.petersen@oracle.com>, "hare@suse.com" <hare@suse.com>,
	"ming.lei@redhat.com"
	 <ming.lei@redhat.com>
Date: Wed, 03 Oct 2018 14:42:17 -0700
In-Reply-To: <1515795074.2396.75.camel@wdc.com>
References: <20180112215207.17852-1-bart.vanassche@wdc.com>
	 <78a60ddb-7e5f-3dac-2024-390e17da02f8@kernel.dk>
	 <1515794417.2396.72.camel@wdc.com>
	 <9ae89a07-7ade-f0c6-cc54-ed56bcc4d5cf@kernel.dk>
	 <1515795074.2396.75.camel@wdc.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-01-12 at 22:11 +-0000, Bart Van Assche wrote:
+AD4 On Fri, 2018-01-12 at 15:05 -0700, Jens Axboe wrote:
+AD4 +AD4 On 1/12/18 3:00 PM, Bart Van Assche wrote:
+AD4 +AD4 +AD4 On Fri, 2018-01-12 at 14:55 -0700, Jens Axboe wrote:
+AD4 +AD4 +AD4 +AD4 On 1/12/18 2:52 PM, Bart Van Assche wrote:
+AD4 +AD4 +AD4 +AD4 +AD4 When debugging e.g. the SCSI timeout handler it is important that
+AD4 +AD4 +AD4 +AD4 +AD4 requests that have not yet been started or that already have
+AD4 +AD4 +AD4 +AD4 +AD4 completed are also reported through debugfs.
+AD4 +AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 +AD4 This patch depends on a patch that went upstream recently, namely
+AD4 +AD4 +AD4 +AD4 +AD4 commit 14e3062fb185 (+ACI-scsi: core: Fix a scsi+AF8-show+AF8-rq() NULL pointer
+AD4 +AD4 +AD4 +AD4 +AD4 dereference+ACI).
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 Why don't we just kill the check, and dump any request that has a
+AD4 +AD4 +AD4 +AD4 matching hctx? We already know the bit was set, so just print
+AD4 +AD4 +AD4 +AD4 all of them.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 It is very helpful during debugging that requests owned by a block driver and
+AD4 +AD4 +AD4 requests owned by the block layer core show up in different debugfs files.
+AD4 +AD4 +AD4 Removing the check completely would cause all requests to show up in the same
+AD4 +AD4 +AD4 debugfs file and would make interpreting the contents of these debugfs files
+AD4 +AD4 +AD4 much harder.
+AD4 +AD4 
+AD4 +AD4 Yeah, we'd have to make it just one file at that point. I'm not hugely
+AD4 +AD4 against the queuelist check, but probably warrants a comment as it's not
+AD4 +AD4 immediately clear (as opposed to the idle check, or the previous START
+AD4 +AD4 bit check).
+AD4 
+AD4 How about the below?
+AD4 
+AD4 diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
+AD4 index 19db3f583bf1..da859dac442b 100644
+AD4 --- a/block/blk-mq-debugfs.c
+AD4 +-+-+- b/block/blk-mq-debugfs.c
+AD4 +AEAAQA -394,6 +-394,12 +AEAAQA struct show+AF8-busy+AF8-params +AHs
+AD4  +AH0AOw
+AD4  
+AD4  /+ACo
+AD4 +- +ACo Show +ACI-busy+ACI requests - these are the requests owned by the block driver.
+AD4 +- +ACo The test list+AF8-empty(+ACY-rq-+AD4-queuelist) is used to figure out whether or not
+AD4 +- +ACo a request is owned by the block driver. That test works because the block
+AD4 +- +ACo layer core uses list+AF8-del+AF8-init() consistently to remove a request from one
+AD4 +- +ACo of the request lists.
+AD4 +- +ACo
+AD4   +ACo Note: the state of a request may change while this function is in progress,
+AD4   +ACo e.g. due to a concurrent blk+AF8-mq+AF8-finish+AF8-request() call.
+AD4   +ACo-/
+AD4 +AEAAQA -402,7 +-408,7 +AEAAQA static void hctx+AF8-show+AF8-busy+AF8-rq(struct request +ACo-rq, void +ACo-data, bool reserved)
+AD4  	const struct show+AF8-busy+AF8-params +ACo-params +AD0 data+ADs
+AD4  
+AD4  	if (blk+AF8-mq+AF8-map+AF8-queue(rq-+AD4-q, rq-+AD4-mq+AF8-ctx-+AD4-cpu) +AD0APQ params-+AD4-hctx +ACYAJg
+AD4 -	    blk+AF8-mq+AF8-rq+AF8-state(rq) +ACEAPQ MQ+AF8-RQ+AF8-IDLE)
+AD4 +-	    list+AF8-empty(+ACY-rq-+AD4-queuelist))
+AD4  		+AF8AXw-blk+AF8-mq+AF8-debugfs+AF8-rq+AF8-show(params-+AD4-m,
+AD4  					 list+AF8-entry+AF8-rq(+ACY-rq-+AD4-queuelist))+ADs
+AD4  +AH0

Hello Jens,

Can you share your opinion about the above patch?

Thanks,

Bart.
