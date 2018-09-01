Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56595 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeIAMfN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Sep 2018 08:35:13 -0400
Date: Sat, 1 Sep 2018 10:27:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
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
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 01/13] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180901082703.GA670@lst.de>
References: <20180830185352.3369-1-logang@deltatee.com> <20180830185352.3369-2-logang@deltatee.com> <2711b3a7-f582-0dda-8ac2-530be7bda1bb@amd.com> <439181bb-6cd6-0ab2-bca6-fc820845166e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <439181bb-6cd6-0ab2-bca6-fc820845166e@deltatee.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 31, 2018 at 09:48:40AM -0600, Logan Gunthorpe wrote:
> Pretty easy. P2P detection is pretty much just pci_p2pdma_distance() ,
> which has nothing to do with the ZONE_DEVICE support.
> 
> (And the distance function makes use of a number of static functions
> which could be combined into a simpler interface, should we need it.)

I'd ѕay lets get things merged as-is, so that we can review the
non-ZONE_DEVICE users.  I'm a little curious how that is going to work,
so having it as a full series would be useful.
