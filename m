Return-Path: <logang@deltatee.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508144341.0441b676@w520.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a524127a-3557-3dff-971c-dfe94ba5a01c@deltatee.com>
Date: Tue, 8 May 2018 14:49:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180508144341.0441b676@w520.home>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
List-ID: <linux-block@vger.kernel.org>



On 08/05/18 02:43 PM, Alex Williamson wrote:
> Yes, GPUs seem to be leading the pack in implementing ATS.  So now the
> dumb question, why not simply turn off the IOMMU and thus ACS?  The
> argument of using the IOMMU for security is rather diminished if we're
> specifically enabling devices to poke one another directly and clearly
> this isn't favorable for device assignment either.  Are there target
> systems where this is not a simple kernel commandline option?  Thanks,

Well, turning off the IOMMU doesn't necessarily turn off ACS. We've run
into some bios's that set the bits on boot (which is annoying).

I also don't expect people will respond well to making the IOMMU and P2P
exclusive. The IOMMU is often used for more than just security and on
many platforms it's enabled by default. I'd much rather allow IOMMU use
but have fewer isolation groups in much the same way as if you had PCI
bridges that didn't support ACS.

Logan
