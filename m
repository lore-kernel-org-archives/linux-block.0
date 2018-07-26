Return-Path: <martin.petersen@oracle.com>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: keith.busch@intel.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org,
        axboe@kernel.dk, vladimirk@mellanox.com
Subject: Re: [PATCH v4 3/3] nvme: use blk API to remap ref tags for IOs with metadata
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
	<1532533577-1600-3-git-send-email-maxg@mellanox.com>
Date: Wed, 25 Jul 2018 21:12:56 -0400
In-Reply-To: <1532533577-1600-3-git-send-email-maxg@mellanox.com> (Max
	Gurtovoy's message of "Wed, 25 Jul 2018 18:46:17 +0300")
Message-ID: <yq1fu063ilj.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Max,

> Also moved the logic of the remapping to the nvme core driver instead
> of implementing it in the nvme pci driver. This way all the other nvme
> transport drivers will benefit from it (in case they'll implement metadata
> support).

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
