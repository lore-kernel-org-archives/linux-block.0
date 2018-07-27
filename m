Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 1/3] block: move ref_tag calculation func to the block
 layer
From: Jens Axboe <axboe@kernel.dk>
To: Max Gurtovoy <maxg@mellanox.com>, keith.busch@intel.com,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 martin.petersen@oracle.com, linux-block@vger.kernel.org
Cc: vladimirk@mellanox.com
References: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
 <a50d17af-6e6f-c899-5dd6-e87d5436af98@kernel.dk>
Message-ID: <165f5bbe-168f-cd15-8fd0-d464aca64414@kernel.dk>
Date: Fri, 27 Jul 2018 09:38:16 -0600
MIME-Version: 1.0
In-Reply-To: <a50d17af-6e6f-c899-5dd6-e87d5436af98@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/27/18 9:21 AM, Jens Axboe wrote:
> On 7/25/18 9:46 AM, Max Gurtovoy wrote:
>> Currently this function is implemented in the scsi layer, but it's
>> actual place should be the block layer since T10-PI is a general
>> data integrity feature that is used in the nvme protocol as well.
> 
> Applied 1-3 for 4.19.

This:

static inline u32 t10_pi_ref_tag(struct request *rq)
{
        return blk_rq_pos(rq) >>
                (rq->q->integrity.interval_exp - 9) & 0xffffffff;
}

won't work for !CONFIG_BLK_DEV_INTEGRITY. I didn't want to make the
change, but looks like it should either return -1U as we the value
should mean nothing if BLK_DEV_INTEGRITY isn't set, or just ignore the
shift and return blk_rq_pos(rq) & 0xffffffff.

Please fixup and resend the series.

-- 
Jens Axboe
