Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "keith.busch@linux.intel.com" <keith.busch@linux.intel.com>
Cc: "hch@lst.de" <hch@lst.de>,
        "keith.busch@intel.com"
 <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
 <20180712192437.GA16839@localhost.localdomain>
 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d19bebcd-8a60-fcbc-ddf5-1dcf1fe553ca@oracle.com>
Date: Fri, 13 Jul 2018 10:40:16 +0800
MIME-Version: 1.0
In-Reply-To: <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>


On 07/13/2018 06:24 AM, Bart Van Assche wrote:
> Hello Keith,
> 
> Before commit 12f5b9314545 ("blk-mq: Remove generation seqeunce"), if a
> request completion was reported after request timeout processing had
> started, completion handling was skipped. The following code in
> blk_mq_complete_request() realized that:
> 
> 	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
> 		__blk_mq_complete_request(rq);

Even if before tejun's patch, we also have this for both blk-mq and blk-legacy code.

blk_rq_check_expired

    if (time_after_eq(jiffies, rq->deadline)) {
        list_del_init(&rq->timeout_list);

        /*
         * Check if we raced with end io completion
         */
        if (!blk_mark_rq_complete(rq))
            blk_rq_timed_out(rq);
    } 
 

blk_complete_request
    
    if (!blk_mark_rq_complete(req))
        __blk_complete_request(req);

blk_mq_check_expired
    
    if (time_after_eq(jiffies, rq->deadline)) {
        if (!blk_mark_rq_complete(rq))
            blk_mq_rq_timed_out(rq, reserved);
    }


blk_mq_complete_request

    if (!blk_mark_rq_complete(rq))
        __blk_mq_complete_request(rq);

Thanks
Jianchao

> 
> Since commit 12f5b9314545, if a completion occurs after request timeout
> processing has started, that completion is processed if the request has the
> state MQ_RQ_IN_FLIGHT. blk_mq_rq_timed_out() does not modify the request
> state unless the block driver timeout handler modifies it, e.g. by calling
> blk_mq_end_request() or by calling blk_mq_requeue_request(). The typical
> behavior of scsi_times_out() is to queue sending of a SCSI abort and hence
> not to change the request state immediately. In other words, if a request
> completion occurs during or shortly after a timeout occurred then
> blk_mq_complete_request() will call __blk_mq_complete_request() and will
> complete the request, although that is not allowed because timeout handling
> has already started. Do you agree with this analysis?
