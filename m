Return-Path: <hch@lst.de>
Date: Sat, 1 Sep 2018 10:28:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
	linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
Message-ID: <20180901082812.GB670@lst.de>
References: <20180830185352.3369-1-logang@deltatee.com> <20180830185352.3369-8-logang@deltatee.com> <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 30, 2018 at 01:11:18PM -0600, Jens Axboe wrote:
> I think this belongs in the caller - both the validity check, and
> passing in NOMERGE for this type of request. I don't want to impose
> this overhead on everything, for a pretty niche case.

It is just a single branch, which will be predicted as not taken
for non-P2P users.  The benefit is that we get proper error checking
by doing it in the block code.
