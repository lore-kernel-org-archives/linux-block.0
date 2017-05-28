Return-Path: <hch@lst.de>
Date: Sun, 28 May 2017 10:34:40 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"osandov@fb.com" <osandov@fb.com>, "axboe@fb.com" <axboe@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 08/19] block: Introduce request_queue.initialize_rq_fn()
Message-ID: <20170528083440.GB13083@lst.de>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com> <20170525184327.23570-9-bart.vanassche@sandisk.com> <20170526063430.GA19034@lst.de> <1495842989.2634.13.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1495842989.2634.13.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 26, 2017 at 11:56:30PM +0000, Bart Van Assche wrote:
> I have tried to move that call into blk_mq_alloc_request() but that
> resulted in a kernel oops during boot due to scsi_add_cmd_to_list()
> dereferencing scsi_cmnd.device and due to that pointer being invalid.
> I think that pointer was invalid because moving the initialize_rq_fn()
> call into blk_mq_alloc_request() caused request initialization to be
> skipped for the following code path:
> submit_bio()
> -> generic_make_request()
>   -> .make_request_fn == blk_mq_make_request()
>  �  -> blk_mq_sched_get_request()
>       -> __blk_mq_alloc_request()
>  � � �  -> blk_mq_rq_ctx_init()
> 
> This is why I would like to keep the .initialize_rq_fn() call in
> blk_mq_rq_ctx_init().

But we don't call scsi_req_init for this path either with the current
code.  So not having the call should be fine as long as you ensure
we still manually initialize everything for the non-passthrough path
in the later patches.  I'll keep an eye on that issue while reviewing
the remaining patches.
