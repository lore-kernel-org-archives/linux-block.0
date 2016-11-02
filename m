Return-Path: <hch@lst.de>
Date: Wed, 2 Nov 2016 15:57:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	jack@suse.cz, hch@lst.de
Subject: Re: [PATCH 4/8] writeback: track if we're sleeping on progress in
	balance_dirty_pages()
Message-ID: <20161102145703.GH13964@lst.de>
References: <1478034531-28559-1-git-send-email-axboe@fb.com> <1478034531-28559-5-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478034531-28559-5-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 01, 2016 at 03:08:47PM -0600, Jens Axboe wrote:
> Note in the bdi_writeback structure whenever a task ends up sleeping
> waiting for progress. We can use that information in the lower layers
> to increase the priority of writes.

Do we need to care about atomicy of multiple threads updating the value
?

Otherwise this looks fine.
