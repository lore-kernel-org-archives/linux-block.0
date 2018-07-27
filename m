Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 1/3] block: move ref_tag calculation func to the block
 layer
To: Max Gurtovoy <maxg@mellanox.com>, keith.busch@intel.com,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 martin.petersen@oracle.com, linux-block@vger.kernel.org
Cc: vladimirk@mellanox.com
References: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a50d17af-6e6f-c899-5dd6-e87d5436af98@kernel.dk>
Date: Fri, 27 Jul 2018 09:21:03 -0600
MIME-Version: 1.0
In-Reply-To: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/25/18 9:46 AM, Max Gurtovoy wrote:
> Currently this function is implemented in the scsi layer, but it's
> actual place should be the block layer since T10-PI is a general
> data integrity feature that is used in the nvme protocol as well.

Applied 1-3 for 4.19.

-- 
Jens Axboe
