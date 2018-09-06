Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH 3/3] nvme-pci: use queue close instead of queue freeze
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, keith.busch@intel.com, jsmart2021@gmail.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        jthumshirn@suse.de, bart.vanassche@wdc.com
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
 <20180905220910.GC21352@ming.t460p>
 <8ba97c77-0c3b-75df-0259-3c97ef7b774e@oracle.com>
 <20180906130715.GB31250@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <165989bc-949f-570e-c1d2-0ee1f0d4472a@oracle.com>
Date: Thu, 6 Sep 2018 22:19:27 +0800
MIME-Version: 1.0
In-Reply-To: <20180906130715.GB31250@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 09/06/2018 09:07 PM, Ming Lei wrote:
> On Thu, Sep 06, 2018 at 09:28:46AM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 09/06/2018 06:09 AM, Ming Lei wrote:
>>> nvme_dev_add() still may call freeze & unfreeze queue, so your patch
>>> can't avoid draining queue completely here.
>>
>> Yes, I know this. We still need to freeze queue when update nr_hw_queues.
>> But we move forward a step at least. :)
>> We don't need to drain request queue in normal case of nvme_reset_work.
> 
> It is hard to say who is the normal case. In case of CPU hotplug, it is quite
> easy to trigger updating nr_hw_queues.
> 
>>
>> As for updating nr_hw_queues, we could try some other method on it next.
> 
> The thing is that draining queue may be inevitable inside reset work
> function because of updating nr_hw_queues, that means the approach in
> this patchset is just a partial solution
> 
> Or it may not make sense to do that because we may never remove the draining
> queue in the code path of updating nr_hw_queues.
> 
> Given they belong to same issue, I suggest to solve them all.

I still think if just prevent new IO, freeze queue is over-kill.

With respect to update nr_hw_queues, we could try to take the bios down from the
queued requests as the blk_steal_bios. Then re-issue these bios after updating the
nr_hw_queues.

Thanks
Jianchao

> 
> Thanks,
> Ming
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=cybJ83konrbKh9jtodiaZRmNrKAo1YtEI_oyaNIbuvk&s=EBhkv_XTOQb3K3-4esnkBrs_ErKuNzXDqZwrIzEA0ig&e=
> 
