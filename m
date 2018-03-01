Return-Path: <jthumshirn@suse.de>
Date: Thu, 1 Mar 2018 09:51:37 +0100
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 04/11] block: Protect queue flag changes with the queue
 lock
Message-ID: <20180301085137.6g3hgobf6kj2bosy@linux-x5ow.site>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
 <20180228192823.5191-5-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180228192823.5191-5-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 28, 2018 at 11:28:16AM -0800, Bart Van Assche wrote:
>  static bool blk_poll_stats_enable(struct request_queue *q)
>  {
> -	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
> -	    test_and_set_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
> +	if (blk_queue_flag_test_and_set(QUEUE_FLAG_POLL_STATS, q))

Is this one really needed or just for symmetry? Even if something
would change the queue_flags after the first test_bit() call, the
test_and_set_bit() would still do the right thing, wouldn't it?

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
