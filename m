Return-Path: <hch@lst.de>
Date: Tue, 27 Jun 2017 16:57:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de,
	martin.petersen@oracle.com
Subject: Re: [PATCH 1/9] fs: add fcntl() interface for setting/getting
	write life time hints
Message-ID: <20170627145711.GA27044@lst.de>
References: <1498491480-16306-1-git-send-email-axboe@kernel.dk> <1498491480-16306-2-git-send-email-axboe@kernel.dk> <20170627144255.GB2541@infradead.org> <f543046a-c186-da7a-73e1-6510e93118bf@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f543046a-c186-da7a-73e1-6510e93118bf@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 27, 2017 at 08:55:02AM -0600, Jens Axboe wrote:
> BTW, that patch does not look like an incremental patch, what's
> this against?

The patch I'm replying to, without the other ones.
