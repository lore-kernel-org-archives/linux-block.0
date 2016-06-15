Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 4/5] nvmet-rdma: add a NVMe over Fabrics RDMA target
 driver
To: Steve Wise <swise@opengridcomputing.com>,
 'Sagi Grimberg' <sagi@lightbits.io>, 'Christoph Hellwig' <hch@lst.de>,
 axboe@kernel.dk, keith.busch@intel.com, sean.hefty@intel.com
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <1465248215-18186-5-git-send-email-hch@lst.de>
 <5756B75C.9000409@lightbits.io>
 <057a01d1c2a3$3082eec0$9188cc40$@opengridcomputing.com>
 <00f501d1c657$483a74e0$d8af5ea0$@opengridcomputing.com>
 <00f701d1c658$efd720d0$cf856270$@opengridcomputing.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, 'Armen Baloyan' <armenx.baloyan@intel.com>,
 'Jay Freyensee' <james.p.freyensee@intel.com>,
 'Ming Lin' <ming.l@ssi.samsung.com>, linux-rdma@vger.kernel.org
From: Sagi Grimberg <sagigrim@gmail.com>
Message-ID: <57619F3E.6070903@gmail.com>
Date: Wed, 15 Jun 2016 21:32:30 +0300
MIME-Version: 1.0
In-Reply-To: <00f701d1c658$efd720d0$cf856270$@opengridcomputing.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Looking at rdma_destroy_id(), I think it is invalid to call it from the event
> handler:

...

>
> So I withdraw my comment about nvmet.  I think the code is fine as-is.  The 2nd
> reject results in a no-op since the connection request was rejected by nvmet.

I was just catching up on this after a short vacation, just what I was
about to comment, thanks Steve :)
