Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V4 0/2] blk-mq: fix race between completion and
 BLK_EH_RESET_TIMER
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "martin@lichtvoll.de" <martin@lichtvoll.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "tj@kernel.org" <tj@kernel.org>,
        "israelr@mellanox.com" <israelr@mellanox.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <20180415154357.19788-1-ming.lei@redhat.com>
 <4563853.Bq5iVV2DL3@merkaba> <20180416004508.GA20345@ming.t460p>
 <4122070.FIbsgdqFrb@merkaba>
 <b459a445-1e3a-2734-e669-68142fab03d6@oracle.com>
 <1021b7c1ecaf9a2d3b7165feb3eb3509bd630984.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <af842d42-7a9e-20f1-e961-13c9173ea53c@oracle.com>
Date: Tue, 17 Apr 2018 11:49:59 +0800
MIME-Version: 1.0
In-Reply-To: <1021b7c1ecaf9a2d3b7165feb3eb3509bd630984.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi bart

Thanks for your kindly response.
I have sent out the patch. Please refer to
https://marc.info/?l=linux-block&m=152393666517449&w=2

Thanks
Jianchao

On 04/17/2018 08:15 AM, Bart Van Assche wrote:
> On Tue, 2018-04-17 at 00:04 +0800, jianchao.wang wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 16e83e6..be9b435 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2077,6 +2077,7 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
>>  
>>         seqcount_init(&rq->gstate_seq);
>>         u64_stats_init(&rq->aborted_gstate_sync);
>> +       WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
>>         return 0;
>>  }
> 
> Hello Jianchao,
> 
> Your approach looks interesting to me. Can you send an official patch to Jens?
> 
> Thanks,
> 
> Bart.
> 
> 
> 
> 
