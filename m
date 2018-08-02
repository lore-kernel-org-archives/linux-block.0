Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: fix updating tags depth
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
 "Ewan D. Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>
References: <20180802102326.6859-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8119ed5d-af04-23b7-6dee-bfdb84497800@kernel.dk>
Date: Thu, 2 Aug 2018 14:48:20 -0600
MIME-Version: 1.0
In-Reply-To: <20180802102326.6859-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/2/18 4:23 AM, Ming Lei wrote:
> The passed 'nr' from userspace represents the total depth, meantime
> inside 'struct blk_mq_tags', 'nr_tags' stores the total tag depth,
> and 'nr_reserved_tags' stores the reserved part.
> 
> There are two issues in blk_mq_tag_update_depth() now:
> 
> 1) for growing tags, we should have used the passed 'nr', and keep the
> number of reserved tags not changed.
> 
> 2) the passed 'nr' should have been used for checking against
> 'tags->nr_tags', instead of number of the normal part.
> 
> This patch fixes the above two cases, and avoids kernel crash caused
> by wrong resizing sbitmap queue.

Applied, thanks.

-- 
Jens Axboe
