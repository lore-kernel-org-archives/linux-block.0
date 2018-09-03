Return-Path: <logang@deltatee.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-8-logang@deltatee.com>
 <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk>
 <20180901082812.GB670@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5f79c012-c6e1-56bb-62fd-0689181fb2c9@deltatee.com>
Date: Mon, 3 Sep 2018 16:26:27 -0600
MIME-Version: 1.0
In-Reply-To: <20180901082812.GB670@lst.de>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
List-ID: <linux-block@vger.kernel.org>



On 01/09/18 02:28 AM, Christoph Hellwig wrote:
> On Thu, Aug 30, 2018 at 01:11:18PM -0600, Jens Axboe wrote:
>> I think this belongs in the caller - both the validity check, and
>> passing in NOMERGE for this type of request. I don't want to impose
>> this overhead on everything, for a pretty niche case.
> 
> It is just a single branch, which will be predicted as not taken
> for non-P2P users.  The benefit is that we get proper error checking
> by doing it in the block code.

I personally agree with Christoph. But if there's consensus in the other
direction or this is a real blocker moving this forward, I can remove it
for the next version.

Logan
