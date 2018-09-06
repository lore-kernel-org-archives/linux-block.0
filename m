Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 2/3] blk-core: introduce queue close feature
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, ming.lei@redhat.com,
        bart.vanassche@wdc.com, sagi@grimberg.me, keith.busch@intel.com,
        jthumshirn@suse.de, jsmart2021@gmail.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536120586-3378-3-git-send-email-jianchao.w.wang@oracle.com>
 <1536163037.11534.6.camel@acm.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <ccf20c21-880a-98ca-b111-8e6b82b47a11@oracle.com>
Date: Thu, 6 Sep 2018 09:31:06 +0800
MIME-Version: 1.0
In-Reply-To: <1536163037.11534.6.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 09/05/2018 11:57 PM, Bart Van Assche wrote:
> On Wed, 2018-09-05 at 12:09 +0800, Jianchao Wang wrote:
>> blk queue freeze is often used to prevent new IO from entering
>> request queue. However, becuase we kill the percpu-ref
>> q_usage_counter when freeze queue, we have to drain the request
>> queue when unfreeze. This is unnecessary for just preventing new
>> IO. In addition, If there is IO timeout or other issue when unfreeze
>> the queue, the scenario could be very tricky.
>>
>> So we introduce BLK_QUEUE_GATE_CLOSED to implement a light-weight
>> queue close feature base on the queue_gate to prevent new IO from
>> comming in queue which will not need to drain the queue any more.
> 
> Does the "queue gate close" feature cause blk_get_request() /
> blk_mq_get_request() to block until blk_clear_queue_closed() is called? 

Yes. It works in blk_queue_enter. So it could cover blk_mq_get_request

If
> so, I think we need a better name for this feature. How about calling these
> two operations suspend and resume?

I'm open for it. :)

> 
> Thanks,
> 
> Bart.
> 
