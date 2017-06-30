Return-Path: <hch@lst.de>
Date: Fri, 30 Jun 2017 02:34:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>, mgorman@suse.de,
	Volker.Lendecke@sernet.de, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: non-blockling buffered reads
Message-ID: <20170630003457.GA5369@lst.de>
References: <20170629212503.15110-1-hch@lst.de> <20170629234657.GO10672@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629234657.GO10672@ZenIV.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jun 30, 2017 at 12:46:57AM +0100, Al Viro wrote:
> Hmm...  It's not quite non-blocking, though - copy_page_to_iter() can
> bloody well block, as any copying to userland.  I'm not saying that
> it's a significant problem (if you are reading into something that
> had been mmaped from NFS server, etc., you are getting what you'd
> asked for), but it's worth documenting.

True.  I'll ensure this is documented in the man page.
