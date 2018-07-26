Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 0/3] Fix silent data corruption in blkdev_direct_IO()
To: Martin Wilck <mwilck@suse.com>, Jan Kara <jack@suse.com>,
 Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 Kent Overstreet <kent.overstreet@gmail.com>, linux-block@vger.kernel.org
References: <20180725211509.13592-1-mwilck@suse.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2988d706-9534-bbb0-5bdf-c1a98946347e@kernel.dk>
Date: Thu, 26 Jul 2018 10:53:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180725211509.13592-1-mwilck@suse.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/25/18 2:15 PM, Martin Wilck wrote:
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
> Following Ming's suggestion, I've changed the patch set such that
> bio_iov_iter_get_pages() now always returns as many pages as possible.
> This simplifies the patch set a lot. Except for
> __blkdev_direct_IO_simple(), all callers of bio_iov_iter_get_pages()
> call it in a loop, and expect to get just some pages. Therefore I
> have made bio_iov_iter_get_pages() return success if it can pin some
> pages, even if MM returns an error on the way. Error is returned only
> if no pages at all could be pinned. This also avoids the need for
> cleanup code in the helper - callers will submit the bio with the
> allocated pages, and clean up later as appropriate.

Thanks everyone involved in this, I've queued it up for 4.18.

-- 
Jens Axboe
