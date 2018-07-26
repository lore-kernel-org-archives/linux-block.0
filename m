Return-Path: <martin.petersen@oracle.com>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: keith.busch@intel.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
        hch@lst.de, martin.petersen@oracle.com, linux-block@vger.kernel.org,
        axboe@kernel.dk, vladimirk@mellanox.com
Subject: Re: [PATCH v4 1/3] block: move ref_tag calculation func to the block layer
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
Date: Wed, 25 Jul 2018 21:11:58 -0400
In-Reply-To: <1532533577-1600-1-git-send-email-maxg@mellanox.com> (Max
	Gurtovoy's message of "Wed, 25 Jul 2018 18:46:15 +0300")
Message-ID: <yq1o9eu3in5.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Max,

> Currently this function is implemented in the scsi layer, but it's
> actual place should be the block layer since T10-PI is a general
> data integrity feature that is used in the nvme protocol as well.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
