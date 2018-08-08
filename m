Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v5 5/9] block: Change the runtime power management
 approach (1/2)
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
 <20180807225133.27221-6-bart.vanassche@wdc.com>
 <414b8689-f04a-abaa-d659-f29dffed7d3e@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <6a1acd11-6e71-ea48-d7fc-1e367d4e4dda@oracle.com>
Date: Wed, 8 Aug 2018 14:43:33 +0800
MIME-Version: 1.0
In-Reply-To: <414b8689-f04a-abaa-d659-f29dffed7d3e@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 08/08/2018 02:11 PM, jianchao.wang wrote:
> Hi Bart
> 
> On 08/08/2018 06:51 AM, Bart Van Assche wrote:
>> @@ -391,6 +393,9 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>>  		}
>>  	}
>>  	data->hctx->queued++;
>> +
>> +	blk_pm_add_request(q, rq);
>> +
>>  	return rq;
>>  }
> 
> The request_queue is in pm_only mode when suspended, who can reach here to do the resume ?

I mean, in the original blk-legacy runtime pm implementation, any new IO could trigger the resume,
after your patch set, only the pm request could pass the blk_queue_enter while the queue is suspended
and in pm-only mode. But if no resume, where does the pm request come from ?

The blk_pm_add_request should be added to blk_queue_enter.
It looks like as following:
   1. when an normal io reaches blk_queue_enter, if queue is in suspended mode, it invoke blk_pm_add_request
      to trigger the resume, then wait here for the pm_only mode to be cleared.
   2. the runtime pm core does the resume work and clear the pm_only more finally
   3. the task blocked in blk_queue_enter is waked up and proceed.

Thanks
Jianchao
