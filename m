Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Update comments that refer to __bio_map_user() and
 bio_map_user()
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170201162008.4628-1-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fe736984-698e-a5f2-4251-31c12aac4138@kernel.dk>
Date: Wed, 1 Feb 2017 11:33:02 -0800
MIME-Version: 1.0
In-Reply-To: <20170201162008.4628-1-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/01/2017 08:20 AM, Bart Van Assche wrote:
> Since __bio_map_user() and bio_map_user() have been removed, update
> the comments that still refer to these functions.

Applied, thanks Bart.

-- 
Jens Axboe
