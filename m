Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 9/9] bio-integrity: stop abusing bi_end_io
To: Christoph Hellwig <hch@lst.de>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Shaohua Li <shli@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20170629183116.28685-1-hch@lst.de>
 <20170629183116.28685-10-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bfccf118-59cb-986a-ab7d-b1a010d4c0fe@kernel.dk>
Date: Mon, 3 Jul 2017 17:00:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170629183116.28685-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/29/2017 12:31 PM, Christoph Hellwig wrote:
> And instead call directly into the integrity code from bio_end_io.

This patch doesn't apply to master. But more importantly, it also
doesn't compile without INTEGRITY:

> +static inline bool bio_integrity_endio(struct bio *)
> +{
> +	return true;
> +}

Oops...

I hand applied and fixed it up.
 
-- 
Jens Axboe
