Subject: Re: [PATCH 0/4] blk-mq: cleanup on all kinds of kobjects
To: Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Omar Sandoval <osandov@osandov.com>
References: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <18f5910b-22ca-65ab-a41f-22ade0fa6cba@fb.com>
Date: Fri, 3 Mar 2017 08:34:58 -0700
MIME-Version: 1.0
In-Reply-To: <1487758442-5855-1-git-send-email-tom.leiming@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/22/2017 03:13 AM, Ming Lei wrote:
> This patchset cleans up on kojects of request_queue.mq_kobj,
> sw queue's kobject and hw queue's kobject.
> 
> The 1st patch initialized kobject of request_queue and sw queue
> in blk_mq_init_allocated_queue(), so we can avoid to initialize
> these kobjects several times, and this patch fixes one kerne
> warning reported from Omar Sandoval.
> 
> The 2nd patch makes lifetime consitent between mq request queue/sw
> queue and their kobjects.
> 
> The 3rd patch makes lifetime consitent between hw queue and their
> kobjects.
> 
> The last patch is a followup of 3rd patch.

Thanks for looking into this, Ming. From a quick look, looks good
to me. I'm going to queue it up for some testing, and hope that
we can funnel this into 4.11 for the next pull request.

-- 
Jens Axboe
