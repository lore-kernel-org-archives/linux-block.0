Return-Path: <hare@suse.de>
Subject: Re: [PATCH v5 2/3] blkdev: __blkdev_direct_IO_simple: fix leak in
 error case
To: Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>,
 Jan Kara <jack@suse.com>, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
 Kent Overstreet <kent.overstreet@gmail.com>, linux-block@vger.kernel.org
References: <20180725211509.13592-1-mwilck@suse.com>
 <20180725211509.13592-3-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <13c64245-094a-25f4-e523-7df1df6fce0d@suse.de>
Date: Thu, 26 Jul 2018 08:38:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180725211509.13592-3-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/25/2018 11:15 PM, Martin Wilck wrote:
> Fixes: 72ecad22d9f1 ("block: support a full bio worth of IO for
>  simplified bdev direct-io")
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  fs/block_dev.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
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
