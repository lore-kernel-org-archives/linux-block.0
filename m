Return-Path: <BATV+c89273d3eea146e66f74+4831+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 14 Nov 2016 10:11:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCHSET] Add support for simplified async direct-io
Message-ID: <20161114181119.GA9396@infradead.org>
References: <1479144519-15738-1-git-send-email-axboe@fb.com>
 <20161114173728.GA22167@infradead.org>
 <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
 <20161114180052.GA24476@infradead.org>
 <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
 <20161114180503.GA31126@infradead.org>
 <d9baad75-d105-2968-1b59-608a8598e3bb@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d9baad75-d105-2968-1b59-608a8598e3bb@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 14, 2016 at 11:08:46AM -0700, Jens Axboe wrote:
> It'd be cleaner to loop one level out, and avoid all that 'dio' stuff
> instead. And then still retain the separate parts of the sync and async.
> There's nothing to share there imho, and it just makes the code harder
> to read.

How do you avoid it for the async case?  We can only call ki_complete
once all bios have finished, which means we need a tracking structure
for it.  For the synchronous case we could in theory wait for the
previous bio before sending the next, but there are plenty of RAID
arrays that would prefer > 1MB I/O.  And we can pretty much reuse the
async case for this anyway.
