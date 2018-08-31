Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:46966 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbeHaT71 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 15:59:27 -0400
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
        Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-7-logang@deltatee.com>
 <98bff500-4e4c-3a34-6762-16ef4b076d90@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6820d451-9591-1979-00bf-60c65fc4f136@deltatee.com>
Date: Fri, 31 Aug 2018 09:51:06 -0600
MIME-Version: 1.0
In-Reply-To: <98bff500-4e4c-3a34-6762-16ef4b076d90@amd.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 31/08/18 02:08 AM, Christian König wrote:
>> +One of the biggest issues is that PCI doesn't require forwarding
>> +transactions between hierarchy domains, and in PCIe, each Root Port
>> +defines a separate hierarchy domain. To make things worse, there is no
>> +simple way to determine if a given Root Complex supports this or not.
>> +(See PCIe r4.0, sec 1.3.1). Therefore, as of this writing, the kernel
>> +only supports doing P2P when the endpoints involved are all behind the
>> +same PCI bridge, as such devices are all in the same PCI hierarchy
>> +domain, and the spec guarantees that all transacations within the
>> +hierarchy will be routable, but it does not require routing
>> +between hierarchies.
> 
> Can we add a kernel command line switch and a whitelist to enable P2P 
> between separate hierarchies?

In future work, yes. But not for this patchset. This is definitely the
way I see things going, but we've chosen to start with what we've presented.

Logan
