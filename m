Return-Path: <hare@suse.de>
Subject: Re: [PATCH v5 08/12] block: Check locking assumptions at runtime
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke
 <hare@suse.com>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20170620181549.24903-1-bart.vanassche@wdc.com>
 <20170620181549.24903-9-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <acf98812-cb2c-963a-54aa-ba4aa56d8a89@suse.de>
Date: Wed, 21 Jun 2017 08:56:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170620181549.24903-9-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/20/2017 08:15 PM, Bart Van Assche wrote:
> From: Bart Van Assche <bart.vanassche@sandisk.com>
> 
> Instead of documenting the locking assumptions of most block layer
> functions as a comment, use lockdep_assert_held() to verify locking
> assumptions at runtime.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c    | 71 +++++++++++++++++++++++++++++++++++------------------
>  block/blk-flush.c   |  8 +++---
>  block/blk-merge.c   |  3 +++
>  block/blk-tag.c     | 15 +++++------
>  block/blk-timeout.c |  4 ++-
>  5 files changed, 64 insertions(+), 37 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
