Return-Path: <axboe@kernel.dk>
Date: Thu, 8 Mar 2018 14:09:23 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: jiufei.xue@linux.alibaba.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: bio_check_eod() needs to consider partition
Message-ID: <20180308210921.GA3932@kernel.dk>
References: <20180308074648.6037-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180308074648.6037-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 08 2018, Christoph Hellwig wrote:
> bio_check_eod() should check partiton size not the whole disk if
> bio->bi_partno is non-zero.
> 
> Based on an earlier patch from Jiufei Xue.

This doesn't apply, what did you generate it against?

-- 
Jens Axboe
