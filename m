Subject: Re: [PATCH ] block: don't call blk_mq_quiesce_queue() during
 switching mq sched
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20170428073250.9579-1-ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Omar Sandoval <osandov@fb.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <88cb69a2-34a7-6315-cc18-b254a46914dc@fb.com>
Date: Fri, 28 Apr 2017 07:42:05 -0600
MIME-Version: 1.0
In-Reply-To: <20170428073250.9579-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/28/2017 01:32 AM, Ming Lei wrote:
> We have freezed queue already, not necessary to call
> blk_mq_quiesce_queue() any more, so remove it.

Are you sure? It ensures that we also aren't in the middle of
blk_mq_make_request(), we need a stable view of the sched
status throughout that.

Similarly with updating the request maps.

-- 
Jens Axboe
