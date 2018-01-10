Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Revert "block: blk-merge: try to make front segments in
 full size"
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Dmitry Osipenko <digetx@gmail.com>
References: <20180110025129.30999-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7c4078db-bb02-b5b1-3a56-dd2dc1361d31@kernel.dk>
Date: Tue, 9 Jan 2018 20:46:56 -0700
MIME-Version: 1.0
In-Reply-To: <20180110025129.30999-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/9/18 7:51 PM, Ming Lei wrote:
> This reverts commit a2d37968d784363842f87820a21e106741d28004.
> 
> If max segment size isn't 512-aligned, this patch won't work well.
> 
> Also once multipage bvec is enabled, adjacent bvecs won't be physically
> contiguous if page is added via bio_add_page(), so we don't need this
> kind of complicated logic.

I was quickly getting to that conclusion as well... Applied, thanks.

-- 
Jens Axboe
