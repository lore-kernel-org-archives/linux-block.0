Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH, resend] block: use bio_add_page in bio_iov_iter_get_pages
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20180920062821.18592-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6dc10e8e-fd78-8793-bb59-17e1d6d640ec@kernel.dk>
Date: Thu, 20 Sep 2018 09:12:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180920062821.18592-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/20/18 12:28 AM, Christoph Hellwig wrote:
> Replace a nasty hack with a different nasty hack to prepare for multipage
> bio_vecs.  By moving the temporary page array as far up as possible in
> the space allocated for the bio_vec array we can iterate forward over it
> and thus use bio_add_page.  Using bio_add_page means we'll be able to
> merge physically contiguous pages once support for multipath bio_vecs is
> merged.

Applied for 4.20.

-- 
Jens Axboe
