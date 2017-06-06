Subject: Re: [PATCH v5 00/12] blk-mq: fix & improve queue quiescing
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
References: <20170606152210.22806-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <08a2b32d-866e-a71f-4ac6-9c131edb88e2@fb.com>
Date: Tue, 6 Jun 2017 10:03:12 -0600
MIME-Version: 1.0
In-Reply-To: <20170606152210.22806-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/06/2017 09:21 AM, Ming Lei wrote:
> Hi,
> 
> There is one big issue in current blk_mq_quiesce_queue():
> 
>     - in case of direct issue or BLK_MQ_S_START_ON_RUN, dispatch won't
>     be prevented after blk_mq_quiesce_queue() is returned.
> 
> 
> The 1st two patches fix two problems in direct issue, please consider
> it for v4.12.
> 
> The other 10 patches improves blk_mq_quiesce_queue(), and
> make is easy to use, and avoid race between queue restart and
> quiescing. These 10 patches should be for v4.13.

I've added 1-2 for 4.12, I'll review the rest for 4.13 when some
cycles free up.

-- 
Jens Axboe
