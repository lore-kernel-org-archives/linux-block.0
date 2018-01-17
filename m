Return-Path: <martin.petersen@oracle.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Fix __bio_integrity_endio() documentation
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180116183139.29777-1-bart.vanassche@wdc.com>
Date: Tue, 16 Jan 2018 23:31:26 -0500
In-Reply-To: <20180116183139.29777-1-bart.vanassche@wdc.com> (Bart Van
	Assche's message of "Tue, 16 Jan 2018 10:31:39 -0800")
Message-ID: <yq1lggxumw1.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Bart,

> Fixes: 4246a0b63bd8 ("block: add a bi_error field to struct bio")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
