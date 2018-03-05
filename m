Return-Path: <logang@deltatee.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@intel.com>,
 Oliver <oohall@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-8-logang@deltatee.com>
 <CAOSf1CEj1vmLLd27-642=XSnL9ODkpEC0qLHA2_W5_7rV5+4Pg@mail.gmail.com>
 <20180305160004.GA30975@localhost.localdomain>
 <36c78987-006a-a97f-1d18-b0a08cbea9d4@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e3ca6482-d68c-0e10-dde9-7ccb702d3ac2@deltatee.com>
Date: Mon, 5 Mar 2018 13:13:20 -0700
MIME-Version: 1.0
In-Reply-To: <36c78987-006a-a97f-1d18-b0a08cbea9d4@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 07/10] nvme-pci: Use PCI p2pmem subsystem to manage the
 CMB
List-ID: <linux-block@vger.kernel.org>



On 05/03/18 12:57 PM, Sagi Grimberg wrote:
> Keith, while we're on this, regardless of cmb, is SQE memcopy and DB 
> update ordering always guaranteed?
> 
> If you look at mlx4 (rdma device driver) that works exactly the same as
> nvme you will find:
> -- 
>                  qp->sq.head += nreq;
> 
>                  /*
>                   * Make sure that descriptors are written before
>                   * doorbell record.
>                   */
>                  wmb();
> 
>                  writel(qp->doorbell_qpn,
>                         to_mdev(ibqp->device)->uar_map + 
> MLX4_SEND_DOORBELL);
> 
>                  /*
>                   * Make sure doorbells don't leak out of SQ spinlock
>                   * and reach the HCA out of order.
>                   */
>                  mmiowb();
> -- 

To me, it looks like the wmb() is redundant as writel should guarantee 
the order. (Indeed, per Sinan's comment, writel on arm64 starts with a 
wmb() which means, on that platform, there are two wmb() calls in a row.)

The mmiowb() call, on the other hand, looks correct per my understanding 
of it's purpose with respect to the spinlock.

Logan
