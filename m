Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "israelr@mellanox.com" <israelr@mellanox.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
 "maxg@mellanox.com" <maxg@mellanox.com>, "tj@kernel.org" <tj@kernel.org>,
 "keith.busch@intel.com" <keith.busch@intel.com>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
 <bc1946d4-7627-3885-68c9-5db6c13b585c@kernel.dk>
 <fee466b8-8e39-adc6-efa4-e50ffa60a663@kernel.dk>
 <448d63e9-cfcd-0bc8-abf3-30296590f1d6@kernel.dk>
 <cd0693cc-a56d-665c-bc14-7e2653b91cb0@kernel.dk>
 <e414a6f8-79a9-0faa-e186-beb3b528acd5@kernel.dk>
 <256db3889953289d75b989dd589802ce8a756553.camel@wdc.com>
 <460909df-cff0-f56b-882e-eb1a96f7510a@kernel.dk>
 <2c0c013717470bb9d5f97ec0559e7081c1e152de.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <be80fd24-0f9f-ebe0-17cf-8db2cb9a4c82@kernel.dk>
Date: Tue, 22 May 2018 15:03:01 -0600
MIME-Version: 1.0
In-Reply-To: <2c0c013717470bb9d5f97ec0559e7081c1e152de.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/22/18 2:44 PM, Bart Van Assche wrote:
> On Tue, 2018-05-22 at 14:38 -0600, Jens Axboe wrote:
>> On 5/22/18 2:33 PM, Bart Van Assche wrote:
>>> Thanks for having reported this. How about using the following change to suppress
>>> that warning:
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index bb99c03e7a34..84e55ea55baf 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -844,6 +844,7 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
>>>  
>>>  	switch (ret) {
>>>  	case BLK_EH_HANDLED:
>>> +		blk_mq_change_rq_state(req, MQ_RQ_TIMED_OUT, MQ_RQ_COMPLETE);
>>>  		__blk_mq_complete_request(req);
>>>  		break;
>>>  	case BLK_EH_RESET_TIMER:
>>>
>>> I think this will work better than what was proposed in your last e-mail. I'm afraid
>>> that with that change that a completion that occurs while the timeout handler is
>>> running can be ignored.
>>
>> What if that races with eg requeue? We get the completion from IRQ, decide we
>> need to requeue/restart the request rather than complete it.
> 
> Shouldn't block drivers that requeue a request from inside their timeout handler
> return BLK_EH_NOT_HANDLED instead of BLK_EH_HANDLED?

Yeah, I guess they should. See reply to Christoph as well, making this
simpler would be a great idea. Could be done as a prep patch (series)
to this one.

-- 
Jens Axboe
