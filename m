Return-Path: <logang@deltatee.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
Date: Tue, 8 May 2018 10:27:56 -0600
MIME-Version: 1.0
In-Reply-To: <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
List-ID: <linux-block@vger.kernel.org>



On 08/05/18 01:17 AM, Christian König wrote:
> AMD APUs mandatory need the ACS flag set for the GPU integrated in the 
> CPU when IOMMU is enabled or otherwise you will break SVM.

Well, given that the current set only disables ACS bits on bridges
(previous versions were only on switches) this shouldn't be an issue for
integrated devices. We do not disable ACS flags globally.

> And what exactly is the problem here? I'm currently testing P2P with 
> GPUs in different IOMMU domains and at least with AMD IOMMUs that works 
> perfectly fine.

In addition to Stephen's comments, seeing we've established a general
need to avoid the root complex (until we have a whitelist at least) we
must have ACS disabled along the path between the devices. Otherwise,
all TLPs will go through the root complex and if there is no support it
will fail.

If the consensus is we want a command line option, then so be it. But
we'll have to deny pretty much all P2P transactions unless the user
correctly disables ACS along the path using the command line option and
this is really annoying for users of this functionality to understand
how to do that correctly.

Logan
