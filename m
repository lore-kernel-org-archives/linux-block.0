Subject: Re: [PATCH] blk-mq: don't complete un-started request in timeout
 handler
To: Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20170322021443.26397-1-tom.leiming@gmail.com>
Cc: Yi Zhang <yizhan@redhat.com>, Bart Van Assche
 <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <keith.busch@intel.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <2bc8118b-4a11-f28e-50eb-22019184756b@fb.com>
Date: Tue, 21 Mar 2017 23:03:59 -0400
MIME-Version: 1.0
In-Reply-To: <20170322021443.26397-1-tom.leiming@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/21/2017 10:14 PM, Ming Lei wrote:
> When iterating busy requests in timeout handler,
> if the STARTED flag of one request isn't set, that means
> the request is being processed in block layer or driver, and
> isn't submitted to hardware yet.
> 
> In current implementation of blk_mq_check_expired(),
> if the request queue becomes dying, un-started requests are
> handled as being completed/freed immediately. This way is
> wrong, and can cause rq corruption or double allocation[1][2],
> when doing I/O and removing&resetting NVMe device at the sametime.

I agree, completing it looks bogus. If the request is in a scheduler or
on a software queue, this won't end well at all. Looks like it was
introduced by this patch:

commit eb130dbfc40eabcd4e10797310bda6b9f6dd7e76
Author: Keith Busch <keith.busch@intel.com>
Date:   Thu Jan 8 08:59:53 2015 -0700

    blk-mq: End unstarted requests on a dying queue

Before that, we just ignored it. Keith?

-- 
Jens Axboe
