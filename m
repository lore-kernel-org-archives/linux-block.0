Return-Path: <hch@lst.de>
Date: Tue, 15 Nov 2016 14:49:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Omar Sandoval <osandov@osandov.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] block: fast-path for small and simple direct I/O
	requests
Message-ID: <20161115134932.GA28632@lst.de>
References: <1478927487-12998-1-git-send-email-axboe@fb.com> <1478927487-12998-2-git-send-email-axboe@fb.com> <20161114193339.GA31821@vader.DHCP.thefacebook.com> <b10995da-5a09-d015-36f2-c7a52c0abcc4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b10995da-5a09-d015-36f2-c7a52c0abcc4@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 14, 2016 at 01:00:09PM -0700, Jens Axboe wrote:
> Prefetches like that tend to grow stale, in my experience. So we should
> probably just evaluate the new path cache behavior and see if it makes
> sense.

Yes.  I've tested the patches with that in place, but it didn't
make a difference.  Probably because we're not wasting many cycles
between the possible place for the prefetch and the use of it anyway.
