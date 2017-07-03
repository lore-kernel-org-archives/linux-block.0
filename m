Return-Path: <maxg@mellanox.com>
Subject: Re: NVMe induced NULL deref in bt_iter()
To: Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
References: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
 <9afc0fd3-e598-dea9-a505-d8fa0f608d16@mellanox.com>
 <7138df5a-b1ce-7f46-281f-ae15172c61e5@grimberg.me>
 <20170703093951.GA28651@ming.t460p>
 <bc6e2ecf-031b-45c0-8fbb-98c12c790ee4@grimberg.me>
 <20170703120348.GB28651@ming.t460p>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <c381e5ab-51b6-494f-db62-09cd4bfdfe39@mellanox.com>
Date: Mon, 3 Jul 2017 15:46:34 +0300
MIME-Version: 1.0
In-Reply-To: <20170703120348.GB28651@ming.t460p>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Return-Path: maxg@mellanox.com
List-ID: <linux-block@vger.kernel.org>



On 7/3/2017 3:03 PM, Ming Lei wrote:
> On Mon, Jul 03, 2017 at 01:07:44PM +0300, Sagi Grimberg wrote:
>> Hi Ming,
>>
>>> Yeah, the above change is correct, for any canceling requests in this
>>> way we should use blk_mq_quiesce_queue().
>>
>> I still don't understand why should blk_mq_flush_busy_ctxs hit a NULL
>> deref if we don't touch the tagset...
>
> Looks no one mentioned the steps for reproduction, then it isn't easy
> to understand the related use case, could anyone share the steps for
> reproduction?

Hi Ming,
I create 500 ns per 1 subsystem (using with CX4 target and C-IB 
initiator but also saw it in CX5 vs. CX5 setup).
The null deref happens when I remove all configuration in the target (1 
port 1 subsystem and 500 namespaces and nvmet modules unload) during 
traffic to 1 nvme device/ns from the intiator.
I get Null deref in blk_mq_flush_busy_ctxs function that calls 
sbitmap_for_each_set in the initiator. seems like the "struct 
sbitmap_word *word = &sb->map[i];" is null. It's actually might be not 
null in the beginning of the func and become null during running the 
while loop there.

>
>>
>> Also, I'm wandering in what case we shouldn't use
>> blk_mq_quiesce_queue()? Maybe we should unexport blk_mq_stop_hw_queues()
>> and blk_mq_start_stopped_hw_queues() and use the quiesce/unquiesce
>> equivalent always?
>
> There are at least one case in which we have to use stop queues:
>
> 	- when QUEUE_BUSY(now it becomes BLK_STS_RESOURCE) happens, some drivers
> 	need to stop queues for avoiding to hurt CPU, such as virtio-blk, ...
>
>>
>> The only fishy usage is in nvme_fc_start_fcp_op() where if submission
>> failed the code stop the hw queues and delays it, but I think it should
>> be handled differently..
>
> It looks like the old way of scsi-mq, but scsi has removed this way and
> avoids to stop queue.
>
>
> Thanks,
> Ming
>
