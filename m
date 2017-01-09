Return-Path: <sergey.senozhatsky@gmail.com>
Return-Path: <sergey.senozhatsky@gmail.com>
Date: Mon, 9 Jan 2017 23:33:44 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Hyeoncheol Lee <cheol.lee@lge.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Robert Jennings <rcj@linux.vnet.ibm.com>,
	Jerome Marchand <jmarchan@redhat.com>
Subject: Re: [RFC] blk: increase logical_block_size to unsigned int
Message-ID: <20170109143344.GA753@tigerII.localdomain>
References: <1483938267-8858-1-git-send-email-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483938267-8858-1-git-send-email-minchan@kernel.org>
List-ID: <linux-block@vger.kernel.org>

On (01/09/17 14:04), Minchan Kim wrote:
> Mostly, zram is used as swap system on embedded world so it want to do IO
> as PAGE_SIZE aligned/size IO unit. For that, one of the problem was
> blk_queue_logical_block_size(zram->disk->queue, PAGE_SIZE) made overflow
> in *64K page system* so [1] changed it to constant 4096.
> Since that, partial IO can happen so zram should handle it which makes zram
> complicated[2].
> 

I thought that zram partial IO support is there because some file
systems cannot cope with large logical_block_size. like FAT, for
example. am I wrong?

	-ss
