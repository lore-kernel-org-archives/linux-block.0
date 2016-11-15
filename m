Return-Path: <BATV+14c2871bace748bdd01b+4832+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 15 Nov 2016 05:58:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCHSET] Add support for simplified async direct-io
Message-ID: <20161115135833.GA27541@infradead.org>
References: <1479144519-15738-1-git-send-email-axboe@fb.com>
 <20161114173728.GA22167@infradead.org>
 <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
 <20161114180052.GA24476@infradead.org>
 <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
 <20161114180503.GA31126@infradead.org>
 <d9baad75-d105-2968-1b59-608a8598e3bb@fb.com>
 <20161114181119.GA9396@infradead.org>
 <47ed731e-91c7-0641-5ce8-401ed4ce7c8d@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47ed731e-91c7-0641-5ce8-401ed4ce7c8d@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 14, 2016 at 11:17:09AM -0700, Jens Axboe wrote:
> Just make the limit reasonable - with a order 1 alloc, we have 256 pages, or
> 1MB of IO.

That's not reasonable for many RAID arrays.

> Loop around that.

How do you want to loop around that for AIO?
