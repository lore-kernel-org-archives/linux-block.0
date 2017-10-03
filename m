Return-Path: <axboe@kernel.dk>
Subject: Re: RQF_PM fix/cleanup
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20171003084701.19346-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <aed85f64-5015-10be-31f9-0b109f46686e@kernel.dk>
Date: Tue, 3 Oct 2017 08:43:26 -0600
MIME-Version: 1.0
In-Reply-To: <20171003084701.19346-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/03/2017 02:46 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series fixed the blocking/passing of requests during PM IFF there were
> more than one.  That currently isn't the case, but relying on that not only
> is fragile, but also leads to more obscure code than handling it properly.

Looks good to me, added for 4.15.

-- 
Jens Axboe
