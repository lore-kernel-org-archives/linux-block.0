Return-Path: <hch@lst.de>
Date: Sun, 24 Sep 2017 17:21:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V4 12/16] blokc: mq-deadline: Introduce dispatch helpers
Message-ID: <20170924152149.GD16608@lst.de>
References: <20170924070247.25560-1-damien.lemoal@wdc.com> <20170924070247.25560-13-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170924070247.25560-13-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

> +static struct request *
> +deadline_next_request(struct deadline_data *dd, int data_dir)
> +{

	if (WARN_ON_ONCE(data_dir != READ && data_dir != WRITE))
		return NULL;

> +	return dd->next_rq[data_dir];
> +}
> +

Else looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
