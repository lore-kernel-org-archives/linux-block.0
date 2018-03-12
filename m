Return-Path: <logang@deltatee.com>
To: Jonathan Corbet <corbet@lwn.net>
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
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-6-logang@deltatee.com> <20180312134114.1e4b12f8@lwn.net>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0204d22a-72fa-d7fb-ae8e-8d20d80cb4a6@deltatee.com>
Date: Mon, 12 Mar 2018 15:18:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180312134114.1e4b12f8@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v3 05/11] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
List-ID: <linux-block@vger.kernel.org>

On 3/12/2018 1:41 PM, Jonathan Corbet wrote:
> This all seems good, but...could we consider moving this documentation to
> driver-api/PCI as it's converted to RST?  That would keep it together with
> similar materials and bring a bit more coherence to Documentation/ as a
> whole.

Yup, I'll change this for the next revision.

Thanks,

Logan
