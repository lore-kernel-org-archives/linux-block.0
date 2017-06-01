Return-Path: <hch@lst.de>
Date: Thu, 1 Jun 2017 08:09:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 07/12] block: Check locking assumptions at runtime
Message-ID: <20170601060951.GH16248@lst.de>
References: <20170531225246.26261-1-bart.vanassche@sandisk.com> <20170531225246.26261-8-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531225246.26261-8-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 03:52:41PM -0700, Bart Van Assche wrote:
> Instead of documenting the locking assumptions of most block layer
> functions as a comment, use lockdep_assert_held() to verify locking
> assumptions at runtime.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
