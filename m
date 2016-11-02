Return-Path: <hch@lst.de>
Date: Wed, 2 Nov 2016 15:51:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCHSET] block: IO polling improvements
Message-ID: <20161102145148.GA13964@lst.de>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478034325-28232-1-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 01, 2016 at 03:05:21PM -0600, Jens Axboe wrote:
> This builds on top of Christophs simplified bdev O_DIRECT code,
> posted earlier today [1].

Btw, can you create a stable branch just for the
"block: add bio_iov_iter_get_pages()" so that we can use it as
a baseline for the iomap dio work?
