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
Message-ID: <19017b48-c6ff-b13c-75ca-32dd173ef0cd@oracle.com>
Date: Fri, 13 Jul 2018 09:12:39 +0800
MIME-Version: 1.0
In-Reply-To: <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 07/13/2018 06:24 AM, Bart Van Assche wrote:
> On Thu, 2018-07-12 at 13:24 -0600, Keith Busch wrote:
>> On Thu, Jul 12, 2018 at 06:16:12PM +0000, Bart Van Assche wrote:
>>> What prevents that a request finishes and gets reused after the
>>> blk_mq_req_expired() call has finished and before kref_get_unless_zero() is
>>> called? Is this perhaps a race condition that has not yet been triggered by
>>> any existing block layer test? Please note that there is no such race
>>> condition in the patch I had posted ("blk-mq: Rework blk-mq timeout handling
>>> again" - https://urldefense.proofpoint.com/v2/url?u=https-3A__www.spinics.net_lists_linux-2Dblock_msg26489.html&d=DwIGaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=zqZd2myYLkxjU6DWtRKpls-gvzEGEB4vv8bdYq5CiBs&s=-d79KAhEM83ShMp8xCHKoE6Dp5Gxf98L94DuamLEAaU&e=).
>>
>> I don't think there's any such race in the merged implementation
>> either. If the request is reallocated, then the kref check may succeed,
>> but the blk_mq_req_expired() check would surely fail, allowing the
>> request to proceed as normal. The code comments at least say as much.
> 
> Hello Keith,
> 
> Before commit 12f5b9314545 ("blk-mq: Remove generation seqeunce"), if a
> request completion was reported after request timeout processing had
> started, completion handling was skipped. The following code in
> blk_mq_complete_request() realized that:
> 
> 	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
> 		__blk_mq_complete_request(rq);
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
>

Oh, thanks gods for hearing Bart said this.
I was always saying the same thing in the mail
https://marc.info/?l=linux-block&m=152950093831738&w=2
Even though my voice is tiny, I support Bart's point definitely.

Thanks
Jianchao
 
> Thanks,
> 
> Bart.
> 
> 
> 
> 
> 
> 
> 
> 
> 
