Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:47200 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbeHaUel (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 16:34:41 -0400
To: Jonathan Cameron <jonathan.cameron@huawei.com>
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
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-2-logang@deltatee.com>
 <20180831171906.00002751@huawei.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a1f6e2d9-8b7d-10ae-5963-50b447cacb44@deltatee.com>
Date: Fri, 31 Aug 2018 10:26:08 -0600
MIME-Version: 1.0
In-Reply-To: <20180831171906.00002751@huawei.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 01/13] PCI/P2PDMA: Support peer-to-peer memory
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 31/08/18 10:19 AM, Jonathan Cameron wrote:
> This feels like a somewhat simplistic starting point rather than a
> generally correct estimate to use.  Should we be taking the bandwidth of
> those links into account for example, or any discoverable latencies?
> Not all PCIe switches are alike - particularly when it comes to P2P.

I don't think this is necessary. There won't typically be a ton of
choice in terms of devices to use and if there is, the hardware will
probably be fairly homogenous. For example, it would be unusual to have
an NVMe drive on a x4 and another one on an x8. Or mixing say Gen3
switches with Gen4 would also be very strange. In weird unusual cases
like this where the user specifically wants to use a faster device they
can specify the specific device in the configfs interface.

I think the latency would probably be proportional to the distance which
is what we are already using.

> I guess that can be a topic for future development if it turns out people
> have horrible mixed systems.

Yup!

Logan
