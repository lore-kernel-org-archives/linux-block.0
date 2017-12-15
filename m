Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 2/6] blk-mq: replace timeout synchronization with a RCU
 and generation based scheme
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "oleg@redhat.com"
 <oleg@redhat.com>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "osandov@fb.com" <osandov@fb.com>,
        "tj@kernel.org" <tj@kernel.org>
References: <20171212190134.535941-1-tj@kernel.org>
 <20171212190134.535941-3-tj@kernel.org> <1513277469.2475.43.camel@wdc.com>
 <20171214202042.GG3326@worktop> <1513287766.2475.73.camel@wdc.com>
 <20171214215404.GK3326@worktop>
 <007e5a56-83fb-23b0-64d9-4725f15c596d@oracle.com>
 <20171215073151.y5nme76arcg7ra23@hirez.programming.kicks-ass.net>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <964d1148-c17b-b9f9-18f7-9178173e3945@oracle.com>
Date: Fri, 15 Dec 2017 23:14:31 +0800
MIME-Version: 1.0
In-Reply-To: <20171215073151.y5nme76arcg7ra23@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 12/15/2017 03:31 PM, Peter Zijlstra wrote:
> On Fri, Dec 15, 2017 at 10:12:50AM +0800, jianchao.wang wrote:
>>> That only makes it a little better:
>>>
>>> 	Task-A					Worker
>>>
>>> 	write_seqcount_begin()
>>> 	blk_mq_rw_update_state(rq, IN_FLIGHT)
>>> 	blk_add_timer(rq)
>>> 	<timer>
>>> 		schedule_work()
>>> 	</timer>
>>> 	<context-switch to worker>
>>> 						read_seqcount_begin()
>>> 							while(seq & 1)
>>> 								cpu_relax();
>>>
>> Hi Peter
>>
>> The current seqcount read side is as below:
>> 	do {
>> 		start = read_seqcount_begin(&rq->gstate_seq);
> 
> 
> static inline unsigned read_seqcount_begin(const seqcount_t *s)
> {
> 	seqcount_lockdep_reader_access(s);
> 	return raw_read_seqcount_begin(s);
> }
> 
> static inline unsigned raw_read_seqcount_begin(const seqcount_t *s)
> {
> 	unsigned ret = __read_seqcount_begin(s);
> 	smp_rmb();
> 	return ret;
> }
> 
> static inline unsigned __read_seqcount_begin(const seqcount_t *s)
> {
> 	unsigned ret;
> 
> repeat:
> 	ret = READ_ONCE(s->sequence);
> 	if (unlikely(ret & 1)) {
> 		cpu_relax();
> 		goto repeat;
> 	}
> 	return ret;
> }
> 
Really thanks for kindly pointing out.
jianchao
