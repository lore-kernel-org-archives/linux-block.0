Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V4 08/16] scsi: sd_zbc: Limit zone write locking to
 sequential zones
To: Christoph Hellwig <hch@lst.de>
Cc: linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <Bart.VanAssche@wdc.com>
References: <20170924070247.25560-1-damien.lemoal@wdc.com>
 <20170924070247.25560-9-damien.lemoal@wdc.com>
 <20170924151804.GB16608@lst.de>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <ef17e904-b0a2-f51c-d144-bbc91c732848@wdc.com>
Date: Sun, 24 Sep 2017 18:51:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170924151804.GB16608@lst.de>
Content-Type: text/plain; charset=utf-8
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>

On 9/24/17 17:18, Christoph Hellwig wrote:
>> +	if (q->seq_zones && test_bit(zno, q->seq_zones))
>> +		return BLKPREP_OK;
> 
> Isn't the check above inverted?  Also shouldn't it use blk_rq_zone_is_seq?
> E.g.
> 
> 	if (!blk_rq_zone_is_seq(cmd->request))
> 		return BLKPREP_OK;
> ?

Arrg ! Good catch. I tested only the scsi-mq case which does not use
this path anymore (same test used, but at the scheduler level). Silly of
me. I should have properly tested all cases.

Will fix this.

Thanks.

-- 
Damien Le Moal
Western Digital Research
