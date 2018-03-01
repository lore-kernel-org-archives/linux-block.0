Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
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
 Alex Williamson <alex.williamson@redhat.com>
References: <20180228234006.21093-1-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <90b658d9-da8a-af36-ad8f-a72ef0c6e3c1@grimberg.me>
Date: Thu, 1 Mar 2018 12:31:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180228234006.21093-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Hi Everyone,

Hi Logan,

> Here's v2 of our series to introduce P2P based copy offload to NVMe
> fabrics. This version has been rebased onto v4.16-rc3 which already
> includes Christoph's devpagemap work the previous version was based
> off as well as a couple of the cleanup patches that were in v1.
> 
> Additionally, we've made the following changes based on feedback:
> 
> * Renamed everything to 'p2pdma' per the suggestion from Bjorn as well
>    as a bunch of cleanup and spelling fixes he pointed out in the last
>    series.
> 
> * To address Alex's ACS concerns, we change to a simpler method of
>    just disabling ACS behind switches for any kernel that has
>    CONFIG_PCI_P2PDMA.
> 
> * We also reject using devices that employ 'dma_virt_ops' which should
>    fairly simply handle Jason's concerns that this work might break with
>    the HFI, QIB and rxe drivers that use the virtual ops to implement
>    their own special DMA operations.

That's good, but what would happen for these devices? simply fail the
mapping causing the ulp to fail its rdma operation? I would think
that we need a capability flag for devices that support it.
