Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove __bio_kmap_atomic
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20171108181348.13945-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ee439005-185e-4f3c-3372-21167f5e2fb1@kernel.dk>
Date: Wed, 8 Nov 2017 11:16:38 -0700
MIME-Version: 1.0
In-Reply-To: <20171108181348.13945-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/08/2017 11:13 AM, Christoph Hellwig wrote:
> This helper doesn't buy us much over calling kmap_atomic directly.
> In fact in the only caller it does a bit of useless work as the
> caller already has the bvec at hand, and said caller would even
> buggy for a multi-segment bio due to the use of this helper.
> 
> So just remove it.

Thanks, done and done.

-- 
Jens Axboe
