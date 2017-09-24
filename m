Return-Path: <hch@lst.de>
Date: Sun, 24 Sep 2017 17:18:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V4 08/16] scsi: sd_zbc: Limit zone write locking to
	sequential zones
Message-ID: <20170924151804.GB16608@lst.de>
References: <20170924070247.25560-1-damien.lemoal@wdc.com> <20170924070247.25560-9-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170924070247.25560-9-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

> +	if (q->seq_zones && test_bit(zno, q->seq_zones))
> +		return BLKPREP_OK;

Isn't the check above inverted?  Also shouldn't it use blk_rq_zone_is_seq?
E.g.

	if (!blk_rq_zone_is_seq(cmd->request))
		return BLKPREP_OK;
?
