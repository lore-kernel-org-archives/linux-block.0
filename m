Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <d69d59c0-6182-cce7-7ba4-8552ba95bef5@deltatee.com>
References: <20180228234006.21093-1-logang@deltatee.com> <20180228234006.21093-3-logang@deltatee.com>
 <20180301174450.GF13722@bhelgaas-glaptop.roam.corp.google.com> <d69d59c0-6182-cce7-7ba4-8552ba95bef5@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 1 Mar 2018 16:36:12 -0800
Message-ID: <CAPcyv4hj5XJrsKHxZEWTSdrDAv0k7tf1ptb7_2FpTGpxqY5jUQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] PCI/P2PDMA: Add sysfs group to display p2pmem stats
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma <linux-rdma@vger.kernel.org>,
	linux-nvdimm <linux-nvdimm@lists.01.org>, linux-block@vger.kernel.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 1, 2018 at 4:15 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 01/03/18 10:44 AM, Bjorn Helgaas wrote:
>>
>> I think these two statements are out of order, since the attributes
>> dereference pdev->p2pdma.  And it looks like you set "error"
>> unnecessarily, since you return immediately looking at it.
>
>
> Per the previous series, sysfs_create_group is must_check for some reason. I
> had a printk there but you didn't think it was necessary. So assigning it to
> error is the only way to squash the warning.

Why not fail the setup if the sysfs_create_group() fails? Sure, it may
not be strictly required for userspace to have access to these
attributes, but it seems hostile that userspace can't make assumptions
about the presence of the "p2pmem" directory relative to the
capability being setup.
