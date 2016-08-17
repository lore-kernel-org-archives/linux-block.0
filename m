Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix race triggered by blk_set_queue_dying()
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <e50dbd54-30fb-bf59-0ce6-5ccf1d830017@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e6644369-db59-215e-bd01-0f2b623fdbb6@kernel.dk>
Date: Tue, 16 Aug 2016 19:37:16 -0600
MIME-Version: 1.0
In-Reply-To: <e50dbd54-30fb-bf59-0ce6-5ccf1d830017@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/16/2016 05:48 PM, Bart Van Assche wrote:
> blk_set_queue_dying() can be called while another thread is
> submitting I/O or changing queue flags, e.g. through dm_stop_queue().
> Hence protect the QUEUE_FLAG_DYING flag change with locking.

Added, thanks.

-- 
Jens Axboe
