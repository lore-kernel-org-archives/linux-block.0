Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: stop using bio_data() in blk_write_same_mergeable
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170619072441.12835-1-hch@lst.de>
	<20170619072441.12835-3-hch@lst.de>
Date: Tue, 20 Jun 2017 21:20:10 -0400
In-Reply-To: <20170619072441.12835-3-hch@lst.de> (Christoph Hellwig's message
	of "Mon, 19 Jun 2017 09:24:41 +0200")
Message-ID: <yq160fqjfw5.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

> While the Write Same page currently always is in low-level it is just
> as easy and safer to just compare the page and offset directly.

Also fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
