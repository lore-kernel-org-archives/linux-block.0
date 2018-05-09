Return-Path: <alex.williamson@redhat.com>
Date: Tue, 8 May 2018 18:01:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Don Dutile <ddutile@redhat.com>
Cc: Stephen Bates <sbates@raithlin.com>, Dan Williams
 <dan.j.williams@intel.com>, Logan Gunthorpe <logang@deltatee.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-rdma <linux-rdma@vger.kernel.org>, linux-nvdimm
 <linux-nvdimm@lists.01.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Sagi Grimberg
 <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe
 <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>, =?UTF-8?B?SsOpcsO0?=
 =?UTF-8?B?bWU=?= Glisse <jglisse@redhat.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all
 devices behind switches
Message-ID: <20180508180157.7c7b393f@w520.home>
In-Reply-To: <c5f30ced-7bbf-9420-db1a-72519fc78b3a@redhat.com>
References: <20180423233046.21476-1-logang@deltatee.com>
	<20180423233046.21476-5-logang@deltatee.com>
	<CAPcyv4g+5N_n03J-VhmJfrr60Sqk95ZapLKBkwSsGvV4nQ+ZRw@mail.gmail.com>
	<64C231F5-DE36-415F-B308-3A423B0BBACB@raithlin.com>
	<15433946-f7f5-f610-4e80-380fb59920e5@redhat.com>
	<3C9FB262-A93C-4C8F-B1E0-85C6D6F78BC2@raithlin.com>
	<c5f30ced-7bbf-9420-db1a-72519fc78b3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Tue, 8 May 2018 19:06:17 -0400
Don Dutile <ddutile@redhat.com> wrote:
> On 05/08/2018 05:27 PM, Stephen  Bates wrote:
> > As I understand it VMs need to know because VFIO passes IOMMU
> > grouping up into the VMs. So if a IOMMU grouping changes the VM's
> > view of its PCIe topology changes. I think we even have to be
> > cognizant of the fact the OS running on the VM may not even support
> > hot-plug of PCI devices.  
> Alex:
> Really? IOMMU groups are created by the kernel, so don't know how
> they would be passed into the VMs, unless indirectly via  PCI(e)
> layout. At best, twiddling w/ACS enablement (emulation) would cause
> VMs to see different IOMMU groups, but again, VMs are not the
> security point/level, the host/HV's are.

Correct, the VM has no concept of the host's IOMMU groups, only the
hypervisor knows about the groups, but really only to the extent of
which device belongs to which group and whether the group is viable.
Any runtime change to grouping though would require DMA mapping
updates, which I don't see how we can reasonably do with drivers,
vfio-pci or native host drivers, bound to the affected devices.  Thanks,

Alex
