Return-Path: <keith.busch@linux.intel.com>
Date: Wed, 25 Jul 2018 11:58:53 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: keith.busch@intel.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org,
	axboe@kernel.dk, vladimirk@mellanox.com
Subject: Re: [PATCH v4 3/3] nvme: use blk API to remap ref tags for IOs with
 metadata
Message-ID: <20180725175853.GB16208@localhost.localdomain>
References: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
 <1532533577-1600-3-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532533577-1600-3-git-send-email-maxg@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 25, 2018 at 06:46:17PM +0300, Max Gurtovoy wrote:
> Also moved the logic of the remapping to the nvme core driver instead
> of implementing it in the nvme pci driver. This way all the other nvme
> transport drivers will benefit from it (in case they'll implement metadata
> support).

I'm afraid I won't be able to test any of this in the near future, but
the code looks good to me!

Acked-by: Keith Busch <keith.busch@intel.com>
