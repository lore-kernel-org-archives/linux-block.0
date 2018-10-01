Return-Path: <logang@deltatee.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Steve Wise <swise@opengridcomputing.com>
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-14-logang@deltatee.com>
 <5ddeed51-0580-9581-cf12-c75e18b4f7cc@grimberg.me>
 <69cd8aab-b94e-98f5-5397-48bb875e8280@deltatee.com>
 <b790b11f-41df-f495-fdd1-d8bd6d6b7dd6@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <587bb6bd-ec07-62ac-6442-cbc7892df37f@deltatee.com>
Date: Mon, 1 Oct 2018 17:43:00 -0600
MIME-Version: 1.0
In-Reply-To: <b790b11f-41df-f495-fdd1-d8bd6d6b7dd6@grimberg.me>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v8 13/13] nvmet: Optionally use PCI P2P memory
List-ID: <linux-block@vger.kernel.org>



On 01/10/18 04:23 PM, Sagi Grimberg wrote:
>> I did not realize the namespace would be available at this time. I guess
>> I can give this a try, but it's going to be a fairly big change from
>> what's presented here... Though, I agree it'll probably be an
>> improvement.
> 
> Thanks, if it turns out to create to much of a churn, we could defer
> that to a later stage, but we can at least document it.

Yeah, it's going to create a bunch of churn, but it's probably worth
doing before merging because I think it will remove a bunch of
complexity (ie. the need for the whole p2p client infrastructure because
we now only need to worry about only one namespace at a time, instead of
needing to find a p2p device that works with all namespaces at once).

I'll try to get a v9 with this change published in the next day or two.

Logan
