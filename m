Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Wise <swise@opengridcomputing.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
Date: Thu, 1 Mar 2018 20:35:55 +0200
MIME-Version: 1.0
In-Reply-To: <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> On 01/03/18 04:03 AM, Sagi Grimberg wrote:
>> Can you describe what would be the plan to have it when these devices
>> do come along? I'd say that p2p_dev needs to become a nvmet_ns reference
>> and not from nvmet_ctrl. Then, when cmb capable devices come along, the
>> ns can prefer to use its own cmb instead of locating a p2p_dev device?
> 
> The patchset already supports CMB drives. That's essentially what patch 
> 7 is for. We change the nvme-pci driver to use the p2pmem code to 
> register and manage the CMB memory. After that, it is simply available 
> to the nvmet code. We have already been using this with a couple 
> prototype CMB drives.

The comment was to your statement:
"Ideally, we'd want to use an NVME CMB buffer as p2p memory. This would
save an extra PCI transfer as the NVME card could just take the data
out of it's own memory. However, at this time, cards with CMB buffers
don't seem to be available."

Maybe its a left-over which confused me...

Anyways, my question still holds. If I rack several of these
nvme drives, ideally we would use _their_ cmbs for I/O that is
directed to these namespaces. This is why I was suggesting that
p2p_dev should live in nvmet_ns and not in nvmet_ctrl as a single
p2p_dev used by all namespaces.

nvmet_ns seems like a more natural place to host p2p_dev with
cmb in mind.

>>> +static int nvmet_p2pdma_add_client(struct nvmet_ctrl *ctrl,
>>> +                   struct nvmet_ns *ns)
>>> +{
>>> +    int ret;
>>> +
>>> +    if (!blk_queue_pci_p2pdma(ns->bdev->bd_queue)) {
>>> +        pr_err("peer-to-peer DMA is not supported by %s\n",
>>> +               ns->device_path);
>>> +        return -EINVAL;
>>
>> I'd say that just skip it instead of failing it, in theory one can
>> connect nvme devices via p2p mem and expose other devices in the
>> same subsystem. The message would be pr_debug to reduce chattiness.
> 
> No, it's actually a bit more complicated than you make it. There's a 
> couple cases:
> 
> 1) The user adds a namespace but there hasn't been a connection and no 
> p2pmem has been selected. In this case the add_client function is never 
> called and the user can add whatever namespace they like.
> 
> 2) When the first connect happens, nvmet_setup_p2pmem() will call 
> add_client() for each namespace and rdma device. If any of them fail 
> then it does not use a P2P device and falls back, as you'd like, to 
> regular memory.
> 
> 3) When the user adds a namespace after a port is in use and a 
> compatible P2P device has been found. In this case, if the user tries to 
> add a namespace that is not compatible with the P2P device in use then 
> it fails adding the new namespace. The only alternative here is to tear 
> everything down, ensure there are no P2P enabled buffers open and start 
> using regular memory again... That is very difficult.
> 

Wouldn't it all be simpler if the p2p_dev resolution would be private
to the namespace?

So is adding some all the namespaces in a subsystem must comply to
using p2p? Seems a little bit harsh if its not absolutely needed. Would
be nice to export a subsystems between two ports (on two HCAs, across
NUMA nodes) where the home node (primary path) would use p2p and
failover would use host memory...

Can you help me understand why this is absolutely not feasible?

> I also disagree that these messages should be pr_debug. If a user is 
> trying to use P2P memory and they enable it but the system doesn't 
> choose to use their memory they must know why that is so they can make 
> the necessary adjustments. If the system doesn't at least print a dmesg 
> they are in the dark.

I was arguing that the user might have intentionally wanted to use p2p
where possible but still expose other namespaces over host memory. For
this user, the messages are spam. I guess info/warn could also suffice
(assuming we allow it, if we fail it then no point of the debug level
discussion).

> 
>>> +    }
>>> +
>>> +    ret = pci_p2pdma_add_client(&ctrl->p2p_clients, nvmet_ns_dev(ns));
>>> +    if (ret)
>>> +        pr_err("failed to add peer-to-peer DMA client %s: %d\n",
>>> +               ns->device_path, ret);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>   int nvmet_ns_enable(struct nvmet_ns *ns)
>>>   {
>>>       struct nvmet_subsys *subsys = ns->subsys;
>>> @@ -299,6 +319,14 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>>>       if (ret)
>>>           goto out_blkdev_put;
>>> +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>>> +        if (ctrl->p2p_dev) {
>>> +            ret = nvmet_p2pdma_add_client(ctrl, ns);
>>> +            if (ret)
>>> +                goto out_remove_clients;
>>
>> Is this really a fatal failure given that we fall-back to main
>> memory? Why not continue with main memory (and warn at best)?
> 
> See above. It's fatal because we are already using p2p memory and we 
> can't easily tear that all down when a user adds a new namespace.

In my mind, I/O to this namespace would use host memory and be done
with it. I guess I still don't understand why this is not possible.

>>> +    ctrl->p2p_dev = pci_p2pmem_find(&ctrl->p2p_clients);
>>
>> This is the first p2p_dev found right? What happens if I have more than
>> a single p2p device? In theory I'd have more p2p memory I can use. Have
>> you considered making pci_p2pmem_find return the least used suitable
>> device?
> 
> Yes, it currently returns the first found. I imagine a bunch of 
> improvements could be made to it in future work. However, I'd probably 
> start with finding the nearest p2p device and then falling back to the 
> least used if that's necessary. At this time though it's not clear how 
> complicated these systems will get and what's actually needed here.

Fair enough. Just wandering.
