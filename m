Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH v8 13/13] nvmet: Optionally use PCI P2P memory
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Steve Wise <swise@opengridcomputing.com>
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-14-logang@deltatee.com>
 <5ddeed51-0580-9581-cf12-c75e18b4f7cc@grimberg.me>
 <69cd8aab-b94e-98f5-5397-48bb875e8280@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b790b11f-41df-f495-fdd1-d8bd6d6b7dd6@grimberg.me>
Date: Mon, 1 Oct 2018 15:23:25 -0700
MIME-Version: 1.0
In-Reply-To: <69cd8aab-b94e-98f5-5397-48bb875e8280@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>> +/*
>>> + * If allow_p2pmem is set, we will try to use P2P memory for the SGL lists for
>>> + * Ι/O commands. This requires the PCI p2p device to be compatible with the
>>> + * backing device for every namespace on this controller.
>>> + */
>>> +static void nvmet_setup_p2pmem(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>>> +{
>>> +	struct nvmet_ns *ns;
>>> +	int ret;
>>> +
>>> +	if (!req->port->use_p2pmem || !req->p2p_client)
>>> +		return;
>>
>> Nit, IMO would be better to check at the call-site, but not a hard
>> must...
> 
> I'd rather keep the logic for whether to enable p2pmem in it's own
> function. nvme_alloc_ctrl() is already very long and complicated.

Fair enough..

>> I still do not fully understand why p2p_dev has to be ctrl-wide and not
>> per namespace. Sorry to keep bringing this up (again). But if people are
>> OK with it then I guess I can stop asking about this...
> 
> Because you never answered my question back in March[1] (which I think
> you've answered below)....

I'm sorry... I lost tracking on this...

>> I think that at some point we said that this looks like it should fall
>> back to host memory for those namespaces.. when we allocate the sgl we
>> already assigned a namespace to the request (nvmet_req_init).
> 
> I did not realize the namespace would be available at this time. I guess
> I can give this a try, but it's going to be a fairly big change from
> what's presented here... Though, I agree it'll probably be an improvement.

Thanks, if it turns out to create to much of a churn, we could defer
that to a later stage, but we can at least document it.
