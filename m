Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:46886 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbeHaTxT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 15:53:19 -0400
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-7-logang@deltatee.com>
 <382af881-0ae1-0274-4628-0137071125b1@infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f0edec85-02d1-4592-5bce-629fb5e0ceae@deltatee.com>
Date: Fri, 31 Aug 2018 09:44:53 -0600
MIME-Version: 1.0
In-Reply-To: <382af881-0ae1-0274-4628-0137071125b1@infradead.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey,

Thanks for the review. I'll make the fixes for the next version.

On 30/08/18 06:34 PM, Randy Dunlap wrote:
>> +With the client list in hand, the orchestrator may then call> +:c:func:`pci_p2pmem_find()` to obtain a published P2P memory provider
>> +that is supported (behind the same root port) as all the clients. If more
>> +than one provider is supported, the one nearest to all the clients will
>> +be chosen first. If there are more than one provider is an equal distance
>> +away, the one returned will be chosen at random. This function returns the PCI
> 
> random or just arbitrarily?

Randomly. See pci_p2pmem_find() in patch 1. We use prandom_u32_max() to
select any of the supported devices.

Logan
