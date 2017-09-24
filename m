Return-Path: <viro@ftp.linux.org.uk>
Date: Sun, 24 Sep 2017 18:15:46 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Vitaly Mayatskikh <v.mayatskih@gmail.com>
Subject: Re: [PATCH] fix unbalanced page refcounting in bio_map_user_iov
Message-ID: <20170924171545.GU32076@ZenIV.linux.org.uk>
References: <87bmm3xqds.wl-v.mayatskih@gmail.com>
 <20170923163928.GO32076@ZenIV.linux.org.uk>
 <20170923165537.GP32076@ZenIV.linux.org.uk>
 <20170923171925.GQ32076@ZenIV.linux.org.uk>
 <20170923203323.GR32076@ZenIV.linux.org.uk>
 <20170924142739.GS32076@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170924142739.GS32076@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Sun, Sep 24, 2017 at 03:27:39PM +0100, Al Viro wrote:

> At the very least, we need bmd->iter = *iter; bmd->iter.iov = bmd->iov;
> instead of that iov_iter_init() in there.  I'm not sure how far back does
> it go; looks like "block: support large requests in blk_rq_map_user_iov"
> is the earliest possible point, but it might need more digging to make
> sure.  v4.5+, if that's when the problems began...
> 
> Anyway, I'd added the obvious fix to #work.iov_iter, reordered it and
> force-pushed the result.

While we are at it, calculation of nr_pages in bio_copy_user_iov() is bloody
odd - why, in the name of everything unholy, does it care about the iovec
boundaries in there?  We are copying data anyway; why does allocation of bio
care about the fragmentation of the other end of copying?  Shouldn't it be
simply max(DIV_ROUND_UP(offset + len, PAGE_SIZE), BIO_MAX_PAGES)?
