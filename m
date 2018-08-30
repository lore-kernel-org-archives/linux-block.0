Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:40724 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeH3Xe0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Aug 2018 19:34:26 -0400
To: Jerome Glisse <jglisse@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830192012.GG3529@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d5d38a3d-ae6f-9995-e818-a8f186a7f346@deltatee.com>
Date: Thu, 30 Aug 2018 13:30:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180830192012.GG3529@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 00/13] Copy Offload in NVMe Fabrics with P2P PCI Memory
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 30/08/18 01:20 PM, Jerome Glisse wrote:
> On Thu, Aug 30, 2018 at 12:53:39PM -0600, Logan Gunthorpe wrote:
> 
> [...]
> 
>>
>> When the PCI P2PDMA config option is selected the ACS bits in every
>> bridge port in the system are turned off to allow traffic to
>> pass freely behind the root port. At this time, the bit must be disabled
>> at boot so the IOMMU subsystem can correctly create the groups, though
>> this could be addressed in the future. There is no way to dynamically
>> disable the bit and alter the groups.

Oh, sorry this paragraph in the cover letter is wrong now. We now rely
on the disable_acs_redir command line option introduced in

aaca43fda742 ("PCI: Add "pci=disable_acs_redir=" parameter for
peer-to-peer support")


> Can you provide an example on how to test this ? Like kernel command
> line option, the doc patch does not have any such example. It would be
> nice to add.

Do you mean to test the patchset or the ACS bits you quoted?

Testing the patchset is a matter of having the right hardware (ie an
RDMA NIC and CMB enabled NVMe behind a PCIe switch, with the ACS bits
set correctly by the above command line option) and setting the p2pmem
configfs attribute in an nvme-of port to 'yes'.


Logan
