Return-Path: <hch@lst.de>
Date: Fri, 29 Jun 2018 10:34:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] include/trace/events/wbt.h: Suppress a compiler warning
Message-ID: <20180629083404.GB15870@lst.de>
References: <20180627202234.17670-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180627202234.17670-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 27, 2018 at 01:22:34PM -0700, Bart Van Assche wrote:
> This patch avoids that the following warning appears when building
> with gcc 8 and W=1:
> 
> ./include/trace/events/wbt.h:36:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]

I really don't think this is the right fix.  Note that the trace
code allows for dynamic arrays using __dynamic_array(), so the best idea
might be to switch to that.
