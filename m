Return-Path: <logang@deltatee.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bab9fb8b-1449-4b87-94de-7da26a279331@deltatee.com>
Date: Thu, 1 Mar 2018 12:13:10 -0700
MIME-Version: 1.0
In-Reply-To: <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 11:02 AM, Bjorn Helgaas wrote:
>>   void pci_enable_acs(struct pci_dev *dev)
>>   {
>> +	if (pci_p2pdma_disable_acs(dev))
>> +		return;
> 
> This doesn't read naturally to me.  I do see that when
> CONFIG_PCI_P2PDMA is not set, pci_p2pdma_disable_acs() does nothing
> and returns 0, so we'll go ahead and try to enable ACS as before.
> 
> But I think it would be clearer to have an #ifdef CONFIG_PCI_P2PDMA
> right here so it's more obvious that we only disable ACS when it's
> selected.

I could do this... however, I wrote it this way because I've read Linus 
dislikes using #ifdef's inside function bodies and I personally agree 
with that sentiment.

Logan
