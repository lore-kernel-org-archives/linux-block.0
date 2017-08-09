Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Make blk_mq_delay_kick_requeue_list() rerun the
 queue at a quiet time
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
References: <20170809182806.32741-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c7887e64-bc80-d1ac-a80e-e2ebd868a577@kernel.dk>
Date: Wed, 9 Aug 2017 13:01:58 -0600
MIME-Version: 1.0
In-Reply-To: <20170809182806.32741-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/09/2017 12:28 PM, Bart Van Assche wrote:
> The blk_mq_delay_kick_requeue_list() function is used by the device
> mapper and only by the device mapper to rerun the queue and requeue
> list after a delay. This function is called once per request that
> gets requeued. Modify this function such that the queue is run once
> per path change event instead of once per request that is requeued.

Looks good to me, will add for this series. Thanks Bart.

-- 
Jens Axboe
