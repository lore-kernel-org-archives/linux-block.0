Subject: Re: [PATCH 2/7] cfq-iosched: use appropriate run queue function
To: Christoph Hellwig <hch@infradead.org>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
 <1480734921-23701-3-git-send-email-axboe@fb.com>
 <20161205130631.GB7100@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, paolo.valente@linaro.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <b20fdde7-a786-f189-b9a5-e1f2e99ba248@fb.com>
Date: Mon, 5 Dec 2016 08:08:22 -0700
MIME-Version: 1.0
In-Reply-To: <20161205130631.GB7100@infradead.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 12/05/2016 06:06 AM, Christoph Hellwig wrote:
> On Fri, Dec 02, 2016 at 08:15:16PM -0700, Jens Axboe wrote:
>> For MQ devices, we have to use other functions to run the queue.
>> No functional changes in this patch, just a prep patch for
>> support legacy schedulers on blk-mq.
> 
> I don't think supporting CFQ on blk-mq makes any sense.  Even if we
> for some reason reuse existing scheduler (something I'm not in favour
> except as bringup vehicle) we should limit it to deadline and in the
> (hopefully near) future BFQ.

Not disagreeing with that. It'd be synthetically limiting it, though, as
there's really nothing preventing CFQ from running under it, with the
slight queue run change here.

-- 
Jens Axboe
