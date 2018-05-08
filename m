Return-Path: <logang@deltatee.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180507232346.GI161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180508105759.7dbaa8fe@w520.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7d06df03-18ee-97c7-595e-0b25c43a6f3d@deltatee.com>
Date: Tue, 8 May 2018 13:14:53 -0600
MIME-Version: 1.0
In-Reply-To: <20180508105759.7dbaa8fe@w520.home>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/14] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 08/05/18 10:57 AM, Alex Williamson wrote:
> AIUI from previously questioning this, the change is hidden behind a
> build-time config option and only custom kernels or distros optimized
> for this sort of support would enable that build option.  I'm more than
> a little dubious though that we're not going to have a wave of distros
> enabling this only to get user complaints that they can no longer make
> effective use of their devices for assignment due to the resulting span
> of the IOMMU groups, nor is there any sort of compromise, configure
> the kernel for p2p or device assignment, not both.  Is this really such
> a unique feature that distro users aren't going to be asking for both
> features?  Thanks,

I think it is. But it sounds like the majority want this to be a command
line option. So we will look at doing that for v5.

Logan
