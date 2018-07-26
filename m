Return-Path: <martin.petersen@oracle.com>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: keith.busch@intel.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org,
        axboe@kernel.dk, vladimirk@mellanox.com
Subject: Re: [PATCH v4 2/3] block: move dif_prepare/dif_complete functions to block layer
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
	<1532533577-1600-2-git-send-email-maxg@mellanox.com>
Date: Wed, 25 Jul 2018 21:12:27 -0400
In-Reply-To: <1532533577-1600-2-git-send-email-maxg@mellanox.com> (Max
	Gurtovoy's message of "Wed, 25 Jul 2018 18:46:16 +0300")
Message-ID: <yq1k1pi3imc.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Max,

> Currently these functions are implemented in the scsi layer, but their
> actual place should be the block layer since T10-PI is a general data
> integrity feature that is used in the nvme protocol as well. Also, use
> the tuple size from the integrity profile since it may vary between
> integrity types.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
