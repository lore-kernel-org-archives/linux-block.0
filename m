Subject: Re: [PATCH 1/2] blk-mq: get rid of manual run of queue with
 __blk_mq_run_hw_queue()
To: Christoph Hellwig <hch@infradead.org>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <1474555980-2787-2-git-send-email-axboe@fb.com>
 <20160922185603.GA32468@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, jbacik@fb.com
From: Jens Axboe <axboe@fb.com>
Message-ID: <aa85fbc5-e803-5488-48ad-20cd3b7bcc45@fb.com>
Date: Thu, 22 Sep 2016 14:29:42 -0600
MIME-Version: 1.0
In-Reply-To: <20160922185603.GA32468@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 09/22/2016 12:56 PM, Christoph Hellwig wrote:
> Ok, I looked into this a bit more, and while I'm still fine with the
> patch I think it's only half of what we should do here.  There really
> is no point in doing the first non-blocking path in blk_mq_map_request
> either as bt_get itself already does the non-blocking pass, and also
> runs the queue when scheduling in the later loop as well.  So to get
> towards what I had in my tree we also need something like this:

Good point, I'll apply this one as well.

-- 
Jens Axboe
