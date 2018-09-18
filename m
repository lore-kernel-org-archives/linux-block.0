Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3 00/17] SCSI: introduce per-host admin queue & enable
 runtime PM
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20180913121546.5710-1-ming.lei@redhat.com>
 <f9ba3c11-21ac-d963-3f24-cb83744014e1@oracle.com>
 <20180916130918.GA9947@ming.t460p>
 <7e9cfa7a-292a-0c26-0da8-187d961d974a@oracle.com>
 <20180917120727.GC28349@ming.t460p>
 <0475ffa4-be81-e35f-efe8-6821bada104c@oracle.com>
 <20180918074245.GC4805@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <5549f4a1-8b87-44d4-50fc-80583824a4b1@oracle.com>
Date: Tue, 18 Sep 2018 15:53:51 +0800
MIME-Version: 1.0
In-Reply-To: <20180918074245.GC4805@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 09/18/2018 03:42 PM, Ming Lei wrote:
> On Tue, Sep 18, 2018 at 09:17:12AM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 09/17/2018 08:07 PM, Ming Lei wrote:
>>>>> This way will delay runtime pm or system suspend until the queue is unfrozen,
>>>>> but it isn't reasonable.
>>>> This interface is for the __scsi_execute only, before we call into function, we should have
>>>> get the device resumed synchronously.
>>> I mean when the queue is frozen, it is reasonable to runtime suspend the queue. However,
>>> blk_queue_preempt_enter() is still waiting for queue becoming unfreezing first.
>>
>> We don't freeze the queue, but set preempt-only mode when suspend the queue. :)
> 
> But the queue can be frozen by other paths. Even though it is frozen, the queue
> should be allowed to suspend too.
> 

Yes, the race between freeze and preempt-only is a tricky issue.

Thanks
Jianchao
