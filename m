Return-Path: <martin.petersen@oracle.com>
To: Greg Edwards <gedwards@ddn.com>
Cc: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/2] block: move bio_integrity_{intervals,bytes} into blkdev.h
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20180725142259.20562-1-gedwards@ddn.com>
	<20180725142259.20562-2-gedwards@ddn.com>
Date: Wed, 25 Jul 2018 21:39:42 -0400
In-Reply-To: <20180725142259.20562-2-gedwards@ddn.com> (Greg Edwards's message
	of "Wed, 25 Jul 2018 10:22:58 -0400")
Message-ID: <yq14lgm3hcx.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Greg,

> This allows bio_integrity_bytes() to be called from drivers instead of
> open coding it.

Looks fine.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
