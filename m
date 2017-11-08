Subject: Re: [PATCH V2] blk-mq: put driver tag if dispatch budget can't be got
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>
References: <20171108011122.21654-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <99b06eaf-616f-1c4f-1b7d-64b4290b11c0@fb.com>
Date: Wed, 8 Nov 2017 11:19:04 -0700
MIME-Version: 1.0
In-Reply-To: <20171108011122.21654-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/07/2017 06:11 PM, Ming Lei wrote:
> We have to put the driver tag if dispatch budget can't be got, otherwise
> it might cause IO deadlock, especially in case that size of tags is very
> small.

Applied, thanks.

-- 
Jens Axboe
