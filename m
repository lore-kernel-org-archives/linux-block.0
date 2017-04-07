Return-Path: <ming.lei@redhat.com>
Date: Fri, 7 Apr 2017 18:23:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Long Li <longli@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH v3 4/5] blk-mq: Introduce blk_mq_delay_run_hw_queue()
Message-ID: <20170407102343.GB28554@ming.t460p>
References: <20170406181050.12137-1-bart.vanassche@sandisk.com>
 <20170406181050.12137-5-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170406181050.12137-5-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 06, 2017 at 11:10:49AM -0700, Bart Van Assche wrote:
> Introduce a function that runs a hardware queue unconditionally

I appreciate if some background can be provided for this function,
like fixing some issues?


Thanks,
Ming
