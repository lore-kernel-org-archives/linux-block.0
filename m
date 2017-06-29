Return-Path: <viro@ftp.linux.org.uk>
Date: Fri, 30 Jun 2017 00:46:57 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>, mgorman@suse.de,
	Volker.Lendecke@sernet.de, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: non-blockling buffered reads
Message-ID: <20170629234657.GO10672@ZenIV.linux.org.uk>
References: <20170629212503.15110-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629212503.15110-1-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 29, 2017 at 02:25:00PM -0700, Christoph Hellwig wrote:
> This series resurrects the old patches from Milosz to implement
> non-blocking buffered reads.  Thanks to the non-blocking AIO code from
> Goldwyn the implementation becomes pretty much trivial.  As that
> implementation is in the block tree I would suggest that we merge
> these patches through the block tree as well.  I've also forward
> ported the test Milosz sent for recent xfsprogs to verify it works
> properly, but I'll still have to address the review comments for it.
> I'll also volunteer to work with Goldwyn to properly document the
> RWF_NOWAIT flag in the man page including this change.

Hmm...  It's not quite non-blocking, though - copy_page_to_iter() can
bloody well block, as any copying to userland.  I'm not saying that
it's a significant problem (if you are reading into something that
had been mmaped from NFS server, etc., you are getting what you'd
asked for), but it's worth documenting.
