Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: NVMe induced NULL deref in bt_iter()
To: Max Gurtovoy <maxg@mellanox.com>, Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
 <9afc0fd3-e598-dea9-a505-d8fa0f608d16@mellanox.com>
 <7138df5a-b1ce-7f46-281f-ae15172c61e5@grimberg.me>
 <335f15ce-ed59-1902-0e01-0bc5390b74db@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5309b55c-5395-918d-4cf9-8ce5475be964@grimberg.me>
Date: Sun, 2 Jul 2017 18:08:48 +0300
MIME-Version: 1.0
In-Reply-To: <335f15ce-ed59-1902-0e01-0bc5390b74db@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> Hmm,
>>
>> In the above flow we should not be freeing the tag_set, not on admin as
>> well. The target keep removing namespaces and finally removes the
>> subsystem which generates a error recovery flow. What we at least try
>> to do is:
>>
>> 1. mark rdma queues as not live
>> 2. stop all the sw queues (admin and io)
>> 3. fail inflight I/Os
>> 4. restart all sw queues (to fast fail until we recover)
>>
>> We shouldn't be freeing the tagsets (although we might update them
>> when we recover and cpu map changed - which I don't think is happening).
>>
>> However, I do see a difference between bt_tags_for_each
>> and blk_mq_flush_busy_ctxs (checks tags->rqs not being NULL).
>>
>> Unrelated to this I think we should quiesce/unquiesce the admin_q
>> instead of stop/start because it respects the submission path rcu [1].
>>
>> It might hide the issue, but given that we never free the tagset its
>> seems like it's not in nvme-rdma (max, can you see if this makes the
>> issue go away?)
> 
> Yes, this fixes the null deref issue.
> I run some additional login/logout tests that passed too.
> This fix is important also for stable kernel (with needed backports to 
> blk_mq_quiesce_queue/blk_mq_unquiesce_queue functions).
> You can add my:
> Tested-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

Thanks for clarifying Max.

However I still think its not the root cause (unless I don't understand
it).

As I said, we do not free the tagset so I'm not sure why we get to
a NULL deref in the sbitmap code. Jens, can you explain why
changing blk_mq_stop_hw_queues to blk_mq_quiesce_queue makes the issue
go away? I know that quiesce respects the rcu grace, but I still do not
understand why without it we get a NULL sb->map.

> Let me know if you want me to push this fix to the mailing list to save 
> time (can we make it to 4.12 ?)

I can send patches, we need it in pci, fc and loop too..

I don't think its a 4.12 material as we are way too late to this sort of
fix.
