Return-Path: <hare@suse.de>
Subject: Re: [PATCH 0/2] Fix silent data corruption in blkdev_direct_IO()
To: Martin Wilck <mwilck@suse.com>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
 Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org
References: <20180718075440.GA15254@ming.t460p>
 <20180719093918.28876-1-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9dca2bbb-a837-6f6c-5f0a-f01baae342a1@suse.de>
Date: Thu, 19 Jul 2018 12:08:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180719093918.28876-1-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/19/2018 11:39 AM, Martin Wilck wrote:
> Hello Jens, Ming, Jan, and all others,
> 
> the following patches have been verified by a customer to fix a silent data
> corruption which he has been seeing since "72ecad2 block: support a full bio
> worth of IO for simplified bdev direct-io".
> 
> The patches are based on our observation that the corruption is only
> observed if the __blkdev_direct_IO_simple() code path is executed,
> and if that happens, "short writes" are observed in this code path,
> which causes a fallback to buffered IO, while the application continues
> submitting direct IO requests.
> 
> For the first patch, an alternative solution by Christoph Hellwig
> exists:
> 
>    https://marc.info/?l=linux-kernel&m=153013977816825&w=2
> 
> While I believe that Christoph's patch is correct, the one presented
> here is smaller. Ming has suggested to use Christoph's for mainline and
> mine for -stable.
> 
> Wrt the second patch, we've had an internal discussion at SUSE how to handle
> (unlikely) error conditions from bio_iov_iter_get_pages(). The patch presented
> here tries to submit as much IO as possible via the direct path even in the
> error case, while Jan Kara suggested to abort, not submit any IO, and fall 
> back to buffered IO in that case.
> 
> Looking forward to your opinions and suggestions.
> 
Can you please add the test program from Jan Kara to the blktest suite?
This issue is something we really should cover there too, seeing the
amount of time we've spend debugging it...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
