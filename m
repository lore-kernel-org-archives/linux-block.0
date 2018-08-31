Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:48140 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbeHaXVF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 19:21:05 -0400
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
 <6820d451-9591-1979-00bf-60c65fc4f136@deltatee.com>
 <30411655-9b90-749e-857f-318dac7cccbf@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9452ee6c-e989-d178-cd51-f29782ad9b31@deltatee.com>
Date: Fri, 31 Aug 2018 13:11:48 -0600
MIME-Version: 1.0
In-Reply-To: <30411655-9b90-749e-857f-318dac7cccbf@amd.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 31/08/18 11:38 AM, Christian König wrote:
> If you can separate out adding the detection I can take a look adding 
> this with my DMA-buf P2P efforts.

Oh, maybe my previous email wasn't clear, but I'd say that detection is
already separate from ZONE_DEVICE. Nothing really needs to be changed.
I just think you'll probably want to write you're own function similar
to pci_p2pdma_distance that perhaps just takes two pci_devs instead of
the list of clients as is needed by nvme-of-like users.

To enable a whitelist we just have to handle the case where
upstream_bridge_distance() returns -1 and check if the devices are in
the same root complex with supported root ports before deciding the
transaction is not supported.

Logan
