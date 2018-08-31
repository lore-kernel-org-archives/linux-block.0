Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:46842 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbeHaTu2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 15:50:28 -0400
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Steve Wise <swise@opengridcomputing.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-14-logang@deltatee.com>
 <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ee3d5c87-4dff-edfb-1f85-958571cb1fef@deltatee.com>
Date: Fri, 31 Aug 2018 09:41:51 -0600
MIME-Version: 1.0
In-Reply-To: <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 13/13] nvmet: Optionally use PCI P2P memory
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Thanks, for the review.

On 30/08/18 06:25 PM, Sagi Grimberg wrote:
>> +	if (req->port->p2p_dev) {
>> +		if (!pci_p2pdma_assign_provider(req->port->p2p_dev,
>> +						&ctrl->p2p_clients)) {
>> +			pr_info("peer-to-peer memory on %s is not supported\n",
>> +				pci_name(req->port->p2p_dev));
>> +			goto free_devices;
>> +		}
>> +		ctrl->p2p_dev = pci_dev_get(req->port->p2p_dev);
>> +	} else {
> 
> When is port->p2p_dev == NULL? a little more documentation would help 
> here...

In the configfs functions, if the user enables p2p (port->use_p2pmem)
using 'auto' or 'y' then port->p2p_dev will be NULL. If the user sets a
specific p2p_dev to use, port->p2p_dev will be set to that device. I can
add a couple comments in the next version.

Logan
