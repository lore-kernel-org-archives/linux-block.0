Return-Path: <logang@deltatee.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-7-logang@deltatee.com>
 <72e90cc2-c05a-3ed8-42c7-e4d7a0d535d8@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3527faf1-3f3a-88d0-caa8-d94d75437d73@deltatee.com>
Date: Thu, 1 Mar 2018 10:16:24 -0700
MIME-Version: 1.0
In-Reply-To: <72e90cc2-c05a-3ed8-42c7-e4d7a0d535d8@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 06/10] IB/core: Add optional PCI P2P flag to
 rdma_rw_ctx_[init|destroy]()
List-ID: <linux-block@vger.kernel.org>

Hey Sagi,

Thanks for the review!


On 01/03/18 03:32 AM, Sagi Grimberg wrote:
>>   int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 
>> port_num,
>>           struct scatterlist *sg, u32 sg_cnt, u32 sg_offset,
>> -        u64 remote_addr, u32 rkey, enum dma_data_direction dir)
>> +        u64 remote_addr, u32 rkey, enum dma_data_direction dir,
>> +        unsigned int flags)
>>   {
>>       struct ib_device *dev = qp->pd->device;
>>       int ret;
>> -    ret = ib_dma_map_sg(dev, sg, sg_cnt, dir);
>> +    if (flags & RDMA_RW_CTX_FLAG_PCI_P2PDMA)
>> +        ret = pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
>> +    else
>> +        ret = ib_dma_map_sg(dev, sg, sg_cnt, dir);
>> +
> 
> Why not use is_pci_p2pdma_page(sg) instead of a flag? It would be so
> much cleaner...

Yes, that sounds like a good idea. We can make that change for v3.

Logan
