Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:45342 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390076AbeIVADi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Sep 2018 20:03:38 -0400
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvdimm@lists.01.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-4-logang@deltatee.com>
 <20180921131550.GG224714@bhelgaas-glaptop.roam.corp.google.com>
 <20180921164813.GJ224714@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <506dd00c-35e9-e285-bc97-c689c766b4cf@deltatee.com>
Date: Fri, 21 Sep 2018 12:13:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180921164813.GJ224714@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v6 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018-09-21 10:48 AM, Bjorn Helgaas wrote:
>> I think the use of "map" in this context is slightly confusing because the
>> general expectation is that map/unmap must be balanced.

Yeah, Jason said the same thing, but having an empty unmap function
seems wasteful and Christoph said to just remove it. My opinion is that
it's not that big an issue one way or another -- if we have to add an
unmap later it's not really that hard.

>> If you keep "map", maybe add a sentence or two about why there's no
>> corresponding unmap?

Will do.

> Another wrinkle is that "map" usually takes an A and gives you back a
> B.  Now the caller has both A and B and both are still valid.
> Here we pass in an SGL and the SGL is transformed, so the caller only
> has B and A has been destroyed, i.e., the SGL can no longer be used as
> it was before, and there's no way to get A back.

I wouldn't say that. Our map_sg function is doing the same thing
dma_map_sg is: it sets the DMA address and length in the scatter list.
So B is still A just with other fields set. If the caller wanted to map
this SG in a different way they can still do so and the new DMA
address/length would override the old values. (Normally, you'd want to
unmap before doing something like that, but seeing our unmap is an empty
operation, we wouldn't have to do that.)

Logan
