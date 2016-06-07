Return-Path: <keith.busch@intel.com>
Date: Tue, 7 Jun 2016 10:47:54 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jay Freyensee <james.p.freyensee@intel.com>,
	Ming Lin <ming.l@ssi.samsung.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 5/5] nvme-rdma: add a NVMe over Fabrics RDMA host driver
Message-ID: <20160607144753.GA28414@localhost.localdomain>
References: <1465248215-18186-1-git-send-email-hch@lst.de>
 <1465248215-18186-6-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465248215-18186-6-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 06, 2016 at 11:23:35PM +0200, Christoph Hellwig wrote:
> To connect to all NVMe over Fabrics controller reachable on a given taget
> port using RDMA/CM use the following command:
> 
> 	nvme connect-all -t rdma -a $IPADDR
> 
> This requires the latest version of nvme-cli with Fabrics support.

Is there a public fork or patch set available for the user tools? I'd
be happy to merge that in.

Overall, this whole series is looking really good. I'll try this out on
some machines today.
