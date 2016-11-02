Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 2 Nov 2016 10:22:03 -0600
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH 1/8] block: add WRITE_BACKGROUND
Message-ID: <20161102162203.GA7591@kernel.dk>
References: <1478034531-28559-1-git-send-email-axboe@fb.com>
 <1478034531-28559-2-git-send-email-axboe@fb.com>
 <20161102145520.GE13964@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161102145520.GE13964@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 02 2016, Christoph Hellwig wrote:
> On Tue, Nov 01, 2016 at 03:08:44PM -0600, Jens Axboe wrote:
> > This adds a new request flag, REQ_BACKGROUND, that callers can use to
> > tell the block layer that this is background (non-urgent) IO.
> 
> The subject still says WRITE_BACKGROUND :)

Gah - will fix that up.

> Otherwise looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Added, thanks.

-- 
Jens Axboe
