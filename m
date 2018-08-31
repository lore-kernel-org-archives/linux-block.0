Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41565 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaE34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 00:29:56 -0400
Subject: Re: [PATCH v5 13/13] nvmet: Optionally use PCI P2P memory
To: Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
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
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ecbb669a-2e84-1333-7e0d-1560cf014750@grimberg.me>
Date: Thu, 30 Aug 2018 17:25:09 -0700
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-14-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> +/*
> + * If allow_p2pmem is set, we will try to use P2P memory for the SGL lists for
> + * Ι/O commands. This requires the PCI p2p device to be compatible with the
> + * backing device for every namespace on this controller.
> + */
> +static void nvmet_setup_p2pmem(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
> +{
> +	struct nvmet_ns *ns;
> +	int ret;
> +
> +	if (!req->port->use_p2pmem || !req->p2p_client)
> +		return;
> +
> +	mutex_lock(&ctrl->subsys->lock);
> +
> +	ret = pci_p2pdma_add_client(&ctrl->p2p_clients, req->p2p_client);
> +	if (ret) {
> +		pr_err("failed adding peer-to-peer DMA client %s: %d\n",
> +		       dev_name(req->p2p_client), ret);
> +		goto free_devices;
> +	}
> +
> +	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
> +		ret = nvmet_p2pdma_add_client(ctrl, ns);
> +		if (ret)
> +			goto free_devices;
> +	}
> +
> +	if (req->port->p2p_dev) {
> +		if (!pci_p2pdma_assign_provider(req->port->p2p_dev,
> +						&ctrl->p2p_clients)) {
> +			pr_info("peer-to-peer memory on %s is not supported\n",
> +				pci_name(req->port->p2p_dev));
> +			goto free_devices;
> +		}
> +		ctrl->p2p_dev = pci_dev_get(req->port->p2p_dev);
> +	} else {

When is port->p2p_dev == NULL? a little more documentation would help 
here...
