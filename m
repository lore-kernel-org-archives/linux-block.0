Return-Path: <hch@lst.de>
Date: Wed, 2 Nov 2016 15:55:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	jack@suse.cz, hch@lst.de
Subject: Re: [PATCH 1/8] block: add WRITE_BACKGROUND
Message-ID: <20161102145520.GE13964@lst.de>
References: <1478034531-28559-1-git-send-email-axboe@fb.com> <1478034531-28559-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478034531-28559-2-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 01, 2016 at 03:08:44PM -0600, Jens Axboe wrote:
> This adds a new request flag, REQ_BACKGROUND, that callers can use to
> tell the block layer that this is background (non-urgent) IO.

The subject still says WRITE_BACKGROUND :)

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
