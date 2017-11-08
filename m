Return-Path: <martin.petersen@oracle.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V7 4/8] block: deadline-iosched: Introduce dispatch helpers
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171108081118.7632-1-damien.lemoal@wdc.com>
	<20171108081118.7632-5-damien.lemoal@wdc.com>
Date: Wed, 08 Nov 2017 18:37:45 -0500
In-Reply-To: <20171108081118.7632-5-damien.lemoal@wdc.com> (Damien Le Moal's
	message of "Wed, 8 Nov 2017 17:11:14 +0900")
Message-ID: <yq1efp8xrxy.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Damien,

> Avoid directly referencing the next_rq and fifo_list arrays using the
> helper functions deadline_next_request() and deadline_fifo_request() to
> facilitate changes in the dispatch request selection in
> deadline_dispatch_requests() for zoned block devices.
>
> While at it, also remove the unnecessary forward declaration of the
> function deadline_move_request().

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
