Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:46930 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbeHaT46 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 15:56:58 -0400
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-2-logang@deltatee.com>
 <2711b3a7-f582-0dda-8ac2-530be7bda1bb@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <439181bb-6cd6-0ab2-bca6-fc820845166e@deltatee.com>
Date: Fri, 31 Aug 2018 09:48:40 -0600
MIME-Version: 1.0
In-Reply-To: <2711b3a7-f582-0dda-8ac2-530be7bda1bb@amd.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 01/13] PCI/P2PDMA: Support peer-to-peer memory
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 31/08/18 02:04 AM, Christian König wrote:
> Am 30.08.2018 um 20:53 schrieb Logan Gunthorpe:
>> Some PCI devices may have memory mapped in a BAR space that's
>> intended for use in peer-to-peer transactions. In order to enable
>> such transactions the memory must be registered with ZONE_DEVICE pages
>> so it can be used by DMA interfaces in existing drivers.
> 
> We want to use that feature without ZONE_DEVICE pages for DMA-buf as well.
> 
> How hard would it be to separate enabling P2P detection (e.g. distance 
> between two devices) from this?

Pretty easy. P2P detection is pretty much just pci_p2pdma_distance() ,
which has nothing to do with the ZONE_DEVICE support.

(And the distance function makes use of a number of static functions
which could be combined into a simpler interface, should we need it.)

Logan
