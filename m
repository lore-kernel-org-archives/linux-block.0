Return-Path: <hch@lst.de>
Date: Wed, 2 Nov 2016 15:52:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 1/4] block: add scalable completion tracking of requests
Message-ID: <20161102145239.GB13964@lst.de>
References: <1478034325-28232-1-git-send-email-axboe@fb.com> <1478034325-28232-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478034325-28232-2-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 01, 2016 at 03:05:22PM -0600, Jens Axboe wrote:
> For legacy block, we simply track them in the request queue. For
> blk-mq, we track them on a per-sw queue basis, which we can then
> sum up through the hardware queues and finally to a per device
> state.

what is the use case for the legacy request tracking?
