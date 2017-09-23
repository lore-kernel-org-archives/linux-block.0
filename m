Return-Path: <viro@ftp.linux.org.uk>
Date: Sat, 23 Sep 2017 21:33:23 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fix unbalanced page refcounting in bio_map_user_iov
Message-ID: <20170923203323.GR32076@ZenIV.linux.org.uk>
References: <87bmm3xqds.wl-v.mayatskih@gmail.com>
 <20170923163928.GO32076@ZenIV.linux.org.uk>
 <20170923165537.GP32076@ZenIV.linux.org.uk>
 <20170923171925.GQ32076@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170923171925.GQ32076@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 23, 2017 at 06:19:26PM +0100, Al Viro wrote:
> On Sat, Sep 23, 2017 at 05:55:37PM +0100, Al Viro wrote:
> 
> > IOW, the loop on failure exit should go through the bio, like __bio_unmap_user()
> > does.  We *also* need to put everything left unused in pages[], but only from the
> > last iteration through iov_for_each().
> > 
> > Frankly, I would prefer to reuse the pages[], rather than append to it on each
> > iteration.  Used iov_iter_get_pages_alloc(), actually.
> 
> Something like completely untested diff below, perhaps...

> +				unsigned n = PAGE_SIZE - offs;
> +				unsigned prev_bi_vcnt = bio->bi_vcnt;

Sorry, that should've been followed by
				if (n > bytes)
					n = bytes;

Anyway, a carved-up variant is in vfs.git#work.iov_iter.  It still needs
review and testing; the patch Vitaly has posted in this thread plus 6
followups, hopefully more readable than aggregate diff.

Comments?
