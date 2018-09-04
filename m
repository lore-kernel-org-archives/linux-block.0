Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:43854 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbeIDUNS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Sep 2018 16:13:18 -0400
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-11-logang@deltatee.com>
 <20180904151638.GL335@mellanox.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d5548f5d-59df-f38e-255d-59b46a17a219@deltatee.com>
Date: Tue, 4 Sep 2018 09:47:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180904151638.GL335@mellanox.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 10/13] nvme-pci: Add support for P2P memory in requests
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 04/09/18 09:16 AM, Jason Gunthorpe wrote:
>>  	if (iod->nents) {
>> -		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
>> +		/* P2PDMA requests do not need to be unmapped */
>> +		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
>> +			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
> 
> This seems like a poor direction, if we add IOMMU hairpin support we
> will need unmapping.

It can always be added later. In any case, you'll have to convince
Christoph who requested the change; I'm not that invested in this decision.

Logan
