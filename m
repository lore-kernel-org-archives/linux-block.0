Return-Path: <hch@lst.de>
Date: Wed, 19 Apr 2017 08:21:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Subject: Re: [PATCH 5/5] block: Optimize ioprio_best()
Message-ID: <20170419062145.GE6412@lst.de>
References: <20170418231037.3968-1-bart.vanassche@sandisk.com> <20170418231037.3968-6-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170418231037.3968-6-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 18, 2017 at 04:10:37PM -0700, Bart Van Assche wrote:
> Since ioprio_best() translates IOPRIO_CLASS_NONE into IOPRIO_CLASS_BE
> and since lower numerical priority values represent a higher priority
> a simple numerical comparison is sufficient.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
