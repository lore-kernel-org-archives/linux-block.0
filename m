Return-Path: <hch@lst.de>
Date: Mon, 7 May 2018 11:51:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	dchinner@redhat.com, hch@lst.de
Subject: Re: [PATCH 1/3] block: break discard submissions into the user
	defined size
Message-ID: <20180507095128.GA25210@lst.de>
References: <1525360843-6504-1-git-send-email-axboe@kernel.dk> <1525360843-6504-2-git-send-email-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525360843-6504-2-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 03, 2018 at 09:20:41AM -0600, Jens Axboe wrote:
> Don't build discards bigger than what the user asked for, if the
> user decided to limit the size by writing to 'discard_max_bytes'.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Why do this here when blk_bio_discard_split already takes care of it?
