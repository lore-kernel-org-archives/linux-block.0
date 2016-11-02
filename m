Return-Path: <hch@lst.de>
Date: Wed, 2 Nov 2016 15:56:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	jack@suse.cz, hch@lst.de
Subject: Re: [PATCH 2/8] writeback: add wbc_to_write_flags()
Message-ID: <20161102145605.GF13964@lst.de>
References: <1478034531-28559-1-git-send-email-axboe@fb.com> <1478034531-28559-3-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478034531-28559-3-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 01, 2016 at 03:08:45PM -0600, Jens Axboe wrote:
> Add wbc_to_write_flags(), which returns the write modifier flags to use,
> based on a struct writeback_control. No functional changes in this
> patch, but it prepares us for factoring other wbc fields for write type.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
