Return-Path: <mb@lightnvm.io>
Return-Path: <mb@lightnvm.io>
Subject: Re: [PATCH 4/4] nvme: lightnvm: add late setup of block size and
 metadata
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 javier@cnexlabs.com, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20180205121505.27563-1-mb@lightnvm.io>
 <20180205121505.27563-5-mb@lightnvm.io>
 <343f19d9-0428-f255-6ed0-519035eef46d@lightnvm.io>
 <20180328082825.GB31409@infradead.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <742b1250-3c1d-2436-7aa8-85c3f0347419@lightnvm.io>
Date: Wed, 28 Mar 2018 14:36:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180328082825.GB31409@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 28/03/2018 10.28, Christoph Hellwig wrote:
> I really don't want more lightnvm cruft in the core.  We'll need
> a proper abstraction.c
> 

I agree, we should get that moving, and make a proper abstraction for 
it. Also with respect to how an SMR interface in general is integrated 
into NVMe.

The patch is necessary due to the revalidate event for retrieving the 
lba format from the nvme drive. It might not be available the first time 
around, and we have to hook in when the drive is revalidated the second 
time.

> On Fri, Mar 23, 2018 at 12:00:08PM +0100, Matias Bjørling wrote:
>> On 02/05/2018 01:15 PM, Matias Bjørling wrote:
>>> The nvme driver sets up the size of the nvme namespace in two steps.
>>> First it initializes the device with standard logical block and
>>> metadata sizes, and then sets the correct logical block and metadata
>>> size. Due to the OCSSD 2.0 specification relies on the namespace to
>>> expose these sizes for correct initialization, let it be updated
>>> appropriately on the LightNVM side as well.
>>>
>>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>>> ---
>>>    drivers/nvme/host/core.c     | 2 ++
>>>    drivers/nvme/host/lightnvm.c | 8 ++++++++
>>>    drivers/nvme/host/nvme.h     | 2 ++
>>>    3 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index f837d666cbd4..740ceb28067c 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -1379,6 +1379,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>>>    	if (ns->noiob)
>>>    		nvme_set_chunk_size(ns);
>>>    	nvme_update_disk_info(disk, ns, id);
>>> +	if (ns->ndev)
>>> +		nvme_nvm_update_nvm_info(ns);
>>>    #ifdef CONFIG_NVME_MULTIPATH
>>>    	if (ns->head->disk)
>>>    		nvme_update_disk_info(ns->head->disk, ns, id);
>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>> index a9c010655ccc..8d4301854811 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -814,6 +814,14 @@ int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg)
>>>    	}
>>>    }
>>> +void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>>> +{
>>> +	struct nvm_dev *ndev = ns->ndev;
>>> +
>>> +	ndev->identity.csecs = ndev->geo.sec_size = 1 << ns->lba_shift;
>>> +	ndev->identity.sos = ndev->geo.oob_size = ns->ms;
>>> +}
>>> +
>>>    int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node)
>>>    {
>>>    	struct request_queue *q = ns->queue;
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index ea1aa5283e8e..1ca08f4993ba 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -451,12 +451,14 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
>>>    #endif /* CONFIG_NVME_MULTIPATH */
>>>    #ifdef CONFIG_NVM
>>> +void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
>>>    int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
>>>    void nvme_nvm_unregister(struct nvme_ns *ns);
>>>    int nvme_nvm_register_sysfs(struct nvme_ns *ns);
>>>    void nvme_nvm_unregister_sysfs(struct nvme_ns *ns);
>>>    int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
>>>    #else
>>> +static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
>>>    static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
>>>    				    int node)
>>>    {
>>>
>>
>> Hi Keith,
>>
>> When going through the patches for 4.17, I forgot to run this patch by you.
>> It is part of adding OCSSD2.0 support to the kernel, and slides in between a
>> large refactoring, and the 2.0 part. May I add your reviewed by and let Jens
>> pick it up after the nvme patches for 4.17 has gone up?
>>
>> Thanks!
>>
>> -Matias
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
> ---end quoted text---
> 
